namespace: Integrations.AOS_Application
flow:
  name: deploy_aos
  inputs:
    - target_host: 172.16.238.121
    - target_host_username: root
    - target_host_password:
        default: Cloud_1234
        sensitive: true
  workflow:
    - install_postgres:
        do:
          Integrations.demo.aos.software.install_postgres:
            - username: '${target_host_username}'
            - password:
                value: '${target_host_password}'
                sensitive: true
            - tomcat_host: '${target_host}'
        navigate:
          - FAILURE: on_failure
          - SUCCESS: install_java
    - install_java:
        do:
          Integrations.demo.aos.software.install_java:
            - username: '${target_host_username}'
            - password:
                value: '${target_host_password}'
                sensitive: true
            - tomcat_host: '${target_host}'
        navigate:
          - FAILURE: on_failure
          - SUCCESS: install_tomcat
    - install_tomcat:
        do:
          Integrations.demo.aos.software.install_tomcat:
            - username: '${target_host_username}'
            - password:
                value: '${target_host_password}'
                sensitive: true
            - tomcat_host: '${target_host}'
        navigate:
          - FAILURE: on_failure
          - SUCCESS: install_aos_application
    - install_aos_application:
        do:
          Integrations.demo.aos.application.install_aos_application:
            - username: '${target_host_username}'
            - password:
                value: '${target_host_password}'
                sensitive: true
            - tomcat_host: '${target_host}'
        navigate:
          - FAILURE: on_failure
          - SUCCESS: SUCCESS
  results:
    - FAILURE
    - SUCCESS
extensions:
  graph:
    steps:
      install_postgres:
        x: 70
        'y': 112
      install_java:
        x: 259
        'y': 114
      install_tomcat:
        x: 440
        'y': 117
      install_aos_application:
        x: 631
        'y': 119
        navigate:
          1a0b60b8-c187-31ec-bc79-a731d93054d3:
            targetId: f7dfb7a0-eb7b-ca77-24ce-cc43302a1a09
            port: SUCCESS
    results:
      SUCCESS:
        f7dfb7a0-eb7b-ca77-24ce-cc43302a1a09:
          x: 974
          'y': 124
      FAILURE:
        3539afc3-ac4d-e95d-afe8-6f08826b428a:
          x: 984
          'y': 253
