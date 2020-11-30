class System {
  Rule[] m_ruleSet;
  int m_generation;
  String m_sentence;

  System(String axiom, Rule[] ruleSet) {
    m_ruleSet = ruleSet;
    m_sentence = axiom;
    m_generation = 0;
  }

  void generate() {
    StringBuffer nextGeneration = new StringBuffer();
    for (int i = 0; i < m_sentence.length(); i++) {

      char current = m_sentence.charAt(i);
      String replace = ""+current;

      for (Rule rule : m_ruleSet) {

        char precedent = rule.m_precedent;
        if (current != precedent) {          
          continue;
        }

        replace = rule.m_consequent;
        break;
      }
      
      nextGeneration.append(replace);
    }
    
    m_sentence = nextGeneration.toString();
    m_generation++;
  }
}
