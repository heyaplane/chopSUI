window:   *SDL.Window;
renderer: *SDL.Renderer;

window_width  :: 1920;
window_height :: 1080;

box_to_f_rect :: (box: SUI.Box) -> SDL.F_Rect
{
    return SDL.F_Rect
    .{
        x = xx box.x_min,
        y = xx (window_height - 1 - box.y_max),
        w = xx SUI.get_x_size(box),
        h = xx SUI.get_y_size(box),
    };
}

init :: ()
{
    ok := SDL.init(.VIDEO);
    assert(ok, "Bad SDL init. SDL: %\n", SDL.get_error());

    ok = SDL.create_window_and_renderer("Debug", window_width, window_height, 0, *window, *renderer);
    assert(ok, "Bad window & renderer. SDL: %\n", SDL.get_error());
}

close :: ()
{
    SDL.destroy_renderer(renderer);
    renderer = null;

    SDL.destroy_window(window);
    window = null;

    SDL.quit();
}

main :: ()
{
    init();

    quit := false;
    e:  SDL.Event;

    while !quit
    {
        while SDL.poll_event(*e)
        {
            if e.type ==
            {
                case .QUIT; quit = true;

                case .MOUSE_MOTION;
                    SUI.set_mouse_xy(xx e.motion.x, xx e.motion.y);

                case .MOUSE_BUTTON_DOWN;
                    if e.button.button == 1 then SUI.set_mouse_down(true);

                case .MOUSE_BUTTON_UP;
                    if e.button.button == 1 then SUI.set_mouse_down(false);

                case .KEY_UP;
                    if e.key.key == .ESCAPE quit = true;
            }
        }

        SDL.set_render_draw_color(renderer, 0, 0, 0, SDL.ALPHA_OPAQUE);
        SDL.render_clear(renderer);

        SUI.begin();

        ok := button.solve_layout(SUI.get_box(0, 0, window_width - 1, window_height - 1));
        rect := box_to_f_rect(button.button_box);
        SDL.set_render_draw_color(renderer, 255, 0, 0, SDL.ALPHA_OPAQUE);

        if SUI.button(button.button_box) print("Button clicked!\n");

        if SUI.box_is_hovered(button.button_box) SDL.set_render_draw_color(renderer, 0, 255, 0, SDL.ALPHA_OPAQUE);
        if SUI.box_is_pressed(button.button_box) SDL.set_render_draw_color(renderer, 0, 0, 255, SDL.ALPHA_OPAQUE);

        SDL.render_rect(renderer, *rect);

        SUI.end();

        SDL.render_present(renderer);
    }

    close();
}

SUI :: #import "chopSUI";
SDL :: #import "SDL3";
button :: #import,file "./layouts/button_layout.jai";
#import "Basic";

// Local Variables:
// compile-command: "jai button_render_test.jai -import_dir '../' && ./button_render_test"
// End:
