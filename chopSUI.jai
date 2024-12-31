Vector2Int :: struct
{
    x, y: int;
}

Box :: struct
{
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

chop :: (box: *Box, dir: Direction, size: u32) -> bool, Box
{
    if dir ==
    {
        case .LEFT;
            if box.x_max - box.x_min < size return false, .{};

            x_min := box.x_min;
            box.x_min = x_min + size;
            return true, .{x_min, box.y_min, box.x_min - 1, box.y_max};

        case .RIGHT;
            if box.x_max - box.x_min < size return false, .{};

            x_max := box.x_max;
            box.x_max = x_max - size;
            return true, .{box.x_max + 1, box.y_min, x_max, box.y_max};

        case .UP;
            if box.y_max - box.y_min < size return false, .{};

            y_max := box.y_max;
            box.y_max = y_max - size;
            return true, .{box.x_min, box.y_max + 1, box.x_max, y_max};

        case .DOWN;
            if box.y_max - box.y_min < size return false, .{};

            y_min := box.y_min;
            box.y_min = y_min + size;
            return true, .{box.x_min, y_min, box.x_max, box.y_min - 1};

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

get_x_size :: inline (box: Box) -> int
{
    return box.x_max - box.x_min + 1;
}

get_y_size :: inline (box: Box) -> int
{
    return box.y_max - box.y_min + 1;
}


#import "Basic";
