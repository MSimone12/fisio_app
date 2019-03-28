Map<String, dynamic> disorders = {
  'Acidose respiratória': {
    'ph': Calculator.highPH,
    'paco2': Calculator.highPaCO2,
    'hco3': Calculator.highHCO3,
    'be': Calculator.normalBE,
    'isAcute': (ph, paco2, be, hco3) => Calculator.lowPH(ph) && Calculator.highPaCO2(paco2) && Calculator.normalHCO3(hco3) && Calculator.normalBE(be)
  },
  'Acidose metabólica': {
    'ph': Calculator.highPH,
    'paco2': Calculator.normalPaCO2,
    'hco3': Calculator.lowHCO3,
    'be': Calculator.lowBE,
    'isAcute': (ph, paco2, hco3, be) => Calculator.lowPH(ph) && Calculator.normalPaCO2(paco2) && Calculator.lowHCO3(hco3) && Calculator.lowBE(be)
  },
  'Alcalose respiratoria': {
    'ph': Calculator.highPH,
    'paco2': Calculator.lowPaCO2,
    'hco3': Calculator.highHCO3,
    'be': Calculator.normalBE,
    'isAcute': (ph, paco2, hco3, be) => Calculator.highPH(ph) && Calculator.lowPaCO2(paco2) && Calculator.normalHCO3(hco3) && Calculator.normalBE(be), 
  },
  'Alcalose metabólica': {
    'ph': Calculator.highPH,
    'paco2': Calculator.normalPaCO2,
    'hco3': Calculator.highHCO3,
    'be': Calculator.highBE,
    'isAcute': (ph, paco2, hco3, be) => Calculator.highPH(ph) && Calculator.normalPaCO2(paco2) && Calculator.highHCO3(hco3) && Calculator.highBE(be)
  }
};

Map disorderDescription = {
  'Alcalose metabólica': 'Alcalose metabólica é uma condição metabólica na qual o pH do sangue está elevado acima da faixa normal. Geralmente é resultado de uma concentração diminuída de ion hidrogênio, levando a concentrações aumentadas de bicarbonato',
  'Acidose metabólica': 'A acidose metabólica é o excesso de acidez no sangue caracterizada por uma concentração anormalmente baixa de carbonatos.',
  'Alcalose respiratória': '',
  'Acidose respiratória': ''
};

class Calculator {
  static bool highPH(ph) => double.parse(ph) > 7.45;
  static bool lowPH(ph) => double.parse(ph) < 7.35;
  static bool normalPH(ph) => double.parse(ph) >= 7.35 && double.parse(ph) <= 7.45;

  static bool highPaCO2(paco2) => int.parse(paco2) > 100;
  static bool lowPaCO2(paco2) => int.parse(paco2) < 80;
  static bool normalPaCO2(paco2) => int.parse(paco2) >= 80 && int.parse(paco2) <= 100;

  static bool highHCO3(hco3) => int.parse(hco3) > 26;
  static bool lowHCO3(hco3) => int.parse(hco3) < 22;
  static bool normalHCO3(hco3) => int.parse(hco3) >= 22 && int.parse(hco3) <= 26;

  static bool highBE(be) => int.parse(be) > 2;
  static bool lowBE(be) => int.parse(be) < -2;
  static bool normalBE(be) => int.parse(be) >= -2 && int.parse(be) <= 2;
}