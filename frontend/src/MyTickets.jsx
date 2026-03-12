// frontend/src/MyTickets.jsx
import { useEffect, useState } from "react";

export default function MyTickets() {
  const [tickets, setTickets] = useState([]);
  const [error, setError] = useState("");

  useEffect(() => {
    const token = localStorage.getItem("access_token");

    if (!token) {
      setError("No login token found. Please login first.");
      return;
    }

    fetch("http://127.0.0.1:8000/tickets/my", {
      headers: {
        Authorization: `Bearer ${token}`,
      },
    })
      .then((res) => {
        if (!res.ok) throw new Error("Not authenticated");
        return res.json();
      })
      .then((data) => setTickets(data))
      .catch((err) => setError(err.message));
  }, []);

  return (
    <div style={{ padding: 20 }}>
      <h2>My Tickets</h2>

      {error && <p style={{ color: "red" }}>{error}</p>}

      {tickets.length === 0 && !error && <p>No tickets yet.</p>}

      {tickets.map((t) => (
        <div
          key={t.id}
          style={{
            border: "1px solid #ccc",
            padding: 10,
            marginBottom: 10,
          }}
        >
          <strong>{t.issue_summary}</strong>
          <br />
          Module: {t.module_id}
          <br />
          Status: {t.status}
          <br />
          Created: {new Date(t.created_at).toLocaleString()}
        </div>
      ))}
    </div>
  );
}
