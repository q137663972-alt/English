# 英语乐园 · 人教版 1–6 年级英语学习 H5

一个面向小学生的英语学习小游戏，基于**人教版新起点（一年级起点）1–6 年级**全 12 册 **72 单元**内容（883 个单词 + 168 个句型），手机浏览器打开即用，无需安装、无需联网服务器。

## 🔒 私密性说明

仓库为公开仓库，但**APK 安装包不对外提供公开下载**：

- 工作流只负责构建，APK 仅作为 **Actions 产物**存在，下载需登录 GitHub（非免登录公开链接）。
- 需要安装包请直接向作者索取（或从 Actions 产物自行下载）。
- GitHub Pages 在线版保持可用（仓库为公开状态）。

## 🌐 在线体验

**https://q137663972-alt.github.io/English/**

![英语乐园二维码](qrcode.png)

> 二维码指向上面的 GitHub Pages 地址，手机扫码即可打开。
> 若微信提示「已停止访问该网页」，用系统相机扫码并在**浏览器**中打开即可（微信内置浏览器会拦截 github.io 域名）。

## 🎮 13 种玩法

| 玩法 | 说明 | 训练点 |
|---|---|---|
| 🔊 听音选图 | 自动播标准音，从 4 张卡片中选正确的图 | 听力辨义 |
| 👀 看图识词 | 看图选出对应英文单词 | 认读 |
| ✏️ 单词拼写 | 听音 + 看图，点字母拼出单词 | 拼写 |
| 🃏 翻牌配对 | 翻出「图—词」对子，翻到即朗读 | 记忆 |
| 🎤 跟读打分 | 听示范后跟读，AI 对比发音打分 | 口语 |
| 🧩 连词成句 ★ | 打乱词块，点词排成正确句子，完成后整句朗读 | 句型语序 |
| 📝 句型填空 ★ | 给句型挖空，选合适的词填入并朗读整句 | 句型迁移 |
| 💬 情景对话 ★ | 2–3 轮迷你对话挖掉答句，选出最合适的一句 | 语用听说 |
| 👂 听音辨词 | 听发音，从近音干扰词中辨析（cat/cap、ship/sheep） | 听辨音素 |
| 🇨🇳 看中文选英文 | 看中文 + 图标，选正确英文 | 中英对应 |
| 💥 单词消消乐 | 网格中图/文成对，点中一对消除 | 记忆 |
| 🗂️ 分类归筐 | 先点单词，再点它属于哪个主题筐 | 归类思维 |
| ⏱️ 限时挑战 | 60 秒混合题型，连对加分，记录历史最高分 | 综合反应 |

★ = 使用单元「句型」数据的玩法。

## ✨ 特色

- **全部解锁**：6 个年级、72 个单元一开始全部开放，没有任何进度门槛，想学哪课点哪课（星星仅作成就反馈）。
- **点哪读哪**：进入题目自动朗读，点任意答案/卡片即点即读。
- **微信也有声音**：微信内置浏览器不支持系统语音，因此内置「原生 TTS + 有道 MP3 兜底」双通道，微信内自动走音频播放。
- **大字号、大按钮**：马卡龙配色、圆角卡片、移动端优先，孩子自己就能操作。
- **进度本地保存**：星星、设置、挑战最高分都存在浏览器 `localStorage`，不依赖账号。

## 📁 文件结构

```
index.html          外壳：各屏容器 + 按顺序引入脚本
css/style.css       全部样式
js/data-g1.js       一年级（上/下）
js/data-g2.js       二年级（上/下）
js/data-g3.js       三年级（上/下）
js/data-g4.js       四年级（上/下）
js/data-g5.js       五年级（上/下）
js/data-g6.js       六年级（上/下）
js/tts.js           混合发音引擎（原生 TTS + 有道 MP3 兜底）
js/games.js         13 种玩法
js/app.js           导航、进度、设置、启动
```

数据结构（每个年级文件）：

```js
(function(g){ (window.GRADES = window.GRADES || []).push(g); })({
  g: 1,
  books: [ { n: "一年级上册", u: [ { n: "Unit 1 School 学校", w: [{e,z,k}], s: [{e,z}] } ] } ]
});
// w = 单词（e 英文 / z 中文 / k 图标）   s = 句型（e 英文 / z 中文）
```

## 🛠 技术说明

- 纯前端，零依赖、无构建步骤；用**经典 `<script>` 标签**（非 ES module），所以双击本地文件也不会被 CORS 拦住。
- 发音：优先 `SpeechSynthesis`（英文语音），失败或微信内自动切到有道词典 `dictvoice` MP3，逐词播放。
- 跟读：依赖浏览器语音识别；不支持或被拒麦克风时会自动放出「✅ 我读啦，过关」按钮，不会卡关。
- 右上角 ⚙️ 可开关发音、调节语速、试听。

## 📦 本地运行

双击 `index.html` 用浏览器打开即可（推荐 Chrome / Safari / Edge）。

或起个静态服务器：

```bash
python3 -m http.server 8000
# 浏览器访问 http://localhost:8000
```

## 📚 内容范围

| 年级 | 上册 | 下册 |
|---|---|---|
| 一 | School 学校 / Face 身体 / Animals 动物 / Numbers 数字 / Colours 颜色 / Fruit 水果 | Classroom 教室 / Room 房间 / Toys 玩具 / Food 食物 / Drink 饮品 / Clothes 衣物 |
| 二 | My Family 家庭 / Boys and Girls 男孩女孩 / My Friends 朋友 / In the Community 在社区 / In the Park 公园 / Happy Holidays 快乐的节日 | Play Sports 运动 / Weather 天气 / Season 季节 / Numbers 11-50 数字 11-50 / Daily Routine 日常作息 / Days of the Week 一周七天 |
| 三 | Myself 我自己 / My Body 身体 / Food 食物 / Pets 宠物 / Clothes 衣服 / Birthdays 生日 | School Subjects 学校课程 / My School 学校 / After School 放学后 / My Family 家庭 / Family Activities 家庭活动 / My Home 家 |
| 四 | Sports and Games 运动和游戏 / On the Weekend 在周末 / Transportation 交通方式 / Asking for Help 寻求帮助 / Safety 安全 / Jobs 职业 | My Neighbourhood 我的社区 / Cities 城市 / Travel Plans 旅行计划 / Hobbies 爱好 / Free Time 空闲 / Countries 国家 |
| 五 | Classmates 同学 / Teachers 老师 / Animals 动物 / Shopping Day 购物日 / TV Shows 电视节目 / Chores 家务 | Keeping Healthy 保持健康 / Special Days 特殊的日子 / Making Contact 取得联系 / Last Weekend 上周末 / Have a Great Trip 旅途愉快 / Growing Up 成长 |
| 六 | In China 在中国 / Around the World 世界各地 / Animal World 动物世界 / Feelings 情绪 / Famous People 名人 / Winter Vacation 寒假 | Visiting Canada 访问加拿大 / All Around Me 我周围的一切 / Daily Life 日常生活 / Free Time 空闲时间 / Nature and Culture 自然与文化 / Summer Vacation 暑假 |

想增改内容，直接编辑对应 `js/data-gN.js`，无需改动玩法代码。

## 📺 安卓电视 / 机顶盒版（APK）

英语乐园可以打包成安卓安装包，装到电视机或机顶盒上用**遥控器**玩。

工程位于 `android-app/`，是一个原生 `WebView` 壳：把本 H5 整体包进 `assets/`，加载 `index.html#tv` 即自动进入「遥控器模式」。兼容普通安卓机顶盒与 Android TV（首页横幅入口）。

### 适配做了什么
- **遥控器方向键（D-pad）导航**：自动给所有可点元素打焦点，方向键在卡片/选项间按几何最近邻移动，确认键（OK/Enter）选中并触发点击。
- **横屏大屏布局**：放宽页面宽度、放大字号、网格多列。电视端（`body.tv`）额外做了**比手机更醒目**的样式——焦点光晕加粗放大、开关放大到 92×50 并带「开/关」文字与强描边、图标与 emoji 再放大，沙发远距离也看得清。
- **发音**：电视盒子常无系统语音包，自动强制走有道 MP3（需联网）。
- **跟读（麦克风）**：带麦遥控器（如部分 Android TV / 机顶盒语音遥控）通过原生 `SpeechRecognizer` 桥接实现**真跟读打分**，首次使用会请求录音权限；无麦克风或拒绝授权的设备自动隐藏麦克风按钮、改为「✅ 我读啦，过关」兜底，不会卡关。

> 手机 / 桌面浏览器打开**完全不受影响**——TV 适配仅在 `#tv` 模式或电视/盒子 UA 下启用。

### 本机构建 APK
需要：Android Studio（或 Android SDK + Gradle）、一台能联网下载依赖的电脑。

**方式一（推荐）**：用 Android Studio 打开 `android-app/` 目录 → 菜单 **Build → Generate Signed Bundle / APK** → 选 **APK** → 生成签名（或先用默认 debug key）→ 构建完成后产物在 `android-app/app/build/outputs/apk/release/app-release.apk`（或 `debug/` 目录）。

**方式二（命令行）**：
```bash
cd android-app
./gradlew assembleRelease   # 首次会自动补齐 gradle wrapper
```

> ⚠️ 本沙箱到 Google 下载源（Android SDK / Gradle 依赖）被网络拦截，无法在此直接编译出 APK；请用下面的方式三（GitHub Actions）或在本机出包。

**方式三（推荐，免本地环境）**：仓库已内置 `.github/workflows/build.yml`。推送后 GitHub 海外服务器会自动构建；也可在仓库 **Actions → Build Android APK (TV + Phone) → Run workflow** 手动触发。约 5–10 分钟后，在页面底部 **Artifacts** 下载：

| 产物名 | 对应工程 | 适用设备 |
|---|---|---|
| `EnglishPlaygroundTV-apk` | `android-app/` | 电视 / 机顶盒（遥控器模式） |
| `EnglishPlaygroundPhone-apk` | `android-phone/` | 安卓手机（原版 H5 样式） |

产物为 debug 签名 APK，开启「未知来源」即可直接安装。

> 需要登录 GitHub 才能下载产物，安装包不对外公开提供直链下载。

### 安装到电视 / 机顶盒
- **ADB（推荐）**：电视需开启「开发者选项 → 网络调试 / USB 调试」，与电脑同一局域网：
  ```bash
  adb connect <电视IP>:5555
  adb install app-release.apk
  ```
- 或把 APK 拷到 U 盘，在电视文件管理器里点击安装。
- 普通安卓机顶盒直接安装即可；Android TV 会在首页以横幅（banner）形式显示入口。

### 已知限制
- 发音需联网（有道 MP3）；离线环境点读无声音。
- 跟读真识别依赖系统语音服务（Google 语音识别）。部分无麦或没装语音服务的盒子会自动回落「我读啦」手动兜底；首次使用会弹录音授权。
- 建议横屏使用；老旧盒子若 WebView 版本过旧，可在应用商店升级「Android System WebView」。

## 📱 安卓手机版（APK）

给手机用的安装包，**界面完全沿用原版 H5 的移动端样式**（不是电视大屏那套）。

工程位于 `android-phone/`，与电视版的差别只有"壳"部分，H5 内容共用同一份：

| 项目 | 电视版 `android-app/` | 手机版 `android-phone/` |
|---|---|---|
| 加载地址 | `index.html#tv`（遥控器模式） | `index.html`（原版手机样式） |
| 屏幕方向 | 横屏 landscape | 竖屏 portrait |
| 桌面入口 | `LAUNCHER` + `LEANBACK_LAUNCHER` | 仅 `LAUNCHER`（不出现在电视桌面） |
| TV 横幅 | 有 banner | 无 |
| 触摸屏 | `required=false` | `required=true` |
| 包名 | `com.example.englishplayground` | `com.example.englishplayground.phone` |

> 包名不同，所以**电视版和手机版可以同时装在一台设备上，互不覆盖**。

手机版同样带**原生 `SpeechRecognizer` 麦克风桥接**，跟读游戏可以真读真打分（首次使用弹录音授权，拒绝则回落「✅ 我读啦，过关」）。

### 构建与安装
与电视版完全相同，三选一：Android Studio 打开 `android-phone/`、命令行 `./gradlew assembleDebug`、或用仓库内置的 **GitHub Actions**（下载 `EnglishPlaygroundPhone-apk` 产物）。

装到手机：把 APK 传到手机（微信/QQ/数据线均可）→ 点击安装 → 允许「未知来源」→ 打开即可，使用体验与浏览器里打开 H5 一致。
