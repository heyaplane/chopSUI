Box :: struct
{
    x_min, x_max, y_min, y_max: int;
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
            return true, .{x_min, box.x_min - 1, box.y_min, box.y_max};

        case .RIGHT;
            if box.x_max - box.x_min < size return false, .{};

            x_max := box.x_max;
            box.x_max = x_max - size;
            return true, .{box.x_max + 1, x_max, box.y_min, box.y_max};

        case .UP;
            if box.y_max - box.y_min < size return false, .{};

            y_max := box.y_max;
            box.y_max = y_max - size;
            return true, .{box.x_min, box.x_max, box.y_max + 1, y_max};

        case .DOWN;
            if box.y_max - box.y_min < size return false, .{};

            y_min := box.y_min;
            box.y_min = y_min + size;
            return true, .{box.x_min, box.x_max, y_min, box.y_min - 1};

        case;
            return false, .{};
    }
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
