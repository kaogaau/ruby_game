require 'gosu'

module ZOrder
  Background, Stars, Player, UI = *0..3
  #[0, 1, 2, 3]
end

class Snake

  attr_accessor :direction

  def initialize(x,y)
    @direction = "move_right"
    @image = Gosu::Image.new("media/snake.png")
    #@beep = Gosu::Sample.new("media/beep.wav")
    @x = x
    @y = y
  end

  def draw
    @image.draw_rot(@x, @y, 1, 0, center_x = 0, center_y = 0, scale_x = 0.1, scale_y = 0.1)
  end

  def move_left
    @x -= 5
  end

  def move_right
    @x += 5
  end

  def move_up
    @y -= 5
  end

  def move_down
    @y += 5  
  end  

end

class GameWindow < Gosu::Window
  def initialize
    super 1920, 1080
    self.caption = "Snake Game"
    @background_image = Gosu::Image.new("media/space.png", :tileable => true)
    @font = Gosu::Font.new(20)
    @snake = Snake.new(0,0)
    @new_snakes = Array.new
  end

  def draw
    @background_image.draw(500, 200, 0)
    @snake.draw
    @new_snakes.each { |snake| snake.draw }
    #@font.draw("test", 100, 100, 3, 6.0, 6.0, 0xff_EA0000)
  end

  def update
    @snake.send(:"#{@snake.direction}")
    @snake.direction = "move_left" if Gosu::button_down? Gosu::KbLeft
    @snake.direction = "move_right" if Gosu::button_down? Gosu::KbRight
    @snake.direction = "move_up" if Gosu::button_down? Gosu::KbUp 
    @snake.direction = "move_down" if Gosu::button_down? Gosu::KbDown
    @new_snakes << Snake.new(rand(100),rand(100)) if rand(100) < 4 and @new_snakes.size < 1   
  end

  def button_down(id)
    if id == Gosu::KbEscape
      close
    end
  end

end

window = GameWindow.new
window.show