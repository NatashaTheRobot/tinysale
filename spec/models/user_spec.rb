# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  avatar_file_name       :string(255)
#  avatar_content_type    :string(255)
#  avatar_file_size       :integer
#  avatar_updated_at      :datetime
#  bio                    :text
#  username               :string(255)      not null, primary_key

require 'spec_helper'

describe User do
  it { should have_many :products}
  it { should have_one :payment }
  it { validate_uniqueness_of :username }
  it { validate_presence_of :username }
  it { should have_attached_file :avatar }

  describe "#update_with_password" do
    context "to bypasses Devise's requirement to re-enter current password to edit" do
      before do
        @user = FactoryGirl.create :user
      end
      context "when the user does not want to change their password" do
        it "returns a successful result" do
          result = @user.update_with_password(:current_password => nil)
          result.should be_true
        end
      end

      context "when the user changes their password" do
        context "and does not provide a current password" do
          it "does not update their password" do
              result = @user.update_with_password(:current_password => nil,
                                                  :password => "new_password1",
                                                  :password_confirmation => "new_password1")
              result.should be_false
          end
        end
        context "and provides an incorrect current password" do
          it "does not update their password" do
            result = @user.update_with_password(:current_password => 'wrong_password',
                                                :password => "new_password1",
                                                :password_confirmation => "new_password1")
            result.should be_false
          end
        end
        context "and provides the correct current password" do
          it "successfully updates their password" do
            result = @user.update_with_password(:current_password => 'thisismypassword1',
                                                :password => "new_password1",
                                                :password_confirmation => "new_password1")
            result.should be_true
          end
        end
      end

    end
  end

end
