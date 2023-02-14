# Дипломный практикум в Yandex.Cloud 

## Описание требований 
Требования доступны по [ссылке](https://github.com/netology-code/devops-diplom-yandexcloud)

## Создание облачной инфраструктуры:

Создание инфраструктуры в Yandex Cloud производилось с использованием Terraform Cloud.  
Репозиторий облачной инфраструктуры доступен по ссылке [diploma-infra](https://github.com/Nb3l77eo/diploma-infra).  


<details>
    <summary style="font-size:15px">Снимки экрана:</summary>
    
![изображение](https://user-images.githubusercontent.com/93001155/215881738-b9b27c1e-9884-41d0-adde-f37df4b85193.png)

</details>


## Создание Kubernetes кластера:

Kubernetes поднимается на сервисе Yandex Managed Service for Kubernetes, который автоматически управляет Yandex Network Load Balancer в случае публикации сервиса с типом LoadBalancer. С параметрами создаваемого кластера Kubernetes можно ознакомится в Terraform манифестах.  

Для создания Kubernetes кластера были использованы следующие основные ресурсы Yandex Cloud:
- [yandex_kubernetes_cluster](https://github.com/Nb3l77eo/diploma-infra/blob/095068c4fa7abb02524b769928ecd423577e3823/terraform/k8s_master.tf#L3)
- [yandex_kubernetes_node_group](https://github.com/Nb3l77eo/diploma-infra/blob/main/terraform/k8s_ng.tf)
- yandex_lb_network_load_balancer - данный ресурс управляется средствами YC


<details>
    <summary style="font-size:15px">Снимки экрана:</summary>
    
![изображение](https://user-images.githubusercontent.com/93001155/215881842-a905feab-cea6-4307-9be2-155eedd7f277.png)
![изображение](https://user-images.githubusercontent.com/93001155/215881893-e8abddd7-0e04-4986-aa8d-8ad8a060a184.png)
![изображение](https://user-images.githubusercontent.com/93001155/215881911-87275dbe-e760-4237-8fda-df7949ac9177.png)
![изображение](https://user-images.githubusercontent.com/93001155/215881944-c9696785-da22-41fa-bfc2-bd2dcb57c7f1.png)
![изображение](https://user-images.githubusercontent.com/93001155/215882030-48cd5608-c025-4c6e-bd99-176410a0cca9.png)


</details>


## Создание тестового приложения:
Репозиторий тестового приложения доступен по ссылке [diploma-app](https://github.com/Nb3l77eo/diploma-app).  
В репозитории расположен файл [Jenkinsfile](https://github.com/Nb3l77eo/diploma-app/blob/main/Jenkinsfile) описания процессов CI/CD для оркестровщика - Jenkins.  

<details>
    <summary style="font-size:15px">Снимки экрана:</summary>
    
![изображение](https://user-images.githubusercontent.com/93001155/215882499-d35cbc89-d690-4916-bffa-8b928500a048.png)


</details>



## Описание схемы деплоя системы мониторинга и оркестровщика:

Один из Terraform манифестов описывает создание [mgmt](https://github.com/Nb3l77eo/diploma-infra/blob/main/terraform/mgmt-node.tf) ноды. Данная нода используется для деплоя системы мониторинга и оркестровщика в кластер Kubernetes.  
Для того, чтобы созданная нода могла подключатся к кластеру мы  [создаем сервисный аккаунт](https://github.com/Nb3l77eo/diploma-infra/blob/095068c4fa7abb02524b769928ecd423577e3823/terraform/mgmt-node.tf#L1) и [привязываем](https://github.com/Nb3l77eo/diploma-infra/blob/095068c4fa7abb02524b769928ecd423577e3823/terraform/mgmt-node.tf#L24) его к ней.  

При создании mgmt-node мы используем параметр [user-data](https://github.com/Nb3l77eo/diploma-infra/blob/095068c4fa7abb02524b769928ecd423577e3823/terraform/mgmt-node.tf#L48), который определяет параметры и первоначальные инструкции. User-data формируется из [шаблона](https://github.com/Nb3l77eo/diploma-infra/blob/main/terraform/metadata/_mgmt_meta.tpl), который позволяет передать динамические данные, которые формируются в том числе при применении Terraform манифестов (такие как идентификатор облака, идентификатор папки, идентификатор кластера Kubernetes) для обеспечения взаимодействия управляющей ноды с кластером Kubernetes.  

Последним этапом передается [инструкция](https://github.com/Nb3l77eo/diploma-infra/blob/095068c4fa7abb02524b769928ecd423577e3823/terraform/metadata/_mgmt_meta.tpl#L42) запуска скрипта деплоя системы мониторинга и оркестровщика.  

[Скрипт деплоя](https://github.com/Nb3l77eo/diploma-infra/blob/main/terraform/src/deploy_cluster_infra.sh) системы мониторинга и оркестровщика логически можно поделить на две составляющих. 1) Подготовка окружения управляющей ноды 2) Непосредственный деплой компонентов.  


## Подготовка системы мониторинга и деплой приложения:

Деплой системы мониторинга [производится](https://github.com/Nb3l77eo/diploma-infra/blob/095068c4fa7abb02524b769928ecd423577e3823/terraform/src/deploy_cluster_infra.sh#L23) при использовании helm и [файла конфигурации](https://github.com/Nb3l77eo/diploma-infra/blob/095068c4fa7abb02524b769928ecd423577e3823/terraform/conf/monitoring.yml) к стеку Kube-prometheus-stack.  


<details>
    <summary style="font-size:15px">Снимки экрана:</summary>

![изображение](https://user-images.githubusercontent.com/93001155/215882564-0bd719f7-1706-47b0-bf24-16d7687caad0.png)
![изображение](https://user-images.githubusercontent.com/93001155/215882577-9d860cf8-4ab3-4638-be50-b49dbe75c74e.png)
![изображение](https://user-images.githubusercontent.com/93001155/215882596-39aa3693-3914-4994-886d-b34bf8bedd73.png)


</details>


## Установка и настройка CI/CD:
В качестве оркестровщика был выбран Jenkins в связи с большим комьюнити и отсутствием необходимости приобретения лицензии.  

Деплой Jenkins [производится](https://github.com/Nb3l77eo/diploma-infra/blob/095068c4fa7abb02524b769928ecd423577e3823/terraform/src/deploy_cluster_infra.sh#L30) с использованием helm и [файла конфигурации](https://github.com/Nb3l77eo/diploma-infra/blob/095068c4fa7abb02524b769928ecd423577e3823/terraform/conf/jenkins.yml).  

В проекте приложения [diploma-app](https://github.com/Nb3l77eo/diploma-app) присутствует Jenkinsfile в котором описана логика CI\CD. К сожалению, сам джоб необходимо добавить в ручную с характеристиками приведенным на снимке экрана [скрин job'ы](https://user-images.githubusercontent.com/93001155/215884095-75fbad1b-7af5-4b1e-8865-e501f15d68ff.png) приложенного в фале [README.md](https://github.com/Nb3l77eo/diploma-infra/blob/095068c4fa7abb02524b769928ecd423577e3823/README.md) в репозитории по сдаче дипломного проекта [diploma-infra](https://github.com/Nb3l77eo/diploma-infra).

Для корректной выкладки docker образа в оркестровщике необходимо создать credentials типа логин/пароль с именем "docker-hub".

Возможно, технически можно и импортировать job'у, чтобы не заниматься ручной работой. Но т.к. настройка job'ы подразумевает установку всего-лишь 4х  параметров, таких как:
- адрес репозитория по которому будем производить CI\CD
- по каким refs будем производить обзор (discovery) репозитория - branches, tags
- по каким условиям будем инициализировать сборку -  branches, tags
- периодичность сканирования репозитория  

было принято решение не усложнять проект.


<details>
    <summary style="font-size:15px">Снимки экрана:</summary>

![изображение](https://user-images.githubusercontent.com/93001155/215882663-cf33f1ac-955c-4595-8755-a28e816ca889.png)
![изображение](https://user-images.githubusercontent.com/93001155/215882685-6dfc6007-cbf8-48d5-b904-4c6378043de0.png)
![изображение](https://user-images.githubusercontent.com/93001155/215884095-75fbad1b-7af5-4b1e-8865-e501f15d68ff.png)
![изображение](https://user-images.githubusercontent.com/93001155/215882703-3c4b9e6e-9100-4f4a-9096-8095bf0053c8.png)
![изображение](https://user-images.githubusercontent.com/93001155/215882721-151319b1-5452-430b-a51b-fac4dfb25b0c.png)
![изображение](https://user-images.githubusercontent.com/93001155/215882734-00e9ad18-ebc1-46cc-8744-4ca712fca213.png)
![изображение](https://user-images.githubusercontent.com/93001155/215882774-2b50ed98-58c4-475a-944c-93dfe58c8c14.png)


</details>

## Итог
Фактически для запуска примитивного CI/CD необходимо выполнить создание облачной инфрастуктуры и настройку оркестровщика в части создания job'ы и credentials.  


