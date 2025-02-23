component=require("component")
os=require("os")
sides=require("sides")
 
local all_transposers={}
local n=0
 
local side_output_hatch=sides.down -- 此处为输出仓的方位
local side_buffer=sides.up -- 此处为想要输出给的缓存器的方位(比如超级缸等)
local fluid_ratio=0.485 -- 此处为控制输出仓中流体的比例,通常为0.5（但是为了连续运行0.485+大输出仓更好）
 
for i,j in pairs(component.list()) do 
	if(j=="transposer")then
		print("find transposer:",i,j)
		all_transposers[n]=component.proxy(i)
		n=n+1
	end
end
-- 此处为获取所有的转运器
 
-- 无限循环,如果想新加入转运器的话直接加入转运器,随后关机再启动程序即可
while(true)do
	for index,trans in pairs(all_transposers)do
		local current_fluids=trans.getFluidInTank(side_output_hatch)
		if(current_fluids~=nil and current_fluids[1]~=nil and current_fluids[1].amount>current_fluids[1].capacity*fluid_ratio)then
			local fluid_count=current_fluids[1].amount-current_fluids[1].capacity*fluid_ratio
			local res=trans.transferFluid(side_output_hatch,side_buffer,fluid_count)
			if(res==false)then
				print("transfer fluid failed , address: ",trans.address)
			else
				print("transferred ",fluid_count," mb fluid")
			end
		end
	end
	os.sleep(0.05) -- 每次转运后延迟1t,如果觉得转运速度不够快可以尝试删除
end