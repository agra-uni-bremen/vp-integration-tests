add_executable(basic-c bootstrap.S sum.c main.c)
target_link_options(basic-c PRIVATE "-nostdlib")
