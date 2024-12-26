#!/bin/bash

# Файл с логами
LOG_FILE="access.log"
REPORT_FILE="report.txt"

# Проверяем наличие файла с логами
if [ ! -f "$LOG_FILE" ]; then
  echo "Файл $LOG_FILE не найден. Сначала создайте его."
  exit 1
fi

# Подсчитать общее количество запросов
total_requests=$(wc -l < "$LOG_FILE")

# Подсчитать количество уникальных IP-адресов
unique_ips=$(awk '{print $1}' "$LOG_FILE" | sort | uniq | wc -l)

# Подсчитать количество запросов по методам
methods=$(awk '{print $6}' "$LOG_FILE" | tr -d '"' | sort | uniq -c | sort -nr)

# Найти самый популярный URL
popular_url=$(awk '{print $7}' "$LOG_FILE" | sort | uniq -c | sort -nr | head -n 1 | awk '{print $2}')

# Создать отчет
{
  echo "Отчет по логам"
  echo "================="
  echo "Общее количество запросов: $total_requests"
  echo "Количество уникальных IP-адресов: $unique_ips"
  echo "Запросы по методам:"
  echo "$methods"
  echo "Самый популярный URL: $popular_url"
} > "$REPORT_FILE"

# Вывод сообщения об успешном завершении
echo "Отчет успешно создан: $REPORT_FILE"
