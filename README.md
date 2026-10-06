# Лендинг ООО «ФЕЛ ИКС»

Сайт компании **ООО «ФЕЛ ИКС»** — комплексное сопровождение бизнеса в сфере B2B/B2C-маркетинга и IT.

- Сайт компании: [falx-b2b.ru](https://falx-b2b.ru)
- Головной офис: Саратов, 3-й Дегтярный проезд, 3д 21 стр 3
- Телефон: 8 926 371-42-00
- График работы: Пн–вс, 09:00 — 20:00

Собрано на [Nuxt UI](https://ui.nuxt.com).

## Структура

Весь контент страницы хранится в `content/index.yml` и проверяется Zod-схемой из `content.config.ts`.

| Секция | Ключ в YAML | Якорь |
| --- | --- | --- |
| Первый экран | `hero`, `terminal`, `logos` | — |
| Услуги | `features` | `#services` |
| Как мы работаем | `process` | `#process` |
| О компании | `about` | `#about` |
| Факты о компании | `metrics` | `#metrics` |
| Контакты | `contacts` | `#contacts` |
| Призыв к действию | `cta` | — |

Чтобы изменить текст, телефон или адрес, отредактируйте `content/index.yml` — компоненты подхватят изменения автоматически.

## Setup

Установите зависимости:

```bash
pnpm install
```

## Development Server

Запустите dev-сервер на `http://localhost:3000`:

```bash
pnpm dev
```

## Production

Соберите приложение для production:

```bash
pnpm build
```

Локальный предпросмотр production-сборки:

```bash
pnpm preview
```

Подробнее о деплое — в [документации Nuxt](https://nuxt.com/docs/getting-started/deployment).
