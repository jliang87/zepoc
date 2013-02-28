module Paperclip
  class Cropper < Thumbnail

    def initialize file, options = {}, attachment = nil
      super
      @target = @attachment.instance
    end

    def transformation_command
      if crop_command
        Rails.logger.debug crop_command + super.join(' ').sub(/ -crop \S+/, '').split(' ')
        crop_command + super.join(' ').sub(/ -crop \S+/, '').split(' ') # super returns an array like this: ["-resize", "100x", "-crop", "100x100+0+0", "+repage"]
      end
    end

    def crop_command
      if @target.cropping?
        ["-crop", "#{@target.crop_w}x#{@target.crop_h}+#{@target.crop_x}+#{@target.crop_y}"]
      end
    end
  end
end