#coding:cp932
require  'dxruby'
require File.dirname(__FILE__) + "/MapManager"

map_name = "map.txt"

@max_sel_x = 20
@max_sel_y = 10
@window_width  = @max_sel_x*20
@window_height = @max_sel_y*20 

Window.width  = @window_width
Window.height = @window_height


#平行線
image_line_parallel = Image.new(Window.width, 10)
image_line_parallel.line(0, 0, Window.width, 0, [255, 255, 255])
#垂線
image_line_vertical = Image.new(10, Window.height)
image_line_vertical.line(0, 0, 0, Window.height, [255, 255, 255])
#ブロック画像
@image_blocks = Image.load_tiles("../image/colorbox.png",6, 1)
@image_blocks.insert(0, Image.new(20, 20,[0,0,0]))
#マス線
$lines =  []
for i in (1..@max_sel_y) do
    $lines.push(Sprite.new(0, 20*i, image_line_parallel))
end
for i in (1..@max_sel_x) do  
    $lines.push(Sprite.new(20*i, 0, image_line_vertical))
end

@MapMana = MapManager.new(@max_sel_x, @max_sel_y, map_name)
@MapMana.load()


def clickBlock
    #マウスのクリックによるマップの変更
    if Input.mouse_push?(M_LBUTTON) || Input.mouse_push?(M_RBUTTON)  then
        sel_x = Input.mouse_pos_x / 20
        sel_y = Input.mouse_pos_y / 20
        
        if (sel_x >= 0 && sel_x <= @max_sel_x) && (sel_y >= 0 && sel_y <= @max_sel_y) then
            sel_value = @MapMana.getSel(sel_x,sel_y)
            sel_value += 1 if Input.mouse_push?(M_LBUTTON)
            sel_value -= 1 if Input.mouse_push?(M_RBUTTON)
            sel_value = 0 if ( sel_value >= @image_blocks.length)
            sel_value = @image_blocks.length - 1 if (sel_value < 0)
            @MapMana.setSel(sel_x,sel_y,sel_value)
        end
    end
end

Window.loop do
    
    clickBlock()

    #マップの描写
    Window.draw_tile(0, 0, @MapMana.getMap(), @image_blocks, 0, 0, @window_width, @window_height, z=0)
    Sprite.draw($lines)

    if Input.key_push?(K_ESCAPE)
        @MapMana.save()
        break
    end
end
