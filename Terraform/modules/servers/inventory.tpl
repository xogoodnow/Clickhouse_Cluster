all:
    children:
        helsinki:
            hosts:
            %{ for index, ip in clickhouse_ips }
                clickhouse-hel-${index}:
                    ansible_host: ${ip}
                    ansible_user: root
                    mode: 'redis'
                    init_cluster: ${index == 0 ? "'true'" : "'false'"}
            %{ endfor }

            %{ for index, ip in monitoring_ips }
                monitoring-hel-${index}:
                    ansible_host: ${ip}
                    ansible_user: root
                    mode: 'monitoring'
                    init_cluster: 'false'
            %{ endfor }