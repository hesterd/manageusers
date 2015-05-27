##
## Define the function to take care of adding the users
##




define manageusers::create_account ( $name, $uid, $password, $shell, $groups,
   $sshkeytype = 'ssh-rsa', 
   $sshkey = 'XXX',
   $sshdomain = 'nobodys@home.net',
   $homedir = "/home/$title",
   $managehome = 'true',
   $serviceaccount = undef,
) {
  $username = $title

if !$serviceaccount {
        ssh_authorized_key{ $username:
            user        => "$username",
            ensure      =>  present,
            type        => "$sshkeytype",
            key         => "$sshkey",
            name        => "$sshdomain" ,
            require     => User[$title],
         }

        exec { "/bin/chown -R $title:$title $homedir":
		unless => "/bin/sh -c '[ $(/usr/bin/stat -c %g $homedir) == $uid ]'",
		require => User[$title],
	}
}



  user { $username:
    comment     => "$name",
    home        => "$homedir",
    shell       => "$shell",
    uid         => $uid,
    gid	        => $uid,
    managehome  => $managehome,
    password    => "$password",
    groups      => $groups,
    purge_ssh_keys => true,
    require     => Group[$title],
  }



  group { $username:
    gid         => "$uid",
  }
}
