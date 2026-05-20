% ==============================
% Base de fatos: rede social
% ==============================

transacao_entre(joao, ana, 1500).
transacao_entre(ana, carlos, 800).
transacao_entre(carlos, daniel, 50).

inadimplente(daniel).

% ==============================
% Conexão direta
% ==============================

conectado(X, Y) :-
    transacao_entre(X, Y, _).

conectado(X, Y) :-
    transacao_entre(Y, X, _).

% ==============================
% Risco por conexão
% ==============================

risco_conexao(X, Y, Grau) :-
    risco_conexao(X, Y, Grau, [X]).

risco_conexao(X, Y, 1, _) :-
    conectado(X, Y).

risco_conexao(X, Y, Grau, Visitados) :-
    conectado(X, Z),
    \+ member(Z, Visitados),
    risco_conexao(Z, Y, GrauAnterior, [Z|Visitados]),
    Grau is GrauAnterior + 1.

% ==============================
% Risco em relação a inadimplente
% ==============================

risco_por_inadimplente(Cliente, Inadimplente, Grau) :-
    inadimplente(Inadimplente),
    risco_conexao(Cliente, Inadimplente, Grau).
