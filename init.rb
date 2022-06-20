require 'gosu'

require_relative 'ecg.rb'

class Window < Gosu::Window
    def initialize
        super(320, 240, false)
        @ecg = Ecg.new
    end

    def button_down(id)
        super
        close! if id == Gosu::KB_ESCAPE
    end

    def update

    end

    def draw
        @ecg.draw(:fine, 10, 10, 48, 24)
    end
end

Window.new.show