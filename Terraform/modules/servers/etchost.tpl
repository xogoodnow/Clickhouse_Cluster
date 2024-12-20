127.0.0.1 localhost

%{ for index, ip in clickhouse_ips }
${ip} clickhouse-${index}
%{ endfor }

ff02::1 ip6-allnodes
ff02::2 ip6-allrouters
