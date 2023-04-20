import logo from "./logo.svg";
import "./App.css";
import React, { useState, useEffect } from "react";
 
function App() {
  const [message, setMessage] = useState([]);
  useEffect(() => {
    fetch("/hello")
      .then((res) => {
        return res.json();
      })
      .then((data) => {
        setMessage(data);
      });
  }, []);
  return (
    <div className="App">
      <header className="App-header">
        <img src={logo} className="App-logo" alt="logo" />
        <p>
          Edit <code>src/App.js</code> and save to reload.
        </p>
        <a
          className="App-link"
          href="https://reactjs.org"
          target="_blank"
          rel="noopener noreferrer"
        >
          Learn React
        </a>
        <ul>
          {message.map((v, idx) => (
            <li key={`${idx}-${v}`}>{v}</li>
          ))}
        </ul>
      </header>
    </div>
  );
}
 
export default App;