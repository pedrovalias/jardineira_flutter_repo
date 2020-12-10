class Constantes {
  static const String SUCESSO_MSG = "Sucesso";
  static const String ERRO_LEITURA_SENSOR =
      "Problemas ao tentar obter dados do sensor. Favor verificar se o sensor de temperatura/umidade possui alguma falha na conexão.";
  static const String RESERVATORIO_OK =
      "O reservatório está cheio. Nenhuma ação necessária.";
  static const String RESERVATORIO_NOK = "O reservatório está incompleto.";
  static const String WIFI_OK =
      "A jardineira está online e conectada ao endereço de ip: ";
  static const String WIFI_NOK = "Jardineira está desconectada.";

  static const String VALVULA_ON =
      "A válvula de água está LIGADA, enchendo o reservatório nesse momento.";
  static const String VALVULA_OFF = "A válvula de água está DESLIGADA.";

  static const String PATH_RAIZ = "Jardineira_X";

  static const String PATH_ACIONAMENTOS = "Jardineira_x/Acionamentos";
  static const String PATH_DADOS_AMBIENTE = "Jardineira_x/Dados Ambiente";
  static const String PATH_CONEXAO = "Jardineira_x/Conexao";
  static const String PATH_SENSORES = "Jardineira_x/Sensores";
  static const String PATH_CONFIGURACAO = "Jardineira_x/Configuracao";
  static const String PATH_IDENTIFICADOR = "Jardineira_x/Identificador";
  static const String PATH_INFO = "Jardineira_x/Info";

  static const String NIVEL_MAXIMO = "nivel_maximo";
  static const String UMIDADE_SOLO = "umidade_solo";
  static const String VALVULA_STATUS = "valvula_status";
  static const String TEMPERATURA = "temperatura";
  static const String UMIDADE_RELATIVA = "umidade_relativa";
  static const String AUTO_AJUSTE_LOOP = "auto_ajuste_loop";

  static const String LIMIAR_SECO = "limiar_seco";
  static const String REGA = "rega";
  static const String CONEXAO_IP = "ip";
  static const String CONEXAO_STATUS = "conexao_status";
  static const String TEMPO_LOOP = "tempo_loop";
  static const String TEMPO_REGA = "tempo_rega";
  static const String IDENTIFICADOR_ID = "id";
  static const String QTD_EXECUCOES_PROGRAMA = "execucoes_programa";

  static const String INFO_UMIDADE_SOLO_SLIDER =
      "Porcentagem ideal de umidade do solo. A Jardineira só irá seguir com o processo de rega caso identificado umidade abaixo do valor estipulado.";
  static const String INFO_TEMPO_REGA_SLIDER =
      "Tempo total da ação de preenchimento do reservatório. Este parâmetro pode ser selecionado de 0 a 60 segundos.";
  static const String INFO_TEMPO_LOOP_SLIDER =
      "Intervalo de tempo entre uma ação de verificação do reservatório e outra. O período pode ser selecionado de 1h a 48h (2 dias).";
  static const String INFO_MODO_AUTOMATICO =
      "Quando ativado, o sistema da jardineira irá funcionar com ajuste automático do tempo de verificação do reservatório baseado na leitura da temperatura do ambiente. Por padrão, quando identificado temperatura acima de 30°C por período superior à 4h, o sistema ajustará para verificações a cada 5 horas. Se a temperatura estiver abaixo de 26°C, será ajustado para verificações a cada 9 horas.";
  static const String INFO_SALVAR_PADRAO_PARAMETROS =
      "Os parâmetros foram atualizados com os seguintes valores padrões:\n- Umidade do Solo: 70%\n - Tempo loop: 9H\n - Tempo rega: 15s";
  static const String INFO_SALVAR_PARAMETROS_PERSONALIZADOS =
      "Os parâmetros foram atualizados com os seguintes valores personalizados: ";
  static const String INFO_DADOS_AMBIENTE =
      "Valores da leitura do sensor de temperatura (°C) e umidade relativa do ar (%) em tempo real.";
}
