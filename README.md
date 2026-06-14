# Workerman Docker

基于 Workerman 的 HTTP 服务 Docker 镜像。

## 项目结构

```
├── Dockerfile           # Docker 镜像构建文件
├── composer             # Composer 可执行文件（静态编译）
├── php                  # PHP 可执行文件（静态编译）
├── entrypoint.sh        # 容器入口脚本
├── .dockerignore        # Docker 构建忽略规则
├── .gitattributes       # Git 换行符配置
└── app/                 # 应用代码
    ├── start.php        # 入口文件
    ├── composer.json    # Composer 依赖配置
    ├── composer.lock
    ├── vendor/          # Composer 依赖
    ├── runtime/         # 运行时目录
    └── storage/         # 存储目录
```

## 构建镜像

```bash
docker build -t workerman-php .
```

## 运行容器

启动服务：

```bash
docker run -d --name workerman -p 2345:2345 workerman-php
```

进入容器调试：

```bash
docker run -it --rm workerman-php sh
```

## docker-compose

```yaml
services:
  workerman:
    build: .
    image: workerman-php
    ports:
      - "2345:2345"
```

## 入口脚本行为

启动容器时 `entrypoint.sh` 自动执行：

1. 若 `vendor/` 不存在且存在 `composer.json`，自动运行 `composer install`
2. 若 `.env.example` 存在，生成 `.env`
3. 若传入命令（如 `sh`），执行该命令
4. 默认启动 Workerman 服务（daemon 模式）

## Windows 用户注意事项

`entrypoint.sh` 和 `Dockerfile` 必须使用 **LF 换行符**（Unix 格式），否则容器启动会失败。

`.gitattributes` 已配置自动处理，确保 Git 检出时保持 LF：

```bash
entrypoint.sh text eol=lf
Dockerfile text eol=lf
```

如果已在 Windows 上检出，执行以下命令修复：

```bash
git rm --cached -r . && git reset --hard
```
