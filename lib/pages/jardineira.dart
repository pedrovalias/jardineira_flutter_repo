class Jardineira {
  JardineiraX jardineiraX;

  Jardineira({this.jardineiraX});

  Jardineira.fromJson(Map<String, dynamic> json) {
    jardineiraX = json['Jardineira_x'] != null
        ? new JardineiraX.fromJson(json['Jardineira_x'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.jardineiraX != null) {
      data['Jardineira_x'] = this.jardineiraX.toJson();
    }
    return data;
  }
}

class JardineiraX {
  Acionamentos acionamentos;
  Conexao conexao;
  DadosAmbiente dadosAmbiente;
  Identificador identificador;
  Info info;
  Sensores sensores;

  JardineiraX(
      {this.acionamentos,
      this.conexao,
      this.dadosAmbiente,
      this.identificador,
      this.info,
      this.sensores});

  JardineiraX.fromJson(Map<String, dynamic> json) {
    acionamentos = json['Acionamentos'] != null
        ? new Acionamentos.fromJson(json['Acionamentos'])
        : null;
    conexao =
        json['Conexao'] != null ? new Conexao.fromJson(json['Conexao']) : null;
    dadosAmbiente = json['Dados Ambiente'] != null
        ? new DadosAmbiente.fromJson(json['Dados Ambiente'])
        : null;
    identificador = json['Identificador'] != null
        ? new Identificador.fromJson(json['Identificador'])
        : null;
    info = json['Info'] != null ? new Info.fromJson(json['Info']) : null;
    sensores = json['Sensores'] != null
        ? new Sensores.fromJson(json['Sensores'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.acionamentos != null) {
      data['Acionamentos'] = this.acionamentos.toJson();
    }
    if (this.conexao != null) {
      data['Conexao'] = this.conexao.toJson();
    }
    if (this.dadosAmbiente != null) {
      data['Dados Ambiente'] = this.dadosAmbiente.toJson();
    }
    if (this.identificador != null) {
      data['Identificador'] = this.identificador.toJson();
    }
    if (this.info != null) {
      data['Info'] = this.info.toJson();
    }
    if (this.sensores != null) {
      data['Sensores'] = this.sensores.toJson();
    }
    return data;
  }
}

class Acionamentos {
  int limiarSeco;
  bool rega;
  int tempoLoop;
  int tempoRega;

  Acionamentos({this.limiarSeco, this.rega, this.tempoLoop, this.tempoRega});

  Acionamentos.fromJson(Map<String, dynamic> json) {
    limiarSeco = json['limiar_seco'];
    rega = json['rega'];
    tempoLoop = json['tempo_loop'];
    tempoRega = json['tempo_rega'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['limiar_seco'] = this.limiarSeco;
    data['rega'] = this.rega;
    data['tempo_loop'] = this.tempoLoop;
    data['tempo_rega'] = this.tempoRega;
    return data;
  }
}

class Conexao {
  bool conexaoStatus;
  String ip;

  Conexao({this.conexaoStatus, this.ip});

  Conexao.fromJson(Map<String, dynamic> json) {
    conexaoStatus = json['conexao_status'];
    ip = json['ip'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['conexao_status'] = this.conexaoStatus;
    data['ip'] = this.ip;
    return data;
  }
}

class DadosAmbiente {
  int temperatura;
  int umidadeRelativa;

  DadosAmbiente({this.temperatura, this.umidadeRelativa});

  DadosAmbiente.fromJson(Map<String, dynamic> json) {
    temperatura = json['temperatura'];
    umidadeRelativa = json['umidade_relativa'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['temperatura'] = this.temperatura;
    data['umidade_relativa'] = this.umidadeRelativa;
    return data;
  }
}

class Identificador {
  int id;

  Identificador({this.id});

  Identificador.fromJson(Map<String, dynamic> json) {
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    return data;
  }
}

class Info {
  int execucoesPrograma;

  Info({this.execucoesPrograma});

  Info.fromJson(Map<String, dynamic> json) {
    execucoesPrograma = json['execucoes_programa'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['execucoes_programa'] = this.execucoesPrograma;
    return data;
  }
}

class Sensores {
  bool nivelMaximo;
  int umidadeSolo;
  bool valvulaStatus;

  Sensores({this.nivelMaximo, this.umidadeSolo, this.valvulaStatus});

  Sensores.fromJson(Map<String, dynamic> json) {
    nivelMaximo = json['nivel_maximo'];
    umidadeSolo = json['umidade_solo'];
    valvulaStatus = json['valvula_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nivel_maximo'] = this.nivelMaximo;
    data['umidade_solo'] = this.umidadeSolo;
    data['valvula_status'] = this.valvulaStatus;
    return data;
  }
}
