from pyswip import Prolog
import pandas as pd
from sklearn.linear_model import LogisticRegression

prolog = Prolog()
prolog.consult("rede_social.pl")

df = pd.read_csv("dados_financeiros.csv")

def obter_grau_risco(nome):
    query = list(prolog.query(f"risco_conexao({nome}, daniel, Grau)"))

    if query:
        return query[0]["Grau"]

    return 999

df["grau_risco_rede"] = df["cliente_id"].apply(obter_grau_risco)

print("Dataset enriquecido:")
print(df)

X = df[["renda_mensal", "score_classico", "grau_risco_rede"]]
y = df["inadimplente_historico"]

modelo = LogisticRegression()
modelo.fit(X, y)

print("\nCoeficientes aprendidos:")
print(modelo.coef_)

print("\nIntercepto:")
print(modelo.intercept_)