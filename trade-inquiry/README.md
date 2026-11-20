# 外贸询盘独立站（Cloudflare Pages + Pages Functions + D1）

## 目录结构
```
trade-inquiry/
├── wrangler.toml          # Pages / D1 绑定配置
├── schema.sql             # D1 建表 SQL
├── public/                # 静态前端（Pages 输出目录）
│   ├── index.html
│   ├── products.html
│   ├── product-detail.html
│   ├── about.html
│   ├── contact.html
│   └── admin/
│       ├── login.html
│       └── dashboard.html
└── functions/api/         # Pages Functions 后端接口
    ├── login.js
    ├── logout.js
    ├── submit-inquiry.js
    ├── inquiry-list.js
    ├── inquiry-update.js
    ├── inquiry-delete.js
    └── export-csv.js
```

## 链接说明（全部相对路径）
- 页面互链使用站点根相对路径，如 `/products.html`、`/admin/login.html`，换域名/换环境无需改代码。
- 前端接口请求统一走 `/api/...`，由 `functions/api/` 目录自动映射。

## 部署步骤
1. Cloudflare 控制台 → Workers & Pages → D1 → 创建数据库，复制 **Database ID**。
2. 编辑 `wrangler.toml`，把 `database_id` 的 `REPLACE_YOUR_D1_ID` 替换为上一步的 ID。
3. 在 D1 控制台的 SQL 编辑器中执行 `schema.sql` 建表。
4. 创建 Pages 项目（连接 Git 或直接上传本目录）：
   - 构建命令：留空
   - 构建输出目录：`public`
5. 项目 → Settings → D1 database bindings，绑定名称填 `DB`（与 wrangler.toml 中 binding 一致）。
6. 部署完成后访问：
   - 前台：`/`
   - 后台：`/admin/login.html`（默认账号 `admin` / 密码 `admin123`，上线前请在 `functions/api/login.js` 修改）

## 后台状态含义
- new 新询盘 / follow 跟进中 / quoted 已报价 / closed 成交 / invalid 无效
- 支持备注保存、删除、导出 CSV。

## 注意
- 当前登录为简易 Cookie 校验（仅判断存在 session Cookie），适合自用小站；商用建议改为 KV 存储的真实 Session 或 JWT。
- 默认账号密码在 `functions/api/login.js` 顶部 `ADMIN_USER` / `ADMIN_PASS`，务必修改。
