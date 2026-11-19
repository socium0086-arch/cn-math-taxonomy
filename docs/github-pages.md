# GitHub Pages 设置（本 fork）

## 你应该打开的地址

| | |
| --- | --- |
| **站点（给用户看）** | https://socium0086-arch.github.io/cn-math-taxonomy/ |
| **Pages 设置（管理员）** | https://github.com/socium0086-arch/cn-math-taxonomy/settings/pages |
| **仓库** | https://github.com/socium0086-arch/cn-math-taxonomy |

这是 **project site**：页面在 `/cn-math-taxonomy/` 下，不是 `https://socium0086-arch.github.io/` 根路径。

## 常见错误：开到了别的仓库

如果 Settings 里显示的 live URL 是例如：

- `https://socium0086-arch.github.io/my-assets/`

那说明你在 **`my-assets`**（或其它仓库）里开了 Pages，**不会**发布 `cn-math-taxonomy`。请关掉那个页面，改开上面表格里的 **cn-math-taxonomy** 设置链接。

## 一次性步骤

1. 用浏览器打开：  
   https://github.com/socium0086-arch/cn-math-taxonomy/settings/pages
2. **Build and deployment → Source** 选 **GitHub Actions**，保存。
3. 打开 https://github.com/socium0086-arch/cn-math-taxonomy/actions/workflows/pages.yml  
   → **Run workflow** → branch `main` → Run。
4. 等绿色成功后访问：  
   https://socium0086-arch.github.io/cn-math-taxonomy/

首次启用后，以后每次 push 到 `main` 都会自动重新部署。

## 部署失败时

日志里若出现：

```text
Failed to create deployment (status: 404) … Ensure GitHub Pages has been enabled
```

→ 回到「一次性步骤」第 1–2 步，确认是在 **cn-math-taxonomy** 仓库、Source 已是 **GitHub Actions**，再 Run workflow。

Agents / 自动化 token **无法**代替你点这个开关（GitHub API 返回 403）。

## 本地对照

```bash
./scripts/serve-local.sh
# http://127.0.0.1:8765/
```

本地预览与 Pages 产物相同（含相对路径的 `kp/` 页），不依赖 GitHub Pages 是否已开启。

## 不要用「Deploy static content to Pages」模板

GitHub 的 starter workflow（`.github/workflows/static.yml`）会把**整个仓库原样**上传，**不会**运行 `prepare-gh-pages.sh`，因此没有生成的 `kp/` 知识点页。若它和本仓库的 `pages.yml` 同时跑，后结束的那次会覆盖站点：首页可能还能打开，但 `/kp/` 会 404/503。

请只保留 **Deploy GitHub Pages**（`pages.yml`）。若 Actions 里还有「Deploy static content to Pages」，删掉 `static.yml` 或在 Actions → 该 workflow → `...` → Disable。

