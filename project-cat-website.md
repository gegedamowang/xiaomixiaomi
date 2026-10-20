---
name: project-cat-website
description: Cat intro website for 小咪 built at workspace cat-site\index.html
  (static HTML, interactive commands, mood/grudge system), completed 2026-10-19
metadata:
  node_type: memory
  type: project
  originSessionId: sess_6601750b-92ab-478c-8c9a-704214ab740d
---

On 2026-10-19 I built a single-file static website introducing the user's cat 小咪 (see [[user-cat-xiaomi]]). Location: `C:\Users\葛葛大王的聪明计算机\.zcode\workspace\default\cat-site\` with `index.html` (all CSS/JS inline) and 6 photos renamed 01-bucket.jpg … 06-collar.jpg (originals in `D:\图片\` untouched). Features: profile, personality manual, photo gallery with lightbox, interactive area with 9 command buttons + free-text keyword matching, mood tiers (love/normal/sulk/angry), grudge-notebook system with revenge events, typewriter replies, avatar switching per state.

2026-10-20 updates: image paths flattened to bare filenames (no `images/` prefix, per user request); photos compressed to 1400px/q82 (~1.6MB total, kept in `cat-site\web\` and copied to cat-site root); a fully self-contained `cat-site\single\index.html` (~2.2MB, photos base64-embedded once in the JS IMG map, static attrs use 1px gif placeholders assigned at init) built by `cat-site\build-single.ps1` (keys in index.html IMG map must be single-space aligned or keyed replace fails). User deployed the site to GitHub Pages themselves; visitors couldn't see photos (jpgs missing from repo). EdgeOne Pages deploy was abandoned (no git/node on machine; user registered Tencent Cloud account but went GitHub route instead).

**Why:** User may ask for follow-up changes (new commands, colors, deployment) — the structure and image-name mapping are needed to edit it.

**How to apply:** Edit cat-site\index.html directly; image refs are bare `0X-name.jpg` in root (compressed versions). Rebuild single-file after edits via build-single.ps1. User communicated in Chinese; respond in Chinese. Also relevant: [[env-windows-shell]].
