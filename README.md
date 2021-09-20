# wp-dbgroupreplica-test-project
WordPress Deploy with MySQL Single-Primary Group Replication
  
## Requirements  
- Git
- Ansible version: 2.11 or higher
- Ansible plugins:
  - community.mysql - to unctall it use: `ansible-galaxy collection install community.mysql`



## Getting started  
You will need at least 4 instances uder Ubuntu Linux: 3 nodes for MySQL Replication and one node for web-server/proxysql. But you can use as many nodes as you like. Configure them and set up access from your computer.  
  
Download this project to your computer.  
```console
git clone https://github.com/rus-bryl/wp-dbgroupreplica-test-project.git
```
Go to the project directory.
```console
cd wp-dbgroupreplica-test-project
```
Edit the file inventory/hosts  
```console
[webservers]
webserver ansible_host=192.168.1.132

[proxysql]
webserver ansible_host=192.168.1.131

[db_masters]
dbmaster1 ansible_host=192.168.1.135

[db_slaves]
dbslave1 ansible_host=192.168.1.134
dbslave2 ansible_host=192.168.1.133
dbslave3 ansible_host=192.168.1.129
dbslave4 ansible_host=192.168.1.128

[db_servers:children]
db_masters
db_slaves

[all:vars]
# Basic Settings
time_zone="Europe/Kiev"

# MySQL Settings
mysql_root_password="!vault |
          $ANSIBLE_VAULT;1.1;AES256
          65393565343233613037376230313064363732666462306266393231393932636435366639663934
          3034656461373738633363323739636332313739343866330a373730343732386264343663663030
          32333137393038663136303033646261326630643637623130343238313230643230333530333865
          3739313234656465650a333766306564393831383535353062646139656362613632366463626531
          6635"
mysql_db="wordpress"
mysql_wp_user="wpuser"
mysql_wp_password="!vault |
          $ANSIBLE_VAULT;1.1;AES256
          34383437613065353939646261643664653135656531333965306434376562306364636564656662
          6338343065626534343561346162356332313130316663640a316336326532333062393332636631
          35393539373438313939613665313732373136656139366238656634666563303639643732663736
          3433383964373033620a343735306531363531363839363434616130363638376533386261306236
          3830"
mysql_replica_user="replicauser"
mysql_replica_password="!vault |
          $ANSIBLE_VAULT;1.1;AES256
          65626330616236383661653937373762323935323866626362626161633235613737666261306131
          3730383730656465313764356532323362646166646436380a303765353837303664373038353964
          38613166316331323136663663633239383636316432653062336165346563623361666465306634
          3261363662623232370a633266623265643063306536346361343963353463313031643134353231
          3565"

# ProxySQL Settings
proxysql_admin_password="!vault |
          $ANSIBLE_VAULT;1.1;AES256
          34633465643962616566643531323862356566343666353032383134396137356138666664343665
          3361376461633731363539653566313831623934383061330a353636303866303535373863313331
          63653930396364636163653561663631313734653730323031366331333464666537623964636166
          3930646532363839630a613563383139346362333566386532306566626565303736353662323265
          66306534613531666534353262643135666662613236636661313662333536646364"

# HTTP Settings
http_host="your-host.domain.name"
http_port="80"
project_name="wordpress"
```
Web server and proxysql can be combined - specify the same IP address for them. DB servers will be deployed as many as you specify in this file. There ara 5 DB servers in this example: 1 master and 4 slaves.  
  
Save this file and run deploy.
```console
./deploy.sh
```
