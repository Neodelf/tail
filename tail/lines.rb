require './tail/helpers'

class Lines
  include Helpers
  
  def initialize(file, lines)
    @f = file
    @lines = lines
    @position = 0
    @lines_counter = 0
  end

  def call
    loop do
      @position -= 1
      offset_cursor_position(@position)

      if f.read(1) == "\n"
        next if @position == -1
        @lines_counter += 1
      end

      break if beginning_of_file? || @lines_counter == @lines
    end

    output(f.read)
  rescue Errno::EINVAL
    output("File doesn't have #{lines} lines, @position: #{@position}")
  end

  private

  def beginning_of_file?
    f.tell == 1
  end
end




  