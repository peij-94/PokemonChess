# 宝可梦自走棋设计与架构文档库 (Design & Architecture Docs)

本文档库收录了《宝可梦自走棋 (Pokémon Auto-Chess)》的完整系统架构设计、机制规范、演进历程与测试验证报告。

---

## 📑 核心文档索引

### 1. 📘 [全系统设计与演进架构全景报告 (DESIGN_AND_SYSTEMS.md)](./DESIGN_AND_SYSTEMS.md)
**最完整、最权威的系统设计全景文档（1700+ 行）**，涵盖：
- **四大核心拓展系统**：
  - 宝可梦携带道具与 20 款装备合成系统 (`ItemBench`, `ItemDatabase`)
  - 战斗实时数据统计面板 (DPS Meter)
  - 18 属性官方正统相克矩阵与专属特性库 (`TypeSystem`, `AbilityDatabase`)
  - 训练家海克斯强化符文与跨世代史诗首领 Boss 战 (`BossWaves`)
- **核心对战机制设计**：
  - 战斗阶段购买与延后自动合成机制 (Deferred Synthesis)
  - 拖拽出售区域系统 (Drag-to-Sell Drop Zone)
  - 满 3 星进化形态蜕变与不变之石机制 (Everstone & Evolution Control)
  - 刺客潜行切后排机制 (Assassin Sneak Leap)
- **多代图鉴与宏大战场**：
  - 第 1-4 世代 493 只宝可梦全量数值与分支招式库
  - 5 套主题战斗场地背景与每 3 局周期递增觉醒特性
- **四大深度扩展系统**：
  - ✨ 闪光异色宝可梦与四大经典情怀隐藏羁绊 (`ShinyAndLoreManager`)
  - 🗺️ 棋盘元素符文地块系统 (`ElementalHexSystem`)
  - 🏛️ 八大道馆巡礼爬塔模式与徽章陈列室 (`GymRoadManager`, `BadgeCase`)
  - 🧢 五大训练家身份与主动战术支援技能 (`TrainerSystem`)
- **性能与界面工程**：
  - 内存深度优化（SpriteFrames 40 上限 LRU 缓存、图鉴懒加载与卡牌节点池、跳字对象池、回合重置纹理清理）
  - 菜单页 16:9 对战竞技场沉浸背景与 2x2 规则卡片网格
  - 角色详情弹窗 (`UnitDetailModal`) 与 3x3 装备栏并列无遮挡响应式布局

---

### 2. 🗺️ [四大核心深度扩展规划路线图 (EXPANSION_PLAN.md)](./EXPANSION_PLAN.md)
包含闪光与情怀羁绊、棋盘元素符文地块、八大道馆巡礼爬塔、训练家战术主动技能四大终极模块的多 Agent 协同落地规划与架构拆解。

---

### 3. ⚡ [天气场地、Mega极巨化与智能阵容规划 (MEGA_WEATHER_PLAN.md)](./MEGA_WEATHER_PLAN.md)
包含四大天气与四大场地领域系统、8 大经典超级进化形态与单核极巨化战术突破、智能阵容构筑器与装备合成悬停预览设计方案。
