# Respostas — investigando o log

## 1. Quantas linhas ERROR existem?

```bash
grep -c ERROR dados/app.log
```
**Resposta: 8**

## 2. Quais são os 3 IPs que mais aparecem?

```bash
grep -oE 'ip=[0-9.]+' dados/app.log | sort | uniq -c | sort -rn | head -3
```
```
  12 ip=203.0.113.10
   7 ip=203.0.113.11
   4 ip=203.0.113.12
```
**Resposta: 203.0.113.10 (12x), 203.0.113.11 (7x), 203.0.113.12 (4x)**

## 3. Quantas linhas entre 10:15 e 10:20?

```bash
grep -cE '10:1[5-9]:' dados/app.log
```
**Resposta: 12** (considerando o intervalo `10:15:00` até `10:19:59` — o `[5-9]` no minuto
cobre exatamente essa faixa).
