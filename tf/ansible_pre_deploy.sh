
# terraform 
# tpl/ansible_inventory.cfg > tmp
# sed 's/${jump}/$(tf output jumpbox_ip)/g' policy.tpl > ansible.hosts.tmp

echo "


Fetching vars from terraform and passing it to ansible


";

sed -e 's/${jump}/'$(terraform output jumpbox_ip | tr -d '"')'/g' \
-e 's/${cassandra_1a}/'$(terraform output cassandra_1a | tr -d '"')'/g' \
-e 's/${cassandra_1b}/'$(terraform output cassandra_1b | tr -d '"')'/g' \
-e 's/${cassandra_1c}/'$(terraform output cassandra_1c | tr -d '"')'/g' \
tpl/ansible_inventory.cfg > ../ansible/hosts

cat ../ansible/hosts



sed -e 's/${jump}/'$(terraform output jumpbox_ip | tr -d '"')'/g' \
-e 's/${cassandra_1a}/'$(terraform output cassandra_1a | tr -d '"')'/g' \
-e 's/${cassandra_1b}/'$(terraform output cassandra_1b | tr -d '"')'/g' \
-e 's/${cassandra_1c}/'$(terraform output cassandra_1c | tr -d '"')'/g' \
tpl/cassandra.yaml.orig.tpl > ../ansible/files/cassandra.yaml.tpl



#
#
#sed -e 's/${rds_db_pass}/'$(terraform output rds_db_pass)'/g' \
#-e 's/${rds_db_name}/'$(terraform output rds_db_name)'/g' \
#-e 's/${rds_db_user}/'$(terraform output rds_db_user)'/g' \
#-e 's/${s3_bucket}/'$(terraform output s3_bucket)'/g' \
#-e 's/${rds_endpoint}/'$(terraform output rds_endpoint | cut -d ':' -f 1)'/g' \
#tpl/ansible_variables.cfg > ../ansible/vars/default.yml
#
#cat ../ansible/vars/default.yml
