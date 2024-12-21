#import "Assertive";

sui :: #import "chopSUI";

chop_left_positive_only_test :: ()
{
    layout := sui.Box.{0, 100, 0, 100};
    ok, piece := sui.chop(*layout, .LEFT, 50);

    assert_true(ok);

    assert_equal(piece.x_min, 0);
    assert_equal(piece.x_max, 49);

    assert_equal(layout.x_min, 50);
    assert_equal(layout.x_max, 100);
} @sui_test

chop_left_negative_and_positive_test :: ()
{
    layout := sui.Box.{-100, 100, -100, 100};
    ok, piece := sui.chop(*layout, .LEFT, 50);

    assert_true(ok);

    assert_equal(piece.x_min, -100);
    assert_equal(piece.x_max, -51);

    assert_equal(layout.x_min, -50);
    assert_equal(layout.x_max, 100);
} @sui_test

chop_left_barely_pass_test :: ()
{
    layout := sui.Box.{0, 100, 0, 100};
    ok, piece := sui.chop(*layout, .LEFT, 100);

    assert_true(ok);

    assert_equal(piece.x_min, 0);
    assert_equal(piece.x_max, 99);

    assert_equal(layout.x_min, 100);
    assert_equal(layout.x_max, 100);
} @sui_test

chop_left_barely_fail_test :: ()
{
    layout := sui.Box.{0, 100, 0, 100};
    ok, piece := sui.chop(*layout, .LEFT, 101);

    assert_false(ok);
} @sui_test

chop_right_positive_only_test :: ()
{
    layout := sui.Box.{0, 100, 0, 100};
    ok, piece := sui.chop(*layout, .RIGHT, 50);

    assert_true(ok);

    assert_equal(piece.x_min, 51);
    assert_equal(piece.x_max, 100);

    assert_equal(layout.x_min, 0);
    assert_equal(layout.x_max, 50);
} @sui_test

chop_right_negative_and_positive_test :: ()
{
    layout := sui.Box.{-100, 100, -100, 100};
    ok, piece := sui.chop(*layout, .RIGHT, 150);

    assert_true(ok);

    assert_equal(piece.x_min, -49);
    assert_equal(piece.x_max, 100);

    assert_equal(layout.x_min, -100);
    assert_equal(layout.x_max, -50);
} @sui_test

chop_right_barely_pass_test :: ()
{
    layout := sui.Box.{0, 100, 0, 100};
    ok, piece := sui.chop(*layout, .RIGHT, 100);

    assert_true(ok);

    assert_equal(piece.x_min, 1);
    assert_equal(piece.x_max, 100);

    assert_equal(layout.x_min, 0);
    assert_equal(layout.x_max, 0);
} @sui_test

chop_right_barely_fail_test :: ()
{
    layout := sui.Box.{0, 100, 0, 100};
    ok, piece := sui.chop(*layout, .RIGHT, 101);

    assert_false(ok);
} @sui_test

chop_up_positive_only_test :: ()
{
    layout := sui.Box.{0, 100, 0, 100};
    ok, piece := sui.chop(*layout, .UP, 50);

    assert_true(ok);

    assert_equal(piece.y_min, 51);
    assert_equal(piece.y_max, 100);

    assert_equal(layout.y_min, 0);
    assert_equal(layout.y_max, 50);
} @sui_test

chop_up_negative_and_positive_test :: ()
{
    layout := sui.Box.{-100, 100, -100, 100};
    ok, piece := sui.chop(*layout, .UP, 150);

    assert_true(ok);

    assert_equal(piece.y_min, -49);
    assert_equal(piece.y_max, 100);

    assert_equal(layout.y_min, -100);
    assert_equal(layout.y_max, -50);
} @sui_test

chop_up_barely_pass_test :: ()
{
    layout := sui.Box.{0, 100, 0, 100};
    ok, piece := sui.chop(*layout, .UP, 100);

    assert_true(ok);

    assert_equal(piece.y_min, 1);
    assert_equal(piece.y_max, 100);

    assert_equal(layout.y_min, 0);
    assert_equal(layout.y_max, 0);
} @sui_test

chop_up_barely_fail_test :: ()
{
    layout := sui.Box.{0, 100, 0, 100};
    ok, piece := sui.chop(*layout, .UP, 101);

    assert_false(ok);
} @sui_test

chop_down_positive_only_test :: ()
{
    layout := sui.Box.{0, 100, 0, 100};
    ok, piece := sui.chop(*layout, .DOWN, 50);

    assert_true(ok);

    assert_equal(piece.y_min, 0);
    assert_equal(piece.y_max, 49);

    assert_equal(layout.y_min, 50);
    assert_equal(layout.y_max, 100);
} @sui_test

chop_down_negative_and_positive_test :: ()
{
    layout := sui.Box.{-100, 100, -100, 100};
    ok, piece := sui.chop(*layout, .DOWN, 50);

    assert_true(ok);

    assert_equal(piece.y_min, -100);
    assert_equal(piece.y_max, -51);

    assert_equal(layout.y_min, -50);
    assert_equal(layout.y_max, 100);
} @sui_test

chop_down_barely_pass_test :: ()
{
    layout := sui.Box.{0, 100, 0, 100};
    ok, piece := sui.chop(*layout, .DOWN, 100);

    assert_true(ok);

    assert_equal(piece.y_min, 0);
    assert_equal(piece.y_max, 99);

    assert_equal(layout.y_min, 100);
    assert_equal(layout.y_max, 100);
} @sui_test

chop_down_barely_fail_test :: ()
{
    layout := sui.Box.{0, 100, 0, 100};
    ok, piece := sui.chop(*layout, .DOWN, 101);

    assert_false(ok);
} @sui_test

// Local Variables:
// compile-command: "jai build_tests.jai - layout_tests && ./layout_tests"
// End:
