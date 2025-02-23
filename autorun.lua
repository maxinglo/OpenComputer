local fs=require("filesystem") --导入了 OC 提供的文件系统模块。
local arg = { ... } --获取此脚本的可变参数列表
local p=arg[1] --获取此脚本的第一个参数，这里参数是 OS 帮忙给传的一个代理，代理是什么？代理就是文件系统的把柄，抓住了代理就可以为所欲为了。
fs.mount(p,"/home") --传代理，将其对应的文件系统挂载到/home目录下，你也可以选择挂载到别的地方。
print("Successfully Mounted") --加一条提示信息表明挂载成功。