package { "lvm2":
	ensure => "absent",
} ->
class { "::epel":
} ->
service { "firewalld":
	ensure => "stopped",
	enable => false,
} ->
package { "unzip":
	ensure => "present",
} ->
class { "::docker":
	tcp_bind        => ['tcp://127.0.0.1:2375'],
} ->
docker::image { "consul":
    tag => "0.7.0",
} ->
docker::image { "jruby":
    tag => "9",
} ->
docker::image { "ruby":
    tag => "2.2.5",
} ->
docker::image { "rabbitmq":
    tag => "3-management",
} ->
docker::image { "gliderlabs/registrator":
    tag => "v7",
} ->
docker::run { "rabbitmq":
	image => "rabbitmq:3-management",
	env => [
			"SERVICE_5672_NAME=rabbitmq",
		],
	ports => [
			"5672:5672",
			"15672:15672",
		],
}
docker::run { "consul":
	image => "consul:0.7.0",
	ports => [
			"8500:8500",
		],
}
docker::run { "registrator":
	image => "gliderlabs/registrator:v7",
	net => 'host',
	volumes => [
			"/var/run/docker.sock:/tmp/docker.sock",
		],
	command => 'consul://localhost:8500',
}
