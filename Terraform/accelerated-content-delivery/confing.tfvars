access_key = "xxxxxxxxxxxxxxxx"
secret_key = "xxxxxxxxxxxxxxxx"
region = "ap-northeast-1"
zone = "ap-northeast-1a"
project_name = "Accelerated-Content-Delivery-for-Terraform"
ecs_password = "!Password2019"
db_user = "test_user"
db_password = "!Password2019"

web_layer_name = "web-server"
web_availability_zone = "ap-northeast-1a"
web_instance_count = 3
web_instance_type = "ecs.sn1ne.large"
web_instance_port = 80
web_instance_image_id = "centos_7_06_64_20G_alibase_20190218.vhd"
web_instance_user_data = "${file("provisioning.sh")}"

app_layer_name = "app-server"
app_availability_zone = "ap-northeast-1a"
app_instance_count = 3
app_instance_type = "ecs.sn1ne.large"
app_instance_port = 5000
app_instance_image_id = "centos_7_06_64_20G_alibase_20190218.vhd"
app_instance_user_data = "${file("provisioning.sh")}"

db_layer_name = "db-server"
db_availability_zone = "ap-northeast-1a"
db_engine = "MySQL"
db_engine_version = "5.7"
db_instance_type = "rds.mysql.s1.small"
db_instance_storage = 10
