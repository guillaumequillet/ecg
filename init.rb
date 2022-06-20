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
        @current_state += 1 if id == Gosu::KB_RIGHT
        @current_state -= 1 if id == Gosu::KB_LEFT
        @current_state = @current_state.clamp(0, @states.size - 1)
    end

    def update
        @states ||= [:fine, :warning, :danger]
        @current_state ||= 0
    end

    def draw
        @ecg.draw(@states[@current_state], 10, 10, 48, 24)
    end
end

Window.new.show