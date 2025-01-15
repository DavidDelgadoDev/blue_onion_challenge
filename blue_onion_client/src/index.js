import React, { useEffect, useState } from 'react';
import ReactDOM from 'react-dom/client';
import FinancialTables from './components/FinancialTables';
import './App.css';

const App = () => {
  const [data, setData] = useState([]);
  const [month, setMonth] = useState('2023-01');

    useEffect(() => {
    // Replace with your API endpoint
    const apiUrl = `http://127.0.0.1:8000/journal_entries/entries_by_month?month=${month}`;

    fetch(apiUrl)
      .then(response => response.json())
      .then(data => setData(data.result))
      .catch(error => console.error('Error fetching data:', error));
    }, [month]);

    const handleMonthChange = (event) => {
      setMonth(event.target.value);
    };
  

  return (
    <div>
      <div className="header">
        <h1>Journal Entries</h1>
        <label htmlFor="month">Select Month and Year:</label>
        <input
          type="month"
          id="month"
          name="month"
          value={month}
          onChange={handleMonthChange}
        />
      </div>
      <FinancialTables data={data} />
    </div>
  );
};

const root = ReactDOM.createRoot(document.getElementById('root'));
root.render(
  <React.StrictMode>
    <App />
  </React.StrictMode>
);