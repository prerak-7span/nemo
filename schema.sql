Table role{
  id uuid pk
  name varchar
  created_at timestamp [default: `now()`]
  updated_at timestamp
}

Table permission{
  id uuid pk
  name varchar
  created_at timestamp [default: `now()`]
  updated_at timestamp
}

Table rolePermission{
  role_id uuid
  permission_id uuid
  created_at timestamp [default: `now()`]
  updated_at timestamp

  Indexes {
    (role_id , permission_id )
  }
}


Table users {
  id uuid pk
  email varchar unique
  password_hash varchar
  first_name varchar
  last_name varchar
  role_id uuid
  yacht_id uuid
  created_at timestamp [default: `now()`]
  updated_at timestamp
}

Table menu{
  id uuid pk
  yacht_id uuid
  categories uuid
  created_at timestamp [default: `now()`]
  updated_at timestamp

}

Table category{
  id uuid pk 
  menu_item uuid
  name varchar
  created_at timestamp [default: `now()`]
  updated_at timestamp
}

Table menuItem{
  id uuid pk
  name varchar
  price int
  quantity int
  created_at timestamp [default: `now()`]
  updated_at timestamp
}

Table ingredient{
  id uuid pk 
  name varchar
  quantity int
  created_at timestamp [default: `now()`]
  updated_at timestamp
}

Table customization{
  menuitem_id uuid
  ingredient_id uuid
  created_at timestamp [default: `now()`]
  updated_at timestamp
}

Table yacht{
  id uuid pk
  name varchar
  yacht_type varchar
  capacity int
  created_at timestamp [default: `now()`]
  updated_at timestamp
}

Table deck{
  id uuid pk
  yacht_id uuid
  deck_no int
  name varchar
  created_at timestamp [default: `now()`]
  updated_at timestamp
}

Table room{
  id uuid pk
  deck_id uuid
  room_number int
  type varchar
  created_at timestamp [default: `now()`]
  updated_at timestamp
}

Table room_history{
  id uuid pk
  room_id int
  guest_id int
  start_date timestamp
  end_date timestamp
  created_at timestamp [default: `now()`]
  updated_at timestamp
}

Table room_stay{
  id uuid pk
  room_id int
  guest_id int
  check_in timestamp
  check_out timestamp
  created_at timestamp [default: `now()`]
  updated_at timestamp
}

Table guests {
  user_id uuid 
  name varchar
  phone varchar
  email varchar
  created_at timestamp [default: `now()`]
  updated_at timestamp
}

Table guest_relationships {
  id uuid pk
  guest_id uuid
  related_guest_id uuid
  relationship varchar
  created_at timestamp [default: `now()`]
  updated_at timestamp
  

  indexes {
    (guest_id, related_guest_id) [unique]
  }
}

Table yacht_config{
  yacht_id pk
  config_ip int
}

Ref: role.id > rolePermission.role_id
Ref: permission.id > rolePermission.permission_id
Ref: category.id > menu.categories
Ref: menuItem.id > category.menu_item
Ref: deck.yacht_id > yacht.id
Ref: room.deck_id > deck.id 
Ref: room_history.room_id > room.id
Ref: room_history.guest_id > guests.user_id
Ref: guest_relationships.guest_id > guests.user_id
Ref: guest_relationships.related_guest_id > users.id
Ref: users.role_id > role.id
Ref: users.yacht_id > yacht.id
Ref: room_stay.room_id > room.id
Ref: room_stay.guest_id > guests.user_id
Ref: customization.menuitem_id > menuItem.id
Ref: customization.ingredient_id > ingredient.id
Ref: guests.user_id > users.id
Ref: yacht_config.yacht_id > yacht.id