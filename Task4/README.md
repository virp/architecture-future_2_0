# Задание 4. Автоматизация развёртывания (локально через Docker)

## Диаграмма

![Диаграмма развёртывания](./diagram.png)

## Как запустить

```bash
   terraform init
   terraform plan
   terraform apply
```

Приложение будет на `http://localhost:8080/` ручки - `/health` или `/info`

```bash
   terraform destroy
```

![terraform apply (1)](./apply-1.png)
![terraform apply (1)](./apply-2.png)
![terraform apply (1)](./apply-3.png)
![terraform apply (1)](./apply-4.png)
