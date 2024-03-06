#!/bin/bash
sh sslkey.sh hosts install
sh elasticsearch.sh hosts install
sh postgres.sh hosts install
sh kibana.sh hosts install
sh nginx.sh hosts install
sh consul.sh hosts install
sh alertmanager.sh hosts install 
sh promealert.sh hosts install
sh node_exporter.sh hosts install
sh vmstorage.sh hosts install
sh vmalert.sh hosts install
sh vmselect.sh hosts install
sh vminsert.sh hosts install
sh vmauth.sh hosts install
sh vmagent.sh hosts install
sh grafana.sh hosts install
sh telegraf.sh hosts install
