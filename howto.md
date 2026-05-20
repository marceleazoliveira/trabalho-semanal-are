# HOWTO - Análise de Risco de Crédito com Prolog e Python

## Descrição

Este projeto implementa um exemplo de análise de risco de crédito híbrido, integrando regras lógicas em Prolog com um pipeline em Python usando Pandas, PySwip e Scikit-Learn.

O sistema calcula o grau de proximidade de clientes em relação a uma pessoa inadimplente em uma rede social/financeira e usa esse valor como atributo para treinar uma regressão logística.

## Arquivos

- `rede_social.pl`: base lógica em Prolog com fatos e regras de conectividade.
- `dados_financeiros.csv`: base tabular com dados financeiros dos clientes.
- `main.py`: script Python que integra Prolog, Pandas e Scikit-Learn.


## Requisitos

- Python instalado
- SWI-Prolog instalado
- Bibliotecas Python:
  - pyswip
  - pandas
  - scikit-learn

# Execução dos Códigos

## 1. Executando o Prolog

?- consult('rede_social.pl').

?- risco_conexao(joao, daniel, Grau).
Grau = 3.

## 2. Executando o Python
No terminal:

`python main.py`

Saída esperada:


```text
Dataset enriquecido:

  cliente_id  renda_mensal  score_classico  inadimplente_historico  grau_risco_rede
0       joao           5200             750                        0                 3
1        ana           3100             610                        0                 2
2     carlos           1800             420                        1                 1

Coeficientes aprendidos:
[[-1.69430252e-02 -2.47733392e-03 -1.19685998e-05]]

Intercepto:
[42.78552581]
```
