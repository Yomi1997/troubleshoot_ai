import React from "react";
import ReactDOM from "react-dom/client";
import App from "./App";
import PaymentSuccess from "./pages/PaymentSuccess";
import { BrowserRouter, Routes, Route } from "react-router-dom";

ReactDOM.createRoot(document.getElementById("root")).render(
  <BrowserRouter>
    <Routes>
      <Route path="/" element={<App />} />
      <Route path="/payment-success" element={<PaymentSuccess />} />
    </Routes>
  </BrowserRouter>,
);
