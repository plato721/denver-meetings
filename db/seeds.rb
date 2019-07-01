User.create(
  username: "eastcolfax",
  email: "east.colfax@yandex.com",
  password: "password1",
  name: "East Colfax",
  )

User.create(
  username: "super_admin",
  email: ENV["admin_email"],
  name: ENV["admin_name"],
  password: ENV["admin_password"],
  role: "admin",
)
