#coding:cp932
require  'dxruby'

class MapManager
    def initialize( map_width, map_height, name)
        @file_name = name
        @map = Array.new(map_height).map{Array.new( map_width,0)} 
    end

    def load
        return unless File.exist?("./" + @file_name)

        File.open(@file_name, 'r'){ |file|
            iy = 0
            file.each{|str|
                ix = 0
                str.chars{ |char|
                    setSel(ix, iy,char.to_i)
                    ix = ix + 1
                }
                iy = iy + 1
            }
        }
        return
    end

    def save
       File.open(@file_name, 'w'){ |file|
        text_ary = []
        @map.each{ |ary|
            text_line = ""
            ary.each{ |num|
                text_line = text_line + num.to_s
            }
            text_ary.push(text_line)
        }
        file.puts(text_ary)
        }
        return
    end

    def getMap
        return @map
    end

    def getSel(sel_x,sel_y)
        return @map[sel_y][sel_x]
    end

    def setSel(sel_x, sel_y, value)
        @map[sel_y][sel_x] = value
        return
    end
end
