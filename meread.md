# 后端启动
## 参考地址
    https://docs.dify.ai/zh-hans/getting-started/install-self-hosted/local-source-code
## 编译启动步骤
1. 先部署 PostgreSQL / Redis / Weaviate（如果本地没有的话）,PostgreSQL / Redis必须得有，可以参考菜鸟教程
2. 安装Python 3.12，切记先安装homebrew，通过brew命令安装python
3. cd api
4. brew install libmagic
5. cp .env.example .env
6. awk -v key="$(openssl rand -base64 42)" '/^SECRET_KEY=/ {sub(/=.*/, "=" key)} 1' .env > temp_env && mv temp_env .env
7. poetry env use 3.12 
8. poetry install
9. poetry run flask db upgrade   数据库迁移，需看下原理，同时看下表结构怎么生成的
10. 配置redis用户名和密码，本地启动redis服务没有，需要为default用户在redis.conf配置密码requirepass admin
11. .env文件修改redis配置，包括api服务启动配置，celery服务异步任务启动配置 
    # redis configuration
    REDIS_HOST=localhost
    REDIS_PORT=6379
    REDIS_USERNAME=default
    REDIS_PASSWORD=admin
    REDIS_USE_SSL=false
    REDIS_DB=1
    # celery configuration
    CELERY_BROKER_URL=redis://default:admin@localhost:${REDIS_PORT}/1
12. 配置weaviate
    https://console.weaviate.cloud/cluster-details/2dde2216-e8cf-4890-b815-98b05e84a82e
    user:gmail
    pas:Aphone@tao
11. poetry run flask run --host 0.0.0.0 --port=5001 --debug   启动后端服务
12. poetry run celery -A app.celery worker -P gevent -c 1 -Q dataset,generation,mail,ops_trace --loglevel INFO   启动 Worker 服务，用于消费异步队列任务，如知识库文件导入、更新知识库文档等异步操作

## 编译启动插件依赖daemon服务dify-plugin-daemon
1. 项目地址：https://github.com/langgenius/dify-plugin-daemon?tab=readme-ov-file
2. 参考文档： https://blog.csdn.net/u011334211/article/details/146925061
3. brew install go
4. dify-plugin-daemon项目目录脚本执行
   .script/install.sh
5. dify-plugin-daemon项目根目录配置文件.env
   copy .env.example .env
6. 修改postgresql和redis配置
7. 运行服务（使用的golang idea，找到main.go执行）
   cmd/server/main.go

# 前端启动
## 参考地址
    https://docs.dify.ai/zh-hans/getting-started/install-self-hosted/local-source-code
## 编译启动步骤
1. 先安装nvm，用于多版本node管理 
   curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
2. 查看nvm版本
   nvm --version
3. 查看远端node版本
   nvm ls-remote
4. 查看本地node版本
   nvm ls
5. 安装node
   nvm install node  安装最新版本 
   nvm install --lts  安装最新稳定版本
6. 使用指定版本node
   nvm use v23.11.0
7. 全局安装pnpm
   npm install -g pnpm
8. cd web
9. pnpm install
10. 在当前目录下创建文件 .env.local，并复制.env.example中的内容
11. pnpm build
12. pnpm start