require "c/stdio"

# Tapes can easily be defined in a single class, but only (imo) at the cost of clarity

class SourceTape
    getter :tape
    getter :brackets
    property :pos

    def initialize(source : Array(Decrement | Increment | LoopEnd | LoopStart | Print | Read | ShiftLeft | ShiftRight))
        @tape = source
        @pos = 0
        @brackets = {} of Int32 => Int32
    end

    def advance
        @pos += 1
    end

    def parse
        lstack = [] of Int32
        @tape.each do |c|
            if c.is_a? LoopStart
                lstack.push(@pos)
            elsif c.is_a? LoopEnd
                l = lstack.pop()
                @brackets[l] = @pos
                @brackets[@pos] = l
            end
            @pos += 1
        end
        @pos = 0
        self
    end
end

class DataTape
    getter :data
    getter :pivot

    def initialize
        @data = Array(Int32).new(30000,0)
        @pivot = 15000
    end

    def shiftLeft
        @pivot -= 1
    end

    def shiftRight
        @pivot += 1
    end

    def increment
        @data[@pivot] += 1
    end

    def decrement
        @data[@pivot] -= 1
    end

    def prnt
        print @data[@pivot].chr
    end

    def rd
        begin
            @data[@pivot] = (STDIN.raw &.read_char).not_nil!.to_i
        rescue
            # do nothing
        end
    end
end
