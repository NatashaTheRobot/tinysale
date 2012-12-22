# == Schema Information
#
# Table name: attachments
#
#  id                :integer          not null, primary key
#  status            :string(255)
#  price_in_cents    :integer
#  product_id        :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  item_file_name    :string(255)
#  item_content_type :string(255)
#  item_file_size    :integer
#  item_updated_at   :datetime
#

require 'spec_helper'

describe Attachment do
  it { should belong_to :product }
end
