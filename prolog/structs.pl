% adicionar os dados nesses dicionários depois

% variáveis que necessitam que podem usar apenas um array

set_global_variables :-

nb_setval(jogador1, ['EUA', 'CAN', 'MX']),
nb_setval(jogador2, ['CN', 'RUS', 'IN']),

nb_setval(america, ['EUA','CAN','BR','CO','ARG','CL','MX']),
nb_setval(europa, ['FR', 'ES', 'UA', 'IT']),
nb_setval(asia, ['SA', 'IR', 'CN', 'JP', 'RUS', 'IN']),
nb_setval(oceania, ['NZ','AU','PNG']),
nb_setval(africa, ['DZ', 'AGO', 'EG', 'RSA', 'MG']),

% dicionário que usa o nome do território como chave e guarda a quantidade de tropas como valor

nb_setval(territorios, {'EUA':2, 'CAN':2, 'BR':3, 'CO':2, 'ARG':2, 'CL':3, 'MX':2, 'ES':3, 
    'IT':3, 'UA':2, 'FR':2, 'EG':2, 'RSA':2, 'AGO':1, 'DZ':3, 'MG':2, 'SA':2, 'IR':2, 
    'CN':2, 'JP':2, 'RUS':2, 'IN':2, 'NZ':3, 'AU':3, 'PNG':2}),

% dicionário que usa o nome do território e tem como valor a lista dos vizinhos

nb_setval(vizinhos, _{'EUA':['CAN', 'MX', 'JP'], 'CAN':['EUA', 'MX', 'FR'], 
    'BR':['ARG', 'CO', 'AGO'], 'CO':['CL', 'BR', 'ARG', 'MX'],
    'ARG':['CL', 'BR', 'CO'], 'CL':['ARG', 'CO'], 'MX':['EUA', 'CO'], 
    'ES':['FR','IT'], 'IT':['FR','ES','UA'], 'UA':['FR','IT','RUS'],
    'FR':['ES','UA','CAN'], 'EG':['SA','AGO','DZ'], 'RSA':['AGO','MG'], 
    'AGO':['RSA','EG','DZ','BR'], 'DZ':['IT','ES','EG','AGO'],
    'MG':['RSA','AU'], 'SA':['EG', 'IR', 'IN'], 
    'IR':['SA', 'IN'], 'CN':['IN', 'JP', 'RUS', 'AU'], 'JP':['CN', 'RUS', 'PNG', 'EUA'],
    'RUS':['UA', 'IR', 'CN', 'IN', 'JP'], 'IN':['SA', 'CN', 'IR', 'RUS'], 
    'NZ':['AU'], 'AU':['NZ', 'PNG','CN','MG'], 'PNG':['AU', 'JP']}).

set_global_variable(Var,Value):-
    nb_setval(Var,Value).

get_global_variable(Var,Value):-
    nb_getval(Var,Value2),
    Value = Value2.
