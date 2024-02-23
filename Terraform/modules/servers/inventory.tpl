all:
    children:
        clickhouse:
            hosts:
            %{ for index, ip in clickhouse_ips }
                clickhouse-hel-${index}:
                    ansible_host: ${ip}
                    ansible_user: root
                    mode: 'clickhouse'
                    init_cluster: ${index == 0 ? "'true'" : "'false'"}
            %{ endfor }
        monitoring:
            hosts:
            %{ for index, ip in monitoring_ips }
                monitoring-hel-${index}:
                    ansible_host: ${ip}
                    ansible_user: root
                    mode: 'monitoring'
                    init_cluster: 'false'
            %{ endfor }