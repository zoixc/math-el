import sympy as sp

def process_expression(expr: str):
    try:
        parsed_expr = sp.sympify(expr)
        simplified = sp.simplify(parsed_expr)
        return str(simplified)
    except Exception as e:
        return f"Ошибка: {str(e)}"
