shared_context "common controller stuff" do
  def sign_in_user 
    @request.env["devise.mapping"] = Devise.mappings[:user]
    user = FactoryGirl.create(:user_facebook)
    sign_in user 
    user
  end 

  def should_be_unauthorized_access
    response.status.should eq 401 #unauthorized access
  end

  def randomize_string
    o = [('a'..'z'), ('A'..'Z')].map { |i| i.to_a }.flatten
    string = (0...50).map{ o[rand(o.length)] }.join
  end
end
