import './App.css';
import React, { useState } from 'react';

const BOT_IMG = "https://www.svgrepo.com/show/331302/azure-v2.svg";
const PERSON_IMG = "https://yt3.googleusercontent.com/ytc/AL5GRJXQLWIBG375TkT3VMb6V_PoQAwm3ob1uW3k5l8SbQ=s900-c-k-c0x00ffffff-no-rj";
const BOT_NAME = "애저봇☁️";
const PERSON_NAME = "애저 너구리🦝"

export default function App() {
  //First message from bot
  // ⬇️ copilot demo ⬇️

  // ⬆️ copilot demo ⬆️

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

    // ⬇️ copilot demo ⬇️
    //Send the message to the backend api
    
    // ⬆️ copilot demo ⬆️
    
  }

  // ⬇️ copilot demo ⬇️ (askmeazure.openai header text, message.map function)
  return (
    <>
  <section className="left-nav">
    
  </section>
  <section className="msger">
    <header className="msger-header">
      
      
      
      <div className="msger-header-options">
        <span>
          <i className="fas fa-cog" />
        </span>
      </div>
    </header>
    
    <div className="msger-chat" id="msger-chat">
     
    

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

