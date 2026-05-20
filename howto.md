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

## 1. Testando o programa em Prolog

Abra o terminal na pasta do projeto e execute:

```bash
swipl
```

Carregue o arquivo Prolog:

```prolog
?- consult('rede_social.pl').
```

### Queries de teste

Consultar o grau de risco entre João e Daniel:

```prolog
?- risco_conexao(joao, daniel, Grau).
```

Resultado esperado:

```prolog
Grau = 3.
```

Consultar o grau de Ana até Daniel:

```prolog
?- risco_conexao(ana, daniel, Grau).
```

Resultado esperado:

```prolog
Grau = 2.
```

### Verificar conexão direta entre duas pessoas

```prolog
?- conectado(joao, ana).
```

Resultado esperado:

```prolog
true.
```

---

### Verificar conexão inexistente

```prolog
?- conectado(joao, maria).
```

Resultado esperado:

```prolog
false.
```

---

### Consultar todas as conexões existentes

```prolog
?- conectado(X, Y).
```

Resultado esperado (exemplo):

```prolog
X = joao,
Y = ana ;

X = ana,
Y = carlos ;

X = carlos,
Y = daniel ;
```

---

### Consultar quem é inadimplente

```prolog
?- inadimplente(X).
```

Resultado esperado:

```prolog
X = daniel.
```

---

### Verificar se existe risco indireto

```prolog
?- risco_conexao(joao, daniel, _).
```

Resultado esperado:

```prolog
true.
```

---

### Consultar todos os clientes conectados a Daniel

```prolog
?- risco_conexao(X, daniel, Grau).
```

Resultado esperado:

```prolog
X = carlos,
Grau = 1 ;

X = ana,
Grau = 2 ;

X = joao,
Grau = 3.
```

---

### Consultar valor de uma transação

```prolog
?- transacao_entre(joao, ana, Valor).
```

Resultado esperado:

```prolog
Valor = 1500.
```


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
# Análise Crítica e XAI

O projeto utiliza uma abordagem híbrida entre lógica simbólica em Prolog e aprendizado estatístico em Python.

As regras Prolog permitem representar explicitamente as relações entre indivíduos e calcular o grau de proximidade em relação a pessoas inadimplentes. Isso torna o sistema mais explicável, pois é possível visualizar os caminhos utilizados na inferência.

Exemplo:

```prolog
?- risco_conexao(joao, daniel, Grau).
Grau = 3.
```
Nesse caso, o sistema consegue explicar que João possui grau de risco 3 porque existe o caminho:

```text
joao -> ana -> carlos -> daniel
```

Diferentemente de modelos puramente estatísticos ou redes neurais profundas, as regras Prolog permitem rastrear explicitamente o raciocínio utilizado pelo sistema.

O valor calculado (`grau_risco_rede`) é utilizado pela regressão logística como uma feature adicional para previsão de risco.

Essa integração contribui para uma IA mais interpretável, auditável e transparente, pois combina regras lógicas compreensíveis com um modelo estatístico de fácil análise.
