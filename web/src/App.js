import './App.css';
import React, { useState } from 'react';

const BOT_IMG = "https://www.svgrepo.com/show/331302/azure-v2.svg";
const PERSON_IMG = "https://yt3.googleusercontent.com/ytc/AL5GRJXQLWIBG375TkT3VMb6V_PoQAwm3ob1uW3k5l8SbQ=s900-c-k-c0x00ffffff-no-rj";
const BOT_NAME = "애저봇☁️";
const PERSON_NAME = "애저 너구리🦝"

export default function App() {
  //First message from bot
  // ⬇️ copilot demo ⬇️
  
  //Define messages const array to set the first message from azure bot
  //Call appendMessage function to render the first message from azure bot
  const [messages, setMessages] = useState([appendMessage(BOT_NAME, BOT_IMG, "left", "안녕하세요. 애저봇입니다. 애저에 대한 건 무엇이든지 물어보세요!")]);

  // ⬆️ copilot demo ⬆️

  //Handling form submit function
  function handleSubmit(e) {

    //Prevent page reload
    e.preventDefault();

    // ⬇️ copilot demo ⬇️
    // 1. Read the form data
    // 2. Make the input empty
    // 3. Append the message to the chat
    // 4. Append the loading message to the chat

    //1. Read the form data
    //Get target value and define it as form.
    const form = e.target;
    //Define msgerInput as a FormData
    const msgerInput = new FormData(form);
    //Get the value from "msger-input" element.
    const msgText = msgerInput.get("msger-input");
    //If there is no message, return.
    if (!msgText) return;

    //2. Make the input empty
    //get "msger-input" element from form and make the value empty.
    form.elements["msger-input"].value = "";

    //3. Append the input message to the chat
    // Use setMessages function to append the message to the chat
    setMessages((prevMessages) => [
      ...prevMessages,
      appendMessage(PERSON_NAME, PERSON_IMG, "right", msgText),
    ]);

    //4. Append the loading message to the chat
    // Use setMessages function to append the loading message to the chat
    setMessages((prevMessages) => [
      ...prevMessages,
      appendMessage(BOT_NAME, BOT_IMG, "left", "잠시만 기다려주세요... 답변을 생성하는 중입니다🤖🏃"),
    ]);

    //Send the message to the backend api
    fetch(process.env.REACT_APP_BACKEND_API_ENDPOINT, {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({ text: msgText }),
    })
      .then((response) => {
        if (!response.ok) {
          throw new Error('Network response was not ok');
        }
        return response.json();
      }) 
      .then((data) => {
        setMessages((prevMessages) => [
          ...prevMessages.slice(0, -1), //Remove the loading message
        ]);
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
    // ⬆️ copilot demo ⬆️
    
  }

  // ⬇️ copilot demo ⬇️ 
  // (askmeazure.openai header text, message.map function)
  // Add msager head title with the title name: askmeazure.openai
  // Add message.map function to render messages.
  // Each message should be React.Fragment 
  return (
    <>
  <section className="left-nav">
    
  </section>
  <section className="msger">
    <header className="msger-header">
      
      <div className="msger-header-title">
        <i className="fas fa-robot" /> askmeazure.openai🤖
      </div>
      
      <div className="msger-header-options">
        <span>
          <i className="fas fa-cog" />
        </span>
      </div>
    </header>
    
    <div className="msger-chat" id="msger-chat">

      {messages.map((message, i) => (
        <React.Fragment key={i}>{message}</React.Fragment>
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

