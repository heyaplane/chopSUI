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
    e: SDL.Event;

    while !quit
    {
        while SDL.poll_event(*e)
        {
            if e.type ==
            {
                case .QUIT; quit = true;
            }
        }

        ok := solve_layout(.{100, 100, window_width - 100 - 1, window_height - 100 - 1});
        assert(ok, "Bad solve.\n");

        boxes := get_all_boxes();

        SDL.set_render_draw_color(renderer, 0, 0, 0, SDL.ALPHA_OPAQUE);  /* black, full alpha */
        SDL.render_clear(renderer);  /* start with a blank canvas. */

        for boxes
        {
            if it_index % 2 == 0 SDL.set_render_draw_color(renderer, 255, 0, 0, SDL.ALPHA_OPAQUE);
            else                 SDL.set_render_draw_color(renderer, 0, 255, 0, SDL.ALPHA_OPAQUE);

            rect := box_to_f_rect(it);
            SDL.render_rect(renderer, *rect);
        }

        SDL.render_present(renderer);
    }

    close();
}

#scope_file;
SUI :: #import "chopSUI";
SDL :: #import "SDL3";
#import "Basic";
