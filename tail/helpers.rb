module Helpers

  private

  attr_reader :f

  def file_changed?
    f.size != file_size
  end

  def move_to_end_of_file
    offset_cursor_position(0)
  end

  def offset_cursor_position(position)
    f.seek(position, IO::SEEK_END)
  end

  def output(data)
    puts data
  end

end
