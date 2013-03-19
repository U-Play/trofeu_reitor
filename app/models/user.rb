class User < ActiveRecord::Base

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  attr_accessible :email, :password, :password_confirmation, :remember_me,
                  :first_name, :last_name, :username, :course, :student_number, :sports_number, :picture

  has_attached_file :picture
                    # TODO check this configs when possible
                    #styles: { medium: "300x300>", thumb: "100x100>" },
                    #default_url: "/images/:style/missing.png"

  belongs_to :role
end
