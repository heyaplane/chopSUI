// Source: https://jai.community/t/using-notes/196

#run
{
    w := compiler_create_workspace();

    options := get_build_options(w);

    args := options.compile_time_command_line;
    print("%\n", args);
    assert(args.count == 3, "Specify one file to build!\n");

    test_file := args[args.count - 1];
    rel_path := sprint("tests/%.jai", test_file);
    _, path_exists := get_absolute_path(rel_path);

    assert(path_exists);

    modules_paths: [..] string;
    modules_dir := "/home/egret/projects/jai/my_modules";
    array_add(*modules_paths, modules_dir);
    array_add(*modules_paths, ..options.import_path);
    options.import_path = modules_paths;

    options.output_executable_name = test_file;
    options.output_path = "tests/";
    set_build_options(options, w);

    compiler_begin_intercept(w);
    add_build_file(rel_path, w);

    tests: [..] string;
    gen_code := false;
    while true
    {
        message := compiler_wait_for_message();
        if !message break;
        if message.kind ==
        {
            case .TYPECHECKED;
                typechecked := cast(*Message_Typechecked) message;
                for decl: typechecked.declarations
                {
                    if equal(decl.expression.name, "main") continue;

                    for note: decl.expression.notes
                    {
                        if equal(note.text, "sui_test")
                        {
                            array_add(*tests, copy_string(decl.expression.name));
                        }
                    }
                }

            case .PHASE;
            {
                phase := cast(*Message_Phase) message;
                if !gen_code && phase.phase == .TYPECHECKED_ALL_WE_CAN
                {
                    code := generate_code(tests);
                    add_build_string(code, w);
                    gen_code = true;
                }
            }

            case .COMPLETE; break;
        }
    }

    compiler_end_intercept(w);
    set_build_options_dc(.{do_output=false});
}

generate_code :: (tests: [..] string) -> string #expand
{
    builder: String_Builder;

    append(*builder, "main :: () {\n");
    for test: tests
    {
        print_to_builder(*builder, " assert_test(%1);\n", test);
    }
    append(*builder, "}\n");

    return builder_to_string(*builder);
}

#import "Compiler";
#import "String";
#import "Basic";
#import "File";
