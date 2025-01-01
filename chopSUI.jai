state: UI_State;

Vector2Int :: struct
{
    x, y: int;
}

Box :: struct
{
    id: int;
    x_min, y_min, x_max, y_max: int;
}

Margins :: struct
{
    left, right, top, bottom: u32;
}

Direction :: enum u32
{
    LEFT;
    RIGHT;
    UP;
    DOWN;
}

UI_State :: struct
{
    mouse_x:    int;
    mouse_y:    int;
    mouse_down: bool;

    next_id:     int;
    hovered_box: int;
    pressed_box: int;
}

begin :: ()
{
    state.next_id = 1;
    state.hovered_box = 0;
}

end :: ()
{
    if !state.mouse_down state.pressed_box = 0;
    else if state.pressed_box == 0 state.pressed_box = -1;
}

get_box :: inline (x_min: int, y_min: int, x_max: int, y_max: int) -> Box
{
    return .{get_next_id(), x_min, y_min, x_max, y_max};
}

get_next_id :: () -> int
{
    state.next_id += 1;
    return state.next_id;
}

set_mouse_xy :: (mouse_x: int, mouse_y: int)
{
    state.mouse_x = mouse_x;
    state.mouse_y = mouse_y;
}

set_mouse_down :: (mouse_down: bool)
{
    state.mouse_down = mouse_down;
}

chop :: (box: *Box, dir: Direction, size: u32) -> bool, Box
{
    if dir ==
    {
        case .LEFT;
            if box.x_max - box.x_min < size return false, .{};

            x_min := box.x_min;
            box.x_min = x_min + size;
            return true, .{get_next_id(), x_min, box.y_min, box.x_min - 1, box.y_max};

        case .RIGHT;
            if box.x_max - box.x_min < size return false, .{};

            x_max := box.x_max;
            box.x_max = x_max - size;
            return true, .{get_next_id(), box.x_max + 1, box.y_min, x_max, box.y_max};

        case .UP;
            if box.y_max - box.y_min < size return false, .{};

            y_max := box.y_max;
            box.y_max = y_max - size;
            return true, .{get_next_id(), box.x_min, box.y_max + 1, box.x_max, y_max};

        case .DOWN;
            if box.y_max - box.y_min < size return false, .{};

            y_min := box.y_min;
            box.y_min = y_min + size;
            return true, .{get_next_id(), box.x_min, y_min, box.x_max, box.y_min - 1};

        case;
            return false, .{};
    }
}

chop_rect :: (box: *Box, margins: Margins) -> bool, [4] Box
{
    margin_boxes: [4] Box;
    ok := true;

    if margins.left > 0
        ok, margin_boxes[0] = chop(box, .LEFT, margins.left);
    if margins.right > 0
        ok, margin_boxes[1] = chop(box, .RIGHT, margins.right);
    if margins.top > 0
        ok, margin_boxes[2] = chop(box, .UP, margins.top);
    if margins.bottom > 0
        ok, margin_boxes[3] = chop(box, .DOWN, margins.bottom);

    return ok, margin_boxes;
}

box_is_hit :: inline (box: Box) -> bool
{
    return !(state.mouse_x < box.x_min ||
             state.mouse_x > box.x_max ||
             state.mouse_y < box.y_min ||
             state.mouse_y > box.y_max);
}

box_is_hovered :: inline (box: Box) -> bool
{
    return state.hovered_box == box.id;
}

box_is_pressed :: inline (box: Box) -> bool
{
    return state.pressed_box == box.id;
}

get_x_size :: inline (box: Box) -> int
{
    return box.x_max - box.x_min + 1;
}

get_y_size :: inline (box: Box) -> int
{
    return box.y_max - box.y_min + 1;
}

button :: (box: Box) -> bool
{
    if box_is_hit(box)
    {
        state.hovered_box = box.id;
        if (state.pressed_box == 0 && state.mouse_down) then state.pressed_box = box.id;
    }

    return !state.mouse_down && state.hovered_box == box.id && state.pressed_box == box.id;
}


#import "Basic";
