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

## 📱 安卓 APK（手机 / 平板 / 电视 一个包）

英语乐园打成一个**通用安装包**：手机、平板、电视、机顶盒装的是同一个 APK，
不再区分「手机版 / 电视版」。工程位于 `android-universal/`，是一个原生 `WebView` 壳，
把本 H5 整体包进 `assets/` 后加载 `file:///android_asset/index.html`。

### 一个包怎么同时伺候三种设备

| 能力 | 做法 |
|---|---|
| 桌面入口 | 同时声明 `LAUNCHER` 与 `LEANBACK_LAUNCHER`，手机桌面和 Android TV 首页横幅都出现 |
| 屏幕方向 | 不写死：电视锁横屏、手机锁竖屏、平板（`sw ≥ 600dp`）交给系统自由旋转 |
| TV 模式判定 | 原生桥 `AndroidDevice.isTV()` 三重兜底（UiMode / leanback feature / 无触摸屏），比 UA 猜测准；浏览器里仍可用 `#tv` 强制模拟 |
| 硬件特性 | 触摸屏、麦克风、leanback 全部 `required=false`，无触摸屏的盒子不会被商店过滤掉 |
| 遥控器导航 | D-pad 方向键几何最近邻移动焦点，确认键触发点击；返回键先交给 H5 导航栈 |
| 跟读（麦克风） | 原生 `SpeechRecognizer` 桥接（`en-US`），无麦或拒授权自动回落「✅ 我读啦，过关」 |

> 包名统一为 `com.example.englishplayground`（旧的 `.phone` 包名已废弃）。
> 手机 / 桌面浏览器打开 H5 **完全不受影响**——TV 适配仅在判定为电视时启用。

### 构建 APK

**方式一：GitHub Actions（推荐，免本地环境）**
推送后自动构建；也可在仓库 **Actions → Build Android APK (Universal) → Run workflow** 手动触发。
约 5–10 分钟后在页面底部 **Artifacts** 下载 `EnglishPlayground-apk`
（CI 里重命名为 `EnglishPlayground.apk`，并随 Pages 发布到 `…/English/apk/` 供应用内升级）。

> ⚠️ CI 出包依赖 4 个签名 Secret（`KEY_ALIAS` / `KEYSTORE_STORE_PASS` / `KEYSTORE_KEY_PASS` / `KEYSTORE_BASE64`），
> 没填则只出未签名包（装不上）。签名密钥不入库，见 `setup-keystore.sh`。

**方式二：Android Studio / 命令行**
```bash
cd android-universal
./gradlew assembleRelease
```

### 安装
- **手机 / 平板**：APK 传到设备后点击安装，允许「未知来源」即可。
- **电视 / 机顶盒**：`adb connect <电视IP>:5555 && adb install app-release.apk`，或拷 U 盘在电视文件管理器里装。
- ⚠️ 若设备上装过旧版（电视版 / 手机版），因**签名已更换**无法覆盖升级，请先卸载旧版再安装。

### 已知限制
- 发音需联网（有道 MP3）；离线环境点读无声音。
- 跟读真识别依赖系统语音服务；无麦或没装语音服务的盒子自动回落手动兜底。
- 老旧盒子若 WebView 版本过旧，可在应用商店升级「Android System WebView」。
