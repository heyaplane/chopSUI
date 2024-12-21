sui  :: #import "chopSUI";
empty :: #import,file "layouts/empty_gui.jai";

#import "Assertive";

compile_test :: ()
{
    assert_true(true);
} @sui_test

positive_only_layout_test :: ()
{
    root_box := sui.Box.{0, 100, 0, 100};

    ok := empty.solve_layout(root_box);

    assert_true(ok);

    assert_equal(empty.minimize_button_box.x_min, 0);
    assert_equal(empty.minimize_button_box.x_max, 19);
    assert_equal(empty.minimize_button_box.y_min, 81);
    assert_equal(empty.minimize_button_box.y_max, 100);

    assert_equal(sui.get_x_size(empty.x_button_box), 20);
    assert_equal(sui.get_y_size(empty.x_button_box), 20);

    assert_equal(empty.x_button_box.x_min, 81);
    assert_equal(empty.x_button_box.x_max, 100);
} @sui_test

// Local Variables:
// compile-command: "jai build_tests.jai - empty_gui_tests && ./empty_gui_tests"
// End:
