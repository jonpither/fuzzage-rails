class UserMailer < ActionMailer::Base
  
  def register(user,hash,sent_at = Time.now)
    subject    'Fuzzage: Confirm email address'
    recipients user.email
    from       ''
    sent_on    sent_at    
    body       :name => user.name, :hash => hash
  end
end