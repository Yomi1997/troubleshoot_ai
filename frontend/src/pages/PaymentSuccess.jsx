// frontend/src/pages/PaymentSuccess.jsx
import { useEffect, useState } from "react";

export default function PaymentSuccess() {
  const [msg, setMsg] = useState("Verifying payment...");
  const [detail, setDetail] = useState("");

  useEffect(() => {
    const params = new URLSearchParams(window.location.search);
    const reference = params.get("reference") || params.get("trxref");

    if (!reference) {
      setMsg("No payment reference found.");
      setDetail("Please return and try again.");
      return;
    }

    const verify = async () => {
      try {
        setMsg("Verifying payment...");
        setDetail("");

        const res = await fetch(
          `http://127.0.0.1:8000/billing/paystack/verify?reference=${encodeURIComponent(reference)}`,
          { method: "GET" },
        );

        const data = await res.json().catch(() => ({}));

        if (!res.ok) {
          setMsg("Payment verification failed.");
          setDetail(data?.detail || "Please try again.");
          return;
        }

        if (data?.status === "success") {
          setMsg("Payment verified ✅ Premium activated!");
          setDetail("Refreshing your account...");

          // 🔥 Refresh user state in backend/session
          const token = localStorage.getItem("token");
          try {
            await fetch("http://127.0.0.1:8000/auth/me", {
              headers: token ? { Authorization: `Bearer ${token}` } : {},
            });
          } catch (_) {
            // ignore; we'll still redirect
          }

          setDetail("Redirecting you back to the app...");

          setTimeout(() => {
            // Force a full reload so App re-checks premium status
            window.location.replace("/");
          }, 1200);

          return;
        }

        setMsg("Payment not successful.");
        setDetail(
          data?.detail ||
            "If you were charged, contact support with your reference.",
        );
      } catch (err) {
        console.error(err);
        setMsg("Verification error.");
        setDetail("Check your internet / backend server and try again.");
      }
    };

    verify();
  }, []);

  return (
    <div style={{ padding: "40px", maxWidth: 700, margin: "0 auto" }}>
      <h2>{msg}</h2>
      {detail ? <p style={{ marginTop: 10 }}>{detail}</p> : null}

      <div style={{ marginTop: 18, opacity: 0.8 }}>
        <small>
          If this page stays for long, make sure your backend is running on{" "}
          <b>http://127.0.0.1:8000</b>.
        </small>
      </div>
    </div>
  );
}
