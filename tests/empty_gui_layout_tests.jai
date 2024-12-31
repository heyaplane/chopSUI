compile_test :: ()
{
    assert_true(true);
} @sui_test

positive_only_layout_test :: ()
{
    root_box := SUI.Box.{0, 0, 99, 99};

    ok := empty.solve_layout(root_box);

    assert_true(ok);

    assert_equal(empty.minimize_button_box.x_min, 0);
    assert_equal(empty.minimize_button_box.y_min, 80);
    assert_equal(empty.minimize_button_box.x_max, 19);
    assert_equal(empty.minimize_button_box.y_max, 99);

    assert_equal(SUI.get_x_size(empty.x_button_box), 20);
    assert_equal(SUI.get_y_size(empty.x_button_box), 20);

    assert_equal(empty.x_button_box.x_min, 80);
    assert_equal(empty.x_button_box.x_max, 99);
} @sui_test

SDL   :: #import "SDL3";
SUI   :: #import "chopSUI";
empty :: #import,file "layouts/empty_gui.jai";

#import "Assertive";

// Local Variables:
// compile-command: "jai build_tests.jai - empty_gui_layout_tests && ./empty_gui_layout_tests"
// End:
