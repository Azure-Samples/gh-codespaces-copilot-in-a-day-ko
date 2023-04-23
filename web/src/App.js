import './App.css';
import React, { useState } from 'react';
//import { ReactDOM } from 'react';

const BOT_MSGS = [
  "Hi, how are you?",
  "Ohh... I can't understand what you trying to say. Sorry!",
  "I like to play games... But I don't know how to play!",
  "Sorry if my answers are not relevant. :))",
  "I feel sleepy! :("
]; 

const BOT_IMG = "https://www.svgrepo.com/show/331302/azure-v2.svg";
const PERSON_IMG = "https://yt3.googleusercontent.com/ytc/AL5GRJXQLWIBG375TkT3VMb6V_PoQAwm3ob1uW3k5l8SbQ=s900-c-k-c0x00ffffff-no-rj";
const BOT_NAME = "애저봇☁️";
const PERSON_NAME = "애저 너구리🦝";


export default function App() {
  const [messages, setMessages] = useState([]);

  function handleSubmit(e) {

    e.preventDefault();

    // Read the form data
    const form = e.target;
    const msgerInput = new FormData(form);
    const msgText = msgerInput.get("msger-input");
    if (!msgText) return;

    msgerInput.set("msger-input", "");

    // appendMessage(PERSON_NAME, PERSON_IMG, "right", msgText);
    setMessages((prevMessages) => [
      ...prevMessages,
      appendMessage(PERSON_NAME, PERSON_IMG, "right", msgText),
    ]);

    botResponse();
    
  }

  function botResponse() {
    const r = random(0, BOT_MSGS.length - 1);
    const msgText = BOT_MSGS[r];
    const delay = msgText.split(" ").length * 100;
  
    setTimeout(() => {
      setMessages((prevMessages) => [
        ...prevMessages,
        appendMessage(BOT_NAME, BOT_IMG, "left", msgText),
      ]);
    }, delay);
  
  }

  return (
    <>
  <section className="left-nav">
    
  </section>

  <section className="msger">
    <header className="msger-header">
      <div className="msger-header-title">
        <i className="fas fa-comment-alt" /> askmeazure.openai🤖
      </div>
      <div className="msger-header-options">
        <span>
          <i className="fas fa-cog" />
        </span>
      </div>
    </header>
    <div className="msger-chat" id="msger-chat">
      <div className="msg left-msg">
        <div
          className="msg-img"
          style={{
            backgroundImage:
              "url(https://www.svgrepo.com/show/331302/azure-v2.svg)"
          }}
        />
        <div className="msg-bubble">
          <div className="msg-info">
            <div className="msg-info-name">애저봇☁️</div>
            {/* <div className="msg-info-time">12:45</div> */}
          </div>
          <div className="msg-text">
            안녕하세요, 애저봇입니다. 만나서 반가워요! 오늘은 뭘 도와드릴까요?
          </div>
        </div>
      </div>
      {messages.map((message, index) => (
          <React.Fragment key={index}>{message}</React.Fragment>
        ))}
    </div>
    <form className="msger-inputarea" onSubmit={handleSubmit}>
      <input
        type="text"
        name="msger-input"
        className="msger-input"
        placeholder="Enter your message..."
      />
      <button type="submit" className="msger-send-btn">
        Send
      </button>
    </form>
  </section>
  </>
  );
};


function formatDate(date) {
const h = "0" + date.getHours();
const m = "0" + date.getMinutes();

return `${h.slice(-2)}:${m.slice(-2)}`;
}

function random(min, max) {
return Math.floor(Math.random() * (max - min) + min);
}

function appendMessage(name, img, side, text) {
  const chatContainer = document.getElementById("msger-chat");

  // Create a new message element
  const msgElement = (
    <div className={`msg ${side}-msg`}>
      <div className="msg-img" style={{ backgroundImage: `url(${img})` }}></div>

      <div className="msg-bubble">
        <div className="msg-info">
          <div className="msg-info-name">{name}</div>
          <div className="msg-info-time">{formatDate(new Date())}</div>
        </div>

        <div className="msg-text">{text}</div>
      </div>
    </div>
  );

  chatContainer.scrollTop = chatContainer.scrollTop +500;

  return msgElement;
}

