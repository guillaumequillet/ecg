require 'json'

class Ecg
    def initialize
        read_data        
    end
    
    def read_data
        @data = JSON.parse(File.read('ecg.json'))
        @colors = {}
        @points = {}

        @data.each do |state, values|
            @colors[state.to_sym] = Gosu::Color.new(255, *values['color'])
            @points[state.to_sym] = values['points']
        end
    end

    def update_clip
        @clip ||= 0.0
        @alpha_clip ||= 0.0
        speed = 0.04

        if @clip < 1.0
            @clip += speed
            @alpha_clip += speed
        elsif @clip >= 1.0 && @alpha_clip >= 0.0
            @alpha_clip -= speed
        elsif @clip >= 1.0 && @alpha_clip <= 0.0
            @clip = 0
            @alpha_clip = 0
        end
    end

    def draw(state, x, y, scale_x, scale_y)
        update_clip
        color = @colors[state]
        color.alpha = @alpha_clip * 255

        Gosu.clip_to(x, y, scale_x * @clip, scale_y) do
            Gosu.translate(x, y) do
                Gosu.scale(scale_x, scale_y) do
                    @points[state].each_with_index do |point, i|
                        if i > 0
                            x1, y1 = @points[state][i - 1]['x'], @points[state][i - 1]['y']
                            x2, y2 = point['x'], point['y']
                            Gosu.draw_line(x1, y1, color, x2, y2, color)
                        end
                    end
                end
            end
        end
    end
end
