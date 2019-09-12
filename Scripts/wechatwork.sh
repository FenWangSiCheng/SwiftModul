#! /bin/bash

KEY="2c481dc6-4094-4e7b-a1a3-035fb452a438"
APK_PATH=../FireProtectionClient-IPA/*.ipa
URL="https://qyapi.weixin.qq.com/cgi-bin/webhook/send?key=$KEY"
if [ -f $IPA_PATH ]; then
curl ${URL} \
-H 'Content-Type: application/json' \
-d '
{
"msgtype": "markdown",
"markdown": {
"content": "branch: '$1' \n version: '$2' \n '$3' 构建完成!
[]()
[点击下载](https://fenrir-inc.cn/gitlab/FireProtection/FireProtectionClient_iOS/-/jobs/'$4'/artifacts/download)"
}
}'

else
curl ${URL} \
-H 'Content-Type: application/json' \
-d '
{
"msgtype": "markdown",
"markdown": {
"content": "branch: '$1' \n version: '$2' \n '$3' 构建失败!
[]()
[点击查看详细](https://fenrir-inc.cn/gitlab/FireProtection/FireProtectionClient_iOS/-/jobs/'$4')"
}
}'

fi
