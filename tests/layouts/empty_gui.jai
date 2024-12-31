debug :: true;

x_button_box       : SUI.Box;
toolbar_button_box : SUI.Box;
minimize_button_box: SUI.Box;

solve_layout :: (box: SUI.Box) -> bool
{
    ok := true;

    ok, toolbar_button_box  = SUI.chop(*box, .UP, 20);
    ok, x_button_box        = SUI.chop(*toolbar_button_box, .RIGHT, 20);
    ok, minimize_button_box = SUI.chop(*toolbar_button_box, .LEFT, 20);

    return ok;
}

get_all_boxes :: inline () -> [] SUI.Box
{
    return .[x_button_box, toolbar_button_box, minimize_button_box];
}

#scope_module;

SUI :: #import "chopSUI";
#import "Math";

#if debug
{
    #load "../../debug_render.jai";
}

// Local Variables:
// compile-command: "jai empty_gui.jai -import_dir '../../' && ./empty_gui"
// End:
