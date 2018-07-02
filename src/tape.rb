# Tapes can easily be defined in a single class, but only (imo) at the cost of clarity

class SourceTape
    attr_reader :tape
    attr_reader :brackets
    attr_accessor :pos

    def initialize(source)
        @tape = source
        @pos = 0
        @brackets = {}
    end

    def advance
        @pos += 1
    end

    def parse
        lstack = []
        for c in @tape
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
    attr_reader :data
    attr_reader :pivot

    def initialize
        @data = Array.new(30000,0)
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
        @data[@pivot] = STDIN.getc.bytes[0]
    end

end

