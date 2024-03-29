#!/usr/bin/env sh

# 确保脚本抛出遇到的错误
set -e

# 生成静态文件
npm run build

# 进入生成的文件夹
cd docs/.vuepress/dist

# deploy to github
# echo 'zhjwork.online' > CNAME
if [ -z "$GITHUB_TOKEN" ]; then
  msg='deploy'
  githubUrl=git@github.com:zhjnerv/zhjworkonline.git
else
  msg='来自github actions的自动部署'
  githubUrl=https://zhjnerv:${GITHUB_TOKEN}@github.com/zhjnerv/zhjworkonline.git
  git config --global user.name "zhjnerv"
  git config --global user.email "zhjwork@gmail.com"
fi
git init
git add -A
git commit -m "${msg}"
git push -f $githubUrl master:gh-pages # 推送到github

# deploy to coding
#echo 'www.zhjwork.online\zhjwork.online' > CNAME  # 自定义域名
#if [ -z "$CODING_TOKEN" ]; then  # -z 字符串 长度为0则为true；$CODING_TOKEN来自于github仓库`Settings/Secrets`设置的私密环境变量
#  codingUrl=git@e.coding.net:zhjwork/zhjwork/zhjwork.git
#else
#  codingUrl=https://HeupemlnXU:${CODING_TOKEN}@e.coding.net/zhjwork/zhjwork/zhjwork.git
#fi
#git add -A
#git commit -m "${msg}"
#git push -f $codingUrl master # 推送到coding

cd - # 退回开始所在目录
rm -rf docs/.vuepress/dist