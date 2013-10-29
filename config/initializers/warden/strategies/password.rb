Warden::Strategies.add(:password) do
  def subdomain
    ActionDispatch::Http::URL.extract_subdomains(request.host, 1)
  end
  def valid?
    subdomain.present? && params['user']
  end
  def authenticate!
    account = Subscribem::Account.find_by(subdomain: subdomain)
    if account
      u = Subscribem::User.find_by(email: params["user"]["email"])
      if u.nil?
        fail!
      else
        u.authenticate(params['user']['password']) ? success!(u) : fail!
      end
    else
      fail!
    end
  end
end