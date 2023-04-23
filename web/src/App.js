import './App.css';
import React from 'react';

export default function App() {
  return (
    <>
  <section className="left-nav">
    
  </section>

  <section className="msger">
    <header className="msger-header">
      <div className="msger-header-title">
        <i className="fas fa-comment-alt" /> My Azure.openai
      </div>
      <div className="msger-header-options">
        <span>
          <i className="fas fa-cog" />
        </span>
      </div>
    </header>
    <main className="msger-chat">
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
            <div className="msg-info-name">BOT</div>
            <div className="msg-info-time">12:45</div>
          </div>
          <div className="msg-text">
            Hi, welcome to SimpleChat! Go ahead and send me a message. 😄
          </div>
        </div>
      </div>
      <div className="msg right-msg">
        <div
          className="msg-img"
          style={{
            backgroundImage:
              "url(https://yt3.googleusercontent.com/ytc/AL5GRJXQLWIBG375TkT3VMb6V_PoQAwm3ob1uW3k5l8SbQ=s900-c-k-c0x00ffffff-no-rj)"
          }}
        />
        <div className="msg-bubble">
          <div className="msg-info">
            <div className="msg-info-name">Sajad</div>
            <div className="msg-info-time">12:46</div>
          </div>
          <div className="msg-text">
            You can change your name in JS section!
          </div>
        </div>
      </div>
    </main>
    <form className="msger-inputarea">
      <input
        type="text"
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