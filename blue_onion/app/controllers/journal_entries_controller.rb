class JournalEntriesController < ApplicationController
    def get_entries_by_month
      # If no month is provided, aggregate by all months
      unless params[:month].present?
        render json: { error: 'Month is required' }, status: :unprocessable_entity and return
      end

        # Parse the provided month to get the start and end datetime of the month
        puts "params[:month]: #{params[:month]}"
        begin
          month = Date.parse(params[:month]+ "-01") # e.g. "2025-01" will be parsed to January 2025
          start_date = month.beginning_of_month
          end_date = month.end_of_month
        rescue ArgumentError => e
            puts e
          render json: { error: 'Invalid month format. Use YYYY-MM' }, status: :unprocessable_entity and return
        end
  
        # Fetch orders for the specific month
        orders = Order.where(ordered_at: start_date..end_date)
        aggregated_data = orders.group_by { |order| order.ordered_at.strftime('%Y-%m-%d') }.sort_by { |day, _orders| day }
        result = []
        aggregated_data.map do |day, orders_in_month|
            journal_entries = []
            totals = {
                "Accounts Receivable": {
                    "Debit": 0.0,
                    "Credit": 0.0
                },
                "Shipping Revenue": {
                    "Debit": 0.0,
                    "Credit": 0.0
                },
                "Revenue": {
                    "Debit": 0.0,
                    "Credit": 0.0
                },
                "Sales Tax Payable": {
                    "Debit": 0.0,
                    "Credit": 0.0
                },
                "Cash": {
                    "Debit": 0.0,
                    "Credit": 0.0
                }   
            }
            orders_in_month.each do |order|
                order.transaction_entries.each do |entry|
                    journal_entries.push({
                        "Account": entry.account,
                        "Debit": entry.debit,
                        "Credit": entry.credit,
                        "Description": entry.description
                    })
                    totals[entry.account.to_sym][:Debit] += entry.debit
                    totals[entry.account.to_sym][:Credit] += entry.credit
                end
            end
            result.push({
                day: day,
                entries: journal_entries,
                totals: totals
            })  
        end
  
        render json: {"result":result}
  
        
      end

  end