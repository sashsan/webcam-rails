# frozen_string_literal: true

class PictureAttachmentService
  class << self
    def attach(model, picture)
      base_image = picture.gsub!(/^data:.*,/, '')

      return if base_image.nil?

      decoded_image = Base64.decode64(base_image)

      model.picture.attach(
        io: StringIO.new(decoded_image),
        filename: "player_picture_#{unique_string}.jpeg"
      )
    end

    private

    def unique_string
      SecureRandom.urlsafe_base64(10)
    end
  end
end
