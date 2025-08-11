import React, { useState } from "react";
import { calculateExpression } from "./api";

export default function App() {
    const [expression, setExpression] = useState("");
    const [result, setResult] = useState("");

    const handleCalculate = async () => {
        const res = await calculateExpression(expression);
        setResult(res);
    };

    return (
        <div style={{ maxWidth: "600px", margin: "auto", padding: "20px" }}>
            <h1>MathCAD Lite</h1>
            <input
                type="text"
                placeholder="Введите выражение, например: sin(pi)"
                value={expression}
                onChange={(e) => setExpression(e.target.value)}
                style={{ width: "100%", padding: "10px", marginBottom: "10px" }}
            />
            <button onClick={handleCalculate} style={{ padding: "10px 20px" }}>
                Вычислить
            </button>
            {result && (
                <div style={{ marginTop: "20px" }}>
                    <strong>Результат:</strong> {result}
                </div>
            )}
        </div>
    );
}
