extends SceneTree

# Automated Skill VFX Pipeline:
# 1. Slices generated JPEG sprite sheets (Thunderbolt, Flamethrower, Hydro Pump) with transparent keying.
# 2. Generates procedural high-detail pixel-art animated VFX frames (Razor Leaf, Shadow Ball, Body Slam, Psystrike, Draco Meteor).
# 3. Saves all 8 skills into transparent RGBA PNG sequences under assets/vfx/<skill_name>/frame_*.png

const BRAIN_DIR = "/Users/peij94/.gemini/antigravity/brain/637df6f0-a3ed-48a7-978f-991a27f006c6"

func _init() -> void:
	print("\n=== STARTING SKILL VFX SPRITE GENERATION & SLICING ===")
	
	process_thunderbolt()
	generate_flamethrower()
	generate_hydro_pump()
	generate_razor_leaf()
	generate_shadow_ball()
	generate_body_slam()
	generate_psystrike()
	generate_draco_meteor()
	generate_swift()
	generate_flame_wheel()
	generate_zen_headbutt()
	generate_discharge()
	generate_blizzard()
	generate_aura_sphere()
	
	print("\n=== ALL 14 SKILL VFX SPRITE SEQUENCES GENERATED SUCCESSFULLY! ===")
	quit(0)

# -------------------------------------------------------------
# 1. Thunderbolt (皮卡丘 - 十万伏特)
# -------------------------------------------------------------
func process_thunderbolt() -> void:
	var path = BRAIN_DIR + "/thunderbolt_vfx_1789691177092.jpg"
	var img = Image.load_from_file(path)
	if img == null or img.is_empty():
		push_error("Cannot load thunderbolt JPEG")
		return
		
	var out_dir = "assets/vfx/thunderbolt"
	DirAccess.make_dir_recursive_absolute(out_dir)
	
	# 2 rows x 3 cols, 1024x1024
	var cell_w = int(1024.0 / 3.0) # 341
	var cell_h = int(1024.0 / 2.0) # 512
	
	var frame_idx = 0
	for r in range(2):
		for c in range(3):
			# Skip top ~35px of label text
			var top_skip = 38
			var rect = Rect2i(c * cell_w + 8, r * cell_h + top_skip, cell_w - 16, cell_h - top_skip - 10)
			var sub_img = img.get_region(rect)
			sub_img.convert(Image.FORMAT_RGBA8)
			apply_black_keying(sub_img, 0.10, 0.32)
			
			# Resize nicely to standardized high-res VFX frame (240x360)
			sub_img.resize(240, 360, Image.INTERPOLATE_BILINEAR)
			var out_file = "%s/frame_%d.png" % [out_dir, frame_idx]
			sub_img.save_png(out_file)
			frame_idx += 1
	print("[VFX] Thunderbolt: 6 frames processed -> ", out_dir)

# -------------------------------------------------------------
# 2. Flamethrower (小火龙 / 喷火龙 - 喷射火焰 / 大字爆炎, 8 frames, 260x130)
# -------------------------------------------------------------
func generate_flamethrower() -> void:
	var out_dir = "assets/vfx/flamethrower"
	DirAccess.make_dir_recursive_absolute(out_dir)
	var w = 260
	var h = 130
	var cy = h / 2.0 # 65.0
	
	for f in range(8):
		var img = Image.create(w, h, false, Image.FORMAT_RGBA8)
		img.fill(Color(0, 0, 0, 0))
		
		var a_fade = 1.0 if f < 5 else (1.0 - (f - 4.0) / 3.2)
		var start_x = 24.0 if f < 4 else (24.0 + (f - 3.0) * 22.0)
		var end_x: float
		if f == 0: end_x = 75.0
		elif f == 1: end_x = 120.0
		elif f == 2: end_x = 175.0
		elif f == 3: end_x = 220.0
		elif f == 4: end_x = 232.0
		else: end_x = 235.0
		
		# Draw layered expanding flame stream along horizontal line
		var dist = end_x - start_x
		if dist > 5.0:
			var steps = int(dist / 4.0)
			for s in range(steps + 1):
				var u = float(s) / max(1.0, float(steps)) # 0.0 to 1.0
				var px = start_x + u * dist
				var py = cy + sin(u * 5.0 + float(f) * 1.2) * (3.0 + u * 6.0)
				var radius = (8.0 + u * 24.0) * (0.8 + 0.2 * sin(float(f) * 1.5 + u * 4.0))
				
				# Deep fiery crimson edge
				draw_radial_gradient(img, Vector2(px, py), radius * 1.2, Color(0.85, 0.2, 0.05, 0.5 * a_fade), Color(0.4, 0.05, 0.0, 0.0))
				# Vibrant orange body
				draw_radial_gradient(img, Vector2(px, py), radius * 0.9, Color(1.0, 0.5, 0.05, 0.8 * a_fade), Color(0.85, 0.2, 0.0, 0.6 * a_fade))
				# Brilliant solar yellow core
				draw_radial_gradient(img, Vector2(px, py), radius * 0.55, Color(1.0, 0.88, 0.2, 0.95 * a_fade), Color(1.0, 0.55, 0.0, 0.7 * a_fade))
				# White-hot plasma spark line
				draw_radial_gradient(img, Vector2(px, py), radius * 0.25, Color(1.0, 1.0, 0.9, 0.95 * a_fade), Color(1.0, 0.85, 0.2, 0.0))
				
		# Billowing flame head & curling tongues at the front
		if f >= 1:
			var head_pos = Vector2(end_x - 12.0, cy)
			var head_rad = 18.0 + min(float(f) * 4.0, 16.0)
			draw_radial_gradient(img, head_pos, head_rad * 1.1, Color(1.0, 0.45, 0.05, 0.85 * a_fade), Color(0.7, 0.1, 0.0, 0.0))
			draw_radial_gradient(img, head_pos, head_rad * 0.65, Color(1.0, 0.9, 0.3, 0.95 * a_fade), Color(1.0, 0.5, 0.0, 0.0))
			draw_radial_gradient(img, head_pos, head_rad * 0.35, Color(1.0, 1.0, 0.95, 0.95 * a_fade), Color(1.0, 0.9, 0.3, 0.0))
			
			# Curling fiery petals / tongues
			var tongues = 5
			for t_idx in range(tongues):
				var t_ang = (float(t_idx) / tongues) * TAU + float(f) * 0.8
				var t_rad = head_rad * (0.8 + 0.3 * sin(float(t_idx) * 2.3))
				var tp = head_pos + Vector2(cos(t_ang), sin(t_ang)) * t_rad
				draw_radial_gradient(img, tp, 6.0 + 3.0 * (1.0 - float(f) / 8.0), Color(1.0, 0.6, 0.1, 0.8 * a_fade), Color(0.8, 0.1, 0.0, 0.0))
				
		# Flying ember particles
		var ember_count = 10
		for e in range(ember_count):
			var ex = start_x + (float(e) / ember_count) * (end_x - start_x + 12.0)
			var ey = cy + sin(float(e) * 3.7 + float(f) * 2.0) * (14.0 + float(e) * 2.5)
			var e_rad = 2.0 + (e % 2)
			draw_radial_gradient(img, Vector2(ex, ey), e_rad, Color(1.0, 0.95, 0.5, 0.9 * a_fade), Color(1.0, 0.3, 0.0, 0.0))
		# Outermost margin safety clear - ensure zero border touch
		for x in range(w):
			for y in range(h):
				if x < 4 or x >= w - 4 or y < 4 or y >= h - 4:
					img.set_pixel(x, y, Color(0, 0, 0, 0))
					
		var out_file = "%s/frame_%d.png" % [out_dir, f]
		img.save_png(out_file)
	print("[VFX] Flamethrower: 8 frames procedurally generated (zero edge cutoff) -> ", out_dir)

# -------------------------------------------------------------
# 3. Hydro Pump (杰尼龟 / 暴鲤龙 - 水炮 / 水流尾, 6 frames, 200x200)
# -------------------------------------------------------------
func generate_hydro_pump() -> void:
	var out_dir = "assets/vfx/hydro_pump"
	DirAccess.make_dir_recursive_absolute(out_dir)
	var sz = 200
	var center = Vector2(sz / 2.0, sz / 2.0)
	
	for f in range(6):
		var img = Image.create(sz, sz, false, Image.FORMAT_RGBA8)
		img.fill(Color(0, 0, 0, 0))
		
		var a_fade = 1.0 if f < 4 else (1.0 - (f - 3.0) / 2.5)
		
		if f < 2:
			# High-pressure spiraling water torrent & vortex core
			var vortex_rad = 16.0 + float(f) * 16.0
			draw_radial_gradient(img, center, vortex_rad * 1.3, Color(0.2, 0.6, 1.0, 0.5 * a_fade), Color(0.05, 0.2, 0.7, 0.0))
			draw_radial_gradient(img, center, vortex_rad, Color(0.1, 0.45, 0.95, 0.9 * a_fade), Color(0.3, 0.8, 1.0, 0.75 * a_fade))
			draw_radial_gradient(img, center, vortex_rad * 0.4, Color(0.95, 1.0, 1.0, 0.95 * a_fade), Color(0.4, 0.85, 1.0, 0.8 * a_fade))
			
			# Spiraling water stream arms
			var arms = 4
			for a in range(arms):
				var a_rot = float(f) * 0.9 + (float(a) / arms) * TAU
				var tendril_rad = vortex_rad * 1.25
				var p = center + Vector2(cos(a_rot), sin(a_rot)) * tendril_rad
				draw_wave_curl(img, center, p, Color(0.5, 0.9, 1.0, 0.85 * a_fade), 4.0)
		else:
			# Massive tidal crash wave surge & water shockwave
			var surge_t = float(f - 2) / 3.0
			var surge_rad = 34.0 + surge_t * 44.0 # Max radius 78px inside 200x200 (well within bounds, zero edge touching)
			
			# Expanding water shockwave rings
			draw_energy_ring(img, center, surge_rad, 6.0, Color(0.3, 0.75, 1.0, 0.85 * a_fade))
			draw_energy_ring(img, center, surge_rad * 0.75, 4.0, Color(0.15, 0.5, 0.95, 0.7 * a_fade))
			draw_radial_gradient(img, center, surge_rad * 0.5, Color(0.7, 0.92, 1.0, 0.6 * a_fade), Color(0.1, 0.4, 0.9, 0.0))
			
			# Cresting wave curls
			var crests = 6
			for c in range(crests):
				var c_ang = (float(c) / crests) * TAU + float(f) * 0.4
				var cp = center + Vector2(cos(c_ang), sin(c_ang)) * (surge_rad * 0.95)
				draw_wave_curl(img, center + Vector2(cos(c_ang), sin(c_ang)) * (surge_rad * 0.4), cp, Color(0.9, 0.98, 1.0, 0.9 * a_fade), 3.5)
				
			# Water splash droplets
			var droplets = 14
			for d in range(droplets):
				var d_angle = (float(d) / droplets) * TAU + float(f) * 0.6
				var d_dist = surge_rad * (0.85 + 0.25 * sin(float(d) * 2.7))
				var dp = center + Vector2(cos(d_angle), sin(d_angle)) * d_dist
				var d_size = max(2.0, (4.5 - float(f) * 0.5))
				draw_radial_gradient(img, dp, d_size, Color(0.85, 0.96, 1.0, 0.85 * a_fade), Color(0.2, 0.65, 1.0, 0.0))
				
		var out_file = "%s/frame_%d.png" % [out_dir, f]
		img.save_png(out_file)
	print("[VFX] Hydro Pump: 6 frames procedurally generated (zero edge cutoff) -> ", out_dir)

func draw_wave_curl(img: Image, start_pt: Vector2, end_pt: Vector2, col: Color, thickness: float) -> void:
	var dist = start_pt.distance_to(end_pt)
	var steps = int(dist * 1.5)
	var dir = (end_pt - start_pt).normalized()
	var normal = Vector2(-dir.y, dir.x)
	for s in range(steps + 1):
		var u = float(s) / max(1.0, float(steps))
		var curve_offset = sin(u * PI) * 5.0
		var pt = start_pt.lerp(end_pt, u) + normal * curve_offset
		var t_thick = thickness * (1.0 - u * 0.3)
		for tx in range(-int(t_thick), int(t_thick) + 1):
			for ty in range(-int(t_thick), int(t_thick) + 1):
				var px = int(pt.x + tx)
				var py = int(pt.y + ty)
				if px >= 0 and px < img.get_width() and py >= 0 and py < img.get_height():
					var d = Vector2(tx, ty).length()
					if d <= t_thick:
						var a = col.a * (1.0 - d / (t_thick + 0.1))
						blend_pixel(img, px, py, Color(col.r, col.g, col.b, a))

func apply_black_keying(img: Image, black_threshold: float, feather: float) -> void:
	var w = img.get_width()
	var h = img.get_height()
	for x in range(w):
		for y in range(h):
			var col = img.get_pixel(x, y)
			var b = max(col.r, max(col.g, col.b))
			if b <= black_threshold:
				img.set_pixel(x, y, Color(0, 0, 0, 0))
			elif b < feather:
				var alpha = (b - black_threshold) / (feather - black_threshold)
				img.set_pixel(x, y, Color(col.r, col.g, col.b, alpha))

# -------------------------------------------------------------
# 4. Razor Leaf (妙蛙种子 - 飞叶快刀, 6 frames, 200x200)
# -------------------------------------------------------------
func generate_razor_leaf() -> void:
	var out_dir = "assets/vfx/razor_leaf"
	DirAccess.make_dir_recursive_absolute(out_dir)
	var sz = 200
	var center = Vector2(sz / 2.0, sz / 2.0)
	
	for f in range(6):
		var img = Image.create(sz, sz, false, Image.FORMAT_RGBA8)
		img.fill(Color(0, 0, 0, 0))
		
		var t = float(f) / 5.0
		var radius = 20.0 + t * 55.0
		var count = 3 + f * 2
		var base_rot = float(f) * 0.8
		var alpha_mult = 1.0 if f < 4 else (1.0 - (f - 3.0) / 2.5)
		
		# Draw swirling emerald blades
		for i in range(count):
			var angle = base_rot + (float(i) / count) * TAU
			var pos = center + Vector2(cos(angle), sin(angle)) * radius
			var leaf_len = 16.0 + (1.0 - t * 0.3) * 10.0
			var leaf_rot = angle + PI / 2.2
			draw_pixel_blade(img, pos, leaf_len, leaf_rot, alpha_mult)
			
		# Draw swirling wind trail rings
		draw_energy_ring(img, center, radius * 0.9, 3.0, Color(0.3, 0.95, 0.4, 0.45 * alpha_mult))
		draw_energy_ring(img, center, radius * 0.6, 2.0, Color(0.6, 1.0, 0.7, 0.35 * alpha_mult))
		
		var out_file = "%s/frame_%d.png" % [out_dir, f]
		img.save_png(out_file)
	print("[VFX] Razor Leaf: 6 frames generated -> ", out_dir)

func draw_pixel_blade(img: Image, center: Vector2, length: float, angle: float, alpha_mult: float) -> void:
	var dir = Vector2(cos(angle), sin(angle))
	var normal = Vector2(-dir.y, dir.x)
	var steps = int(length)
	for s in range(-steps / 2, steps / 2):
		var u = float(s) / (steps / 2.0) # -1 to 1
		var width = (1.0 - u * u) * 6.0
		var pt = center + dir * float(s)
		for w in range(-int(width), int(width) + 1):
			var p = pt + normal * float(w)
			var ix = int(p.x)
			var iy = int(p.y)
			if ix >= 0 and ix < img.get_width() and iy >= 0 and iy < img.get_height():
				var dist_center = abs(w) / max(1.0, width)
				var col: Color
				if dist_center < 0.25:
					col = Color(0.9, 1.0, 0.9, 0.95 * alpha_mult) # White-green core
				elif dist_center < 0.65:
					col = Color(0.2, 0.95, 0.35, 0.85 * alpha_mult) # Vibrant emerald
				else:
					col = Color(0.05, 0.6, 0.15, 0.65 * alpha_mult) # Deep forest edge
				blend_pixel(img, ix, iy, col)

# -------------------------------------------------------------
# 5. Shadow Ball (耿鬼 - 暗影球, 6 frames, 200x200)
# -------------------------------------------------------------
func generate_shadow_ball() -> void:
	var out_dir = "assets/vfx/shadow_ball"
	DirAccess.make_dir_recursive_absolute(out_dir)
	var sz = 200
	var center = Vector2(sz / 2.0, sz / 2.0)
	
	for f in range(6):
		var img = Image.create(sz, sz, false, Image.FORMAT_RGBA8)
		img.fill(Color(0, 0, 0, 0))
		
		var t = float(f) / 5.0
		if f < 3: # Charging and condensing ball
			var core_rad = 18.0 + f * 5.0
			draw_radial_gradient(img, center, core_rad * 1.8, Color(0.6, 0.1, 0.8, 0.4), Color(0.1, 0.02, 0.2, 0.0))
			draw_radial_gradient(img, center, core_rad, Color(0.1, 0.0, 0.15, 0.95), Color(0.4, 0.05, 0.6, 0.8))
			draw_radial_gradient(img, center, core_rad * 0.45, Color(0.95, 0.5, 1.0, 0.9), Color(0.2, 0.0, 0.3, 0.95))
			
			# Ghostly wisps / tendrils
			var arms = 5
			for a in range(arms):
				var a_rot = float(f) * 0.7 + (float(a) / arms) * TAU
				var tendril_rad = core_rad * (1.2 + 0.3 * sin(float(f) + a))
				var p = center + Vector2(cos(a_rot), sin(a_rot)) * tendril_rad
				draw_radial_gradient(img, p, 8.0, Color(0.8, 0.2, 1.0, 0.7), Color(0, 0, 0, 0))
		else: # Detonation and nether shockwave
			var det_t = float(f - 3) / 2.0 # 0 to 1
			var blast_rad = 32.0 + det_t * 55.0
			var a_fade = 1.0 - det_t * 0.8
			
			# Outer shadow shockwave ring
			draw_energy_ring(img, center, blast_rad, 8.0, Color(0.7, 0.15, 0.9, 0.75 * a_fade))
			draw_energy_ring(img, center, blast_rad * 0.8, 5.0, Color(0.3, 0.05, 0.5, 0.6 * a_fade))
			draw_radial_gradient(img, center, blast_rad * 0.5, Color(0.9, 0.4, 1.0, 0.6 * a_fade), Color(0, 0, 0, 0))
			
			# Spattered dark fragments
			var shards = 12
			for s in range(shards):
				var s_angle = (float(s) / shards) * TAU + float(f) * 0.4
				var s_dist = blast_rad * (0.8 + 0.35 * sin(float(s) * 2.1))
				var sp = center + Vector2(cos(s_angle), sin(s_angle)) * s_dist
				draw_radial_gradient(img, sp, 6.0 + 3.0 * (1.0 - det_t), Color(0.85, 0.3, 1.0, 0.8 * a_fade), Color(0, 0, 0, 0))
				
		var out_file = "%s/frame_%d.png" % [out_dir, f]
		img.save_png(out_file)
	print("[VFX] Shadow Ball: 6 frames generated -> ", out_dir)

# -------------------------------------------------------------
# 6. Body Slam / Earthquake (卡比兽 / 腕力 - 泰山压顶, 6 frames, 220x220)
# -------------------------------------------------------------
func generate_body_slam() -> void:
	var out_dir = "assets/vfx/body_slam"
	DirAccess.make_dir_recursive_absolute(out_dir)
	var sz = 220
	var center = Vector2(sz / 2.0, sz / 2.0)
	
	for f in range(6):
		var img = Image.create(sz, sz, false, Image.FORMAT_RGBA8)
		img.fill(Color(0, 0, 0, 0))
		
		var t = float(f) / 5.0
		var shock_rad = 22.0 + t * 75.0
		var a_fade = 1.0 if f < 3 else (1.0 - (f - 2.0) / 3.5)
		
		# Ground shockwave ring
		draw_energy_ring(img, center, shock_rad, 6.0, Color(0.95, 0.85, 0.45, 0.85 * a_fade))
		draw_energy_ring(img, center, shock_rad * 0.75, 4.0, Color(0.85, 0.5, 0.2, 0.65 * a_fade))
		
		# Central ground impact flash
		if f <= 2:
			var flash_rad = 30.0 * (1.0 - float(f) / 3.0)
			draw_radial_gradient(img, center, flash_rad, Color(1.0, 0.95, 0.8, 0.9), Color(0.9, 0.6, 0.2, 0.0))
			
		# Earthen fissure crack lines
		var cracks = 6
		for c in range(cracks):
			var c_angle = (float(c) / cracks) * TAU + 0.2
			var start_pt = center
			var crack_len = shock_rad * 0.95
			draw_jagged_fissure(img, start_pt, c_angle, crack_len, Color(0.95, 0.75, 0.3, 0.7 * a_fade))
			
		# Flying debris rock chunks
		var debris_count = 10
		for d in range(debris_count):
			var d_angle = (float(d) / debris_count) * TAU + 0.4
			var d_dist = shock_rad * (0.6 + 0.4 * cos(float(d) * 1.7))
			var dp = center + Vector2(cos(d_angle), sin(d_angle)) * d_dist
			draw_rock_shard(img, dp, 4.0 + float(d % 4), Color(0.7, 0.5, 0.35, 0.8 * a_fade))
			
		var out_file = "%s/frame_%d.png" % [out_dir, f]
		img.save_png(out_file)
	print("[VFX] Body Slam: 6 frames generated -> ", out_dir)

func draw_jagged_fissure(img: Image, origin: Vector2, angle: float, length: float, col: Color) -> void:
	var dir = Vector2(cos(angle), sin(angle))
	var normal = Vector2(-dir.y, dir.x)
	var steps = int(length / 6.0)
	var cur = origin
	for s in range(steps):
		var next_pt = cur + dir * 6.0 + normal * sin(float(s) * 2.3) * 3.5
		draw_line_pixel(img, cur, next_pt, col, 2.0)
		cur = next_pt

func draw_rock_shard(img: Image, pos: Vector2, rad: float, col: Color) -> void:
	for x in range(int(pos.x - rad), int(pos.x + rad) + 1):
		for y in range(int(pos.y - rad), int(pos.y + rad) + 1):
			var d = pos.distance_to(Vector2(x, y))
			if d <= rad and x >= 0 and x < img.get_width() and y >= 0 and y < img.get_height():
				var c = col if d > rad * 0.5 else Color(col.r * 1.3, col.g * 1.3, col.b * 1.3, col.a)
				blend_pixel(img, x, y, c)

# -------------------------------------------------------------
# 7. Psystrike (超梦 / 胡地 - 精神击破, 6 frames, 220x220)
# -------------------------------------------------------------
func generate_psystrike() -> void:
	var out_dir = "assets/vfx/psystrike"
	DirAccess.make_dir_recursive_absolute(out_dir)
	var sz = 220
	var center = Vector2(sz / 2.0, sz / 2.0)
	
	for f in range(6):
		var img = Image.create(sz, sz, false, Image.FORMAT_RGBA8)
		img.fill(Color(0, 0, 0, 0))
		
		var t = float(f) / 5.0
		var nova_rad = 20.0 + t * 80.0
		var a_fade = 1.0 if f < 4 else (1.0 - (f - 3.0) / 2.5)
		
		# Cosmic psychic distortion rings
		draw_energy_ring(img, center, nova_rad, 7.0, Color(0.9, 0.25, 1.0, 0.85 * a_fade))
		draw_energy_ring(img, center, nova_rad * 0.7, 4.0, Color(0.2, 0.85, 1.0, 0.75 * a_fade))
		draw_energy_ring(img, center, nova_rad * 1.15, 2.5, Color(1.0, 0.6, 1.0, 0.5 * a_fade))
		
		# Central bright singularity core
		var core_r = max(4.0, 24.0 * (1.0 - t))
		draw_radial_gradient(img, center, core_r, Color(1.0, 1.0, 1.0, 0.95 * a_fade), Color(0.8, 0.2, 1.0, 0.0))
		
		# Geometric psychic star beams
		var rays = 8
		for r in range(rays):
			var r_angle = (float(r) / rays) * TAU + float(f) * 0.35
			var r_len = nova_rad * 1.25
			var p_end = center + Vector2(cos(r_angle), sin(r_angle)) * r_len
			draw_line_pixel(img, center, p_end, Color(0.5, 0.95, 1.0, 0.7 * a_fade), 2.0)
			
		var out_file = "%s/frame_%d.png" % [out_dir, f]
		img.save_png(out_file)
	print("[VFX] Psystrike: 6 frames generated -> ", out_dir)

# -------------------------------------------------------------
# 8. Draco Meteor (快龙 - 流星群, 6 frames, 220x220)
# -------------------------------------------------------------
func generate_draco_meteor() -> void:
	var out_dir = "assets/vfx/draco_meteor"
	DirAccess.make_dir_recursive_absolute(out_dir)
	var sz = 220
	var center = Vector2(sz / 2.0, sz / 2.0)
	
	for f in range(6):
		var img = Image.create(sz, sz, false, Image.FORMAT_RGBA8)
		img.fill(Color(0, 0, 0, 0))
		
		if f <= 2: # Meteor descending from upper right
			var t_desc = float(f) / 2.0
			var start_pos = Vector2(sz * 0.85, sz * 0.15)
			var cur_pos = start_pos.lerp(center, t_desc)
			
			# Meteor tail trail
			var tail_dir = (start_pos - center).normalized()
			for s in range(12):
				var tp = cur_pos + tail_dir * float(s * 8)
				var t_rad = 14.0 * (1.0 - float(s) / 12.0)
				draw_radial_gradient(img, tp, t_rad, Color(1.0, 0.45, 0.1, 0.65), Color(0.8, 0.1, 0.0, 0.0))
				
			# Meteor flaming head
			draw_radial_gradient(img, cur_pos, 18.0, Color(1.0, 1.0, 0.9, 0.95), Color(1.0, 0.5, 0.1, 0.8))
			draw_radial_gradient(img, cur_pos, 28.0, Color(1.0, 0.35, 0.05, 0.6), Color(0.8, 0.0, 0.0, 0.0))
		else: # Massive impact fireball detonation
			var t_exp = float(f - 3) / 2.0
			var blast_rad = 35.0 + t_exp * 65.0
			var a_fade = 1.0 - t_exp * 0.75
			
			# Blast shockwave ring
			draw_energy_ring(img, center, blast_rad, 8.0, Color(1.0, 0.6, 0.1, 0.85 * a_fade))
			draw_energy_ring(img, center, blast_rad * 0.8, 6.0, Color(1.0, 0.25, 0.05, 0.75 * a_fade))
			
			# Dense nuclear fireball core
			draw_radial_gradient(img, center, blast_rad * 0.55, Color(1.0, 0.95, 0.7, 0.9 * a_fade), Color(1.0, 0.4, 0.0, 0.0))
			
			# Embers / volcanic sparks flying
			var embers = 14
			for e in range(embers):
				var e_angle = (float(e) / embers) * TAU + float(f) * 0.5
				var ep = center + Vector2(cos(e_angle), sin(e_angle)) * (blast_rad * (0.8 + 0.3 * sin(float(e) * 3.1)))
				draw_radial_gradient(img, ep, 5.0, Color(1.0, 0.85, 0.2, 0.8 * a_fade), Color(0, 0, 0, 0))
				
		var out_file = "%s/frame_%d.png" % [out_dir, f]
		img.save_png(out_file)
	print("[VFX] Draco Meteor: 6 frames generated -> ", out_dir)

# -------------------------------------------------------------
# 9. Swift (伊布 - 高速星星, 6 frames, 220x220)
# -------------------------------------------------------------
func generate_swift() -> void:
	var out_dir = "assets/vfx/swift"
	DirAccess.make_dir_recursive_absolute(out_dir)
	var sz = 220
	var center = Vector2(sz / 2.0, sz / 2.0)
	
	for f in range(6):
		var img = Image.create(sz, sz, false, Image.FORMAT_RGBA8)
		img.fill(Color(0, 0, 0, 0))
		var t = float(f) / 5.0
		var num_stars = 5
		var a_fade = 1.0 if f < 4 else (1.0 - (f - 3.0) / 2.5)
		
		for s in range(num_stars):
			var base_angle = (float(s) / num_stars) * TAU + t * 3.5
			var orbit_rad = 18.0 + t * 58.0 + sin(float(s) + t * 4.0) * 8.0
			var star_pos = center + Vector2(cos(base_angle), sin(base_angle)) * orbit_rad
			var star_rot = base_angle * 1.5 + float(f) * 0.8
			var star_size = 14.0 + sin(float(s) * 2.0 + t * 3.0) * 3.0
			
			draw_radial_gradient(img, star_pos, star_size * 1.6, Color(1.0, 0.9, 0.3, 0.5 * a_fade), Color(1.0, 0.8, 0.1, 0.0))
			draw_star_polygon(img, star_pos, star_size, star_size * 0.42, star_rot, Color(1.0, 0.88, 0.15, 0.95 * a_fade))
			
			for spark in range(4):
				var tail_t = float(spark + 1) * 0.18
				var tail_pos = center + Vector2(cos(base_angle - tail_t), sin(base_angle - tail_t)) * (orbit_rad - tail_t * 15.0)
				draw_radial_gradient(img, tail_pos, 3.5 - spark * 0.6, Color(1.0, 0.95, 0.5, 0.7 * a_fade), Color(0, 0, 0, 0))
				
		if f < 3:
			draw_radial_gradient(img, center, 24.0 * (1.0 - t * 0.5), Color(1.0, 1.0, 0.8, 0.8 * a_fade), Color(1.0, 0.7, 0.1, 0.0))
		else:
			var ring_rad = 25.0 + (f - 2.0) * 26.0
			draw_energy_ring(img, center, ring_rad, 4.0, Color(1.0, 0.85, 0.2, 0.65 * a_fade))
			
		var out_file = "%s/frame_%d.png" % [out_dir, f]
		img.save_png(out_file)
	print("[VFX] Swift: 6 frames generated -> ", out_dir)

# -------------------------------------------------------------
# 10. Flame Wheel (卡蒂狗 - 火焰轮, 6 frames, 220x220)
# -------------------------------------------------------------
func generate_flame_wheel() -> void:
	var out_dir = "assets/vfx/flame_wheel"
	DirAccess.make_dir_recursive_absolute(out_dir)
	var sz = 220
	var center = Vector2(sz / 2.0, sz / 2.0)
	
	for f in range(6):
		var img = Image.create(sz, sz, false, Image.FORMAT_RGBA8)
		img.fill(Color(0, 0, 0, 0))
		var t = float(f) / 5.0
		var a_fade = 1.0 if f < 4 else (1.0 - (f - 3.0) / 2.5)
		var wheel_rad = 22.0 + t * 48.0
		
		draw_radial_gradient(img, center, wheel_rad * 0.55, Color(1.0, 0.95, 0.7, 0.95 * a_fade), Color(1.0, 0.45, 0.05, 0.8 * a_fade))
		
		var num_arms = 4
		for a in range(num_arms):
			var start_ang = (float(a) / num_arms) * TAU + t * 5.0
			var pts = 16
			for p in range(pts):
				var pt_u = float(p) / float(pts - 1)
				var r_cur = wheel_rad * (0.35 + pt_u * 0.75)
				var ang = start_ang + pt_u * 1.8
				var pos = center + Vector2(cos(ang), sin(ang)) * r_cur
				var blob_rad = (1.0 - pt_u * 0.5) * (7.0 + sin(float(f) + pt_u * 4.0) * 2.0)
				var blob_col = Color(1.0, 0.9 - pt_u * 0.6, 0.1, (0.85 - pt_u * 0.3) * a_fade)
				draw_radial_gradient(img, pos, blob_rad, blob_col, Color(0.8, 0.1, 0.0, 0.0))
				
		draw_energy_ring(img, center, wheel_rad, 6.0, Color(1.0, 0.5, 0.05, 0.7 * a_fade))
		
		if f >= 3:
			var embers = 12
			for e in range(embers):
				var e_ang = (float(e) / embers) * TAU + float(f) * 0.6
				var e_dist = wheel_rad * (0.9 + 0.3 * sin(float(e) * 2.7))
				var ep = center + Vector2(cos(e_ang), sin(e_ang)) * e_dist
				draw_radial_gradient(img, ep, 4.0, Color(1.0, 0.75, 0.1, 0.8 * a_fade), Color(0, 0, 0, 0))
				
		var out_file = "%s/frame_%d.png" % [out_dir, f]
		img.save_png(out_file)
	print("[VFX] Flame Wheel: 6 frames generated -> ", out_dir)

# -------------------------------------------------------------
# 11. Zen Headbutt (可达鸭 - 念力头槌, 6 frames, 220x220)
# -------------------------------------------------------------
func generate_zen_headbutt() -> void:
	var out_dir = "assets/vfx/zen_headbutt"
	DirAccess.make_dir_recursive_absolute(out_dir)
	var sz = 220
	var center = Vector2(sz / 2.0, sz / 2.0)
	
	for f in range(6):
		var img = Image.create(sz, sz, false, Image.FORMAT_RGBA8)
		img.fill(Color(0, 0, 0, 0))
		var t = float(f) / 5.0
		var a_fade = 1.0 if f < 4 else (1.0 - (f - 3.0) / 2.5)
		
		var ring_rad = 18.0 + t * 62.0
		draw_energy_ring(img, center, ring_rad, 5.0, Color(0.9, 0.2, 0.85, 0.8 * a_fade))
		draw_energy_ring(img, center, ring_rad * 0.7, 4.0, Color(0.2, 0.85, 1.0, 0.75 * a_fade))
		draw_energy_ring(img, center, ring_rad * 0.4, 3.0, Color(0.95, 0.8, 1.0, 0.6 * a_fade))
		
		var num_dizzy_stars = 4
		for s in range(num_dizzy_stars):
			var ang = (float(s) / num_dizzy_stars) * TAU + t * 6.0
			var r_star = 26.0 + sin(t * 8.0 + s) * 12.0
			var pos = center + Vector2(cos(ang) * r_star * 1.3, sin(ang) * r_star * 0.65 - 12.0)
			draw_star_polygon(img, pos, 9.0, 3.5, ang * 2.0, Color(1.0, 0.9, 0.2, 0.9 * a_fade))
			draw_radial_gradient(img, pos, 12.0, Color(1.0, 0.8, 0.1, 0.4 * a_fade), Color(0, 0, 0, 0))
			
		var droplets = 8
		for d in range(droplets):
			var d_ang = (float(d) / droplets) * TAU + float(f) * 0.4
			var d_dist = ring_rad * (0.8 + 0.25 * cos(float(d) * 3.3))
			var dp = center + Vector2(cos(d_ang), sin(d_ang)) * d_dist
			draw_radial_gradient(img, dp, 4.5, Color(0.3, 0.9, 1.0, 0.8 * a_fade), Color(0, 0, 0, 0))
			
		var out_file = "%s/frame_%d.png" % [out_dir, f]
		img.save_png(out_file)
	print("[VFX] Zen Headbutt: 6 frames generated -> ", out_dir)

# -------------------------------------------------------------
# 12. Discharge (电击兽 - 放电, 6 frames, 240x240)
# -------------------------------------------------------------
func generate_discharge() -> void:
	var out_dir = "assets/vfx/discharge"
	DirAccess.make_dir_recursive_absolute(out_dir)
	var sz = 240
	var center = Vector2(sz / 2.0, sz / 2.0)
	
	for f in range(6):
		var img = Image.create(sz, sz, false, Image.FORMAT_RGBA8)
		img.fill(Color(0, 0, 0, 0))
		var t = float(f) / 5.0
		var a_fade = 1.0 if f < 4 else (1.0 - (f - 3.0) / 2.5)
		var core_rad = 20.0 + t * 50.0
		
		draw_radial_gradient(img, center, core_rad * 0.65, Color(1.0, 1.0, 0.95, 0.95 * a_fade), Color(1.0, 0.85, 0.2, 0.8 * a_fade))
		draw_radial_gradient(img, center, core_rad * 1.1, Color(0.3, 0.7, 1.0, 0.5 * a_fade), Color(0.1, 0.3, 0.9, 0.0))
		
		var bolts = 8
		for b in range(bolts):
			var base_ang = (float(b) / bolts) * TAU + float(f) * 0.5
			var cur_p = center + Vector2(cos(base_ang), sin(base_ang)) * (core_rad * 0.4)
			var segments = 4
			for seg in range(segments):
				var seg_u = float(seg + 1) / float(segments)
				var target_dist = core_rad * 0.4 + seg_u * (core_rad * 0.8)
				var jitter = sin(float(f) * 5.0 + b * 7.0 + seg * 3.0) * 0.28
				var next_ang = base_ang + jitter
				var next_p = center + Vector2(cos(next_ang), sin(next_ang)) * min(sz / 2.0 - 12.0, target_dist)
				draw_line_pixel(img, cur_p, next_p, Color(1.0, 0.95, 0.4, 0.9 * a_fade), 2.5)
				draw_line_pixel(img, cur_p, next_p, Color(0.4, 0.8, 1.0, 0.6 * a_fade), 4.5)
				cur_p = next_p
				
		draw_energy_ring(img, center, core_rad, 5.0, Color(1.0, 0.9, 0.2, 0.75 * a_fade))
		draw_energy_ring(img, center, core_rad * 1.18, 3.0, Color(0.3, 0.75, 1.0, 0.6 * a_fade))
		
		var out_file = "%s/frame_%d.png" % [out_dir, f]
		img.save_png(out_file)
	print("[VFX] Discharge: 6 frames generated -> ", out_dir)

# -------------------------------------------------------------
# 13. Blizzard (拉普拉斯 - 暴风雪, 6 frames, 240x240)
# -------------------------------------------------------------
func generate_blizzard() -> void:
	var out_dir = "assets/vfx/blizzard"
	DirAccess.make_dir_recursive_absolute(out_dir)
	var sz = 240
	var center = Vector2(sz / 2.0, sz / 2.0)
	
	for f in range(6):
		var img = Image.create(sz, sz, false, Image.FORMAT_RGBA8)
		img.fill(Color(0, 0, 0, 0))
		var t = float(f) / 5.0
		var a_fade = 1.0 if f < 4 else (1.0 - (f - 3.0) / 2.5)
		var vortex_rad = 25.0 + t * 62.0
		
		draw_radial_gradient(img, center, vortex_rad * 0.9, Color(0.6, 0.9, 1.0, 0.45 * a_fade), Color(0.1, 0.3, 0.7, 0.0))
		draw_energy_ring(img, center, vortex_rad * 0.8, 4.0, Color(0.4, 0.85, 1.0, 0.7 * a_fade))
		draw_energy_ring(img, center, vortex_rad * 0.5, 3.0, Color(0.85, 0.95, 1.0, 0.8 * a_fade))
		
		var num_flakes = 6
		for k in range(num_flakes):
			var f_ang = (float(k) / num_flakes) * TAU + t * 4.0
			var f_dist = vortex_rad * (0.4 + 0.45 * sin(float(k) + t * 3.0))
			var fp = center + Vector2(cos(f_ang), sin(f_ang)) * f_dist
			var flake_size = 11.0 + sin(float(k) * 1.5) * 3.0
			draw_snowflake(img, fp, flake_size, f_ang * 2.0, Color(0.95, 1.0, 1.0, 0.95 * a_fade))
			draw_radial_gradient(img, fp, flake_size * 1.5, Color(0.3, 0.8, 1.0, 0.4 * a_fade), Color(0, 0, 0, 0))
			
		if f >= 3:
			var shards = 14
			for s in range(shards):
				var s_ang = (float(s) / shards) * TAU + float(f) * 0.7
				var s_dist = vortex_rad * (0.75 + 0.3 * sin(float(s) * 2.3))
				var sp = center + Vector2(cos(s_ang), sin(s_ang)) * s_dist
				draw_radial_gradient(img, sp, 3.5, Color(0.9, 0.98, 1.0, 0.85 * a_fade), Color(0, 0, 0, 0))
				
		var out_file = "%s/frame_%d.png" % [out_dir, f]
		img.save_png(out_file)
	print("[VFX] Blizzard: 6 frames generated -> ", out_dir)

func draw_snowflake(img: Image, center: Vector2, radius: float, rot: float, col: Color) -> void:
	for arm in range(6):
		var ang = rot + (float(arm) / 6.0) * TAU
		var dir = Vector2(cos(ang), sin(ang))
		var tip = center + dir * radius
		draw_line_pixel(img, center, tip, col, 2.0)
		var mid = center + dir * (radius * 0.6)
		var norm = Vector2(-dir.y, dir.x)
		var b1 = mid + (dir * 0.2 + norm * 0.4) * radius * 0.5
		var b2 = mid + (dir * 0.2 - norm * 0.4) * radius * 0.5
		draw_line_pixel(img, mid, b1, col, 1.5)
		draw_line_pixel(img, mid, b2, col, 1.5)

# -------------------------------------------------------------
# 14. Aura Sphere (路卡利欧 - 波导弹, 6 frames, 220x220)
# -------------------------------------------------------------
func generate_aura_sphere() -> void:
	var out_dir = "assets/vfx/aura_sphere"
	DirAccess.make_dir_recursive_absolute(out_dir)
	var sz = 220
	var center = Vector2(sz / 2.0, sz / 2.0)
	
	for f in range(6):
		var img = Image.create(sz, sz, false, Image.FORMAT_RGBA8)
		img.fill(Color(0, 0, 0, 0))
		var t = float(f) / 5.0
		if f < 3:
			var a_rad = 16.0 + f * 7.0
			draw_radial_gradient(img, center, a_rad * 2.0, Color(0.0, 0.8, 1.0, 0.4), Color(0.0, 0.2, 0.8, 0.0))
			draw_radial_gradient(img, center, a_rad * 1.1, Color(0.2, 0.9, 1.0, 0.85), Color(0.05, 0.4, 0.9, 0.8))
			draw_radial_gradient(img, center, a_rad * 0.5, Color(1.0, 1.0, 1.0, 0.95), Color(0.3, 0.9, 1.0, 0.9))
			
			var streamers = 4
			for s in range(streamers):
				var s_ang = float(f) * 1.2 + (float(s) / streamers) * TAU
				var sp = center + Vector2(cos(s_ang), sin(s_ang)) * (a_rad * 1.35)
				draw_radial_gradient(img, sp, 6.0, Color(0.5, 1.0, 1.0, 0.75), Color(0, 0, 0, 0))
		else:
			var det_t = float(f - 3) / 2.0
			var blast_rad = 32.0 + det_t * 58.0
			var a_fade = 1.0 - det_t * 0.75
			
			draw_energy_ring(img, center, blast_rad, 7.0, Color(0.1, 0.85, 1.0, 0.85 * a_fade))
			draw_energy_ring(img, center, blast_rad * 0.75, 5.0, Color(0.6, 0.95, 1.0, 0.75 * a_fade))
			draw_energy_ring(img, center, blast_rad * 0.45, 4.0, Color(1.0, 1.0, 1.0, 0.8 * a_fade))
			
			var rays = 8
			for r in range(rays):
				var r_ang = (float(r) / rays) * TAU + float(f) * 0.4
				var ray_dir = Vector2(cos(r_ang), sin(r_ang))
				var p1 = center + ray_dir * (blast_rad * 0.3)
				var p2 = center + ray_dir * min(sz / 2.0 - 10.0, blast_rad * 1.15)
				draw_line_pixel(img, p1, p2, Color(0.8, 1.0, 1.0, 0.8 * a_fade), 3.0)
				
		var out_file = "%s/frame_%d.png" % [out_dir, f]
		img.save_png(out_file)
	print("[VFX] Aura Sphere: 6 frames generated -> ", out_dir)

# -------------------------------------------------------------
# Primitive Pixel Drawing Helpers
# -------------------------------------------------------------
func draw_star_polygon(img: Image, center: Vector2, outer_r: float, inner_r: float, rot: float, col: Color) -> void:
	var points: PackedVector2Array = []
	for i in range(10):
		var a = rot + (float(i) / 10.0) * TAU
		var r = outer_r if i % 2 == 0 else inner_r
		points.append(center + Vector2(cos(a), sin(a)) * r)
		
	var min_x = int(max(0, center.x - outer_r - 1))
	var max_x = int(min(img.get_width() - 1, center.x + outer_r + 1))
	var min_y = int(max(0, center.y - outer_r - 1))
	var max_y = int(min(img.get_height() - 1, center.y + outer_r + 1))
	
	for y in range(min_y, max_y + 1):
		for x in range(min_x, max_x + 1):
			var pt = Vector2(x, y)
			if Geometry2D.is_point_in_polygon(pt, points):
				var d = center.distance_to(pt)
				var t = d / max(1.0, outer_r)
				var c = col.lerp(Color.WHITE, (1.0 - t) * 0.7)
				c.a = col.a
				blend_pixel(img, x, y, c)

func draw_energy_ring(img: Image, center: Vector2, radius: float, thickness: float, col: Color) -> void:
	var r_min = max(0.0, radius - thickness / 2.0)
	var r_max = radius + thickness / 2.0
	var min_x = int(max(0, center.x - r_max - 1))
	var max_x = int(min(img.get_width() - 1, center.x + r_max + 1))
	var min_y = int(max(0, center.y - r_max - 1))
	var max_y = int(min(img.get_height() - 1, center.y + r_max + 1))
	
	for x in range(min_x, max_x + 1):
		for y in range(min_y, max_y + 1):
			var d = center.distance_to(Vector2(x, y))
			if d >= r_min and d <= r_max:
				var edge_dist = abs(d - radius) / (thickness / 2.0)
				var alpha = col.a * (1.0 - edge_dist)
				blend_pixel(img, x, y, Color(col.r, col.g, col.b, alpha))

func draw_radial_gradient(img: Image, center: Vector2, radius: float, inner_col: Color, outer_col: Color) -> void:
	var min_x = int(max(0, center.x - radius - 1))
	var max_x = int(min(img.get_width() - 1, center.x + radius + 1))
	var min_y = int(max(0, center.y - radius - 1))
	var max_y = int(min(img.get_height() - 1, center.y + radius + 1))
	
	for x in range(min_x, max_x + 1):
		for y in range(min_y, max_y + 1):
			var d = center.distance_to(Vector2(x, y))
			if d <= radius:
				var t = d / radius
				var c = inner_col.lerp(outer_col, t)
				blend_pixel(img, x, y, c)

func draw_line_pixel(img: Image, p1: Vector2, p2: Vector2, col: Color, thickness: float) -> void:
	var dist = p1.distance_to(p2)
	var steps = int(dist * 1.5)
	for s in range(steps + 1):
		var t = float(s) / max(1.0, float(steps))
		var pt = p1.lerp(p2, t)
		for tx in range(-int(thickness), int(thickness) + 1):
			for ty in range(-int(thickness), int(thickness) + 1):
				var px = int(pt.x + tx)
				var py = int(pt.y + ty)
				if px >= 0 and px < img.get_width() and py >= 0 and py < img.get_height():
					var d = Vector2(tx, ty).length()
					if d <= thickness:
						var a = col.a * (1.0 - d / (thickness + 0.1))
						blend_pixel(img, px, py, Color(col.r, col.g, col.b, a))

func blend_pixel(img: Image, x: int, y: int, new_col: Color) -> void:
	if new_col.a <= 0.001:
		return
	var old = img.get_pixel(x, y)
	# Alpha compositing
	var out_a = new_col.a + old.a * (1.0 - new_col.a)
	if out_a <= 0:
		return
	var out_r = (new_col.r * new_col.a + old.r * old.a * (1.0 - new_col.a)) / out_a
	var out_g = (new_col.g * new_col.a + old.g * old.a * (1.0 - new_col.a)) / out_a
	var out_b = (new_col.b * new_col.a + old.b * old.a * (1.0 - new_col.a)) / out_a
	img.set_pixel(x, y, Color(out_r, out_g, out_b, out_a))
