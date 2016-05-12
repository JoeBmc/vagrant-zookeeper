# Explictly set to avoid warning message
Package
{
	allow_virtual => false,
}

node /^centos/ 
{
	file { 'bash_profile':
			path    => '/home/vagrant/.bash_profile',
			ensure  => file,
			source  => '/vagrant/manifests/bash_profile',
			before => Class['zookeeper']
	}
	
	exec { 'update-rpm-packages':
		command => '/usr/bin/yum update -y',
		timeout => 1800
	}

	package {'epel-release':
  		ensure => 'installed',
  		require => Exec['update-rpm-packages'],
		before => Class['java']
	}

	class { 'java':
		distribution => 'jre',
		before => Class['zookeeper'],
		require => Exec['update-rpm-packages']
  	}

	# Install Zookeeper at 127.0.0.1
	class { 'zookeeper':
	    repo => 'cloudera',
	    cdhver => '5',
	    packages => ['zookeeper', 'zookeeper-server'],
	    service_name => 'zookeeper-server',
	    initialize_datastore => true,
	    client_ip => $::ipaddress_lo,
	    service_provider => 'redhat',
	    require => Exec['update-rpm-packages']
  	}

  
	# Configure TrueSight Pulse meter
	class { 'boundary':
		token => $::api_token
	}

}

node /ubuntu-14-04/ 
{
	file { 'bash_profile':
		path    => '/home/vagrant/.bash_profile',
		ensure  => file,
		source  => '/vagrant/manifests/bash_profile',
		before => Class['zookeeper']
	}

	exec { 'update-apt-packages':
		command => '/usr/bin/apt-get update -y',
	}

	# Install Zookeeper at 127.0.0.1
	class { 'zookeeper':		
		client_ip => $::ipaddress_lo,		
		require => Exec['update-apt-packages']		
	}	

	# Configure TrueSight Pulse meter
	class { 'boundary':
		token => $::api_token,
	}

}

node /ubuntu-12-04/ 
{
	file { 'bash_profile':
		path    => '/home/vagrant/.bash_profile',
		ensure  => file,
		source  => '/vagrant/manifests/bash_profile',
		before => Class['java']
	}

	exec { 'update-apt-packages':
		command => '/usr/bin/apt-get update -y',
	}
	
	class { 'java':
			distribution => 'jre',
			before => Class['boundary'],
			require => Exec['update-apt-packages']
  	}
		

	# Configure TrueSight Pulse meter
	class { 'boundary':
		token => $::api_token		
	}

}
