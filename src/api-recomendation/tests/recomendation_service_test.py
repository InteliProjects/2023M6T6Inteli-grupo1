from src.recomendation_service import school_best_supplier, schools_best_supplier

def test():
    assert schools_best_supplier([12]) == '10.663.308/0001-70'
    assert school_best_supplier(12) == '10.663.308/0001-70'
    