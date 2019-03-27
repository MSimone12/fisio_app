Map<String, dynamic> disorders = {
  'Acidose respiratória': {
    'ph': (ph) => double.parse(ph) < 7.35,
    'paco2': (paco2) => int.parse(paco2) > 100,
    'hco3': (hco3) => int.parse(hco3) > 26,
    'be': (be) => int.parse(be) > -2 && int.parse(be) < 2,
    'isAcute': (be, hco3) => (int.parse(be) > -2 && int.parse(be) < 2) && (int.parse(hco3) >= 22 && int.parse(hco3) <= 26)
  },
  'Acidose metabólica': {
    'ph': (ph) => double.parse(ph) < 7.35,
    'paco2': (paco2) => int.parse(paco2) > 80 && int.parse(paco2) < 100,
    'hco3': (hco3) => int.parse(hco3) < 22,
    'be': (be) => int.parse(be) < -2,
  },
  'Alcalose respiratoria': {
    'ph': (ph) => double.parse(ph) > 7.45,
    'paco2': (paco2) => int.parse(paco2) < 80,
    'hco3': (hco3) => int.parse(hco3) > 26,
    'be': (be) => int.parse(be) > -2 && int.parse(be) < 2 
  }
};