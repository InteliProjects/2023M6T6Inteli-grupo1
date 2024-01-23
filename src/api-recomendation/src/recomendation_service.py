
from joblib import load
from collections import Counter

supplier_matrix = load('src/supplier_matrix.pkl')


def school_best_supplier(cie):
    float_cie = float(str(cie))  # Converte a entrada para float
    if float_cie in supplier_matrix:
        best_supplier = supplier_matrix[float_cie]
        return best_supplier

def schools_best_supplier(cie_list):
    results = []
    for cie in cie_list:
      result = school_best_supplier(cie)
      if(result):
          results.append(result)

    count = Counter(results)

    return count.most_common(1)[0][0]
