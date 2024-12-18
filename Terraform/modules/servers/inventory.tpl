all:
    children:
        clickhouse:
            hosts:
            %{ for index, ip in clickhouse_ips }
                clickhouse-${index}:
                    ansible_host: ${ip}
                    ansible_user: root
                    init_cluster: ${index == 0 ? "'true'" : "'false'"}
            %{ endfor }