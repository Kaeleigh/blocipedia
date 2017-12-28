class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many  :wikis, dependent: :destroy
  
  validates :email, presence: true
  validates :password, presence: true

  has_many :collaborators, dependent: :destroy

  after_initialize { self.role ||= :standard }

  enum role: [:standard, :premium, :admin]

  def self.collabable(wiki, user)
    User.where.not(id: wiki.collaborators.pluck(:user_id) << user.id)
  end

end
