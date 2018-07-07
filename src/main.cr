require "parse.cr"
require "tape.cr"

begin
    if ARGV.size <= 0
        raise("Expected input")
    end

    abort "File is missing", 1 if !File.file? ARGV[0]
    inp = File.read ARGV[0]
    inp = inp.chomp

    stream = inp.chars.map { |c| parseChar(c) }.compact
    src_tape = SourceTape.new(stream).parse
    data_tape = DataTape.new

    while src_tape.pos < src_tape.tape.size
        case src_tape.tape[src_tape.pos]
        when Increment then
            data_tape.increment
        when Decrement then
            data_tape.decrement
        when ShiftRight then
            data_tape.shiftRight
        when ShiftLeft then
            data_tape.shiftLeft
        when Read then
            data_tape.rd
        when Print then
            data_tape.prnt
        when LoopStart then
            if data_tape.data[data_tape.pivot] == 0
                src_tape.pos = src_tape.brackets[src_tape.pos]
            end
        when LoopEnd then
            if data_tape.data[data_tape.pivot] != 0
                src_tape.pos = src_tape.brackets[src_tape.pos]
            end
        end

        src_tape.advance
    end

    STDOUT.flush

rescue e
    STDERR.puts "#{e.class}: #{e}"
end
