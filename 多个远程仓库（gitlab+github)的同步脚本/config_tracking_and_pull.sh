
#!/bin/bash

branch_local=master
branch_remote=master
remote_gitlab=origin
remote_github=origin-github

shellDir=$(dirname $0)
cd $shellDir
echo -e "shellDir:$shellDir\npwd:$(pwd)"

git_root_path=$(pwd)/../



show_branch_config()
{
	local_branch=$1
	config_remote=$(git config branch.${local_branch}.remote)
	config_remote_branch=$(git config branch.${local_branch}.merge|cut -d / -f3)
	# echo -e "-------------当前本地分支:$local_branch 跟踪的远程仓库为:$config_remote (for git fetch)"
	# echo -e "-------------当前本地分支:$local_branch 合并的源分支为:$config_remote_branch (for git merge)"
	# echo -e "-------------综上，当前git pull的配置，是从远程仓库:$config_remote 的分支:$config_remote_branch 合并内容到本地分支:$local_branch"
	echo -e "⏬⏬⏬⏬⏬⏬⏬⏬⏬⏬⏬[$local_branch]<․․․․․․․․․[$config_remote/$config_remote_branch]⏬⏬⏬⏬⏬⏬⏬⏬⏬⏬⏬⏬"
}


config_local_branch_tracking_remote_branch_before_git_pull()
{
	local_branch=$1
	remote=$2
	remote_branch=$3
	# echo -e "-------------------------- 修改前 --------------------------"
	# show_branch_config $local_branch

	if [ -z "$local_branch" -o -z "$remote" -o -z "$remote_branch" ]; then
		echo -e "入参为空!!local_branch:($local_branch),remote:($remote),remote_branch:($remote_branch)"
	else
		echo -e "正在配置本地分支:$local_branch 跟踪远程分支:$remote/$remote_branch..."
		git config branch.${local_branch}.remote ${remote}
		git config branch.${local_branch}.merge refs/heads/${remote_branch}
		echo -e "-------------------------- 修改后 --------------------------"
		show_branch_config $local_branch
	fi
}


main()
{
	# 每个项目需要单独配置此项 ./remote_config
	echo -e "☀︎☀︎☀︎☀︎☀︎☀︎☀︎☀︎☀︎☀︎☀︎☀︎☀︎☀︎☀︎☀︎☀︎☀︎☀︎☀︎☀︎☀︎☀︎☀︎☀︎☀︎☀︎☀︎☀︎☀︎☀︎ 执行git pull操作 ☀︎☀︎☀︎☀︎☀︎☀︎☀︎☀︎☀︎☀︎☀︎☀︎☀︎☀︎☀︎☀︎☀︎☀︎☀︎☀︎☀︎☀︎☀︎☀︎☀︎☀︎☀︎☀︎☀︎☀︎☀︎"
	echo -e "====================== pwd:🏠🏠🏠🏠🏠🏠🏠🏠🏠🏠[$(pwd)]🏠🏠🏠🏠🏠🏠🏠🏠🏠\n脚本执行开始时间:$(date '+%Y.%m.%d %H:%M:%S-%A') =========================="

	echo -e "\n--------更新git pull前置..."
	config_local_branch_tracking_remote_branch_before_git_pull $branch_local $remote_gitlab $branch_remote;git pull
	echo -e "\n--------更新git pull前置..."
	config_local_branch_tracking_remote_branch_before_git_pull $branch_local $remote_github $branch_remote;git pull
	echo -e "\n--------还原配置..."
	config_local_branch_tracking_remote_branch_before_git_pull $branch_local $remote_gitlab $branch_remote

	echo -e "☀︎☀︎☀︎☀︎☀︎☀︎☀︎☀︎☀︎☀︎☀︎☀︎☀︎☀︎☀︎☀︎☀︎☀︎☀︎☀︎☀︎☀︎☀︎☀︎☀︎☀︎☀︎☀︎☀︎☀︎☀︎ 执行git pull 操作结束 ☀︎☀︎☀︎☀︎☀︎☀︎☀︎☀︎☀︎☀︎☀︎☀︎☀︎☀︎☀︎☀︎☀︎☀︎☀︎☀︎☀︎☀︎☀︎☀︎☀︎☀︎☀︎☀︎☀︎☀︎☀︎"
	echo -e "====================== pwd:[$(pwd)] 脚本执行结束时间:$(date '+%Y.%m.%d %H:%M:%S-%A') =========================="
	echo -e "✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅\n\n"
}

main