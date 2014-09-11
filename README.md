Rathole
==========

## Как запустить у себя?

Чтобы запустить нору у себя на машине нужно, для начала забрать исходный код:

```
git clone https://github.com/kimrgrey/rathole.git
cd rathole
```

Теперь нам потребуется пустая база данных. Лично я рекомендую PostgreSQL 9.3, ибо в коде приложения есть куски, связанные с такими специфичными для PG типами, как Array и HStore.

Сначала заходим от имени администратора СУБД:

```
psql -U postgres
```

Теперь создаем нужные нам роль, пользователя и базу данных:

```sql
CREATE ROLE rathole_owner;
CREATE USER rathole;
GRANT rathole_owner TO rathole;
CREATE DATABASE rathole_development WITH OWNER rathole_owner;
```

Затем логинимся от имени администратора в только что созданную базу:

```
 psql -U postgres -d rathole_development
```

И включаем там поддержку HStore:

```sql
CREATE EXTENSION IF NOT EXISTS hstore;
```

Создаем файл с конфигом БД, который будут использоваться Rails для подключения:

```
cp config/database.yml.example config/database.yml
```

Аналогично копируем конфиг с необходимыми настройками приложения

```
cp config/secrets.yml.example config/secrets.yml
```

Откройте `secrets.yml` в любимом текстовом редакторе и заполните все настройки, имеющие отношение к `development`-среде. Токены для сессии и Devise легко сгенерировать при помощи  команды `bundle exec rake secret`. Разделы test и production из конфига можно смело удалять. 

Кроме того, для работы приложения понадобится [redis](http://redis.io/). Он используется для быстрого доступа к списку событий пользователя. Предполагается, что redis будет установлен на той же машине, на которой запускается приложение и запущен по адресу `127.0.0.1:6379`.

Что ж... Вроде приготовления закончены? Самое время инициировать структуру базы данных и запустить приложение:

```
bundle exec rake db:schema:load
bundle exec rails server
```

Открываем в браузере http://localhost:3000/ и развлекаемся! 

P.S. Я бы еще рекомендовал добавить `rathole.dev` в локальные хосты  (читай, в файл `/etc/hosts` для Linux) и использовать этот адрес для дальнейшей  разработки. Либо изменить конфиг `default_url_options` в файле  `config/development.rb` на симпатичное вам (и, разумеется, работающее) значение.

## Как включить поддержку стикеров?

Стикеры на сайте выдаются за те или иные достижения, например, за первый пост, десять постов или максимальное количество комментариев. Для того, чтобы иметь возможность стикеры раздавать, необходимо сначала их инициализировать. Для этого достаточно выполнить следующую команду:

```
bundle exec rake stickers:create_from_scratch
```

Для распределения каждого из существующих стикеров используется отдельная задача, например:

```
bundle exec rake stickers:post_number_1
bundle exec rake stickers:post_number_10
bundle exec rake stickers:post_number_100
bundle exec rake stickers:best_author
bundle exec rake stickers:best_commentator
bundle exec rake stickers:best_corrector
```

В production-окружении все эти таски выполняются автоматически единой задачей примерно раз в сутки:

```
bundle exec rake stickers:distribute
```

## Как можно использовать?

Вообще говоря, было бы здорово, если бы вы поучаствовали в разработке той платформы, которая [уже запущена и существует](http://rathole.io). Для этого достаточно исправить какой-нибудь косяк или добавить новую функциональность, а затем прислать pull request мне. Однако никто вас не остановит и в том случае, если вы решите запустить свою копию крысиной норы. Короче, делайте, что хотите, на свой страх и риск :wink:

## License

The MIT License (MIT)

Copyright (c) 2013 Sergey Tsvetkov

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
