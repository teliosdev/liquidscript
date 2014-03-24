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

    private

    def perform_compiliation(file, out)
      infile = if file == '-'
        $stdin
      else
        File.open(file, "r")
      end

      outfile = if out == '-'
        $stdout
      else
        File.open(out, "w")
      end

      out = Liquidscript.compile(infile.read)
      outfile.write(out)
    rescue StandardError => e
        $stderr.puts "ERROR: #{e.class}: #{e.message}"
        $stderr.puts e.backtrace[0..5].map { |s| "\t#{s.gsub(/^.*?\/lib\/liquidscript\//, "")}" }.join("\n")
    ensure
      ([infile, outfile] - [$stdin, $stdout]).each(&:close)
    end
  end
end
