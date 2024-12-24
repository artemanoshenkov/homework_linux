#!/bin/bash
# Создание заголовка отчета
echo "Отчет о логе веб-сервера" >> report.txt
echo "========================" >> report.txt
# Подсчет общего количества запросов
awk '{count++} END {print "Oбщее количество запросов:\t" count}' access.log >> report.txt
# Подсчет количества уникальных IP-адресов (строго с использованием awk)
awk '{ips[$1]++} END {print "Количество уникальных IP-адресов:\t" length(ips)}' access.log >> report.txt
# Подсчет количества запросов по методам (GET, POST и т.д.)
awk 'BEGIN{print "\nКоличество запросов по методам:"}{method=$6; gsub(/"/, "", method);if (method!="") methods[method]++} END {for (method in methods) print "\t"methods[method], method}' access.log >> report.txt
# Нахождение самого популярного URL (строго с использованием awk)
awk 'BEGIN{print"\n"}{l=$7; ls[l]++} END {max=0; name="test"; for (i in ls) if(ls[i]>max) {max=ls[i]; name=i}; print "Самый популярный URL: \t" max, name }' access.log >> report.txt
