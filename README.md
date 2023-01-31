# Дипломный практикум в Yandex.Cloud 

## Описание требований 
Требования доступны по [ссылке](https://github.com/netology-code/devops-diplom-yandexcloud)

## Создание облачной инфраструктуры:

Создание инфраструктуры в Yandex Cloud производилось с использованием Terraform.  
Репозиторий облачной инфраструктуры доступ по [ссылке](https://github.com/Nb3l77eo/diploma-infra).  


<details>
    <summary style="font-size:15px">Снимки экрана:</summary>

</details>


## Создание Kubernetes кластера:

Для создания Kubernetes кластера были использованы следующие ресурсы Yandex Cloud:
- yandex_kubernetes_cluster
- yandex_kubernetes_node_group
- yandex_lb_network_load_balancer

<details>
    <summary style="font-size:15px">Снимки экрана:</summary>

</details>


## Создание тестового приложения:
Репозиторий тестового приложения доступен по [ссылке](https://github.com/Nb3l77eo/diploma-app).  

<details>
    <summary style="font-size:15px">Снимки экрана:</summary>

</details>



## Подготовка cистемы мониторинга и деплой приложения:
Деплой системы мониторинга производился при использовании helm и файла конфигурации к стеку.  


<details>
    <summary style="font-size:15px">Снимки экрана:</summary>

</details>


## Установка и настройка CI/CD:
В качестве оркестровщика был выбран Jenkins. Деплой Jenkins производился с импользованием helm и файлов конфигурации.  

<details>
    <summary style="font-size:15px">Снимки экрана:</summary>

</details>

## Итог
Фактически для запуска примитивного CI/CD необходимо выполнить создание облачной инфрастуктуры и настройку оркестровщика в части создания задачи, которую так же скорее всего можно импортировать.  