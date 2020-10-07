# Наносервис

Прототип микросервиса , обеспечивающий эмуляцию отправки сообщений в популярные сервисы 
instant messaging (Viber, Telegram, What’s App).

## Установка

```
$ bundle install
$ gem install foreman
$ yarn install

$ rake db:create
$ rake db:migrate
$ rake db:seed
```

## Использование

Запускаем сервер.
```
foreman start -f Procfile.dev
```

Запрос на авторизацию.

POST http://localhost:3000/api/v1/sign_in
```json
{
 "user": {
  "email":"admin@nanoservice.ru",
  "password":"Pas$W0rd"
 }
}
```

Отправка сообщения.

POST http://localhost:3000/api/v1/messages
```json
{
	"body": "Привет! Эта наша первая рассылка :)",
	"dispatches_attributes": [
		{
			"phone": "+79308409858",
			"messenger_type": "telegram" 
		},
		{
			"phone": "+79308409858",
			"messenger_type": "viber"
		},
		{
			"phone": "+79308509158",
			"messenger_type": "telegram", 
			"send_at": "2020-10-07 22:04:48.586544 +0300"
		},
		{
			"phone": "+79308509258",
			"messenger_type": "whatsapp",
			"send_at": "2020-10-07 22:04:48.586544 +0300"
		}
	]
}
```
