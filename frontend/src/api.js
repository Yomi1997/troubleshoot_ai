// frontend/src/api.js

const BACKEND_URL = "http://127.0.0.1:8000";

/* =========================
   TOKEN HELPERS
========================= */
export function getToken() {
  return localStorage.getItem("access_token");
}

export function setToken(token) {
  localStorage.setItem("access_token", token);
}

export function clearToken() {
  localStorage.removeItem("access_token");
}

/* =========================
   CORE FETCH WRAPPER
   - Supports BOTH:
     (A) { ok, data, error }
     (B) FastAPI default { detail }
========================= */
async function apiFetch(
  path,
  { method = "GET", body, auth = false, headers = {} } = {},
) {
  const finalHeaders = { ...headers };

  if (body !== undefined && body !== null) {
    finalHeaders["Content-Type"] = "application/json";
  }

  if (auth) {
    const token = getToken();
    if (!token) throw new Error("Not authenticated: please login first");
    finalHeaders["Authorization"] = `Bearer ${token}`;
  }

  const res = await fetch(`${BACKEND_URL}${path}`, {
    method,
    headers: finalHeaders,
    body: body ? JSON.stringify(body) : undefined,
  });

  let payload = null;
  let text = "";
  try {
    payload = await res.json();
  } catch {
    text = await res.text().catch(() => "");
  }

  if (!res.ok) {
    // ✅ make error parsing more tolerant
    const msg =
      (payload && (payload.detail || payload.message)) ||
      (payload && payload?.error?.message) ||
      text ||
      `Request failed (${res.status})`;
    throw new Error(msg);
  }

  // ✅ your backend style
  if (payload && typeof payload === "object" && "ok" in payload) {
    if (!payload.ok) {
      throw new Error(payload?.error?.message || "Request failed");
    }
    return payload.data;
  }

  return payload ?? text;
}

/* =========================
   API METHODS
========================= */
export const api = {
  /* ---- PUBLIC ---- */
  health: () => apiFetch("/health"),
  getModules: () => apiFetch("/modules"),
  /* ---- TICKET ATTACHMENTS ---- */
  ticketAttachments: (ticketId) =>
    apiFetch(`/tickets/${ticketId}/attachments`, { auth: true }),

  uploadTicketAttachment: async (ticketId, file) => {
    const token = getToken();
    if (!token) throw new Error("Not authenticated: please login first");

    const form = new FormData();
    form.append("file", file);

    const res = await fetch(`${BACKEND_URL}/tickets/${ticketId}/attachments`, {
      method: "POST",
      headers: { Authorization: `Bearer ${token}` },
      body: form,
    });

    let payload = null;
    let text = "";
    try {
      payload = await res.json();
    } catch {
      text = await res.text().catch(() => "");
    }

    if (!res.ok) {
      throw new Error(payload?.detail || text || "Upload failed");
    }

    return payload?.ok ? payload.data : payload;
  },

  /* ---- TROUBLESHOOT ---- */
  startSession: (module_id, user_context = {}) =>
    apiFetch("/sessions/start", {
      method: "POST",
      body: { module_id, user_context },
    }),

  answer: (session_id, answer_id) =>
    apiFetch("/sessions/answer", {
      method: "POST",
      body: { session_id, answer_id },
    }),

  /* ---- AUTH ---- */
  register: ({ full_name, email, phone, password }) =>
    apiFetch("/auth/register", {
      method: "POST",
      body: { full_name, email, phone, password },
    }),

  login: async ({ email, password }) => {
    const res = await fetch(`${BACKEND_URL}/auth/login`, {
      method: "POST",
      headers: { "Content-Type": "application/x-www-form-urlencoded" },
      body: new URLSearchParams({ username: email, password }),
    });

    let payload = null;
    let text = "";
    try {
      payload = await res.json();
    } catch {
      text = await res.text().catch(() => "");
    }

    if (!res.ok) {
      throw new Error(
        payload?.detail || payload?.error?.message || text || "Login failed",
      );
    }

    const data = payload?.ok ? payload.data : payload;
    if (data?.access_token) setToken(data.access_token);

    return data;
  },

  me: () => apiFetch("/auth/me", { auth: true }),
  logout: () => clearToken(),

  /* ---- PASSWORD RESET ----
     IMPORTANT: App.jsx calls: api.forgotPassword({ email })
     so this function MUST accept an object.
  */
  forgotPassword: ({ email }) =>
    apiFetch("/auth/forgot-password", {
      method: "POST",
      body: { email },
    }),

  resetPassword: ({ token, new_password }) =>
    apiFetch("/auth/reset-password", {
      method: "POST",
      body: { token, new_password },
    }),

  /* ---- TICKETS (USER) ---- */
  createTicket: (payload) =>
    apiFetch("/tickets", { method: "POST", auth: true, body: payload }),

  myTickets: () => apiFetch("/tickets/my", { auth: true }),

  /* ---- TICKETS (USER) ---- */
  createTicket: (payload) =>
    apiFetch("/tickets", { method: "POST", auth: true, body: payload }),

  myTickets: () => apiFetch("/tickets/my", { auth: true }),

  /* ✅ ATTACHMENTS */
  getTicketAttachments: (ticketId) =>
    apiFetch(`/tickets/${ticketId}/attachments`, { auth: true }),

  uploadTicketAttachment: async (ticketId, file) => {
    const token = getToken();
    if (!token) throw new Error("Not authenticated: please login first");

    const fd = new FormData();
    fd.append("file", file);

    const res = await fetch(`${BACKEND_URL}/tickets/${ticketId}/attachments`, {
      method: "POST",
      headers: {
        Authorization: `Bearer ${token}`,
      },
      body: fd,
    });

    let payload = null;
    let text = "";
    try {
      payload = await res.json();
    } catch {
      text = await res.text().catch(() => "");
    }

    if (!res.ok) {
      throw new Error(payload?.detail || text || "Upload failed");
    }

    return payload?.ok ? payload.data : payload;
  },

  /* ---- TECH ---- */
  techTickets: () => apiFetch("/tech/tickets", { auth: true }),

  techUpdateTicketStatus: (ticketId, status) =>
    apiFetch(`/tech/tickets/${ticketId}/update-status`, {
      method: "POST",
      auth: true,
      body: { status },
    }),

  /* ---- ADMIN ---- */
  adminTickets: () => apiFetch("/admin/tickets", { auth: true }),

  adminTechnicians: () => apiFetch("/admin/technicians", { auth: true }),

  adminCreateTechnician: (payload) =>
    apiFetch("/admin/technicians", {
      method: "POST",
      auth: true,
      body: payload,
    }),

  autoAssignTicket: (ticketId) =>
    apiFetch(`/tickets/${ticketId}/auto-assign`, {
      method: "POST",
      auth: true,
    }),
};

export default BACKEND_URL;
