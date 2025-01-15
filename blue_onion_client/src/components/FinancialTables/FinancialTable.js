import React from "react";
import './FinancialTable.css';

const FinancialTable = ({ data, day, totals }) => {
  const formatCurrency = (value) => {
    return new Intl.NumberFormat('en-US', {
      style: 'currency',
      currency: 'USD',
    }).format(value);
  };
  return (
    <div className="table-container">
      <div>
        <h1>Journal Entries for {day}</h1>
        <table>
          <thead>
            <tr>
              <th>Account</th>
              <th>Debit</th>
              <th>Credit</th>
              <th>Description</th>
            </tr>
          </thead>
          <tbody>
            {data.map((row, index) => (
              <tr key={index}>
                <td>{row.Account}</td>
                <td>{row.Debit ? formatCurrency(parseFloat(row.Debit)) : "-"}</td>
                <td>{row.Credit ? formatCurrency(parseFloat(row.Credit)) : "-"}</td>
                <td>{row.Description}</td>
              </tr>
            ))}

          </tbody>
        </table>
        <h2>Totals</h2>
        <table>
          <thead>
            <tr>
              <th>Account</th>
              <th>Debit</th>
              <th>Credit</th>
            </tr>
          </thead>
          <tbody>
          {Object.keys(totals).map((account, index) => (
              <tr key={index}>
                <td>{account}</td>
                <td>{totals[account].Debit ? formatCurrency(totals[account].Debit) : "-"}</td>
                <td>{totals[account].Credit ? formatCurrency(totals[account].Credit) : "-"}</td>
              </tr>
            ))}

          </tbody>
        </table>
      </div>
    </div>
  );
};

export default FinancialTable;