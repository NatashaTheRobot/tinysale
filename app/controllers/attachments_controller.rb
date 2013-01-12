class AttachmentsController < ApplicationController

  def show
    attachment = Attachment.find(params[:id])
    io = open(URI.parse(attachment.item.expiring_url(10)))
    send_data io.read, type: io.content_type, filename: attachment.item_file_name
  end

end
