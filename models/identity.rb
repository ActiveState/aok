class Identity < OmniAuth::Identity::Models::ActiveRecord
  has_many :protected_resources
  has_many :access_tokens
  has_many :authorization_codes
  has_many :clients

  alias_attribute :first_name, :given_name
  alias_attribute :last_name, :family_name

  validates :username, 
    :uniqueness => { :case_sensitive => false },
    :length => { :maximum => 255 }

  before_validation do
    self.email = email.strip.downcase if attribute_present?("email")
    self.username = username.strip if attribute_present?("username")
  end

  def email=(val)
    write_attribute :email, val.strip.downcase
  end
  
end