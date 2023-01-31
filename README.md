# Дипломный практикум в Yandex.Cloud 

## Описание требований 
Требования доступны по [ссылке](https://github.com/netology-code/devops-diplom-yandexcloud)

## Создание облачной инфраструктуры:

Создание инфраструктуры в Yandex Cloud производилось с использованием Terraform.  
Репозиторий облачной инфраструктуры доступ по [ссылке](https://github.com/Nb3l77eo/diploma-infra).  


<details>
    <summary style="font-size:15px">Снимки экрана:</summary>
    
![изображение](https://user-images.githubusercontent.com/93001155/215881738-b9b27c1e-9884-41d0-adde-f37df4b85193.png)

</details>


## Создание Kubernetes кластера:

Для создания Kubernetes кластера были использованы следующие ресурсы Yandex Cloud:
- yandex_kubernetes_cluster
- yandex_kubernetes_node_group
- yandex_lb_network_load_balancer

<details>
    <summary style="font-size:15px">Снимки экрана:</summary>
    
![изображение](https://user-images.githubusercontent.com/93001155/215881842-a905feab-cea6-4307-9be2-155eedd7f277.png)
![изображение](https://user-images.githubusercontent.com/93001155/215881893-e8abddd7-0e04-4986-aa8d-8ad8a060a184.png)
![изображение](https://user-images.githubusercontent.com/93001155/215881911-87275dbe-e760-4237-8fda-df7949ac9177.png)
![изображение](https://user-images.githubusercontent.com/93001155/215881944-c9696785-da22-41fa-bfc2-bd2dcb57c7f1.png)
![изображение](https://user-images.githubusercontent.com/93001155/215882030-48cd5608-c025-4c6e-bd99-176410a0cca9.png)


</details>


## Создание тестового приложения:
Репозиторий тестового приложения доступен по [ссылке](https://github.com/Nb3l77eo/diploma-app).  

<details>
    <summary style="font-size:15px">Снимки экрана:</summary>
    
![изображение](https://user-images.githubusercontent.com/93001155/215882499-d35cbc89-d690-4916-bffa-8b928500a048.png)


</details>



## Подготовка cистемы мониторинга и деплой приложения:
Деплой системы мониторинга производился при использовании helm и файла конфигурации к стеку.  


<details>
    <summary style="font-size:15px">Снимки экрана:</summary>

![изображение](https://user-images.githubusercontent.com/93001155/215882564-0bd719f7-1706-47b0-bf24-16d7687caad0.png)
![изображение](https://user-images.githubusercontent.com/93001155/215882577-9d860cf8-4ab3-4638-be50-b49dbe75c74e.png)
![изображение](https://user-images.githubusercontent.com/93001155/215882596-39aa3693-3914-4994-886d-b34bf8bedd73.png)


</details>


## Установка и настройка CI/CD:
В качестве оркестровщика был выбран Jenkins. Деплой Jenkins производился с импользованием helm и файлов конфигурации.  

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
Фактически для запуска примитивного CI/CD необходимо выполнить создание облачной инфрастуктуры и настройку оркестровщика в части создания задачи, которую так же скорее всего можно импортировать.  

Мониторинг доступ по адресу: [51.250.14.124](http://51.250.14.124)  
Логин/пароль направлен через личный кабинет.
Оркестровщик доступ по адресу: [51.250.72.203](http://51.250.72.203)  
Логин/пароль направлен через личный кабинет.
Приложение доступно по адресу: [51.250.64.210](http://51.250.64.210)  
