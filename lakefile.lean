import Lake
open Lake DSL

package «p3» {
  -- add package configuration options here
}

lean_lib «P3» {
  -- add library configuration options here
}

@[default_target]
lean_exe «p3» {
  root := `Main
}
