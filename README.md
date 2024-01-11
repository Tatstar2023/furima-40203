# README

# テーブル設計

## users テーブル

| Column              | Type   | Options                   |
| ------------------- | ------ | ------------------------- |
| nickname            | string | null: false               |
| email               | string | null: false, unique: true |
| encrypted_password  | string | null: false               |
| first_name_zenkaku  | string | null: false               |
| last_name_zenkaku   | string | null: false               |
| first_name_katakana | string | null: false               |
| last_name_katakana  | string | null: false               |
| birthday            | date   | null: false               |

### Association

- has_many :items
- has_many :orders

## items テーブル

| Column                | Type       | Options                        |
| --------------------- | ---------- | ------------------------------ |
| title                 | string     | null: false                    |
| description           | text       | null: false                    |
  ** ActiveHash **
| category_id           | integer    | null: false                    |
-----------------------------------------------------------------------
  ** ActiveHash **
| condition_id          | integer    | null: false                    |
-----------------------------------------------------------------------
  ** ActiveHash **
| shipping_fee_id       | integer    | null: false                    |
-----------------------------------------------------------------------
  ** ActiveHash **
| shipping_origin_id    | integer    | null: false                    |
-----------------------------------------------------------------------
  ** ActiveHash **
| shipping_lead_time_id | integer    | null: false                    |
-----------------------------------------------------------------------
| price                 | integer    | null: false                    |
| user                  | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- has_one    :order

## orders テーブル

| Column    | Type       | Options                        |
| --------- | ---------- | ------------------------------ |
| user      | references | null: false, foreign_key: true |
| item      | references | null: false, foreign_key: true |
| amount    | integer    | null: false                    |

### Association

- belongs_to :user
- belongs_to :item
- has_one    :shipment

## shipments テーブル

| Column           | Type       | Options                        |
| ---------------- | ---------- | ------------------------------ |
| postcode         | string     | null: false                    |
------------------------------------------------------------------
  ** ActiveHash **
| prefecture_id    | integer    | null: false                    |
------------------------------------------------------------------
| city             | string     | null: false                    |
| house_number     | string     | null: false                    |
| building_name    | string     |                                |
| telephone        | string     | null: false                    |
| order            | references | null: false, foreign_key: true |

### Association

- belongs_to :order