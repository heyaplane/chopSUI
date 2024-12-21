main :: () {}

solve_layout :: (box: sui.Box, center: Vector2Int) -> bool
{
    window_box    = box;
    window_center = center;

    ok := true;

    ok, toolbar_button_box  = sui.chop(*window_box, .UP, 20);
    ok, x_button_box        = sui.chop(*toolbar_button_box, .RIGHT, 20);
    ok, minimize_button_box = sui.chop(*toolbar_button_box, .LEFT, 20);

    return ok;
}

window :: ()
{
    style := Panel_Style.{type = .COLOR, color = WHITE};
    // draw_panel();
}

x_button :: () -> bool
{
    return true;
}

#scope_file

x_button_box       : sui.Box;
toolbar_button_box : sui.Box;
minimize_button_box: sui.Box;

x_button_style := Button_Style.{type = .COLORS, colors = .{WHITE, RED, BLUE}};

window_box   : sui.Box;
window_center: Vector2Int;

WHITE :: Vector4.{1, 1, 1, 1};
RED   :: Vector4.{1, 0, 0, 1};
GREEN :: Vector4.{0, 1, 0, 1};
BLUE  :: Vector4.{0, 0, 1, 1};

Panel_Style :: struct
{
    type: enum {COLOR; TEXTURE;};
    using background: union
    {
        color  : Vector4;
        texture: *void;
    };
}

Button_Style :: struct
{
    type: enum {COLORS; SPRITES;};
    using states: union
    {
        colors: struct {off, hot, active: Vector4;};
    };
}

Vector2Int :: struct {x, y: int;}

sui  :: #import,file "../../chopSUI.jai";
#import "Math";

// Local Variables:
// compile-command: "jai empty_gui.jai && ./empty_gui"
// End:
