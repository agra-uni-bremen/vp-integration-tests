add_executable(mc-basic bootstrap.S main.c)
target_link_options(mc-basic PRIVATE "-nostdlib")
