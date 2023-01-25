# テーブル設計

## users テーブル

| Column               | Type    | Options                   |
| -------------------- | ------- | ------------------------- |
| nickname             | string  | null: false               |
| email                | string  | null: false, unique: true |
| encrypted_password   | string  | null: false               |
| last_name            | string  | null: false               |
| first_name           | string  | null: false               |
| last_name_kana       | string  | null: false               |
| first_name_kana      | string  | null: false               |
| date_of_birth        | integer | null: false               |

### Association

- has_many :items
- has_many :orders

## items テーブル

| Column          | Type       | Options                        |
| --------------- | ---------- | ------------------------------ |
| name            | string     | null: false                    |
| description     | text       | null: false                    |
| category        | string     | null: false                    |
| condition       | string     | null: false                    |
| shipping_fee    | string     | null: false                    |
| region          | string     | null: false                    |
| delivery_time   | string     | null: false                    |
| price           | integer    | null: false                    |
| user            | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- has_one :order

## orders テーブル

| Column | Type       | Options                        |
| ------ | ---------- | ------------------------------ |
| user   | references | null: false, foreign_key: true |
| item   | references | null: false, foreign_key: true |

### Association

- belongs_to :item
- belongs_to :user
- has_one :delivery

## deliveries テーブル

| Column          | Type       | Options                        |
| --------------- | ---------- | ------------------------------ |
| postcode        | integer    | null: false                    |
| prefecture      | string     | null: false                    |
| municipality    | string     | null: false                    |
| address         | integer    | null: false                    |
| building_name   | string     |                                |
| phone_number    | integer    | null: false                    |
| order           | references | null: false, foreign_key: true |

### Association

- belongs_to :order