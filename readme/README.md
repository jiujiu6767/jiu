# 粒子跃迁 ENERGY DRIFT —— 作品说明文档

> 一个专为「网络加载等待」场景打造的科技粒子风互动小游戏。用户在等待数据同步/页面加载时，驾驶光核飞船穿行数据流，收集能量、躲避碎片，让等待时间变成一局 30 秒的沉浸体验。

---

## 1. 作品简介

- **作品名称**：粒子跃迁 ENERGY DRIFT
- **作品类型**：网页互动小游戏（加载等待场景 / Loading Mini-Game）
- **目标用户**：处于网络加载等待中的用户
- **核心体验**：等待不再是空白进度条——加载在后台继续，用户随时可以来一局，也随时可以退出
- **界面风格**：科技粒子风（深空渐变、透视网格、多层粒子流、霓虹发光、玻璃拟态面板）
- **交付形态**：单 HTML 文件，零运行时依赖，可直接嵌入任何加载页

## 2. 环境依赖说明与一键安装

### 2.1 环境依赖

**运行时零第三方依赖**——全部代码为原生 HTML5 + CSS + JavaScript（ES2017），单文件自包含。

| 项目 | 要求 | 说明 |
|------|------|------|
| 浏览器 | Chrome / Edge / Firefox / Safari（近两年版本） | 需支持 Canvas 2D、Pointer Events、Web Audio API、backdrop-filter |
| 本地预览（可选） | Python 3.6+ 或任意静态文件服务器 | 仅用于本地起服务预览，非运行必需 |
| 操作系统 | 任意 | 桌面与移动端浏览器均可运行 |

### 2.2 一键安装

```bash
bash readme/install.sh
```

脚本会自动完成环境检查（浏览器无需安装，脚本仅校验本地预览服务器所需的 Python 环境）。本项目无任何需要下载的依赖。

### 2.3 部署运行步骤

**方式一：一键启动（推荐）**

```bash
bash readme/start.sh
```

自动在 `project/` 目录启动本地静态服务器（默认端口 8000），浏览器访问 `http://localhost:8000/` 即可。

**方式二：直接打开**

双击 `project/index.html`，或在浏览器中打开（`file://` 协议可直接运行；最佳纪录等 localStorage 功能推荐在 `http://` 环境下使用）。

**方式三：生产部署**

将 `project/index.html` 单文件复制到任意静态服务器、CDN 或对象存储静态托管即可，无需构建步骤。

### 2.4 集成到真实加载页

游戏通过全局接口与宿主页面的真实加载流程联动：

| 接口 | 作用 |
|------|------|
| `window.ENERGY_DRIFT.start()` | 开始一局游戏 |
| `window.ENERGY_DRIFT.pause()` / `resume()` | 暂停 / 恢复 |
| `window.ENERGY_DRIFT.finishLoading()` | 真实加载完成时调用，进度条立即置 100% 并显示 SYNC COMPLETE |
| `window.ENERGY_DRIFT.phase` / `score` | 只读属性：当前状态 / 当前得分 |

典型接入示例：

```html
<iframe src="energy-drift.html" id="game"></iframe>
<script>
  // 真实资源加载完成时通知游戏
  window.addEventListener('load', () => {
    document.getElementById('game').contentWindow.ENERGY_DRIFT.finishLoading();
  });
</script>
```

## 3. 额外使用的开源组件说明

**运行时：无。** 游戏本身不引用任何第三方 JS/CSS 库、字体或图片资源（图标为内联 SVG data URI，音效由 Web Audio API 实时合成）。

开发与提交物料过程中使用的开源工具（不进入运行时产物）：

| 组件 | 许可证 | 用途 |
|------|--------|------|
| Chromium | BSD-3-Clause | 无头浏览器自动化验证与演示视频录制 |
| Puppeteer（puppeteer-core） | Apache-2.0 | 驱动 Chromium 进行自动化测试 |
| FFmpeg（经 imageio-ffmpeg 分发） | LGPL-2.1+ | 将录屏帧序列合成为 `video/demo.mp4` |

## 4. 码道在项目开发中的应用总结

本项目由华为云码道（CodeArts）代码智能体端到端完成，AI 参与了从需求到交付的全流程：

| 阶段 | 码道的应用方式 |
|------|----------------|
| 需求理解 | 将「互动小游戏 / 加载等待 / 运动元素 / 科技粒子风」四个关键词解析为完整游戏设计文档（GDD）与状态机定义 |
| 技能调用 | 自动加载 game-maker 游戏开发技能，按其架构规范（状态机闭环、碰撞矩阵、反馈系统）生成代码 |
| 代码生成 | 一次生成约 1600 行的单文件完整工程：Canvas 渲染、粒子系统、状态机、碰撞检测、Web Audio 合成音效、localStorage 排行、响应式布局 |
| 自动化验证 | 通过无头 Chromium 实测：状态闭环、得分/连击/最佳分、暂停恢复、加载完成接口、移动端布局，并自动截图确认视觉效果 |
| 迭代修复 | 自动化验证发现 2 处问题（游戏结束页连击徽标残留、favicon 404），均在同一会话内定位并修复 |
| 视觉增强 | 根据截图评审结果追加漂浮光尘、纵向数据流线、底部能量光带三层粒子氛围，并重写移动端 HUD 为 Grid 布局 |
| 交付打包 | 按提交要求自动生成 ppt / project / video / codearts_proof / readme 完整提交包 |

详细过程记录见 `codearts_proof/码道应用过程记录.md`。

## 5. 目录结构

```
submission/
├── ppt/                  # 作品介绍 PPT
├── project/              # 完整工程源码（单文件，可复现运行）
│   └── index.html
├── video/                # 功能演示视频
├── codearts_proof/       # 码道使用证明材料
└── readme/               # 本说明文档 + 一键安装/启动脚本
```
