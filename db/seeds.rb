puts 'setting up roles'
roles = [
  { name: 'root' },
  { name: 'admin' },
  { name: 'athlete' }
]

roles.each do |role|
 Role.find_or_create_by_name(role[:name])
end

puts 'creating default users'
users = [
  { first_name: 'Señor', last_name: 'root',  email: 'root@uplay.com',  password: 'rootroot',   password_confirmation: 'rootroot',   confirmed_at: Time.now, role_id: Role.find_by_name('root').id },
  { first_name: 'Mr',    last_name: 'admin', email: 'admin@uplay.com', password: 'adminadmin', password_confirmation: 'adminadmin', confirmed_at: Time.now, role_id: Role.find_by_name('admin').id },
  { first_name: 'Cristiano', last_name: 'Ronaldo', email: 'cr7@uplay.com', password: 'ronaldoronaldo', password_confirmation: 'ronaldoronaldo', confirmed_at: Time.now, role_id: Role.find_by_name('athlete').id },
  { first_name: 'Lionel', last_name: 'Messi', email: 'messi@uplay.com', password: 'messimessi', password_confirmation: 'messimessi', confirmed_at: Time.now, role_id: Role.find_by_name('athlete').id }
]

users.each do |attr|
  User.find_or_initialize_by_email(attr[:email]).tap do |user|
    user.first_name   = attr[:first_name]
    user.last_name    = attr[:last_name]
    user.confirmed_at = attr[:confirmed_at]
    user.role_id      = attr[:role_id]
    user.password     = attr[:password]
    user.password_confirmation = attr[:password_confirmation]
    user.save!
  end
end
