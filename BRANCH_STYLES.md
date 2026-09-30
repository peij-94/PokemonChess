# 宝可梦自走棋 分支风格规范指南 (Branch Styles Guide)

本项目通过 Git 分支维护了不同视觉表现维度与渲染管线的版本。开发与扩展时请严格遵循所在分支的设计规范与风格定位：

---

## 🌿 1. `master` 分支：2D 正统像素点阵与官方插画风格 (Classic 2D Pixel & Dream World)

* **核心定位**：原汁原味的经典宝可梦像素自走棋，极速加载、全平台纯 2D 高帧率运行。
* **视觉体系**：
  * **角色立绘 / 卡牌头像**：`assets/units/{pokemon_id}.png` (256×256 32-bit RGBA PNG)。采用官方 **Dream World（梦境世界）/ 杉森建（Ken Sugimori）原版官方高清立绘**。
  * **战场动态动画**：`assets/units/anim/{pokemon_id}/` (128×128 像素级透明图集)。提取自宝可梦黑白第 5 世代（Generation V Black/White Animated）正版对战动态点阵。
    * `idle.png`：站立待机微动呼吸
    * `walk_0.png` ~ `walk_5.png`：地面移动行走循环 (6帧)
    * `attack_0.png` ~ `attack_5.png`：普通攻击动作 (6帧)
    * `attack_physical_0.png` ~ `5`：物理近战挥砍动作 (6帧)
    * `attack_special_0.png` ~ `5`：特攻远程投射姿势 (6帧)
    * `cast_skill_0.png` ~ `5`：大招/终极技能蓄能姿态 (6帧)
    * `hurt_0.png`, `hurt_1.png`：受击硬直与后仰
  * **棋盘与界面**：纯 2D Canvas 渲染，8×6 棋盘网格 (`Board`) + 8 格备战席。
  * **技能特效**：2D 独立图集序列帧（122+ 种去重特效，由 `SkillVFX` 管理）。
* **数据与玩法**：包含初代 152 只及后续扩充的第 2、3 代角色，全星级 3 分支技能树、属性羁绊、装备合成、天气系统、图鉴百科与羁绊规划器。

---

## 🧊 2. `3d` 分支：3D 混合视口与 2D Billboard 精灵风格 (3D Viewport Hybrid)

* **核心定位**：将战场升级为 3D 三维竞技场，保留 2D 点阵角色的复古怀旧感。
* **视觉体系**：
  * **渲染管线**：`SubViewport` 3D 混合视口，带有 3D 透视相机（`Camera3D`）、动态平行光照与软阴影。
  * **角色表现**：`AnimatedSprite3D`（Billboard 公告板模式），2D 像素精灵在 3D 空间中站立，面对摄像机。
  * **场地与地砖**：3D 立体棋盘地砖 (`Arena3D`)，支持多种主题场地贴图（如竞技场、火山、冰川、翡翠、星空）与 VRAM 压缩。
  * **技能特效**：结合 3D 粒子系统与空间光效。

---

## 💎 3. `3d.1` 分支：纯正 3D 官方 1:1 模型与实体手办风格 (True 3D Official Models & Amiibo Tabletop)

* **核心定位**：全 3D 化的高品质桌面手办战棋，使用 100% 官方正版 1:1 模型资产。
* **视觉体系**：
  * **模型资产**：提取自《Pokémon GO / Let's Go / 3DS》官方原版 3D 模型 (`assets/models/{pokemon_id}.glb`)。
  * **贴图映射**：官方多层高精度 UV 漫反射与法线贴图（`BodyA1`, `Eye1`, `Mouth1`，以及小火龙半透明发光尾焰 `FireCore` 等）。
  * **实体手办手感**：
    * `ModelAnchor` 根骨骼重心归零与地面吸附，支持无偏摆原地 360° 战斗索敌朝向（`set_facing`）。
    * 触觉拾取倾角、落地回弹压缩、接触阴影与撞击尘埃粒子。
  * **检视生态**：内置 Godot 3D 原生展台场景（`scenes/showcase_3d_models.tscn`）与单文件 WebGL 3D 离线交互检视网页（`pokemon_3d_models_sample.html`）。

---

## 📌 协作切换准则

1. 在 **`master`** 分支开发新角色或系统时：严禁引入 3D 视口或 3D GLB/FBX 依赖，所有角色资源统一使用 Dream World 256×256 立绘与 B&W 128×128 动态像素图集。
2. 在 **`3d`** 分支开发时：保持 3D 场地 + 2D Billboard 的混合架构。
3. 在 **`3d.1`** 分支开发时：保持 1:1 官方模型、材质 UV 映射与 3D 物理手办手感。
