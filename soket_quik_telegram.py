import socket
import telebot

#from telebot import apihelper #импорт библиотеки для работы с прокси сервером

#ip = '167.99.60.252' #варианты серверов, которые у меня работали
#port = '9050'
#ip = '193.183.187.228'
#port = '9699'

#apihelper.proxy = {'https': 'socks5://{}:{}'.format(ip,port)} #раскомментируйте, чтобы включить прокси сервер

token='Между кавычками вставить Токен своего чат бота'
bot = telebot.TeleBot (token)

sock=socket.socket(socket.AF_INET, socket.SOCK_STREAM)
sock.bind (('', 8888)) #между кавычками можно записать адрес, который будет слушать сервер (если пусто, любой адрес), вместо 8888 - можно использовать люой свободный порт
sock.listen (5) # цифра 5 в скобках означает количество сообщений в очереди, если одновменно придет много сообщений (можно увеличить или уменьшить)

while True:
    try:        
        client, adr = sock.accept()
    except KeyboardInterrupt:
        sock.close()
        break
    else:
        result = client.recv(1024)
        client.close()
        if result:            
            bot.send_message(111111111, result.decode('cp1251')) #вместо единиц вписать свой ID в Телеграмме 
            
            #bot.polling(none_stop=True)
        #print ('messge', result.decode('cp1251'))        
    

