
class SType
    def inspect
        "#{self.class}"
    end
end

class Increment < SType; end
class Decrement < SType; end

class ShiftRight < SType; end
class ShiftLeft < SType; end

class Read < SType; end
class Print < SType; end

class LoopStart < SType; end
class LoopEnd < SType; end

class Ignored; end

def parseChar(c)
    case c
    when '+' then
        Increment.new
    when '-' then
        Decrement.new
    when '>' then
        ShiftRight.new
    when '<' then
        ShiftLeft.new
    when ',' then
        Read.new
    when '.' then
        Print.new
    when '[' then
        LoopStart.new
    when ']' then
        LoopEnd.new
    else
        nil
    end
end
