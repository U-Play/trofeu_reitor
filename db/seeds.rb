puts 'setting up roles'
roles = [
  { name: 'root' },
  { name: 'admin' },
  { name: 'validator' },
  { name: 'blogger' },
  { name: 'manager' },
  { name: 'athlete' }
]

roles.each do |role|
  Role.find_or_create_by_name(role[:name])
end

if Rails.env.production?
  puts 'creating default users in production'
  users = [
    { first_name: 'Senor',      last_name: 'root',      email: 'root@uplay.com',      password: 'rootpass',      password_confirmation: 'rootpass',      role_id: Role.find_by_name('root').id },
    { first_name: 'Mr',         last_name: 'admin',     email: 'admin@uplay.com',     password: 'adminpass',     password_confirmation: 'adminpass',     role_id: Role.find_by_name('admin').id }
  ]
else
  puts 'creating default users'
  users = [
    { first_name: 'Senor',      last_name: 'root',      email: 'root@uplay.com',      password: 'root',      password_confirmation: 'root',      role_id: Role.find_by_name('root').id },
    { first_name: 'Mr',         last_name: 'admin',     email: 'admin@uplay.com',     password: 'admin',     password_confirmation: 'admin',     role_id: Role.find_by_name('admin').id },
    { first_name: 'Awesome',    last_name: 'validator', email: 'validator@uplay.com', password: 'validator', password_confirmation: 'validator', role_id: Role.find_by_name('validator').id },
    { first_name: 'Effeminate', last_name: 'blogger',   email: 'blogger@uplay.com',   password: 'blogger',   password_confirmation: 'blogger',   role_id: Role.find_by_name('blogger').id },
    { first_name: 'Cristiano',  last_name: 'Ronaldo',   email: 'cr7@uplay.com',       password: 'user',      password_confirmation: 'user',      role_id: Role.find_by_name('athlete').id },
    { first_name: 'Lionel',     last_name: 'Messi',     email: 'messi@uplay.com',     password: 'user',      password_confirmation: 'user',      role_id: Role.find_by_name('athlete').id }
  ]
end

users.each do |attr|
  User.find_or_initialize_by_email(attr[:email]).tap do |user|
    user.first_name   = attr[:first_name]
    user.last_name    = attr[:last_name]
    user.role_id      = attr[:role_id]
    user.password     = attr[:password]
    user.password_confirmation = attr[:password_confirmation]
    user.save!
  end
end

puts 'creating default event'
Event.find_or_initialize_by_name('Trofeu do Reitor').tap do |event|
  event.user_id = Role.find_by_name('root').users.first.id
  event.start_date = Time.now
  event.save!
end

puts 'creating default formats'
Format.find_or_initialize_by_name('Group Stage').tap do |group|
  group.description = "A group stage (also known as pool play or the pool stage) is the round-robin stage of many sporting championships"
  group.save!
end
Format.find_or_initialize_by_name('Knockout Stage').tap do |group|
  group.description = "A knockout tournament is divided into successive rounds; each competitor
  plays in at most one fixture per round. The top-ranked competitors in each fixture progress to the
  next round. As rounds progress, the number of competitors and fixtures decreases. The final round,
  usually known as the final or cup final, consists of just one fixture; the winner of which is the
  overall champion."
  group.save!
end
Format.find_or_initialize_by_name('Multi Stage').tap do |group|
  group.description = "Many tournaments are held in multiple stages, with the top teams in one stage progressing to the next."
  group.save!
end

puts 'creating default sports'
futsal = 'Futsal'
basket = 'Basketball'
hand   = 'Handball'
sports = [
  {name: futsal, description: ''},
  {name: basket, description: ''},
  {name: hand  , description: ''},
]

sports.each do |attr|
  Sport.find_or_initialize_by_name(attr[:name]).tap do |sport|
    sport.description = attr[:description]
    sport.save!
  end
end

puts 'creating default highlights'
futsal_id = Sport.find_by_name(futsal).id
basket_id = Sport.find_by_name(basket).id
hand_id   = Sport.find_by_name(hand).id
highlights = [ 
  # futsal
  { name: 'Goal'        , description: '', sport_id: futsal_id },
  { name: 'Yellow Card' , description: '', sport_id: futsal_id },
  { name: 'Red Card'    , description: '', sport_id: futsal_id },
  { name: 'Foul'        , description: '', sport_id: futsal_id },
  # basket
  { name: 'Foul 1st Period' , description: '', sport_id: basket_id },
  { name: 'Foul 2nd Period' , description: '', sport_id: basket_id },
  { name: 'Foul 3rd Period' , description: '', sport_id: basket_id },
  { name: 'Foul 4th Period' , description: '', sport_id: basket_id },
  { name: 'One Point'       , description: '', sport_id: basket_id },
  { name: 'Two Points'      , description: '', sport_id: basket_id },
  { name: 'Three Points'    , description: '', sport_id: basket_id },
  # handball
  { name: 'Goal' , description: ''                           , sport_id: hand_id },
  { name: 'A'    , description: 'Yellow Card Warning'        , sport_id: hand_id },
  { name: "2'"   , description: ''                           , sport_id: hand_id },
  { name: 'D/E'  , description: 'Desqualification/Expulsion' , sport_id: hand_id },
  # { name: 'D'    , description: 'Red Card Desqualification: can be substituted after 2 minutes', sport_id: hand_id },
  # { name: 'E'    , description: 'Expulsion: can\'t be substituted'                             , sport_id: hand_id },
  { name: 'TP'   , description: 'Penalização adicional a um jogador que incorre numa conduta
                                  antidesportiva após sofrer desqualificação direta ou por acumulação.', sport_id: hand_id }
]

highlights.each do |attr|
  Highlight.find_or_initialize_by_name(attr[:name]).tap do |highlight|
    highlight.description = attr[:description]
    highlight.sport_id = attr[:sport_id]
    highlight.save!
  end
end
