// frontend/src/TechDashboard.jsx
import { useEffect, useState } from "react";
import { api } from "./api";

export default function TechDashboard({ onBack }) {
  const [tickets, setTickets] = useState([]);
  const [status, setStatus] = useState("");

  async function load() {
    const t = await api.techTickets();
    setTickets(Array.isArray(t) ? t : []);
  }

  useEffect(() => {
    load().catch((e) => setStatus(e.message));
  }, []);

  async function accept(id) {
    setStatus("Accepting...");
    try {
      await api.acceptTicket(id);
      setStatus("Accepted ✅");
      await load();
    } catch (e) {
      setStatus(e.message);
    }
  }

  async function setTicketStatus(id, s) {
    setStatus("Updating status...");
    try {
      await api.updateTechTicketStatus(id, s);
      setStatus("Updated ✅");
      await load();
    } catch (e) {
      setStatus(e.message);
    }
  }

  return (
    <div className="page">
      <div className="container">
        <div className="topBar">
          <button className="btnGhost" onClick={onBack}>
            ← Back
          </button>
          <div className="brandCenter">Technician Dashboard</div>
          <div className="tiny">{status}</div>
        </div>

        <div className="actionPanel">
          <div className="panelTitle">My Assigned Tickets</div>

          <div
            style={{
              maxHeight: 520,
              overflowY: "auto",
              display: "grid",
              gap: 10,
            }}
          >
            {tickets.map((t) => (
              <div key={t.id} className="actionPanel">
                <div className="panelTitle">
                  Ticket #{t.id} — <span className="badge">{t.status}</span>
                </div>

                <div className="panelText">
                  <div>
                    <b>Module:</b> {t.module_id}
                  </div>
                  <div>
                    <b>City:</b> {t.user_city}
                  </div>
                  <div>
                    <b>Preferred:</b> {t.preferred_contact}
                  </div>
                  <div style={{ marginTop: 6 }}>{t.issue_summary}</div>
                </div>

                <div
                  className="modalActions"
                  style={{ justifyContent: "flex-start", gap: 8 }}
                >
                  {t.status === "assigned" ? (
                    <button
                      className="btnSecondary"
                      onClick={() => accept(t.id)}
                    >
                      Accept
                    </button>
                  ) : null}

                  <button
                    className="btnGhost"
                    onClick={() => setTicketStatus(t.id, "in_progress")}
                  >
                    In Progress
                  </button>
                  <button
                    className="btnGhost"
                    onClick={() => setTicketStatus(t.id, "resolved")}
                  >
                    Resolved
                  </button>
                  <button
                    className="btnGhost"
                    onClick={() => setTicketStatus(t.id, "closed")}
                  >
                    Closed
                  </button>
                </div>
              </div>
            ))}
          </div>

          {tickets.length === 0 ? (
            <div className="tiny">No assigned tickets yet.</div>
          ) : null}
        </div>
      </div>
    </div>
  );
}
