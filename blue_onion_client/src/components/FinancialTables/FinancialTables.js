import React from "react";
import FinancialTable from "./FinancialTable";

const FinancialTables = ({ data }) => {
  return (
    <div>
      {data.map((dayData, index) => (
        <FinancialTable key={index} data={dayData.entries} day={dayData.day} totals={dayData.totals} />
      ))}
    </div>
  );
};

export default FinancialTables;