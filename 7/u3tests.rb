require 'minitest/autorun'
require './hw7.rb'


#Constants for testing
ZERO = 0.0
ONE = 1.0
TWO = 2.0
THREE = 3.0
FOUR = 4.0
FIVE = 5.0
SIX = 6.0
SEVEN = 7.0
NINE = 9.0
TEN = 10.0

class Point < GeometryValue
  def ==(p)
    self.class == p.class and @x == p.x and @y == p.y
  end
end

class Line < GeometryValue
  def ==(l)
    self.class == l.class and @m == l.m and @b == l.b
  end
end

class VerticalLine < GeometryValue
  def ==(vl)
    self.class == vl.class and @x == vl.x
  end
end

class LineSegment < GeometryValue
  def ==(ls)
    self.class == ls.class and @x1 == ls.x1 and @y1 == ls.y1 and @x2 == ls.x2 and @y2 == ls.y2
  end
end

class Intersect < GeometryExpression
  attr_reader :e1, :e2
  def ==(i)
    self.class == i.class and @e1 == i.e1 and @e2 == i.e2
  end
end

class Let < GeometryExpression
  attr_reader :s, :e1, :e2
  def ==(l)
    self.class == l.class and @s == l.s and @e1 == l.e1 and @e2 == l.e2
  end
end

class Var < GeometryExpression
  attr_reader :s
  def ==(v)
    self.class == v.class and @s == v.s
  end
end

class Shift < GeometryExpression
  attr_reader :dx, :dy, :e
  def ==(s)
    self.class == s.class and @dx == s.dx and @dy == s.dy and @e == s.e
  end
end

describe "Test Programs" do
  before do
    @line1 = Line.new(ONE, SIX)
    @line2 = Line.new(-THREE, SIX)
    @line3 = LineSegment.new(-TEN, NINE, TEN, THREE)
    @p1 = Point.new(ZERO, SIX)
  end

  it "must return the point of intersection of multiple lines" do
    e = Let.new("A", @line1,
          Let.new("B", @line2,
            Let.new("C", @line3,
              # Let D be the intersection of A-B
              Let.new("D", Intersect.new(Var.new("A"), Var.new("B")),
                # Return intersection of C with D
                Intersect.new(Var.new("C"), Var.new("D"))))))
    e.preprocess_prog.eval_prog([]).must_equal @p1
  end

  it "must return the shifted point of intersection of multiple lines" do
    e = Let.new("D", Point.new(ZERO, ZERO),
          Shift.new(TWO, FOUR,
            # Let D be the intersection of A-B
            Let.new("D", Let.new("A", @line1,
                           Let.new("B", @line2,
                               Intersect.new(Var.new("A"), Var.new("B")))),
              Let.new("C", @line3,
                  # Return intersection of C with D
                  Intersect.new(Var.new("C"), Var.new("D"))))))
    e.preprocess_prog.eval_prog([]).must_equal Point.new(TWO, TEN)
  end
end