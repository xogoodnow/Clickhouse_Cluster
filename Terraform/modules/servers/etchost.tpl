127.0.0.1 localhost

%{ for index, ip in clickhouse_ips }
${ip} clickhouse-${index +1}
%{ endfor }

ff02::1 ip6-allnodes
ff02::2 ip6-allrouters