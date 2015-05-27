##
## Define the function to take care of adding the gropups
##


define manageusers::create_group ( $name, $gid ) {
  group { $name:
    gid         => "$gid",
  }
}
