module Subscribem
  class Account < ActiveRecord::Base
    EXCLUDED_SUBDOMAINS = %w(admin)

    before_validation do
      self.subdomain = subdomain.to_s.downcase     
    end

    belongs_to :owner, class_name: 'Subscribem::User'
    has_many :members, class_name: 'Subscribem::Member'
    has_many :users, through: :members
    accepts_nested_attributes_for :owner

    validates :subdomain,
      presence: true,
      uniqueness: true,
      format: { with: /\A[\w\-]+\Z/i,
        message: 'is not allowed. Please choose another subdomain.' },
      exclusion: { in: EXCLUDED_SUBDOMAINS,
        message: 'is not allowed. Please choose another subdomain.' }

    def self.create_with_owner(params={})
      account = new(params)
      if account.save
        account.users << account.owner
      end
      account
    end
    def create_schema
      Apartment::Database.create(subdomain)
    end
  end
end