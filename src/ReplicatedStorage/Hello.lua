-- Hello module

local Hello = {}

function Hello.greeting(name)
	return ("Hello, %s"):format(name)
end

function Hello.hello_world()
	print(Hello.greeting("world"))
end

return Hello
