## Define the microservice version

provectus_versiontag = "0.0.2"

### AWS related

region = {
        production = "eu-central-1"
        development = "eu-west-1"
}

vpc_cidr = {
        production = "10.10.0.0/16"
        development = "10.3.0.0/16"
}

default_subnet_cidr_block = {
        production = "10.10.0.0/22"
        development = "10.3.0.0/22"
}

default_db_subnet_cidr_block = {
        production = "10.10.4.0/22"
        development = "10.3.0.0/22"
}
default_subnet_availability_zone = {
        production = "eu-central-1a"
        development = "eu-west-1a"
}
default_db_subnet_availability_zone = {
        production = "eu-central-1b"
        development = "eu-west-1b"
}

# Map
instance_type = {
     production = "m3.medium"
     development = "m3.medium"
}

# Map of Lists
default_db_subnet_group_subnet_ids = {
     eu-central-1 = [ "subnet-f1e92d8a", "subnet-304b7f7a" ]
     eu-west-1 = [ "subnet-f1e92d8a", "subnet-304b7f7a"  ]
}

asg_enabled_metrics = [ "GroupDesiredCapacity", "GroupPendingInstances", "GroupInServiceInstances", "GroupMaxSize",
                        "GroupStandbyInstances", "GroupTotalInstances", "GroupMinSize" , "GroupTerminatingInstances" ]

#
#instance_suffix = ["blue"]
instance_suffix = ["blue","green"]


instance_count_provectus_desired = {
	        production = 1 
	        development = 1
}
instance_count_provectus_min = {
	        production = 1
	        development = 1
}
instance_count_provectus_max = {
	        production = 3
	        development = 1
}

