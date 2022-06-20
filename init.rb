require 'gosu'

require_relative 'ecg.rb'

class Window < Gosu::Window
    def initialize
        super(640, 480, false)
        @ecg = Ecg.new
    end

    def button_down(id)
        super
        close! if id == Gosu::KB_ESCAPE
    end

    def update

    end

    def draw
        @ecg.draw(self.mouse_x, self.mouse_y, 200, 100)
    end
end

Window.new.show