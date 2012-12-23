# == Schema Information
#
# Table name: products
#
#  id          :integer          not null, primary key
#  user_id     :integer
#  title       :string(255)
#  description :text
#  permalink   :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'spec_helper'

describe Product do

  it { should belong_to :user }
  it { should have_many :attachments }
  it { should have_many :images }
  it { should validate_presence_of :title }
  it { should validate_presence_of :description }
  it { should validate_presence_of :permalink }
  it { should validate_uniqueness_of :permalink }
  it { should accept_nested_attributes_for :attachments }
  it { should accept_nested_attributes_for :images }

end
