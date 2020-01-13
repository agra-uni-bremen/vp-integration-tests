add_executable(basic-asm sum.S)
target_link_options(basic-asm PRIVATE "-nostdlib")
