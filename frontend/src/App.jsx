// frontend/src/App.jsx
import { useEffect, useMemo, useRef, useState } from "react";
import ChatActions from "./components/ChatActions";
import Modal from "./components/Modal";
import AdminDashboard from "./AdminDashboard";
import { api, getToken, clearToken } from "./api";
import "./App.css";

/* ✅ Your business contact */
const TECH_WHATSAPP_NUMBER = "2349067921361"; // wa.me format (no +)
const TECH_CALL_NUMBER = "09067921361"; // local format is fine for tel:
const SUPPORT_EMAIL = "wiser.gencomputing@gmail.com";

function Badge({ children }) {
  return <span className="badge">{children}</span>;
}

function TypingIndicator() {
  return (
    <div className="typing">
      <span className="dot" />
      <span className="dot" />
      <span className="dot" />
      <span className="typingText">Assistant is typing…</span>
    </div>
  );
}

function ResultCard({
  result,
  onRestart,
  onOpenTechModal,
  onOpenSteps,
  onOpenPremium,
  requirePremium,
}) {
  if (!result) return null;

  const map = {
    free_fix: { title: "Free Tips & Fixes", emoji: "✅", cls: "resFree" },
    refer_technician: {
      title: "Refer Technician",
      emoji: "🧑‍🔧",
      cls: "resRefer",
    },
    premium_fix: { title: "Premium Fix", emoji: "🔒", cls: "resPremium" },
  };

  const meta = map[result.type] || {
    title: "Result",
    emoji: "📌",
    cls: "resDefault",
  };

  const openWhatsApp = () => {
    const msg = encodeURIComponent(
      `Hello Wiser_Gen Computing,\n\nI need a technician.\n\nIssue: ${result.title}\nSummary: ${result.summary}\n\nNext Action:\n${result.next_action || ""}\n`,
    );
    window.open(`https://wa.me/${TECH_WHATSAPP_NUMBER}?text=${msg}`, "_blank");
  };

  const callTech = () => {
    window.location.href = `tel:${TECH_CALL_NUMBER}`;
  };

  const emailSupport = () => {
    const subject = encodeURIComponent(`Technician Request: ${result.title}`);
    const body = encodeURIComponent(
      `Hello Wiser_Gen Computing,\n\nI need a technician.\n\nIssue: ${result.title}\nSummary: ${result.summary}\n\nNext Action:\n${result.next_action || ""}\n`,
    );
    window.location.href = `mailto:${SUPPORT_EMAIL}?subject=${subject}&body=${body}`;
  };

  return (
    <div className={`resultCard ${meta.cls}`}>
      <div className="resultHeader">
        <div className="resultTitle">
          <span className="emoji">{meta.emoji}</span>
          <div>
            <div className="h">{meta.title}</div>
            <div className="sub">{result.title}</div>
          </div>
        </div>
        <Badge>{result.type}</Badge>
      </div>

      <p className="resultSummary">{result.summary}</p>

      {result.next_action ? (
        <div className="actionPanel" style={{ marginTop: 12 }}>
          <div className="panelTitle">Next steps</div>
          <pre className="panelSteps">{result.next_action}</pre>
        </div>
      ) : null}

      <div className="resultActions">
        <button className="btnPrimary" onClick={onOpenSteps}>
          View Steps
        </button>

        {result.type === "refer_technician" && (
          <>
            <button
              className="btnSecondary"
              onClick={() =>
                requirePremium(openWhatsApp, "Upgrade to chat technician")
              }
            >
              Chat Technician (WhatsApp)
            </button>

            <button
              className="btnSecondary"
              onClick={() =>
                requirePremium(callTech, "Upgrade to call technician")
              }
            >
              Call Technician
            </button>

            <button
              className="btnGhost"
              onClick={() =>
                requirePremium(onOpenTechModal, "Upgrade to enter details")
              }
            >
              Enter My Details
            </button>

            <button
              className="btnGhost"
              onClick={() =>
                requirePremium(emailSupport, "Upgrade to email support")
              }
            >
              Email Support
            </button>
          </>
        )}

        {result.type === "premium_fix" && (
          <button className="btnSecondary" onClick={onOpenPremium}>
            Unlock Premium
          </button>
        )}

        <button className="btnGhost" onClick={onRestart}>
          Restart
        </button>
      </div>
    </div>
  );
}

function normalizeTickets(payload) {
  if (!payload) return [];
  if (Array.isArray(payload)) return payload;
  if (Array.isArray(payload.tickets)) return payload.tickets;
  if (Array.isArray(payload.items)) return payload.items;
  if (Array.isArray(payload.data)) return payload.data;
  return [];
}

function normalizeAttachments(payload) {
  if (!payload) return [];
  if (Array.isArray(payload)) return payload;
  if (Array.isArray(payload.attachments)) return payload.attachments;
  if (Array.isArray(payload.items)) return payload.items;
  if (Array.isArray(payload.data)) return payload.data;
  return [];
}

export default function App() {
  // screens
  const [screen, setScreen] = useState("landing"); // landing | pick | chat | admin

  const [categories, setCategories] = useState([]);
  const [moduleId, setModuleId] = useState("");

  const [sessionId, setSessionId] = useState(null);
  const [messages, setMessages] = useState([]);
  const [options, setOptions] = useState([]);
  const [result, setResult] = useState(null);

  const [status, setStatus] = useState("Loading...");
  const [isThinking, setIsThinking] = useState(false);

  // chat actions panels
  const [showWhy, setShowWhy] = useState(false);
  const [showSteps, setShowSteps] = useState(false);

  // Modal state
  const [modalOpen, setModalOpen] = useState(false);
  const [modalTitle, setModalTitle] = useState("");
  const [modalKind, setModalKind] = useState("info");
  // info | tech | premium | auth | tickets | steps | ticket_details | forgot_password

  const openTechOrPremium = () => {
    if (!me) {
      openAuthModal("login");
      return;
    }

    if (!hasActivePremium(me)) {
      openModal("premium", "Upgrade to Premium");
      return;
    }

    openModal("tech", "Find a technician");
  };

  // ✅ PREMIUM PLAN SELECTION
  const [selectedPlan, setSelectedPlan] = useState("weekly");

  // Technician mini form (user details for contact)
  const [techState, setTechState] = useState("");
  const [techCity, setTechCity] = useState("");
  const [techWhatsapp, setTechWhatsapp] = useState("");

  // AUTH STATE
  const [me, setMe] = useState(null);
  const [authMode, setAuthMode] = useState("login"); // login | register
  const [authForm, setAuthForm] = useState({
    full_name: "",
    email: "",
    phone: "",
    password: "",
  });

  const [authBusy, setAuthBusy] = useState(false);
  const [authErr, setAuthErr] = useState("");
  const [authOk, setAuthOk] = useState("");

  // TICKET STATE
  const [preferredContact, setPreferredContact] = useState("whatsapp"); // whatsapp | call | email
  const [myTickets, setMyTickets] = useState([]);

  // ticket details
  const [selectedTicket, setSelectedTicket] = useState(null);

  // ✅ ATTACHMENTS
  const [ticketAttachments, setTicketAttachments] = useState([]);
  const [uploadFile, setUploadFile] = useState(null);
  const [uploadBusy, setUploadBusy] = useState(false);

  const chatEndRef = useRef(null);
  const fileInputRef = useRef(null);

  // =========================
  // LOAD MODULES + ME
  // =========================
  useEffect(() => {
    api
      .getModules()
      .then((data) => {
        // backend may return {categories:[...]} OR {modules:[...]}
        const cats = data?.categories || [];
        const mods = data?.modules || [];

        if (cats.length) {
          setCategories(cats);
          const first = cats?.[0]?.modules?.[0]?.module_id || "";
          setModuleId(first);
        } else if (mods.length) {
          // wrap into a default category if backend returns flat modules
          setCategories([
            {
              category_id: "all",
              title: "All Modules",
              modules: mods,
            },
          ]);
          setModuleId(mods?.[0]?.module_id || "");
        } else {
          setCategories([]);
          setModuleId("");
        }

        setStatus("Ready");
      })
      .catch((e) => setStatus(`Error: ${e.message}`));

    if (getToken()) loadMe();
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, []);

  useEffect(() => {
    chatEndRef.current?.scrollIntoView({ behavior: "smooth" });
  }, [
    messages,
    options,
    isThinking,
    result,
    showWhy,
    showSteps,
    modalOpen,
    myTickets,
    selectedTicket,
    screen,
    ticketAttachments,
  ]);

  const allModules = useMemo(() => {
    return categories.flatMap((c) =>
      (c.modules || []).map((m) => ({
        module_id: m.module_id,
        title: m.title,
        category_id: c.category_id,
        category_title: c.title,
      })),
    );
  }, [categories]);

  const categoriesForCards = useMemo(() => {
    const base = [
      {
        id: "laptops_desktops",
        title: "Laptops / Desktops",
        desc: "Power, boot, slow, blue screen, apps",
        icon: "💻",
      },
      {
        id: "networking_internet",
        title: "Networking / Internet",
        desc: "No internet, Wi-Fi, router, LAN",
        icon: "📶",
      },
      {
        id: "printers_servers",
        title: "Printers / Servers",
        desc: "Printer offline, errors, sharing, servers",
        icon: "🖨️",
      },
    ];

    return base.map((b) => ({
      ...b,
      modules: allModules.filter((m) => m.category_id === b.id),
    }));
  }, [allModules]);

  const addMsg = (who, text) => {
    if (!text) return;
    setMessages((prev) => [...prev, { who, text }]);
  };

  const resetSession = () => {
    setSessionId(null);
    setMessages([]);
    setOptions([]);
    setResult(null);
    setIsThinking(false);
    setShowWhy(false);
    setShowSteps(false);
  };

  // ✅ PLAN DISPLAY
  const PLAN_UI = {
    weekly: { label: "Weekly", price: "₦1,500 / week" },
    monthly: { label: "Monthly", price: "₦6,000 / month" },
    yearly: { label: "Yearly", price: "₦60,000 / year" },
  };

  // ✅ premium check (active = premium AND not expired)
  const hasActivePremium = (me) => {
    if (!me) return false;

    const isPremium = me.is_premium === 1 || me.is_premium === true;
    if (!isPremium) return false;

    // if expiry missing, treat as active
    if (!me.premium_expires_at) return true;

    // ✅ Fix MySQL datetime: "YYYY-MM-DD HH:mm:ss" -> "YYYY-MM-DDTHH:mm:ss"
    const expStr = String(me.premium_expires_at);
    const fixed = expStr.includes(" ") ? expStr.replace(" ", "T") : expStr;

    const exp = new Date(fixed).getTime();
    return Number.isFinite(exp) && exp > Date.now();
  };

  const openModal = (kind, title) => {
    setModalKind(kind);
    setModalTitle(title);
    setModalOpen(true);
  };

  const requirePremium = (action, title = "Upgrade to Premium") => {
    if (!hasActivePremium(me)) {
      openModal("premium", title);
      return;
    }
    action();
  };

  const closeModal = () => setModalOpen(false);

  const restartDiagnosis = () => {
    resetSession();
    setStatus("Ready");
    setScreen("pick");
    closeModal();
  };

  // =========================
  // AUTH FUNCTIONS
  // =========================
  async function loadMe() {
    try {
      if (!api.me) throw new Error("api.me() not found in api.js");
      const data = await api.me();
      setMe(data);
    } catch {
      clearToken();
      setMe(null);
    }
  }

  function openAuthModal(mode = "login") {
    setAuthMode(mode);
    setAuthErr("");
    setAuthOk("");
    openModal("auth", "Login / Register");
  }

  async function handleLogin(e) {
    e.preventDefault();
    setAuthErr("");
    setAuthOk("");
    setAuthBusy(true);

    try {
      if (!api.login) throw new Error("api.login() not found in api.js");
      await api.login({
        email: authForm.email.trim(),
        password: authForm.password,
      });
      await loadMe();
      setAuthOk("Logged in ✅");
      closeModal();
    } catch (err) {
      setAuthErr(err?.message || "Login failed");
    } finally {
      setAuthBusy(false);
    }
  }

  async function handleRegister(e) {
    e.preventDefault();
    setAuthErr("");
    setAuthOk("");
    setAuthBusy(true);

    try {
      if (!api.register) throw new Error("api.register() not found in api.js");
      await api.register({
        full_name: authForm.full_name.trim(),
        email: authForm.email.trim(),
        phone: (authForm.phone || "").trim(),
        password: authForm.password,
      });

      setAuthOk("Account created ✅ Now login.");
      setAuthMode("login");
    } catch (err) {
      setAuthErr(err?.message || "Register failed");
    } finally {
      setAuthBusy(false);
    }
  }

  function handleLogout() {
    try {
      if (api.logout) api.logout();
      else clearToken();
    } catch {
      clearToken();
    }
    setMe(null);
    setMyTickets([]);
    setSelectedTicket(null);
    setTicketAttachments([]);
    setUploadFile(null);
    setStatus("Logged out");
    setScreen("landing");
  }

  function openAdmin() {
    if (!me) {
      setStatus("Please login first");
      openAuthModal("login");
      return;
    }
    if (me.role !== "admin") {
      setStatus("Admin only");
      return;
    }
    setScreen("admin");
  }

  // =========================
  // TICKETS + ATTACHMENTS
  // =========================
  async function loadMyTicketsAndOpen() {
    if (!me) throw new Error("Please login first");

    const raw =
      me.role === "technician"
        ? api.techTickets
          ? await api.techTickets()
          : []
        : api.myTickets
          ? await api.myTickets()
          : [];

    const list = normalizeTickets(raw);
    setMyTickets(list);
    setSelectedTicket(null);

    openModal(
      "tickets",
      me.role === "technician" ? "Assigned Tickets" : "My Tickets",
    );
  }

  async function loadMyTickets() {
    try {
      await loadMyTicketsAndOpen();
    } catch (err) {
      setStatus(`Error: ${err.message}`);
    }
  }

  async function loadTicketAttachments(ticketId) {
    try {
      if (!api.getTicketAttachments)
        throw new Error("Attachments route not added yet");
      const raw = await api.getTicketAttachments(ticketId);
      setTicketAttachments(normalizeAttachments(raw));
    } catch (e) {
      setTicketAttachments([]);
      setStatus(`Attachments: ${e.message}`);
    }
  }

  async function handleUploadAttachment(ticketId) {
    if (!uploadFile) {
      setStatus("Please choose a picture first");
      return;
    }

    try {
      setUploadBusy(true);
      setStatus("Uploading picture...");
      if (!api.uploadTicketAttachment)
        throw new Error("Upload route not added yet");
      await api.uploadTicketAttachment(ticketId, uploadFile);
      setUploadFile(null);
      if (fileInputRef.current) fileInputRef.current.value = "";
      await loadTicketAttachments(ticketId);
      setStatus("Uploaded ✅");
    } catch (e) {
      setStatus(`Upload error: ${e.message}`);
    } finally {
      setUploadBusy(false);
    }
  }

  function openTicketDetails(t) {
    setSelectedTicket(t);
    setTicketAttachments([]);
    setUploadFile(null);
    if (fileInputRef.current) fileInputRef.current.value = "";

    const tid = t?.id || t?.ticket_id;
    if (tid) loadTicketAttachments(tid);

    openModal("ticket_details", tid ? `Ticket #${tid}` : "Ticket Details");
  }

  // =========================
  // TROUBLESHOOT FLOW
  // =========================
  const startChat = async (pickedModuleId) => {
    try {
      resetSession();
      setStatus("Starting diagnosis...");
      setIsThinking(true);

      setModuleId(pickedModuleId);

      if (!api.startSession)
        throw new Error("api.startSession() not found in api.js");
      const data = await api.startSession(pickedModuleId, {
        device_type: "laptop",
        os: "windows",
      });

      setSessionId(data.session_id);
      setScreen("chat");

      addMsg("bot", data.message);
      setOptions((data.options || []).map((o) => ({ ...o, disabled: false })));
      setResult(data.result || null);

      setShowWhy(false);
      setShowSteps(false);

      setIsThinking(false);
      setStatus("Ready");
    } catch (e) {
      setIsThinking(false);
      setStatus(`Error: ${e.message}`);
    }
  };

  const choose = async (opt) => {
    if (!sessionId || isThinking) return;

    try {
      setIsThinking(true);
      setOptions((prev) => prev.map((o) => ({ ...o, disabled: true })));

      addMsg("user", opt.label || opt.id);
      setStatus("Diagnosing...");

      if (!api.answer) throw new Error("api.answer() not found in api.js");
      const data = await api.answer(sessionId, opt.id);

      addMsg("bot", data.message);
      setResult(data.result || null);

      setShowWhy(false);
      setShowSteps(false);

      if (data.result) {
        setOptions([]);
        setStatus("Completed");
      } else {
        setOptions(
          (data.options || []).map((o) => ({ ...o, disabled: false })),
        );
        setStatus("Ready");
      }

      setIsThinking(false);
    } catch (e) {
      setIsThinking(false);
      setStatus(`Error: ${e.message}`);
      setOptions((prev) => prev.map((o) => ({ ...o, disabled: false })));
    }
  };

  // =========================
  // TICKET CREATE
  // =========================
  async function handleCreateTicket() {
    if (!me) {
      setStatus("Please login first to create ticket");
      openAuthModal("login");
      return;
    }
    if (!result) {
      setStatus("Finish troubleshooting first");
      return;
    }
    if (!techCity) {
      setStatus("Please enter your city");
      return;
    }

    try {
      setStatus("Creating ticket...");
      const issue_summary = `${result.title}: ${result.summary}`;

      if (!api.createTicket)
        throw new Error("api.createTicket() not found in api.js");
      const data = await api.createTicket({
        session_id: sessionId,
        module_id: moduleId,
        issue_summary,
        user_city: techCity,
        preferred_contact: preferredContact,
      });

      const newId = data?.ticket_id || data?.id || data?.ticket?.id || "";
      setStatus(`Ticket created ✅ ${newId ? `ID: ${newId}` : ""}`);

      await loadMyTicketsAndOpen();
    } catch (err) {
      setStatus(`Error: ${err.message}`);
    }
  }

  // =========================
  // MODAL BODY RENDERER
  // =========================
  function renderModalBody() {
    if (modalKind === "steps") {
      return (
        <>
          <div className="modalHint">Step-by-step guide</div>
          <div className="actionPanel">
            <div className="panelTitle">{result?.title || "Steps"}</div>
            <pre className="panelSteps">
              {result?.next_action || "No steps available."}
            </pre>
          </div>
          <div className="modalActions">
            <button className="btnPrimary" onClick={closeModal}>
              Close
            </button>
          </div>
        </>
      );
    }

    if (modalKind === "ticket_details") {
      const t = selectedTicket;
      const isTech = me?.role === "technician";
      const canUpload = !!me && !isTech; // user/admin upload; technician view only
      const tid = t?.id || t?.ticket_id;

      return (
        <>
          {!t ? (
            <div className="tiny">No ticket selected.</div>
          ) : (
            <>
              <div className="modalHint">Ticket details</div>

              <div className="actionPanel">
                <div className="panelTitle">
                  Ticket #{tid || "—"} <Badge>{t.status || "—"}</Badge>
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

                  <div style={{ marginTop: 10 }}>
                    <b>Issue summary:</b>
                    <div style={{ marginTop: 6 }}>{t.issue_summary || "—"}</div>
                  </div>

                  {t.created_at ? (
                    <div style={{ marginTop: 10 }}>
                      <b>Created at:</b> {String(t.created_at)}
                    </div>
                  ) : null}
                </div>
              </div>

              {/* ✅ ATTACHMENTS VIEW (everyone can view) */}
              <div className="actionPanel" style={{ marginTop: 12 }}>
                <div className="panelTitle">
                  Screenshots <Badge>{ticketAttachments.length}</Badge>
                </div>

                {ticketAttachments.length === 0 ? (
                  <div className="panelText">
                    No screenshot uploaded yet.
                    <div className="tiny" style={{ marginTop: 6 }}>
                      If you see “404 Not Found”, you still need the backend
                      route: <b>GET /tickets/&lt;ticketId&gt;/attachments</b>
                    </div>
                  </div>
                ) : (
                  <div style={{ display: "grid", gap: 10, marginTop: 10 }}>
                    {ticketAttachments.map((a) => {
                      const url =
                        a.url ||
                        a.file_url ||
                        (a.file_path
                          ? `http://127.0.0.1:8000/${String(a.file_path).replace(/^\/+/, "")}`
                          : "");

                      return (
                        <div
                          key={a.id || url || a.file_name}
                          className="actionPanel"
                        >
                          <div className="panelText">
                            <b>📷 {a.file_name || "attachment"}</b>

                            {url ? (
                              <div style={{ marginTop: 8 }}>
                                <a
                                  className="btnGhost"
                                  href={url}
                                  target="_blank"
                                  rel="noreferrer"
                                  style={{ textAlign: "left" }}
                                >
                                  Open full image
                                </a>

                                <div style={{ marginTop: 8 }}>
                                  <img
                                    src={url}
                                    alt={a.file_name || "attachment"}
                                    style={{
                                      width: "100%",
                                      maxHeight: 260,
                                      objectFit: "contain",
                                      borderRadius: 12,
                                    }}
                                  />
                                </div>
                              </div>
                            ) : (
                              <div className="tiny" style={{ marginTop: 8 }}>
                                No URL returned from backend for this
                                attachment.
                              </div>
                            )}
                          </div>
                        </div>
                      );
                    })}
                  </div>
                )}

                <div
                  className="modalActions"
                  style={{ justifyContent: "flex-start", marginTop: 10 }}
                >
                  <button
                    className="btnGhost"
                    type="button"
                    onClick={() => tid && loadTicketAttachments(tid)}
                  >
                    Refresh Screenshots
                  </button>
                </div>
              </div>

              {/* ✅ UPLOAD (ONLY user/admin) */}
              {canUpload ? (
                <div className="actionPanel" style={{ marginTop: 12 }}>
                  <div className="panelTitle">Upload Fault Picture</div>

                  <div className="panelText">
                    Choose an image then click <b>Upload</b>.
                  </div>

                  <input
                    ref={fileInputRef}
                    type="file"
                    accept="image/*"
                    onChange={(e) => setUploadFile(e.target.files?.[0] || null)}
                  />

                  <div
                    className="modalActions"
                    style={{ justifyContent: "flex-start" }}
                  >
                    <button
                      className="btnSecondary"
                      type="button"
                      disabled={!uploadFile || uploadBusy || !tid}
                      onClick={() => handleUploadAttachment(tid)}
                    >
                      {uploadBusy ? "Uploading..." : "Upload"}
                    </button>

                    <button
                      className="btnGhost"
                      type="button"
                      onClick={() => {
                        setUploadFile(null);
                        if (fileInputRef.current)
                          fileInputRef.current.value = "";
                      }}
                      disabled={uploadBusy}
                    >
                      Clear
                    </button>
                  </div>
                </div>
              ) : (
                <div className="actionPanel" style={{ marginTop: 12 }}>
                  <div className="panelTitle">Upload</div>
                  <div className="panelText">
                    Technicians can <b>view</b> screenshots here. Only the
                    customer/admin uploads.
                  </div>
                </div>
              )}

              <div
                className="modalActions"
                style={{ justifyContent: "flex-start" }}
              >
                <button
                  className="btnGhost"
                  onClick={() =>
                    openModal(
                      "tickets",
                      me?.role === "technician"
                        ? "Assigned Tickets"
                        : "My Tickets",
                    )
                  }
                >
                  ← Back to Tickets
                </button>

                <button className="btnPrimary" onClick={closeModal}>
                  Close
                </button>
              </div>
            </>
          )}
        </>
      );
    }

    // ✅ Forgot password modal
    if (modalKind === "forgot_password") {
      return (
        <>
          <div className="modalHint">
            Enter your email to receive reset instructions
          </div>

          {(authErr || authOk) && (
            <div
              className="actionPanel"
              style={{ marginTop: 10, marginBottom: 10 }}
            >
              <div className="panelTitle">{authErr ? "Error" : "Success"}</div>
              <div className="panelText">{authErr || authOk}</div>
            </div>
          )}

          <form
            onSubmit={async (e) => {
              e.preventDefault();
              setAuthErr("");
              setAuthOk("");
              setAuthBusy(true);
              try {
                if (!api.forgotPassword)
                  throw new Error("api.forgotPassword() not found in api.js");
                await api.forgotPassword(authForm.email.trim());
                setAuthOk(
                  "Reset instructions sent ✅ (If email sending is not configured, you may not receive it on localhost.)",
                );
              } catch (err) {
                setAuthErr(err?.message || "Failed to send reset instructions");
              } finally {
                setAuthBusy(false);
              }
            }}
            className="formGrid"
          >
            <label className="field">
              <div className="fieldLabel">Email</div>
              <input
                className="fieldInput"
                required
                value={authForm.email}
                onChange={(e) =>
                  setAuthForm({ ...authForm, email: e.target.value })
                }
                placeholder="e.g. you@gmail.com"
                autoComplete="email"
              />
            </label>

            <div className="modalActions">
              <button
                className="btnGhost"
                type="button"
                onClick={() => openAuthModal("login")}
                disabled={authBusy}
              >
                ← Back to Login
              </button>

              <button className="btnPrimary" type="submit" disabled={authBusy}>
                {authBusy ? "Sending..." : "Send reset"}
              </button>
            </div>
          </form>
        </>
      );
    }

    if (modalKind === "auth") {
      return (
        <>
          <div className="modalHint">
            {authMode === "login"
              ? "Login to continue"
              : "Create a new account"}
          </div>

          <div
            className="modalActions"
            style={{ justifyContent: "flex-start" }}
          >
            <button
              className="btnGhost"
              type="button"
              onClick={() => {
                setAuthMode("login");
                setAuthErr("");
                setAuthOk("");
              }}
              disabled={authMode === "login" || authBusy}
            >
              Login
            </button>

            <button
              className="btnGhost"
              type="button"
              onClick={() => {
                setAuthMode("register");
                setAuthErr("");
                setAuthOk("");
              }}
              disabled={authMode === "register" || authBusy}
            >
              Register
            </button>
          </div>

          {(authErr || authOk) && (
            <div
              className="actionPanel"
              style={{ marginTop: 10, marginBottom: 10 }}
            >
              <div className="panelTitle">{authErr ? "Error" : "Success"}</div>
              <div className="panelText">{authErr || authOk}</div>
            </div>
          )}

          {authMode === "login" ? (
            <form onSubmit={handleLogin} className="formGrid">
              <label className="field">
                <div className="fieldLabel">Email</div>
                <input
                  className="fieldInput"
                  required
                  value={authForm.email}
                  onChange={(e) =>
                    setAuthForm({ ...authForm, email: e.target.value })
                  }
                  placeholder="e.g. you@gmail.com"
                  autoComplete="email"
                />
              </label>

              <label className="field">
                <div className="fieldLabel">Password</div>
                <input
                  className="fieldInput"
                  required
                  type="password"
                  value={authForm.password}
                  onChange={(e) =>
                    setAuthForm({ ...authForm, password: e.target.value })
                  }
                  placeholder="Your password"
                  autoComplete="current-password"
                />
              </label>

              <div className="modalActions">
                <button
                  className="btnGhost"
                  type="button"
                  onClick={closeModal}
                  disabled={authBusy}
                >
                  Cancel
                </button>
                <button
                  className="btnPrimary"
                  type="submit"
                  disabled={authBusy}
                >
                  {authBusy ? "Please wait..." : "Login"}
                </button>
              </div>

              <div style={{ textAlign: "center", marginTop: 8 }}>
                <button
                  type="button"
                  className="btnGhost"
                  onClick={() => {
                    setAuthErr("");
                    setAuthOk("");
                    openModal("forgot_password", "Reset password");
                  }}
                  disabled={authBusy}
                >
                  Forgot password?
                </button>
              </div>
            </form>
          ) : (
            <form onSubmit={handleRegister} className="formGrid">
              <label className="field">
                <div className="fieldLabel">Full name</div>
                <input
                  className="fieldInput"
                  required
                  value={authForm.full_name}
                  onChange={(e) =>
                    setAuthForm({ ...authForm, full_name: e.target.value })
                  }
                  placeholder="e.g. Tim"
                  autoComplete="name"
                />
              </label>

              <label className="field">
                <div className="fieldLabel">Email</div>
                <input
                  className="fieldInput"
                  required
                  value={authForm.email}
                  onChange={(e) =>
                    setAuthForm({ ...authForm, email: e.target.value })
                  }
                  placeholder="e.g. you@gmail.com"
                  autoComplete="email"
                />
              </label>

              <label className="field">
                <div className="fieldLabel">Phone (optional)</div>
                <input
                  className="fieldInput"
                  value={authForm.phone}
                  onChange={(e) =>
                    setAuthForm({ ...authForm, phone: e.target.value })
                  }
                  placeholder="e.g. 090..."
                  autoComplete="tel"
                />
              </label>

              <label className="field">
                <div className="fieldLabel">Password</div>
                <input
                  className="fieldInput"
                  required
                  type="password"
                  value={authForm.password}
                  onChange={(e) =>
                    setAuthForm({ ...authForm, password: e.target.value })
                  }
                  placeholder="Create password"
                  autoComplete="new-password"
                />
              </label>

              <div className="modalActions">
                <button
                  className="btnGhost"
                  type="button"
                  onClick={closeModal}
                  disabled={authBusy}
                >
                  Cancel
                </button>
                <button
                  className="btnPrimary"
                  type="submit"
                  disabled={authBusy}
                >
                  {authBusy ? "Please wait..." : "Create account"}
                </button>
              </div>
            </form>
          )}
        </>
      );
    }

    // ✅ TECH MODAL: premium required
    if (modalKind === "tech") {
      if (!hasActivePremium(me)) {
        return (
          <>
            <div className="modalHint">
              Premium required to contact technicians.
            </div>
            <div className="premiumBox">
              <div className="premiumTitle">Upgrade to unlock</div>
              <ul className="premiumList">
                <li>Chat/call/email technicians</li>
                <li>Priority support</li>
                <li>Faster ticket assignment</li>
              </ul>
            </div>
            <div className="modalActions">
              <button className="btnGhost" onClick={openTechOrPremium}>
                Close
              </button>
              <button
                className="btnPrimary"
                onClick={() => openModal("premium", "Upgrade to Premium")}
              >
                Upgrade
              </button>
            </div>
          </>
        );
      }

      return (
        <>
          <div className="modalHint">
            Enter your details. You can send WhatsApp request, and (if logged
            in) save a Ticket in the system.
          </div>

          {!me ? (
            <div className="actionPanel" style={{ marginBottom: 12 }}>
              <div className="panelTitle">Login required to save ticket</div>
              <div className="panelText">
                You can still send WhatsApp now. If you want to track the
                request, login and then create ticket.
              </div>
              <div
                className="modalActions"
                style={{ justifyContent: "flex-start" }}
              >
                <button
                  className="btnPrimary"
                  type="button"
                  onClick={() => openAuthModal("login")}
                >
                  Login / Register
                </button>
              </div>
            </div>
          ) : null}

          <div className="formGrid">
            <label className="field">
              <div className="fieldLabel">State</div>
              <input
                className="fieldInput"
                value={techState}
                onChange={(e) => setTechState(e.target.value)}
                placeholder="e.g. Lagos"
                autoComplete="address-level1"
              />
            </label>

            <label className="field">
              <div className="fieldLabel">City</div>
              <input
                className="fieldInput"
                value={techCity}
                onChange={(e) => setTechCity(e.target.value)}
                placeholder="e.g. Ikeja"
                autoComplete="address-level2"
              />
            </label>

            <label className="field">
              <div className="fieldLabel">Your WhatsApp Number</div>
              <input
                className="fieldInput"
                value={techWhatsapp}
                onChange={(e) => setTechWhatsapp(e.target.value)}
                placeholder="e.g. 090..."
                autoComplete="tel"
              />
            </label>

            <label className="field">
              <div className="fieldLabel">Preferred Contact</div>
              <select
                className="fieldInput"
                value={preferredContact}
                onChange={(e) => setPreferredContact(e.target.value)}
              >
                <option value="whatsapp">WhatsApp</option>
                <option value="call">Call</option>
                <option value="email">Email</option>
              </select>
            </label>
          </div>

          <div className="modalActions">
            <button className="btnGhost" type="button" onClick={closeModal}>
              Cancel
            </button>

            <button
              className="btnPrimary"
              type="button"
              onClick={() => {
                const msg = encodeURIComponent(
                  `Hello Wiser_Gen Computing,\n\nI need a technician.\n\nState: ${techState}\nCity: ${techCity}\nMy WhatsApp: ${techWhatsapp}\nPreferred Contact: ${preferredContact}\n\nIssue: ${result?.title || ""}\nSummary: ${result?.summary || ""}\n\nNext Action:\n${result?.next_action || ""}\n`,
                );

                window.open(
                  `https://wa.me/${TECH_WHATSAPP_NUMBER}?text=${msg}`,
                  "_blank",
                );
                closeModal();
              }}
              disabled={!techState || !techWhatsapp}
            >
              Send on WhatsApp
            </button>

            <button
              className="btnGhost"
              type="button"
              onClick={() => {
                const subject = encodeURIComponent(
                  `Technician Request: ${result?.title || "Troubleshoot AI"}`,
                );
                const body = encodeURIComponent(
                  `State: ${techState}\nCity: ${techCity}\nMy WhatsApp: ${techWhatsapp}\nPreferred Contact: ${preferredContact}\n\nIssue: ${result?.title || ""}\nSummary: ${result?.summary || ""}\n\nNext Action:\n${result?.next_action || ""}\n`,
                );
                window.location.href = `mailto:${SUPPORT_EMAIL}?subject=${subject}&body=${body}`;
              }}
            >
              Send by Email instead
            </button>
          </div>

          <div
            className="modalActions"
            style={{ justifyContent: "flex-start" }}
          >
            <button
              className="btnSecondary"
              type="button"
              onClick={handleCreateTicket}
              disabled={!me || !techCity || !result}
              title={!me ? "Login first" : !techCity ? "Enter city" : ""}
            >
              Save Ticket (in system)
            </button>

            {me ? (
              <button
                className="btnGhost"
                type="button"
                onClick={loadMyTickets}
              >
                View My Tickets
              </button>
            ) : null}
          </div>
        </>
      );
    }

    if (modalKind === "premium") {
      return (
        <>
          <div className="modalHint">
            Stop wasting hours watFching random YouTube fixes. Get instant
            virtual support from real professionals and resolve your issues
            faster.
          </div>
          {/* ✅ PLAN SELECTOR */}
          <div className="actionPanel" style={{ marginTop: 10 }}>
            <div className="panelTitle">Choose a plan</div>

            <div style={{ display: "grid", gap: 10, marginTop: 10 }}>
              {Object.entries(PLAN_UI).map(([key, meta]) => (
                <button
                  key={key}
                  type="button"
                  className={selectedPlan === key ? "btnPrimary" : "btnGhost"}
                  onClick={() => setSelectedPlan(key)}
                  style={{ justifyContent: "space-between", display: "flex" }}
                >
                  <span>{meta.label}</span>
                  <span className="tiny">{meta.price}</span>
                </button>
              ))}
            </div>
          </div>

          <div className="premiumBox">
            <div className="premiumTitle">What you get</div>
            <ul className="premiumList">
              <li>Chat directly with technicians</li>
              <li>Upload error screenshots</li>
              <li>Priority support</li>
              <li>Faster ticket assignment</li>
            </ul>
          </div>

          <div className="modalActions">
            <button className="btnGhost" onClick={closeModal}>
              Close
            </button>
            <button
              className="btnPrimary"
              onClick={async () => {
                try {
                  if (!me) {
                    alert("Please login first");
                    openAuthModal("login");
                    return;
                  }

                  const token = getToken();

                  if (!token) {
                    openAuthModal("login");
                    return;
                  }

                  const res = await fetch(
                    "http://127.0.0.1:8000/billing/paystack/init",
                    {
                      method: "POST",
                      headers: {
                        "Content-Type": "application/json",
                        Authorization: `Bearer ${token}`, // ✅ IMPORTANT
                      },
                      body: JSON.stringify({
                        plan: selectedPlan, // ✅ only send plan now
                      }),
                    },
                  );

                  const data = await res.json();

                  if (!res.ok) {
                    alert(data.detail || "Payment init failed");
                    return;
                  }

                  // redirect to Paystack
                  window.location.href = data.authorization_url;
                } catch (err) {
                  console.error(err);
                  alert("Payment error");
                }
              }}
            >
              Proceed to Payment
            </button>
          </div>
        </>
      );
    }

    if (modalKind === "tickets") {
      return (
        <>
          <div className="modalHint">
            Your saved technician requests (tickets)
          </div>

          {myTickets.length === 0 ? (
            <div className="tiny">No tickets yet.</div>
          ) : (
            <div
              style={{
                display: "grid",
                gap: 10,
                maxHeight: "60vh",
                overflowY: "auto",
                paddingRight: 6,
              }}
            >
              {myTickets.map((t) => (
                <div key={t.id || t.ticket_id} className="actionPanel">
                  <div className="panelTitle">
                    Ticket #{t.id || t.ticket_id} <Badge>{t.status}</Badge>
                  </div>

                  <div className="panelText">
                    <div>
                      <b>Module:</b> {t.module_id}
                    </div>
                    <div>
                      <b>City:</b> {t.user_city}
                    </div>
                    <div style={{ marginTop: 6 }}>{t.issue_summary}</div>
                  </div>

                  <div
                    className="modalActions"
                    style={{ justifyContent: "flex-start" }}
                  >
                    <button
                      className="btnGhost"
                      type="button"
                      onClick={() => openTicketDetails(t)}
                    >
                      View Details
                    </button>
                  </div>
                </div>
              ))}
            </div>
          )}

          <div className="modalActions">
            <button className="btnPrimary" onClick={closeModal}>
              Close
            </button>
          </div>
        </>
      );
    }

    if (modalKind === "info") {
      return (
        <>
          <div className="modalHint">About Troubleshoot AI</div>

          <div className="actionPanel">
            <div className="panelTitle">What this platform does</div>
            <div className="panelText">
              Troubleshoot AI helps you diagnose computer, internet, and printer
              problems through guided questions, then connects you with trusted
              technicians if needed.
            </div>
          </div>

          <div className="actionPanel">
            <div className="panelTitle">Why you can trust it</div>
            <ul className="panelText">
              <li>Structured troubleshooting logic</li>
              <li>No random guesses</li>
              <li>Verified technician matching</li>
              <li>Your data stays private</li>
            </ul>
          </div>

          <div className="actionPanel">
            <div className="panelTitle">Premium</div>
            <div className="panelText">
              Premium users can chat directly with technicians, upload system
              error screenshots, and get priority support.
            </div>
          </div>

          <div className="modalActions">
            <button className="btnPrimary" onClick={closeModal}>
              Got it
            </button>
          </div>
        </>
      );
    }

    return (
      <>
        <div className="modalHint">Info</div>
        <div className="modalActions">
          <button className="btnPrimary" onClick={closeModal}>
            OK
          </button>
        </div>
      </>
    );
  }

  // =========================
  // ADMIN SCREEN
  // =========================
  if (screen === "admin") {
    return (
      <AdminDashboard
        me={me}
        onBack={() => setScreen("pick")}
        onLogout={handleLogout}
      />
    );
  }

  // =========================
  // RENDER SCREENS
  // =========================
  if (screen === "landing") {
    return (
      <div className="page">
        <div className="container">
          <div className="topBar">
            <div className="brand">
              <div className="brandName">Troubleshoot AI</div>
              <div className="brandSub">Intelligent Troubleshooting System</div>
            </div>
            <div className="topRight">
              <Badge>Beta</Badge>
            </div>
          </div>

          <div className="hero">
            <div className="heroInner">
              <h1>Fix tech problems in minutes.</h1>
              <p>
                A clean, guided troubleshooting assistant for <b>computers</b>,{" "}
                <b>internet</b>, and <b>printers</b>.
              </p>

              <div className="heroButtons">
                <button
                  className="btnPrimary"
                  onClick={() => setScreen("pick")}
                  disabled={status !== "Ready"}
                >
                  Start Diagnosis
                </button>

                <button
                  className="btnSecondary"
                  onClick={() => openModal("info", "About Troubleshoot AI")}
                >
                  Learn More
                </button>

                <button
                  className="btnGhost"
                  onClick={() =>
                    requirePremium(() =>
                      openModal("tech", "Contact a technician"),
                    )
                  }
                >
                  Contact Technician
                </button>
              </div>

              <div className="tiny">
                {status !== "Ready"
                  ? status
                  : "No signup required. Guided steps. Clear results."}
              </div>
            </div>

            <div className="heroSide">
              <div className="sideCard">
                <div className="sideTitle">How it works</div>
                <ul className="sideList">
                  <li>Choose a category</li>
                  <li>Answer quick questions</li>
                  <li>Get a diagnosis & next steps</li>
                </ul>
                <div className="sideHint">
                  Built to match your organogram: Diagnose → Result → Action.
                </div>
              </div>
            </div>
          </div>

          <div className="footerNote">
            Light, clean, mobile-friendly UI (AI chat-style diagnosis).
          </div>
        </div>

        <Modal open={modalOpen} title={modalTitle} onClose={closeModal}>
          {renderModalBody()}
        </Modal>
      </div>
    );
  }

  if (screen === "pick") {
    return (
      <div className="page">
        <div className="container">
          <div className="topBar">
            <button className="btnGhost" onClick={() => setScreen("landing")}>
              ← Back
            </button>

            <div className="brandCenter">Choose a category</div>

            <div style={{ display: "flex", gap: 8, alignItems: "center" }}>
              {me ? (
                <>
                  <Badge>{me.full_name || "User"}</Badge>
                  <Badge>{me.role}</Badge>

                  {me.role === "admin" ? (
                    <button className="btnGhost" onClick={openAdmin}>
                      Admin
                    </button>
                  ) : null}

                  <button className="btnGhost" onClick={loadMyTickets}>
                    My Tickets
                  </button>
                  <button className="btnGhost" onClick={handleLogout}>
                    Logout
                  </button>
                </>
              ) : (
                <button
                  className="btnGhost"
                  onClick={() => openAuthModal("login")}
                >
                  Login
                </button>
              )}
            </div>
          </div>

          <div className="grid">
            {categoriesForCards.map((c) => {
              const enabled = c.modules.length > 0;

              const inThisCard = c.modules.some(
                (m) => m.module_id === moduleId,
              );
              const selected = inThisCard
                ? moduleId
                : c.modules?.[0]?.module_id || "";

              return (
                <div key={c.id} className={`card ${enabled ? "" : "disabled"}`}>
                  <div className="cardTop">
                    <div className="icon">{c.icon}</div>
                    <div>
                      <div className="cardTitle">{c.title}</div>
                      <div className="cardDesc">{c.desc}</div>
                    </div>
                  </div>

                  <div className="cardBottom">
                    {enabled ? (
                      <>
                        <select
                          className="cardSelect"
                          value={selected}
                          onChange={(e) => setModuleId(e.target.value)}
                        >
                          {c.modules.map((m) => (
                            <option key={m.module_id} value={m.module_id}>
                              {m.title}
                            </option>
                          ))}
                        </select>

                        <button
                          className="btnPrimary"
                          onClick={() => startChat(selected)}
                        >
                          Continue
                        </button>
                      </>
                    ) : (
                      <>
                        <Badge>Coming soon</Badge>
                        <button className="btnPrimary" disabled>
                          Continue
                        </button>
                      </>
                    )}
                  </div>
                </div>
              );
            })}
          </div>

          <div className="tiny">
            Tip: Need help with another device? Technician support is available
          </div>
        </div>

        <Modal open={modalOpen} title={modalTitle} onClose={closeModal}>
          {renderModalBody()}
        </Modal>
      </div>
    );
  }

  // screen === "chat"
  const lastMessage = messages[messages.length - 1];
  const showInlineActions =
    !!result && !!lastMessage && lastMessage.who === "bot";

  return (
    <div className="page">
      <div className="container">
        <div className="topBar">
          <button className="btnGhost" onClick={() => setScreen("pick")}>
            ← Categories
          </button>

          <div className="brandCenter">Diagnosis</div>

          <div style={{ display: "flex", gap: 8, alignItems: "center" }}>
            {me ? (
              <>
                <Badge>{me.full_name || "User"}</Badge>
                <Badge>{me.role}</Badge>

                {me.role === "admin" ? (
                  <button className="btnGhost" onClick={openAdmin}>
                    Admin
                  </button>
                ) : null}

                <button className="btnGhost" onClick={loadMyTickets}>
                  My Tickets
                </button>
                <button className="btnGhost" onClick={handleLogout}>
                  Logout
                </button>
              </>
            ) : (
              <button
                className="btnGhost"
                onClick={() => openAuthModal("login")}
              >
                Login
              </button>
            )}

            <button className="btnGhost" onClick={restartDiagnosis}>
              Restart
            </button>
          </div>
        </div>

        <div className="statusRow">
          <div className={`statusDot ${isThinking ? "thinking" : ""}`} />
          <div className="statusText">{status}</div>
        </div>

        <div className="chatBox">
          {messages.map((m, idx) => {
            const isLastBot = idx === messages.length - 1 && m.who === "bot";

            return (
              <div key={idx} className={`bubble ${m.who}`}>
                <div className="who">
                  {m.who === "bot" ? "Assistant" : "You"}
                </div>
                <div className="text">{m.text}</div>

                {isLastBot && showInlineActions && (
                  <>
                    <ChatActions
                      result={result}
                      onWhy={() => setShowWhy((v) => !v)}
                      onShowSteps={() => setShowSteps((v) => !v)}
                      onFindTechnician={() =>
                        requirePremium(() =>
                          openModal("tech", "Find a technician"),
                        )
                      }
                      onUnlockPremium={() =>
                        openModal("premium", "Unlock premium steps")
                      }
                      onRestart={restartDiagnosis}
                    />

                    {showWhy && (
                      <div className="actionPanel inline">
                        <div className="panelTitle">
                          Why this may be happening
                        </div>
                        <div className="panelText">
                          {result?.summary ||
                            "This explanation is based on your answers in the diagnosis flow."}
                        </div>
                      </div>
                    )}

                    {showSteps && (
                      <div className="actionPanel inline">
                        <div className="panelTitle">Basic steps</div>
                        <pre className="panelSteps">
                          {result?.next_action || "No steps available."}
                        </pre>
                      </div>
                    )}
                  </>
                )}
              </div>
            );
          })}

          {isThinking && <TypingIndicator />}
          <div ref={chatEndRef} />
        </div>

        <div className="optionsRow">
          {options.map((o) => (
            <button
              key={o.id}
              className="btnOption"
              onClick={() => choose(o)}
              disabled={o.disabled || isThinking || !sessionId}
            >
              {o.label || o.id}
            </button>
          ))}
        </div>

        <ResultCard
          result={result}
          onRestart={restartDiagnosis}
          onOpenTechModal={() =>
            requirePremium(() => openModal("tech", "Find a technician"))
          }
          onOpenSteps={() => openModal("steps", "Step-by-step guide")}
          onOpenPremium={() => openModal("premium", "Unlock premium")}
          requirePremium={requirePremium}
        />

        <Modal open={modalOpen} title={modalTitle} onClose={closeModal}>
          {renderModalBody()}
        </Modal>
      </div>
    </div>
  );
}
