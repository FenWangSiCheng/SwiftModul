# !/bin/bash

SECONDS=0
is_workspace="true"
scheme_name="FireProtectionClient"
info_plist_name="Info"
build_configuration="Release"
ExportOptionsPlistPath="./ExportOptionsPlist/AdHocExportOptionsPlist.plist"
cd ..
project_name=`find . -name *.xcodeproj | awk -F "[/.]" '{print $(NF-1)}'`

info_plist_path="$project_name/$info_plist_name.plist"
bundle_version=`/usr/libexec/PlistBuddy -c "Print CFBundleShortVersionString" $info_plist_path`

rm -rf ./$scheme_name-IPA-AdHoc/$scheme_name.xcarchive
export_path=./$scheme_name-IPA-AdHoc
export_archive_path="$export_path/$scheme_name.xcarchive"
export_ipa_path="$export_path"
ipa_name="$scheme_name-v$bundle_version"

echo "\033[32m*************************  开始构建项目  *************************  \033[0m"
if [ -d "$export_path" ] ; then
echo $export_path
else
mkdir -pv $export_path
fi

if $is_workspace ; then
xcodebuild clean -workspace ${project_name}.xcworkspace \
                 -scheme ${scheme_name} \
                 -configuration ${build_configuration}

xcodebuild archive -workspace ${project_name}.xcworkspace \
                   -scheme ${scheme_name} \
                   -configuration ${build_configuration} \
                   -archivePath ${export_archive_path}
else
xcodebuild clean -project ${project_name}.xcodeproj \
                 -scheme ${scheme_name} \
                 -configuration ${build_configuration}
xcodebuild archive -project ${project_name}.xcodeproj \
                   -scheme ${scheme_name} \
                   -configuration ${build_configuration} \
                   -archivePath ${export_archive_path}
fi


if [ -d "$export_archive_path" ] ; then
echo "\033[32;1m项目构建成功 🚀 🚀 🚀  \033[0m"
else
echo "\033[31;1m项目构建失败 😢 😢 😢  \033[0m"
exit 1
fi

echo "\033[32m*************************  开始导出ipa文件  *************************  \033[0m"
xcodebuild  -exportArchive \
            -archivePath ${export_archive_path} \
            -exportPath ${export_ipa_path} \
            -exportOptionsPlist ${ExportOptionsPlistPath}

mv $export_ipa_path/$scheme_name.ipa $export_ipa_path/$ipa_name.ipa

if [ -f "$export_ipa_path/$ipa_name.ipa" ] ; then
echo "\033[32;1m导出 ${ipa_name}.ipa 包成功 🎉  🎉  🎉   \033[0m"
else
echo "\033[31;1m导出 ${ipa_name}.ipa 包失败 😢 😢 😢     \033[0m"
exit 1
fi
echo "\033[36;1m使用PPAutoPackageScript打包总用时: ${SECONDS}s \033[0m"


