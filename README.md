<!-- #モデル名

##テーブル名
## table
|Column|Type|Options|
|------|----|-------|

##アソシエーション
 - アソシエーションの記述

 -->

# User
---
## table
|Column|Type|Options|
|------|----|-------|
|name|integer|null: false|
|email|email|null: false, unique: true|
|group_id|integer|null: false, foreign_key: true|

## association
  - has_many :messages
  - has_many :groups
  - has_many :group_users

# Group
---

## table
|Column|Type|Options|
|------|----|-------|
|name|integer|null: false, unique: true|

## association
  - has_many :messages
  - has_many :users
  - has_many :group_users

# Group_user
---
## table
|Column|Type|Options|
|------|----|-------|
|group_id|integer|index: true, foreign_key: true|
|group_id|integer|index: true, foreign_key: true|

## association
  - belongs_to :user
  - belongs_to :group

# Message
---

## table
|Column|Type|Options|
|------|----|-------|
|body|integer||
|message_img|string||
|user_id|integer|foreign_key: true|
|group_id|integer|foreign_key: true|

## association
  - belongs_to :user
  - belongs_to :group
