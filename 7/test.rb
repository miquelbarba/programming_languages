require "./hw7.rb"

class NoPoints < GeometryValue
  def ==(np)
    self.class == np.class
  end
end

class Point < GeometryValue
  def ==(p)
    self.class == p.class && @x == p.x && @y == p.y
  end
end

class Line < GeometryValue
  def ==(l)
    self.class == l.class && @m == l.m && @b == l.b
  end
end

class VerticalLine < GeometryValue
  def ==(vl)
    self.class == vl.class && @x == vl.x
  end
end

class LineSegment < GeometryValue
  def ==(ls)
    self.class == ls.class && @x1 == ls.x1 && @y1 == ls.y1 && @x2 == ls.x2 && @y2 == ls.y2
  end
end

class Intersect < GeometryExpression
  attr_reader :e1, :e2
  def ==(i)
    self.class == i.class && @e1 == i.e1 && @e2 == i.e2
  end
end

class Let < GeometryExpression
  attr_reader :e1, :e2, :s
  def ==(l)
    self.class == l.class && @s == l.s && @e1 == l.e1 && @e2 == l.e2
  end
end

class Var < GeometryExpression
  attr_reader :s
  def ==(v)
    self.class == v.class && @s == v.s
  end
end

class Shift < GeometryExpression
  attr_reader :dx, :dy, :e
  def ==(s)
    self.class == s.class && @dx == s.dx && @dy == s.dy && @e == s.e
  end
end


puts Let.new("b", LineSegment.new(1, 2, 3, 4), LineSegment.new(1, 1, 1, 1)).preprocess_prog == 
       Let.new("b", LineSegment.new(1, 2, 3, 4), Point.new(1, 1)) 

puts Shift.new(1, 2, LineSegment.new(2, 4, 2, 4)).preprocess_prog == 
      Shift.new(1, 2, Point.new(2, 4))

puts Intersect.new(LineSegment.new(3, 4, 3, 4), LineSegment.new(4, 1, 0, 0)).preprocess_prog == 
      Intersect.new(Point.new(3, 4), LineSegment.new(0, 0, 4, 1))


puts Shift.new(1, 4, Point.new(7, 3)).eval_prog([]) == Point.new(8, 7)
puts Shift.new(1, 4,  Line.new(7, 3)).eval_prog([]) == Line.new(7, -0)
puts Shift.new(1, 4, VerticalLine.new(4)).eval_prog([]) == VerticalLine.new(5)
puts Shift.new(1, 4, LineSegment.new(1, 2, 3, 4)).eval_prog([]) == 
      LineSegment.new(2.0, 6.0, 4.0, 8.0)


puts Intersect.new(Point.new(4, 4), Point.new(4, 4)).eval_prog([]) == Point.new(4, 4)
puts Intersect.new(Point.new(1, 8), Line.new(4, 4)).eval_prog([]) == Point.new(1, 8)
puts Intersect.new(Point.new(1, 2), VerticalLine.new(7)).eval_prog([]) == NoPoints.new
puts Intersect.new(Line.new(-1, 4), LineSegment.new(1, 1, 4, 4)).eval_prog([]) == Point.new(2.0, 2.0) 
puts Intersect.new(LineSegment.new(2, 2, 3, 3), LineSegment.new(0, 0, 7, 7)).eval_prog([]) == 
        LineSegment.new(2, 2, 3, 3)

puts Let.new("a", Point.new(0, 0), Var.new("a")).eval_prog([]) == Point.new(0, 0)