require './tail/helpers'

class Live
  include Helpers

  LINE_NUMBERS = 3
  SLEEP_TIME = 1 # seconds

  def initialize(file)
    @f = file
    @file_size = file.size
  end

  def call
    show_lines_before_following
    move_to_end_of_file
    loop do
      if file_changed?
        @file_size = f.size
        output(f.read)
        move_to_end_of_file
      end
      sleep(SLEEP_TIME)
    end
  end

  private

  def file_changed?
    f.size != @file_size
  end

  def show_lines_before_following
    Lines.new(f, LINE_NUMBERS).call
  end

end
