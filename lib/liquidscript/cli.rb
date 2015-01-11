require "thor"

module Liquidscript
  class CLI < Thor

    desc "compile FILES", "Compile the given file to javascript."
    long_desc <<-LONGDESC
      It will compile each file listed to javascript.  If the file
      given is `-`, it will check the standard input for file data.
      By default, this will output to standard output - if this isn't
      what you want, use the -o option to change it.

      Note that if you pass in multiple files,
      the last file's compiled output will be in this file (i.e.
      multiple output files are not yet supported).  If you want the
      output to go to standard output, use `-` as the value.

      > $ lscript compile test.liq
    LONGDESC
    option :out, :aliases => :o, :desc => "The output file."
    def compile(*files)
      files.each do |file|
        puts "COMPILING: #{file}"
        perform_compiliation(file,
          options[:out] || file.gsub('.liq', '.js'))
      end
    end

    desc "syntax FILES", "Syntax check given file"
    long_desc <<-LONGDESC
     It will run a syntax check on the file listed. If the file does
     not pass the syntax check it will return the error code 1. If
     the file give is - it will check the standard input.
    LONGDESC
    def syntax(*files)
      errored = files.select do |file|
        print "CHECKING: #{file} "
        !preform_syntax_check(file)
      end

      if errored.size > 0
        puts "#{errored.join(', ')} did not pass the syntax check"
        exit 1
      end
    end

    private

    def perform_compiliation(file, out)
      open_files(file, out) do |infile, outfile|
        out = Liquidscript.compile(infile.read, :file => file, ast: true)
        outfile.write(out)
      end
    end

    def preform_syntax_check(file)
      open_files(file) do |infile|
        Liquidscript.compile(infile.read)
        puts "OK"
      end
    end

    def open_files(inf, outf = nil)
      inf = if inf == '-'
        $stdin
      else
        File.open(inf, 'r')
      end

      outf = if outf == '-'
        $stdout
      elsif outf
        File.open(outf, 'w')
      end

      begin
        yield inf, outf
      rescue StandardError => e
        $stderr.puts "ERROR: #{e.class}: #{e.message}"
        $stderr.puts e.backtrace[0..5].map { |s| "\t" +
          s.gsub(/^lib\/liquidscript\//, "") }.join("\n")
        false
      ensure
        ( [ inf, outf].compact - [$stdin, $stdout]).each(&:close)
      end
    end
  end
end
