const chatBox = document.getElementById("chat-box");
const messageInput = document.getElementById("message-input");
const usernameInput = document.getElementById("username-input");
const startBtn = document.getElementById("start-chat");
const sendBtn = document.getElementById("send-btn");
const chatArea = document.getElementById("chat-area");
const usernameContainer = document.getElementById("username-container");

let username = "";

// Cargar historial guardado
function loadChatHistory() {
  const saved = localStorage.getItem("chatHistory");
  if (saved) {
    chatBox.innerHTML = saved;
    chatBox.scrollTop = chatBox.scrollHeight;
  }
}

function saveChatHistory() {
  localStorage.setItem("chatHistory", chatBox.innerHTML);
}

// Iniciar chat
startBtn.addEventListener("click", () => {
  username = usernameInput.value.trim();
  if (username === "") {
    alert("Por favor, escribe tu nombre antes de entrar.");
    return;
  }

  usernameContainer.style.display = "none";
  chatArea.classList.remove("hidden");
  loadChatHistory();
});

// Enviar mensaje
function sendMessage() {
  const message = messageInput.value.trim();
  if (message === "") return;

  const userMsg = document.createElement("div");
  userMsg.classList.add("message", "user");
  userMsg.textContent = `${username}: ${message}`;
  chatBox.appendChild(userMsg);

  messageInput.value = "";
  chatBox.scrollTop = chatBox.scrollHeight;
  saveChatHistory();
}

sendBtn.addEventListener("click", sendMessage);
messageInput.addEventListener("keypress", (e) => {
  if (e.key === "Enter") sendMessage();
});
