import './App.css';
import React, { useState } from 'react';

//** Sample Bot Messages for test **
// const BOT_MSGS = [
//   "Hi, how are you?",
//   "Ohh... I can't understand what you trying to say. Sorry!",
//   "I like to play games... But I don't know how to play!",
//   "Sorry if my answers are not relevant. :))",
//   "I feel sleepy! :("
// ]; 

const BOT_IMG = "https://www.svgrepo.com/show/331302/azure-v2.svg";
const PERSON_IMG = "https://yt3.googleusercontent.com/ytc/AL5GRJXQLWIBG375TkT3VMb6V_PoQAwm3ob1uW3k5l8SbQ=s900-c-k-c0x00ffffff-no-rj";
const BOT_NAME = "애저봇☁️";
const PERSON_NAME = "애저 너구리🦝"

export default function App() {
  //First message from bot
  const [messages, setMessages] = useState([appendMessage(BOT_NAME, BOT_IMG, "left", "안녕하세요, 애저봇입니다. 만나서 반가워요! 오늘은 뭘 도와드릴까요?")]);

  //Handling form submit function
  function handleSubmit(e) {

    //Prevent page reload
    e.preventDefault();

    // Read the form data
    const form = e.target;
    const msgerInput = new FormData(form);
    const msgText = msgerInput.get("msger-input");
    if (!msgText) return; //If no message, do nothing

    //Make the input empty
    form.elements["msger-input"].value = "";

    //Append the message to the chat
    setMessages((prevMessages) => [
      ...prevMessages,
      appendMessage(PERSON_NAME, PERSON_IMG, "right", msgText),
    ]);

    //Send the message to the backend api
    //Uncomment this & comment fetch("/api/messages") if you want to run in local.
    //fetch("http://localhost:8080/api/messages", {
    fetch("/api/messages", {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({ text: msgText }),
    })
      .then((response) => response.json()) // parse JSON from request
      .then((data) => {
        const result = data.reply;
        if (result) { //If there is a result, append the bot message with the reply from openai
          // botResponse(result);
          setMessages((prevMessages) => [
            ...prevMessages,
            appendMessage(BOT_NAME, BOT_IMG, "left", result),
          ]);
        }
      })
      .catch((error) => console.error(error));
    
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
      {messages.map((message, index) => (
          <React.Fragment key={index}>{message}</React.Fragment>
        ))}
    </div>
    <form className="msger-inputarea" onSubmit={handleSubmit}>
      <input
        type="text"
        name="msger-input"
        className="msger-input"
        placeholder="새로운 질문을 입력하세요. 구체적일수록 좋습니다 🤖"
      />
      <button type="submit" className="msger-send-btn">
        질문하기
      </button>
    </form>
  </section>
  </>
  );
};

//Make Date format
function formatDate(date) {
  const h = "0" + date.getHours();
  const m = "0" + date.getMinutes();

  return `${h.slice(-2)}:${m.slice(-2)}`;
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

  // If there is no chat container, return the message element(Inital message)
  if (!chatContainer) return msgElement;
  // Scroll to the bottom of the chat container
  chatContainer.scrollTop = chatContainer.scrollTop +500;

  return msgElement;
}

