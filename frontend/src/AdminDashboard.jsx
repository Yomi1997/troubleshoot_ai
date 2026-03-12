// frontend/src/AdminDashboard.jsx
import { useEffect, useMemo, useState } from "react";
import { api } from "./api";

function Badge({ children }) {
  return <span className="badge">{children}</span>;
}

function normalizeList(payload) {
  if (!payload) return [];
  if (Array.isArray(payload)) return payload;
  if (Array.isArray(payload.tickets)) return payload.tickets;
  if (Array.isArray(payload.technicians)) return payload.technicians;
  if (Array.isArray(payload.items)) return payload.items;
  if (Array.isArray(payload.data)) return payload.data;
  return [];
}

export default function AdminDashboard({ me, onBack, onLogout }) {
  const [tab, setTab] = useState("tickets"); // tickets | technicians
  const [status, setStatus] = useState("Ready");

  const [tickets, setTickets] = useState([]);
  const [techs, setTechs] = useState([]);

  // ✅ Create technician profile form (matches your backend: user_id required)
  const [newTech, setNewTech] = useState({
    user_id: "",
    city: "",
    rating: "5",
    is_available: true,
    skills: "", // comma-separated, we send as array or JSON string
  });

  const [busyCreate, setBusyCreate] = useState(false);

  const isAdmin = me?.role === "admin";

  async function loadTickets() {
    const raw = await api.adminTickets();
    setTickets(normalizeList(raw));
  }

  async function loadTechs() {
    const raw = await api.adminTechnicians();
    setTechs(normalizeList(raw));
  }

  async function refreshAll() {
    try {
      setStatus("Loading...");
      await Promise.all([loadTickets(), loadTechs()]);
      setStatus("Ready");
    } catch (e) {
      setStatus(`Error: ${e.message}`);
    }
  }

  useEffect(() => {
    if (!isAdmin) return;
    refreshAll();
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [isAdmin]);

  const stats = useMemo(() => {
    const total = tickets.length;
    const pending = tickets.filter(
      (t) => (t.status || "").toLowerCase() === "pending",
    ).length;
    const done = tickets.filter(
      (t) => (t.status || "").toLowerCase() === "done",
    ).length;
    const assigned = tickets.filter((t) => !!t.assigned_tech_user_id).length;
    return { total, pending, assigned, done };
  }, [tickets]);

  async function handleAutoAssign(id) {
    try {
      setStatus(`Auto-assigning ticket #${id}...`);
      await api.autoAssignTicket(id);
      await loadTickets();
      setStatus("Assigned ✅");
    } catch (e) {
      setStatus(`Error: ${e.message}`);
    }
  }

  // ✅ Strong validation to prevent: "Error: user_id is required"
  function validateNewTech() {
    const userIdNum = Number(newTech.user_id);
    if (!newTech.user_id || Number.isNaN(userIdNum) || userIdNum <= 0) {
      throw new Error("user_id is required (must be a number like 1, 2, 3...)");
    }
    if (!(newTech.city || "").trim()) {
      throw new Error("city is required");
    }
  }

  function parseSkillsToArray(skillsText) {
    const raw = (skillsText || "").trim();
    if (!raw) return null;
    const arr = raw
      .split(",")
      .map((s) => s.trim())
      .filter(Boolean);
    return arr.length ? arr : null;
  }

  async function handleCreateTechnician(e) {
    e.preventDefault();
    setBusyCreate(true);
    setStatus("Creating technician...");
    try {
      validateNewTech();

      // ✅ Send the payload your backend expects
      const payload = {
        user_id: Number(newTech.user_id),
        city: newTech.city.trim(),
        rating: newTech.rating === "" ? 5.0 : Number(newTech.rating),
        is_available: !!newTech.is_available,

        // IMPORTANT:
        // Some backends expect "skills" as list, some store "skills_json" string.
        // We send BOTH safely:
        skills: parseSkillsToArray(newTech.skills),
        skills_json: (() => {
          const arr = parseSkillsToArray(newTech.skills);
          return arr ? JSON.stringify(arr) : null;
        })(),
      };

      await api.adminCreateTechnician(payload);

      setNewTech({
        user_id: "",
        city: "",
        rating: "5",
        is_available: true,
        skills: "",
      });

      await loadTechs();
      setStatus("Technician profile created ✅");
      setTab("technicians");
    } catch (e2) {
      setStatus(`Error: ${e2.message}`);
    } finally {
      setBusyCreate(false);
    }
  }

  if (!isAdmin) {
    return (
      <div className="page">
        <div className="container">
          <div className="topBar">
            <button className="btnGhost" onClick={onBack}>
              ← Back
            </button>
            <div className="brandCenter">Admin</div>
            <div />
          </div>

          <div className="actionPanel" style={{ marginTop: 12 }}>
            <div className="panelTitle">Admin only</div>
            <div className="panelText">
              You’re logged in, but your account role is not <b>admin</b>.
              <br />
              Update your user role in the database to <code>admin</code>, then
              login again.
            </div>
          </div>
        </div>
      </div>
    );
  }

  return (
    <div className="page">
      <div className="container">
        <div className="topBar">
          <button className="btnGhost" onClick={onBack}>
            ← Back
          </button>

          <div className="brandCenter">Admin Dashboard</div>

          <div style={{ display: "flex", gap: 8, alignItems: "center" }}>
            <Badge>{me?.full_name || "Admin"}</Badge>
            <Badge>{me?.role}</Badge>
            <button className="btnGhost" onClick={onLogout}>
              Logout
            </button>
          </div>
        </div>

        <div className="statusRow">
          <div
            className={`statusDot ${status !== "Ready" ? "thinking" : ""}`}
          />
          <div className="statusText">{status}</div>
        </div>

        {/* Quick stats */}
        <div className="grid" style={{ marginTop: 12 }}>
          <div className="card">
            <div className="cardTop">
              <div className="icon">🎫</div>
              <div>
                <div className="cardTitle">Tickets</div>
                <div className="cardDesc">
                  Total <b>{stats.total}</b>
                </div>
              </div>
            </div>
            <div
              className="cardBottom"
              style={{ display: "flex", gap: 8, flexWrap: "wrap" }}
            >
              <Badge>Pending: {stats.pending}</Badge>
              <Badge>Assigned: {stats.assigned}</Badge>
              <Badge>Done: {stats.done}</Badge>
            </div>
          </div>

          <div className="card">
            <div className="cardTop">
              <div className="icon">🧑‍🔧</div>
              <div>
                <div className="cardTitle">Technicians</div>
                <div className="cardDesc">
                  Total <b>{techs.length}</b>
                </div>
              </div>
            </div>
            <div className="cardBottom">
              <button
                className="btnSecondary"
                onClick={() => setTab("technicians")}
              >
                View technicians
              </button>
            </div>
          </div>

          <div className="card">
            <div className="cardTop">
              <div className="icon">🔄</div>
              <div>
                <div className="cardTitle">Refresh</div>
                <div className="cardDesc">Reload tickets & technicians</div>
              </div>
            </div>
            <div className="cardBottom">
              <button className="btnPrimary" onClick={refreshAll}>
                Refresh data
              </button>
            </div>
          </div>
        </div>

        {/* Tabs */}
        <div style={{ display: "flex", gap: 8, marginTop: 14 }}>
          <button
            className="btnGhost"
            onClick={() => setTab("tickets")}
            disabled={tab === "tickets"}
          >
            Tickets
          </button>
          <button
            className="btnGhost"
            onClick={() => setTab("technicians")}
            disabled={tab === "technicians"}
          >
            Technicians
          </button>
        </div>

        {/* TICKETS */}
        {tab === "tickets" && (
          <div className="actionPanel" style={{ marginTop: 12 }}>
            <div className="panelTitle">
              All Tickets <Badge>{tickets.length}</Badge>
            </div>

            {tickets.length === 0 ? (
              <div className="panelText">No tickets found.</div>
            ) : (
              <div
                style={{
                  display: "grid",
                  gap: 10,
                  maxHeight: "70vh",
                  overflowY: "auto",
                  paddingRight: 6,
                  marginTop: 10,
                }}
              >
                {tickets.map((t) => {
                  const id = t.id || t.ticket_id;
                  const alreadyAssigned = !!t.assigned_tech_user_id;
                  const statusLower = String(t.status || "").toLowerCase();
                  const canAssign =
                    !alreadyAssigned &&
                    statusLower !== "done" &&
                    statusLower !== "rejected";

                  return (
                    <div key={id} className="actionPanel">
                      <div className="panelTitle">
                        Ticket #{id} <Badge>{t.status || "—"}</Badge>
                      </div>

                      <div className="panelText">
                        <div>
                          <b>Module:</b> {t.module_id || "—"}
                        </div>
                        <div>
                          <b>City:</b> {t.user_city || "—"}
                        </div>
                        <div>
                          <b>Preferred contact:</b> {t.preferred_contact || "—"}
                        </div>
                        <div>
                          <b>Assigned tech:</b>{" "}
                          {t.assigned_tech_user_id
                            ? t.assigned_tech_user_id
                            : "Not assigned"}
                        </div>

                        <div style={{ marginTop: 8 }}>
                          <b>Issue:</b>
                          <div style={{ marginTop: 6 }}>
                            {t.issue_summary || t.summary || "—"}
                          </div>
                        </div>

                        {t.created_at ? (
                          <div style={{ marginTop: 8 }}>
                            <b>Created:</b> {String(t.created_at)}
                          </div>
                        ) : null}
                      </div>

                      <div
                        className="modalActions"
                        style={{ justifyContent: "flex-start" }}
                      >
                        <button
                          className="btnSecondary"
                          onClick={() => handleAutoAssign(id)}
                          disabled={!canAssign}
                          title={
                            canAssign
                              ? "Auto assign"
                              : alreadyAssigned
                                ? "Already assigned"
                                : "Cannot assign this status"
                          }
                        >
                          Auto Assign
                        </button>
                      </div>
                    </div>
                  );
                })}
              </div>
            )}
          </div>
        )}

        {/* TECHNICIANS */}
        {tab === "technicians" && (
          <div style={{ marginTop: 12, display: "grid", gap: 12 }}>
            <div className="actionPanel">
              <div className="panelTitle">
                Technicians <Badge>{techs.length}</Badge>
              </div>

              {techs.length === 0 ? (
                <div className="panelText">No technicians found.</div>
              ) : (
                <div style={{ display: "grid", gap: 10, marginTop: 10 }}>
                  {techs.map((t) => (
                    <div
                      key={t.id || t.user_id || t.email || Math.random()}
                      className="actionPanel"
                    >
                      <div className="panelTitle">
                        Technician <Badge>{t.role || "technician"}</Badge>
                      </div>
                      <div className="panelText">
                        <div>
                          <b>User ID:</b> {t.user_id ?? "—"}
                        </div>
                        <div>
                          <b>City:</b> {t.city || t.user_city || "—"}
                        </div>
                        <div>
                          <b>Rating:</b>{" "}
                          {t.rating !== undefined && t.rating !== null
                            ? t.rating
                            : "—"}
                        </div>
                        <div>
                          <b>Available:</b>{" "}
                          {t.is_available === true
                            ? "Yes"
                            : t.is_available === false
                              ? "No"
                              : "—"}
                        </div>
                        {t.skills_json ? (
                          <div>
                            <b>Skills:</b> {String(t.skills_json)}
                          </div>
                        ) : null}
                      </div>
                    </div>
                  ))}
                </div>
              )}
            </div>

            {/* Create technician */}
            <div className="actionPanel">
              <div className="panelTitle">Create Technician Profile</div>
              <div className="panelText">
                This uses <code>POST /admin/technicians</code>. You must provide{" "}
                <b>user_id</b> of an existing user.
              </div>

              <form
                onSubmit={handleCreateTechnician}
                className="formGrid"
                style={{ marginTop: 10 }}
              >
                <label className="field">
                  <div className="fieldLabel">User ID (required)</div>
                  <input
                    className="fieldInput"
                    value={newTech.user_id}
                    onChange={(e) =>
                      setNewTech({ ...newTech, user_id: e.target.value })
                    }
                    required
                    placeholder="e.g. 1"
                    inputMode="numeric"
                  />
                </label>

                <label className="field">
                  <div className="fieldLabel">City (required)</div>
                  <input
                    className="fieldInput"
                    value={newTech.city}
                    onChange={(e) =>
                      setNewTech({ ...newTech, city: e.target.value })
                    }
                    required
                    placeholder="e.g. Mowe"
                  />
                </label>

                <label className="field">
                  <div className="fieldLabel">Rating</div>
                  <input
                    className="fieldInput"
                    value={newTech.rating}
                    onChange={(e) =>
                      setNewTech({ ...newTech, rating: e.target.value })
                    }
                    placeholder="e.g. 5"
                    inputMode="decimal"
                  />
                </label>

                <label className="field">
                  <div className="fieldLabel">Available</div>
                  <select
                    className="fieldInput"
                    value={newTech.is_available ? "yes" : "no"}
                    onChange={(e) =>
                      setNewTech({
                        ...newTech,
                        is_available: e.target.value === "yes",
                      })
                    }
                  >
                    <option value="yes">Yes</option>
                    <option value="no">No</option>
                  </select>
                </label>

                <label className="field" style={{ gridColumn: "1 / -1" }}>
                  <div className="fieldLabel">Skills (comma separated)</div>
                  <input
                    className="fieldInput"
                    value={newTech.skills}
                    onChange={(e) =>
                      setNewTech({ ...newTech, skills: e.target.value })
                    }
                    placeholder="e.g. laptop repair, networking, printer"
                  />
                </label>

                <div className="modalActions">
                  <button
                    className="btnPrimary"
                    type="submit"
                    disabled={busyCreate}
                  >
                    {busyCreate ? "Creating..." : "Create technician"}
                  </button>
                </div>
              </form>
            </div>
          </div>
        )}

        <div className="footerNote" style={{ marginTop: 16 }}>
          Admin tools: view tickets, auto-assign, manage technicians.
        </div>
      </div>
    </div>
  );
}
