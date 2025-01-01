debug :: true;

button_box       : SUI.Box;

solve_layout :: (box: SUI.Box) -> bool
{
    ok := true;

    button_box = box;
    ok, _ = SUI.chop_rect(*button_box, .{800, 800, 400, 400});

    return ok;
}

get_all_boxes :: inline () -> [] SUI.Box
{
    return .[button_box];
}

#scope_module;

SUI :: #import "chopSUI";
#import "Math";

#if debug
{
    #load "../../debug_render.jai";
}

// Local Variables:
// compile-command: "jai button_layout.jai -import_dir '../../' && ./button_layout"
// End:
