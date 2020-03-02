is_run = true
t_orders = {} -- ��������� ������ ������� ��� ���������� ������� ������

function main()
    while is_run do
        sleep(50)
    end;
end

function soket_klient (dates) --������� ��� ������� ������� ����� ��� �������� ������� ����� ���������
	local socket = require("socket")
	host = host or "localhost"
	port = port or 8888
	c = assert(socket.connect(host, port))	
	c:send(dates)
end

function OnStop() 
    is_run = false
end

function OnTrade (trade_data) -- ������� ���������� ����� ���������� ������ 
		if t_orders[trade_data.trade_num] then -- ���� � ������� t_orders ������ ��� ���� � ����� �������, �� ��������� �� ������������
			return -- ��� ��� ������� OnTrade ����������� ��� ���� ��� ������ ������
		end
		t_orders[trade_data.trade_num] = true -- ���������� � ������� ����� ��������� ������ (����� ������ �� ���������� ���� � ���)
        summ=trade_data.value -- ����� ������ (���� ����� ���������� � �������� - �������� ���������� � ������ 36 (kl_to_serv....)
		instr=trade_data.sec_code --��� �����������
		cena=trade_data.price -- ���� � ������
		kol=trade_data.qty -- ��������� ����� � ������
		kod_klienta=trade_data.client_code -- ��� �������
		if (kod_klienta=='412438') then  --���� � ��� ������ ��� �������, �������� ���� � ��������
			kod_klienta = '���' -- ���� � ��� ������ ������ �������� ������ ������� � ��������
		end
		operat=trade_data.side_qualifier --������������ ����������������� ������
		kl_to_serv= instr..' .  '..operat..'. ���������� '..kol..' . ���� '..cena..' . ������ '..kod_klienta
		soket_klient(kl_to_serv)
		message ("instrument " .. tostring(kl_to_serv))
end