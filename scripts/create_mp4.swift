import Foundation
import AVFoundation
import CoreGraphics
import ImageIO

let args = CommandLine.arguments
guard args.count >= 4 else {
    print("Usage: create_mp4 <input_dir> <fps> <output_file>")
    exit(1)
}

let inputDir = args[1]
let fps = Int32(args[2]) ?? 10
let outputPath = args[3]

let fm = FileManager.default
guard let files = try? fm.contentsOfDirectory(atPath: inputDir)
    .filter({ $0.hasSuffix(".png") })
    .sorted() else {
    print("Error reading directory: \(inputDir)")
    exit(1)
}

guard !files.isEmpty else {
    print("No PNG files found in \(inputDir)")
    exit(1)
}

guard let firstImageSource = CGImageSourceCreateWithURL(URL(fileURLWithPath: "\(inputDir)/\(files[0])") as CFURL, nil),
      let firstImage = CGImageSourceCreateImageAtIndex(firstImageSource, 0, nil) else {
    print("Failed to read first image")
    exit(1)
}

let width = firstImage.width
let height = firstImage.height
print("Video dimensions: \(width)x\(height), Total frames: \(files.count), FPS: \(fps)")

let outputURL = URL(fileURLWithPath: outputPath)
try? fm.removeItem(at: outputURL)

guard let writer = try? AVAssetWriter(outputURL: outputURL, fileType: .mp4) else {
    print("Failed to create AVAssetWriter")
    exit(1)
}

let videoSettings: [String: Any] = [
    AVVideoCodecKey: AVVideoCodecType.h264,
    AVVideoWidthKey: width,
    AVVideoHeightKey: height
]

let writerInput = AVAssetWriterInput(mediaType: .video, outputSettings: videoSettings)
writerInput.expectsMediaDataInRealTime = false

let sourcePixelBufferAttributes: [String: Any] = [
    kCVPixelBufferPixelFormatTypeKey as String: kCVPixelFormatType_32ARGB,
    kCVPixelBufferWidthKey as String: width,
    kCVPixelBufferHeightKey as String: height
]

let adaptor = AVAssetWriterInputPixelBufferAdaptor(
    assetWriterInput: writerInput,
    sourcePixelBufferAttributes: sourcePixelBufferAttributes
)

writer.add(writerInput)
guard writer.startWriting() else {
    print("writer.startWriting failed: \(String(describing: writer.error))")
    exit(1)
}
writer.startSession(atSourceTime: .zero)

func newPixelBufferFromCGImage(image: CGImage, pool: CVPixelBufferPool?) -> CVPixelBuffer? {
    var pixelBuffer: CVPixelBuffer?
    if let pool = pool {
        CVPixelBufferPoolCreatePixelBuffer(kCFAllocatorDefault, pool, &pixelBuffer)
    } else {
        CVPixelBufferCreate(
            kCFAllocatorDefault,
            image.width,
            image.height,
            kCVPixelFormatType_32ARGB,
            sourcePixelBufferAttributes as CFDictionary,
            &pixelBuffer
        )
    }
    guard let pb = pixelBuffer else { return nil }
    CVPixelBufferLockBaseAddress(pb, [])
    let data = CVPixelBufferGetBaseAddress(pb)
    let rgbColorSpace = CGColorSpaceCreateDeviceRGB()
    let context = CGContext(
        data: data,
        width: image.width,
        height: image.height,
        bitsPerComponent: 8,
        bytesPerRow: CVPixelBufferGetBytesPerRow(pb),
        space: rgbColorSpace,
        bitmapInfo: CGImageAlphaInfo.noneSkipFirst.rawValue
    )
    context?.draw(image, in: CGRect(x: 0, y: 0, width: image.width, height: image.height))
    CVPixelBufferUnlockBaseAddress(pb, [])
    return pb
}

var frameIndex: Int64 = 0
for file in files {
    let filePath = "\(inputDir)/\(file)"
    guard let source = CGImageSourceCreateWithURL(URL(fileURLWithPath: filePath) as CFURL, nil),
          let cgImage = CGImageSourceCreateImageAtIndex(source, 0, nil) else {
        continue
    }
    
    while !writerInput.isReadyForMoreMediaData {
        Thread.sleep(forTimeInterval: 0.005)
    }
    
    if let pb = newPixelBufferFromCGImage(image: cgImage, pool: adaptor.pixelBufferPool) {
        let frameTime = CMTimeMake(value: frameIndex, timescale: fps)
        adaptor.append(pb, withPresentationTime: frameTime)
        frameIndex += 1
    }
}

writerInput.markAsFinished()
let semaphore = DispatchSemaphore(value: 0)
writer.finishWriting {
    semaphore.signal()
}
semaphore.wait()

print("Successfully encoded MP4: \(outputPath)")
