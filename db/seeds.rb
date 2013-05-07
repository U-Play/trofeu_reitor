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

puts 'creating courses'
courses = [
  { abbreviation: 'APublica', name: 'Administração Publica' },
  { abbreviation: 'Arqueologia', name: 'Arqueologia' },
  { abbreviation: 'Arquitetura', name: 'Arquitetura' },
  { abbreviation: 'BAplicada', name: 'Biologia Aplicada' },
  { abbreviation: 'BGeologia', name: 'Biologia Geologia' },
  { abbreviation: 'Bioquímica', name: 'Bioquímica' },
  { abbreviation: 'CPolitica', name: 'Ciência Politica' },
  { abbreviation: 'CAmbiente', name: 'Ciências do Ambiente' },
  { abbreviation: 'CComputação', name: 'Ciências da Computação' },
  { abbreviation: 'CComunicacao', name: 'Ciências da Comunicação ' },
  { abbreviation: 'Contabilidade', name: 'Contabilidade' },
  { abbreviation: 'Criminologia', name: 'Criminologia' },
  { abbreviation: 'DMModa' name: 'Design e Marketing de Moda ' },
  { abbreviation: 'DProduto', name: 'Design do Produto' },
  { abbreviation: 'Direito', name: 'Direito' },
  { abbreviation: 'Economia', name: 'Economia' },
  { abbreviation: 'Educação', name: 'Educação' },
  { abbreviation: 'EBasica', name: 'Educação Básica' },
  { abbreviation: 'Enfermagem', name: 'Enfermagem' },
  { abbreviation: 'EBiologica', name: 'Engenharia Biológica (MI)' },
  { abbreviation: 'EBiomédica', name: 'Engenharia Biomédica (MI)' },
  { abbreviation: 'ECivil', name: 'Engenharia Civil (MI)' },
  { abbreviation: 'EComunicações', name: 'Engenharia de Comunicações (MI)' },
  { abbreviation: 'EComputadores', name: 'Engenharia Electrónica Industrial e Computadores (MI)' },
  { abbreviation: 'EFisica', name: 'Engenharia Física (MI)' },
  { abbreviation: 'EGIndustrial', name: 'Engenharia e Gestão Industrial (MI)' },
  { abbreviation: 'EGSInformacão', name: 'Engenharia e Gestão de Sistemas de Informação (MI)' },
  { abbreviation: 'EInformáaica', name: 'Engenharia Informática' },
  { abbreviation: 'EMateriais', name: 'Engenharia de Materiais (MI)' },
  { abbreviation: 'EMecanica', name: 'Engenharia Mecânica (MI)' },
  { abbreviation: 'EPolimeros', name: 'Engenharia de Polímeros (MI)' },
  { abbreviation: 'ETextil', name: 'Engenharia Têxtil (MI)' },
  { abbreviation: 'EAplicada', name: 'Estatística Aplicada' },
  { abbreviation: 'ECulturais', name: 'Estudos Culturais' },
  { abbreviation: 'EPLusofonos', name: 'Estudos Portugueses e Lusófonos' },
  { abbreviation: 'Filosofia', name: 'Filosofia' },
  { abbreviation: 'Fisica', name: 'Física' },
  { abbreviation: 'GPlaneamento', name: 'Geografia e Planeamento' },
  { abbreviation: 'Geologia', name: 'Geologia ' },
  { abbreviation: 'Gestao', name: 'Gestão' },
  { abbreviation: 'Historia', name: 'História' },
  { abbreviation: 'LAplicadas', name: 'Línguas Aplicadas ' },
  { abbreviation: 'LCOrientais', name: 'Línguas e Culturas Orientais' },
  { abbreviation: 'LLEuropeias', name: 'Línguas e Literaturas Europeias' },
  { abbreviation: 'Marketing', name: 'Marketing' },
  { abbreviation: 'Matematica', name: 'Matemática' },
  { abbreviation: 'Medicina', name: 'M(MI)' },
  { abbreviation: 'Musica', name: 'Música' },
  { abbreviation: 'NInternacionais', name: 'Negócios Internacionais' },
  { abbreviation: 'OCV' name: 'Optometria e Ciências da Visão ' },
  { abbreviation: 'Psicologia', name: 'P(MI)' },
  { abbreviation: 'Quimica', name: 'Química' },
  { abbreviation: 'RInternacionais', name: 'Relações Internacionais' },
  { abbreviation: 'Sociologia', name: 'Sociologia' },
  { abbreviation: 'Teatro', name: 'Teatro' }
]

courses.each do |course|
  Course.find_or_create_by_name(course[:name])
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
    { first_name: 'Effeminate', last_name: 'blogger',   email: 'blogger@uplay.com',   password: 'blogger',   password_confirmation: 'blogger',   role_id: Role.find_by_name('blogger').id }
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
# Sports
individual  = 1
team        = 14

futsal_m    = 'Futsal M'
futsal_f    = 'Futsal F'
basket      = 'Basquetebol'
hand        = 'Andebol'
volley      = 'Vólei de Praia'
badminton   = 'Badminton'
tenis       = 'Ténis'
table_tenis = 'Ténis de Mesa'
squash      = 'Squash'
padel       = 'Padel'
surf        = 'Surf'
bodyboard   = 'Bodyboard'
chess       = 'Xadrez'
pool        = 'Bilhar'
foosebal    = 'Matraquilhos'
climbing    = 'Escalada'
sports = [
  {name: futsal_m   , athletes_per_team: team       , description: ''},
  {name: futsal_f   , athletes_per_team: team       , description: ''},
  {name: basket     , athletes_per_team: team       , description: ''},
  {name: hand       , athletes_per_team: team       , description: ''},
  {name: volley     , athletes_per_team: team       , description: ''},
  {name: badminton  , athletes_per_team: individual , description: ''},
  {name: tenis      , athletes_per_team: individual , description: ''},
  {name: table_tenis, athletes_per_team: individual , description: ''},
  {name: squash     , athletes_per_team: individual , description: ''},
  {name: padel      , athletes_per_team: individual , description: ''},
  {name: surf       , athletes_per_team: individual , description: ''},
  {name: bodyboard  , athletes_per_team: individual , description: ''},
  {name: chess      , athletes_per_team: individual , description: ''},
  {name: pool       , athletes_per_team: individual , description: ''},
  {name: foosebal   , athletes_per_team: individual , description: ''},
  {name: climbing   , athletes_per_team: individual , description: ''},
]

sports.each do |attr|
  Sport.find_or_initialize_by_name(attr[:name]).tap do |sport|
    sport.description = attr[:description]
    sport.athletes_per_team = attr[:athletes_per_team]
    sport.save!
  end
end

puts 'creating default highlights'
futsal_m_id = Sport.find_by_name(futsal_m).id
futsal_f_id = Sport.find_by_name(futsal_f).id
basket_id   = Sport.find_by_name(basket).id
hand_id     = Sport.find_by_name(hand).id
volley_id   = Sport.find_by_name(volley).id
highlights = [ 
  # futsal_m
  { name: 'Goal'        , description: '', sport_id: futsal_m_id },
  { name: 'Yellow Card' , description: '', sport_id: futsal_m_id },
  { name: 'Red Card'    , description: '', sport_id: futsal_m_id },
  { name: 'Foul'        , description: '', sport_id: futsal_m_id },
  # futsal_f
  { name: 'Goal'        , description: '', sport_id: futsal_f_id },
  { name: 'Yellow Card' , description: '', sport_id: futsal_f_id },
  { name: 'Red Card'    , description: '', sport_id: futsal_f_id },
  { name: 'Foul'        , description: '', sport_id: futsal_f_id },
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
  # volley
  # badminton  
  # tenis      
  # table_tenis
  # squash     
  # padel      
  # surf       
  # bodyboard  
  # chess      
  # pool       
  # foosebal   
  # climbing   
]

highlights.each do |attr|
  Highlight.find_or_initialize_by_name(attr[:name]).tap do |highlight|
    highlight.description = attr[:description]
    highlight.sport_id = attr[:sport_id]
    highlight.save!
  end
end
