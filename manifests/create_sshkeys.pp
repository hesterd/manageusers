##
##

define manageusers::create_sshkeys ( $user, $sshkeytype, $sshkey,$sshdomain ) {

  $username = $title
  ssh_authorized_key{ $username: 
    user        => "$user",
    ensure      =>  present, 
    type        => "$sshkeytype", 
    key         => "$sshkey", 
    name        => "$sshdomain" ,
    require     => User[$user],
  } 
}
