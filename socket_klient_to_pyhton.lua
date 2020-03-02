is_run = true
t_orders = {} -- создается пустая таблица для сохранения номеров сделок

function main()
    while is_run do
        sleep(50)
    end;
end

function soket_klient (dates) --функция для запуска клиента сокет для отправки серверу сокет сообщения
	local socket = require("socket")
	host = host or "localhost"
	port = port or 8888
	c = assert(socket.connect(host, port))	
	c:send(dates)
end

function OnStop() 
    is_run = false
end

function OnTrade (trade_data) -- функция вызывается когда происходит сделка 
		if t_orders[trade_data.trade_num] then -- если в таблице t_orders сделка уже была с таким номером, то сообщение не отправляется
			return -- так как функция OnTrade срабатывает три раза при каждой сделке
		end
		t_orders[trade_data.trade_num] = true -- записываем в таблицу номер прошедшей сделки (чтобы больше не отправлять инфу о ней)
        summ=trade_data.value -- объем сделки (если нужно отправлять в телеграм - добавить переменную в строку 36 (kl_to_serv....)
		instr=trade_data.sec_code --код инструмента
		cena=trade_data.price -- цена в сделке
		kol=trade_data.qty -- количство лотов в сделке
		kod_klienta=trade_data.client_code -- код клиента
		if (kod_klienta=='412438') then  --если у вас другой код клиента, напишите свой в кавычках
			kod_klienta = 'втб' -- если у вас другой брокер напишите своего брокера в кавычках
		end
		operat=trade_data.side_qualifier --определяется направлениевление сделки
		kl_to_serv= instr..' .  '..operat..'. количество '..kol..' . цена '..cena..' . брокер '..kod_klienta
		soket_klient(kl_to_serv)
		message ("instrument " .. tostring(kl_to_serv))
end