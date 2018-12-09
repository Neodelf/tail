#! /usr/bin/env ruby

require 'optparse'
require './tail/live'
require './tail/lines'

class Tail
  VERSION = '0.1.0'

  attr_reader :follow, :lines_number, :parser

  def initialize
    @follow = false
    init_parser
  end

  def parse(args)
    parser.parse!(args)
  end

  def call(args)
    filename = args.pop
    f = File.open(filename)
    if @lines_number
      Lines.new(f, @lines_number).call
    else
      Live.new(f).call
    end
  rescue Errno::ENOENT => e
    puts e
  end

  private

  def init_parser
    @parser = OptionParser.new

    parser.banner = "Usage: ./tail.rb [options] FILENAME"
    parser.separator ''
    parser.separator 'Specific options:'

    parser.on('-f', '--follow', TrueClass, "Shows last #{Live::LINE_NUMBERS} lines and will be show data which\
 was appended to the file") do |f|
      follow = f
    end

    parser.on('-n', '--number NUMBER', Integer, 'Shows last NUMBER of lines from file') do |n|
      @lines_number = n
    end

    parser.on('-v', '--version', 'Show version number' ) do |_|
      puts VERSION
      exit
    end

    parser.separator ''
  end
end

tail = Tail.new
tail.parse(ARGV)
tail.call(ARGV)
