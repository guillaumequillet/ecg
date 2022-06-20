require 'json'

class Ecg
    def initialize
        read_points_data        
        @state = :fine
    end
    
    def read_points_data
        @points = {}
        [:fine].each do |state|
            @points[state] = JSON.parse(File.read("./ecg/#{state.to_s}.json"))
        end
        p @points[:fine].inspect
    end

    def draw(x, y, scale_x, scale_y)
        color = Gosu::Color::GREEN

        Gosu.clip_to(x, y, scale_x, scale_y) do
            Gosu.translate(x, y) do
                Gosu.scale(scale_x, scale_y) do
                    @points[@state].each_with_index do |point, i|
                        if i > 0
                            x1, y1 = @points[@state][i - 1]['x'], @points[@state][i - 1]['y']
                            x2, y2 = point['x'], point['y']
                            Gosu.draw_line(x1, y1, color, x2, y2, color)
                        end
                    end
                end
            end
        end
    end
end
