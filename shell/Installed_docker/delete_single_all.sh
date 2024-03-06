#!/bin/bash
echo "yes" | sh alertmanager.sh hosts delete 
echo "yes" | sh promealert.sh hosts delete
echo "yes" | sh node_exporter.sh hosts delete
echo "yes" | sh vmstorage.sh hosts delete
echo "yes" | sh vmalert.sh hosts delete
echo "yes" | sh vmselect.sh hosts delete
echo "yes" | sh vminsert.sh hosts delete
echo "yes" | sh vmauth.sh hosts delete
echo "yes" | sh vmagent.sh hosts delete
echo "yes" | sh grafana.sh hosts delete
echo "yes" | sh sslkey.sh hosts delete
echo "yes" | sh elasticsearch.sh hosts delete
echo "yes" | sh postgres.sh hosts delete
echo "yes" | sh kibana.sh hosts delete
echo "yes" | sh nginx.sh hosts delete
echo "yes" | sh consul.sh hosts delete
echo "yes" | sh telegraf.sh hosts delete
