class Constantes {
  static const String SUCESSO_MSG = "Sucesso";
  static const String ERRO_LEITURA_SENSOR =
      "Problemas ao tentar obter dados do sensor. Favor verificar se o sensor de temperatura/umidade possui alguma falha na conexão.";
  static const String RESERVATORIO_OK =
      "O reservatório está cheio. Nenhuma ação necessária.";
  static const String RESERVATORIO_NOK = "O reservatório está incompleto.";
  static const String WIFI_OK = "Jardineira está conectada.";
  static const String WIFI_NOK = "Jardineira está desconectada.";

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
      "Tempo total da ação de rega. Este parâmetro pode ser selecionado de 0 a 60 segundos.";
}
