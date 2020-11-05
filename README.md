# database design

## users table

| Column          | Type    | Options     |
| --------------- | ------- | ----------- |
| email           | string  | null: false |
| password        | string  | null: false |
| nickname        | string  | null: false |

### Association

- has_many :ballot_boxes
- has_many :votes
- has_many :rooms, through: :user_rooms
- has_many :user_rooms
- has_many :discussions
- has_many :likes

## ballot_boxes table

| Column   | Type          | Options                         |
| -------- | ------------- | ------------------------------- |
| question | string        | null: false                     |
| detail   | text          |                                 |
| user_id  | references    | null: false, foreign_key: true  |

### Association

- belongs_to :user
- has_many :tags, through: :ballot_tags
- has_many :ballot_tags
- has_many :votes
- has_one :rooms

## tags table

| Column | Type   | Options     |
| ------ | ------ | ----------- |
| name   | string | null: false |

### Association

- has_many :ballot_boxes, through: :ballot_tags
- has_many :ballot_tags

## ballot_tags table

| Column        | Type       | Options                        |
| ------------- | ---------- | ------------------------------ |
| ballot_box_id | references | null: false, foreign_key: true |
| tag_id        | references | null: false, foreign_key: true |

### Association

- belongs_to :ballot_box
- belongs_to :tag

## votes table

| Column        | Type       | Options                        |
| ------------- | ---------- | ------------------------------ |
| result        | boolean    | null: false                    |
| user_id       | references | null: false, foreign_key: true |
| ballot_box_id | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :ballot_box

## rooms table

| Column        | Type       | Options                         |
| ------------- | ---------- | ------------------------------- |
| ballot_box_id | references | null: false, foreign_key: true  |

### Association

- has_many :users, through: :user_rooms
- has_many :user_rooms
- has_many :discussions
- belongs_to :ballot_box

## user_rooms table

| Column  | Type       | Options                        |
| ------- | ---------- | ------------------------------ |
| user_id | references | null: false, foreign_key: true |
| room_id | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :room

## discussions table

| Column  | Type       | Options                        |
| ------- | ---------  | ------------------------------ |
| comment | text       | null: false                    |
| user_id | references | null: false, foreign_key: true |
| room_id | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :room
- has_many :likes

## likes table

| Column        | Type       | Options                        |
| ------------- | ---------- | ------------------------------ |
| user_id       | references | null: false, foreign_key: true |
| discussion_id | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :discussion