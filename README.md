# 宝可梦自走棋 (Pokémon Auto-Chess)

基于 **Godot 4** 引擎打造的宝可梦题材经典自走棋策略游戏。

---

## 🎮 游戏特性

1. **核心自走棋循环**:
   - **准备阶段 (20s)**: 购买/出售宝可梦、布阵站位、研读升级增加人口上限、刷新/锁定商店，亦可点击「立即开战」直接切入战斗。
   - **战斗阶段 (40s)**: 双方全自动寻路索敌与普通攻击，积攒能量满蓝施放专属招牌大招。
   - **结算阶段**: 根据存活敌方数量扣减失败方血量，发放基础金币、利息 (最高 +5G) 与连胜/连败奖金。
2. **三连升星与进化系统 (★1 ➔ ★2 ➔ ★3)**:
   - 收集 3 只相同 1 星宝可梦自动合成 2 星形态（全属性提升 1.8 倍，技能伤害大幅强化）。
   - 收集 3 只 2 星宝可梦合成 3 星终极大招形态。
3. **属性羁绊系统 (Synergies)**:
   - **火系 (Fire)**: 攻击附加持续燃烧伤害，提高全队攻速。
   - **水系 (Water)**: 增加全员生命上限，每秒百分比回血。
   - **草系 (Grass)**: 攻击附带吸血并强化护甲。
   - **电系 (Electric)**: 普攻额外回蓝，高概率触发弹射闪电与眩晕。
   - **超能系 (Psychic)**: 全员技能伤害大幅提升，开局初始法力加成。
   - **格斗系 (Fighting)**: 攻击力大幅提升，高额暴击几率。
   - **龙系 (Dragon)**: 开局获得魔免吸收护盾，大招范围扩大。
   - **一般系 (Normal)**: 巨额减伤与坦度。
   - **幽灵系 (Ghost)**: 物理攻击闪避与破甲。
4. **12 只经典特色宝可梦**:
   - 包含皮卡丘、小火龙、杰尼龟、妙蛙种子、腕力、耿鬼、卡比兽、胡地、喷火龙、暴鲤龙、快龙、超梦。
5. **视听管线**:
   - **Banana2 资产**: 采用生图管线生成的精美像素与立绘资源。
   - **SFX 程序化音频**: 内置 12 种纯净 16-bit 44.1kHz WAV 音效（普攻、电击、烈焰、水炮、大招、买卖、升星、胜负音效）。

---

## 🕹️ 运行方式

### 方式 1：使用 Godot 编辑器运行
1. 打开系统中的 `/Applications/Godot_mono.app`（或任何 Godot 4.x 编辑器）。
2. 在项目管理器中点击「导入 (Import)」，选择本项目根目录下的 `project.godot`。
3. 进入编辑器后按 `F5`（或点击右上角播放三角按钮）即可全屏/窗口启动游玩！

### 方式 2：使用命令行直接启动游戏
```bash
/Applications/Godot_mono.app/Contents/MacOS/Godot scenes/main.tscn
```

### 方式 3：运行自动化集成测试套件
```bash
/Applications/Godot_mono.app/Contents/MacOS/Godot --headless scenes/test_runner.tscn
```

---

## 📚 系统设计与架构文档 (Documentation)

项目拥有详尽的系统架构、机制演进历程与测试验证文档，均已持久化归档至本地仓库的 [`docs/`](./docs/README.md) 目录：

- 📘 [**全系统设计与演进架构全景报告 (DESIGN_AND_SYSTEMS.md)**](./docs/DESIGN_AND_SYSTEMS.md)：涵盖携带装备与合成矩阵、DPS数据面板、18系克制与特性、海克斯强化与Boss战、493只全图鉴、刺客机制、道馆巡礼、训练家战术、闪光与隐藏羁绊、内存优化以及无遮挡UI布局等全量内容。
- 🗺️ [**四大核心深度扩展规划路线图 (EXPANSION_PLAN.md)**](./docs/EXPANSION_PLAN.md)：闪光与情怀羁绊、元素符文地块、八大道馆巡礼、训练家战术系统设计。
- ⚡ [**天气场地、Mega极巨化与智能阵容规划 (MEGA_WEATHER_PLAN.md)**](./docs/MEGA_WEATHER_PLAN.md)：天气与场地领域系统、超级进化/极巨化战术与智能阵容构筑器。
- 📑 [**设计文档库完整索引 (docs/README.md)**](./docs/README.md)

---

## 📁 目录结构

```
focused-hubble/
├── project.godot                  # Godot 4 核心工程配置文件
├── docs/                          # 全系统设计、架构演进与路线图文档库
│   ├── README.md                  # 设计文档索引
│   ├── DESIGN_AND_SYSTEMS.md      # 全系统设计与演进架构报告 (1700+ 行)
│   ├── EXPANSION_PLAN.md          # 四大核心深度扩展路线图
│   └── MEGA_WEATHER_PLAN.md       # 天气场地与Mega极巨化设计案
├── assets/
│   ├── units/                     # 宝可梦精灵图 (Banana2 生图立绘与高精像素图)
│   ├── ui/                        # 属性徽标、金币、星级与卡牌组件贴图
│   ├── arena/                     # 棋盘地砖与高亮选框
│   └── audio/                     # 12 种游戏 WAV 音效
├── scenes/
│   ├── main.tscn                  # 游戏主场景 (UI、棋盘、战斗容器)
│   ├── unit.tscn                  # 宝可梦战斗棋子节点场景 (Sprite, 血条, 蓝条, 状态机)
│   ├── shop_card.tscn             # 商店单个购买卡片组件
│   ├── floating_text.tscn         # 战斗浮动伤害/治疗跳字
│   └── test_runner.tscn           # 自动化回归测试场景
└── scripts/
    ├── autoload/
    │   ├── game_manager.gd        # 全局状态 (金币、血量、等级、回合、胜败)
    │   ├── pokemon_database.gd    # 宝可梦属性表、数值、技能定义
    │   ├── synergy_manager.gd     # 羁绊结算与加成计算器
    │   └── audio_manager.gd       # 全局音效播放单例
    ├── board.gd                   # 棋盘网格系统、备战席管理、拖拽与升星进化
    ├── unit.gd                    # 宝可梦独立 AI、移动寻路、攻击、施法、受击
    ├── hud_ui.gd                  # 顶部状态条、左侧羁绊面板、商店与单位信息
    ├── shop_card.gd               # 商店卡牌交互
    ├── floating_text.gd           # 伤害数字动画
    ├── generate_sfx.py            # SFX 音效生成器
    ├── generate_sprites.py        # 像素精灵与贴图生成器
    └── test_runner.gd             # 自动化测试脚本
```
