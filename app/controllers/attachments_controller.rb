class AttachmentsController < ApplicationController

  def show
    referer = response.request.env['HTTP_REFERER']
    if referer and referer.include?(root_url)
      attachment = Attachment.find(params[:id])
      io = open(URI.parse(attachment.item.expiring_url(10)))
      send_data io.read, type: io.content_type, filename: attachment.item_file_name
    else
      redirect_to root_url
    end
  end

end
