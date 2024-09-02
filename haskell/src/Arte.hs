module Arte where 

{- Exibe a Arte Inicial do Jogo e o Mapa dos territórios disponíveis-}

exibirInicio :: IO() 
exibirInicio = do

    {-Inicio Jogo-}

    putStrLn "                                                                                                                  "
    putStrLn "     ╔═══════════════════════════════════════════════════════════════════════════════════════════════════════════╗"
    putStrLn "     ║                                                                                                           ║"
    putStrLn "     ║       ████████╗███████╗██████╗ ███╗   ███╗██╗███╗   ██╗ █████╗ ██╗         ██╗    ██╗ █████╗ ██████╗      ║"
    putStrLn "     ║       ╚══██╔══╝██╔════╝██╔══██╗████╗ ████║██║████╗  ██║██╔══██╗██║         ██║    ██║██╔══██╗██╔══██╗     ║"
    putStrLn "     ║          ██║   █████╗  ██████╔╝██╔████╔██║██║██╔██╗ ██║███████║██║         ██║ █╗ ██║███████║██████╔╝     ║"    
    putStrLn "     ║          ██║   ██╔══╝  ██╔══██╗██║╚██╔╝██║██║██║╚██╗██║██╔══██║██║         ██║███╗██║██╔══██║██╔══██╗     ║"
    putStrLn "     ║          ██║   ███████╗██║  ██║██║ ╚═╝ ██║██║██║ ╚████║██║  ██║███████╗    ╚███╔███╔╝██║  ██║██║  ██║     ║"
    putStrLn "     ║          ╚═╝   ╚══════╝╚═╝  ╚═╝╚═╝     ╚═╝╚═╝╚═╝  ╚═══╝╚═╝  ╚═╝╚══════╝     ╚══╝╚══╝ ╚═╝  ╚═╝╚═╝  ╚═╝     ║"
    putStrLn "     ║                                                                                                           ║"
    putStrLn "     ║                                                                                                           ║"
    putStrLn "     ║                                                                                                           ║"
    putStrLn "     ╚═══════════════════════════════════════════════════════════════════════════════════════════════════════════╝"

    {-Mapa do Jogo-}

    putStrLn "                                                                                                                       "
    putStrLn "╔═════════════════════════════════════════════════════════════════════════════════════════════════════════════════════╗"       
    putStrLn "║                                                                                                                     ║"    
    putStrLn "║                                       ........    ..                                                                ║"
    putStrLn "║                               ..  ....  ......--                  ..      ....                                      ║"
    putStrLn "║                         ----      ................        --                  ....                  ....            ║"
    putStrLn "║         ....--      ....      ....    ..........                            ......--....  ................--        ║"
    putStrLn "║       --........--..  ....  ------      ........--                        ..............................--          ║"
    putStrLn "║       --............----..    ....      ........                          ................................          ║"
    putStrLn "║     ......................  ..    --  --......              --        --..  ........................  ..--          ║"
    putStrLn "║           ........CAN...........  ..    --....              ......--  ..............................    ..          ║"
    putStrLn "║             ............--    --      ....      --      .............................RUS........      ..            ║"
    putStrLn "║             ..............    ..                        ..  ....................................                    ║"
    putStrLn "║               ...............  ....                  --    FR  .....UK............................                  ║"
    putStrLn "║               .......EUA.....--......              ..--  --.......................................                  ║"
    putStrLn "║               ................--  --                  ES........................................--  --              ║"
    putStrLn "║             ..................                        ....--..IT  ..............................    ..              ║"
    putStrLn "║             --.......MX..........                      ..--    ----................................  ..  JP         ║"
    putStrLn "║               ..............                        --....      --...SA......IR...............                      ║"
    putStrLn "║                 ......                            ....................--......................--                    ║"
    putStrLn "║                   ..                            ...DZ...........EG........  --..........CN....                      ║"
    putStrLn "║                   ......                        ..................  ......      IN    --..                          ║"
    putStrLn "║                         ..                      ......................          ..      --..                        ║"
    putStrLn "║                           --......                ....................--                                            ║"
    putStrLn "║                           ..........                      ............                  ..  ..                      ║"
    putStrLn "║                           .CO...........                  .AGO.......                        --    ..  ..           ║"
    putStrLn "║                           ..........BR.....                ..........                                  ....  PNG    ║"
    putStrLn "║                            ............                  ..........  ..                          ..                 ║"
    putStrLn "║                              ..........                  ........  .MG                          ........            ║"
    putStrLn "║                              ..ARG....                    ..RSA.                            --....AU......          ║"
    putStrLn "║                              ......                        ....                            ..............           ║"
    putStrLn "║                              CL..                                                          ..      ......           ║"
    putStrLn "║                              ....                                                                  ....             ║"
    putStrLn "║                              ..                                                                                ..   ║"
    putStrLn "║                              ..                                                                              NZ     ║"
    putStrLn "║                              ..                                                                            ..       ║"
    putStrLn "║                                                                                                                     ║"
    putStrLn "╚═════════════════════════════════════════════════════════════════════════════════════════════════════════════════════╝"  
    putStrLn "                                                                                                                       "

{- Lista de países do jogo -}
exibeListaPaises :: IO()
exibeListaPaises = do 

    putStrLn "EUA - Vizinhos: Canadá, México, Japão"
    putStrLn "Canadá - Vizinhos: EUA, México, França"
    putStrLn "Brasil - Vizinhos: Argentina, Colômbia, Angola"
    putStrLn "Colômbia - Vizinhos: Chile, Brasil, Argentina, México"
    putStrLn "Argentina - Vizinhos: Chile, Brasil, Colômbia"
    putStrLn "Chile - Vizinhos: Argentina, Colômbia"
    putStrLn "México - Vizinhos: EUA, Colômbia"
    putStrLn "Espanha - Vizinhos: França, Itália"
    putStrLn "Itália - Vizinhos: França, Espanha, Ucrânia"
    putStrLn "Ucrânia - Vizinhos: França, Itália, Rússia"
    putStrLn "França - Vizinhos: Espanha, França, Ucrânia, Canadá"
    putStrLn "Egito - Vizinhos: Arábia Saudita, Angola, Argélia"
    putStrLn "África do Sul - Vizinhos: Angola, Madagascar"
    putStrLn "Angola - Vizinhos: África do Sul, Egito, Argélia, Brasil"
    putStrLn "Argélia- Vizinhos: Itália, Espanha, Egito, Angola"
    putStrLn "Madagascar - Vizinhos: África do Sul, Austrália"
    putStrLn "Arábia Saudiia - Vizinhos: Egito, Irã, Índia"
    putStrLn "Irã - Vizinhos: Arábia Saudita, Índia"
    putStrLn "China - Vizinhos: Índia, Japão, Rússia, Austrália"
    putStrLn "Japão - Vizinhos: China, Rússia, Papua Nova-Guiné, EUA"
    putStrLn "Rússia - Vizinhos: Ucrânia, Irã, China, Índia, Japão"
    putStrLn "Índia - Vizinhos: Arábia Saudita, China, Irã, Rússia"
    putStrLn "Nova Zelândia - Vizinhos: Austrália"
    putStrLn "Austrália- Vizinhos: Nova Zelândia, Papua Nova-Guiné, China, Madagascar"
    putStrLn "Papua Nova-Guiné - Vizinhos: Austrália, Japão"


{- Exibe as opçoes de cada rodada -}

exibirOpcoesRodada :: IO()
exibirOpcoesRodada = do


    {-Rodada-}

    putStrLn "                                                                                                             "
    putStrLn "╔═══════════════════════════════════════════════════════════════════════════════════════════════════════════╗"
    putStrLn "║                                                                                                           ║"
    putStrLn "║     1. Ataque                                                                                             ║"                                                                               
    putStrLn "║                                                                                                           ║"
    putStrLn "║     2. Mover Tropas                                                                                       ║"
    putStrLn "║                                                                                                           ║"
    putStrLn "║     3. Próxima Rodada                                                                                     ║" 
    putStrLn "║                                                                                                           ║"                             
    putStrLn "║     Digite a opção:                                                                                       ║"                                       
    putStrLn "║                                                                                                           ║" 
    putStrLn "╚═══════════════════════════════════════════════════════════════════════════════════════════════════════════╝"
    putStrLn "                                                                                                             "  

{- Será exibido apenas uma vez, quando for selecionada a opcao de ataque-}

exibirTelaAtaque :: IO()
exibirTelaAtaque = do
    {-Ataque-}

    putStrLn "                                                                                                             "
    putStrLn "╔═══════════════════════════════════════════════════════════════════════════════════════════════════════════╗"
    putStrLn "║                                                                                                           ║"
    putStrLn "║                                                                                                           ║"
    putStrLn "║                            █████  ████████  █████   ██████  ██    ██ ███████                              ║"      
    putStrLn "║                           ██   ██    ██    ██   ██ ██    ██ ██    ██ ██                                   ║"      
    putStrLn "║                           ███████    ██    ███████ ██    ██ ██    ██ █████                                ║"   
    putStrLn "║                           ██   ██    ██    ██   ██ ██ ▄▄ ██ ██    ██ ██                                   ║"  
    putStrLn "║                           ██   ██    ██    ██   ██  ██████   ██████  ███████                              ║"   
    putStrLn "║                                                                 ▀▀                                        ║"                                                                                                                                             
    putStrLn "║                                                                                                           ║"                                                                                                                                                                                                                                                                                                                                                                                     
    putStrLn "╚═══════════════════════════════════════════════════════════════════════════════════════════════════════════╝"
    putStrLn "                                                                                                             "                                       
  

exibirTelaLoopAtaque :: IO()
exibirTelaLoopAtaque = do

    {-putStrLn "Insira o território de onde partirá o ataque:"
    territorioAtaqueInput <- getLine

    putStrLn "Insira o território que você deseja atacar:"
    territorioDefesaInput <- getLine

    putStrLn "Insira quantas tropas irão atacar o território inimigo:"
    t_at <- readLn-}

    {-Loop ataque-}

    putStrLn "╔═══════════════════════════════════════════════════════════════════════════════════════════════════════════╗"
    putStrLn "║                                                                                                           ║"
    putStrLn "║     Continuar a atacar?                                                                                   ║"                                                                               
    putStrLn "║                                                                                                           ║"
    putStrLn "║     1. Continuar                                                                                          ║"
    putStrLn "║                                                                                                           ║"
    putStrLn "║     2. Não continuar                                                                                      ║" 
    putStrLn "║                                                                                                           ║" 
    putStrLn "║     Digite a opção:                                                                                       ║"                             
    putStrLn "║                                                                                                           ║"                                       
    putStrLn "╚═══════════════════════════════════════════════════════════════════════════════════════════════════════════╝"        


{- Será exibido apenas uma vez, quando for selecionada a opcao de mover tropas -}

exibirTelaMoverTropas :: IO()
exibirTelaMoverTropas = do

    {-Mover Tropas -}
    putStrLn "                                                                                                             "
    putStrLn "╔═══════════════════════════════════════════════════════════════════════════════════════════════════════════╗"
    putStrLn "║                                                                                                           ║"
    putStrLn "║                                                                                                           ║"
    putStrLn "║    ███    ███  ██████  ██    ██ ███████ ██████      ████████ ██████   ██████  ██████   █████  ███████     ║"
    putStrLn "║    ████  ████ ██    ██ ██    ██ ██      ██   ██        ██    ██   ██ ██    ██ ██   ██ ██   ██ ██          ║"
    putStrLn "║    ██ ████ ██ ██    ██ ██    ██ █████   ██████         ██    ██████  ██    ██ ██████  ███████ ███████     ║"
    putStrLn "║    ██  ██  ██ ██    ██  ██  ██  ██      ██   ██        ██    ██   ██ ██    ██ ██      ██   ██      ██     ║"
    putStrLn "║    ██      ██  ██████    ████   ███████ ██   ██        ██    ██   ██  ██████  ██      ██   ██ ███████     ║"
    putStrLn "║                                                                                                           ║"                                                                                                                   
    putStrLn "║                                                                                                           ║"                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              
    putStrLn "╚═══════════════════════════════════════════════════════════════════════════════════════════════════════════╝"  
    putStrLn "                                                                                                             "

    
exibirTelaLoopMoverTropas :: IO()
exibirTelaLoopMoverTropas = do

    {-Loop Mover Tropas-}
    putStrLn "╔═══════════════════════════════════════════════════════════════════════════════════════════════════════════╗"
    putStrLn "║                                                                                                           ║"
    putStrLn "║     Continuar a mover tropas?                                                                             ║"                                                                               
    putStrLn "║                                                                                                           ║"
    putStrLn "║     1. Continuar                                                                                          ║"
    putStrLn "║                                                                                                           ║"
    putStrLn "║     2. Não continuar                                                                                      ║"
    putStrLn "║                                                                                                           ║"
    putStrLn "║     Digite a opção:                                                                                       ║"                             
    putStrLn "║                                                                                                           ║"                                       
    putStrLn "╚═══════════════════════════════════════════════════════════════════════════════════════════════════════════╝"             

    
    
exibirTelaGameOver :: IO()
exibirTelaGameOver = do


 
    putStrLn "   ╔═══════════════════════════════════════════════════════════════════════════════════════════════════════════╗"
    putStrLn "   ║                                                                                                           ║"   
    putStrLn "   ║                                                                                                           ║"
    putStrLn "   ║                 ██████╗  █████╗ ███╗   ███╗███████╗     ██████╗ ██╗   ██╗███████╗██████╗                  ║"
    putStrLn "   ║                ██╔════╝ ██╔══██╗████╗ ████║██╔════╝    ██╔═══██╗██║   ██║██╔════╝██╔══██╗                 ║"
    putStrLn "   ║                ██║  ███╗███████║██╔████╔██║█████╗      ██║   ██║██║   ██║█████╗  ██████╔╝                 ║"
    putStrLn "   ║                ██║   ██║██╔══██║██║╚██╔╝██║██╔══╝      ██║   ██║╚██╗ ██╔╝██╔══╝  ██╔══██╗                 ║"
    putStrLn "   ║                ╚██████╔╝██║  ██║██║ ╚═╝ ██║███████╗    ╚██████╔╝ ╚████╔╝ ███████╗██║  ██║                 ║"
    putStrLn "   ║                 ╚═════╝ ╚═╝  ╚═╝╚═╝     ╚═╝╚══════╝     ╚═════╝   ╚═══╝  ╚══════╝╚═╝  ╚═╝                 ║"                                                                                           
    putStrLn "   ║                                                                                                           ║"
    putStrLn "   ║                                                                                                           ║"
    putStrLn "   ╚═══════════════════════════════════════════════════════════════════════════════════════════════════════════╝"


 

    