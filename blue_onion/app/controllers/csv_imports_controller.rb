class CsvImportsController < ApplicationController
    require 'csv'

    skip_before_action :verify_authenticity_token, only: [:import_csv]

    def import_csv
      
      puts "Importing data..."
      file = params[:file]
  
      if file.nil?
        render json: { error: 'No file uploaded' }, status: :bad_request and return
      end
  
      begin
        CSV.foreach(file.path, headers: true) do |row|
          # Extract data from the CSV row
          order_id = row['order_id']
          ordered_at = row['ordered_at']
          item_type = row['item_type']
          price_per_item = row['price_per_item']
          quantity = row['quantity']
          shipping = row['shipping']
          tax_rate = row['tax_rate']
          payment_1_id = row['payment_1_id']
          payment_1_amount = row['payment_1_amount']
          payment_2_id = row['payment_2_id']
          payment_2_amount = row['payment_2_amount']
  
          # Check if the order already exists
          order = Order.find_by(id: order_id)
          next if order # Skip the rest of the operations if the order exists
  
          # Create the order if it does not exist
          order = Order.create!(
            id: order_id,
            ordered_at: ordered_at,
            shipping: shipping,
            tax_rate: tax_rate
          )
  
          # Create the item
          item = Item.create!(
            item_type: item_type
          )
          OrderedItem.create!(
            item: item,
            order: order,
            price_per_item: price_per_item,
            quantity: quantity
          )
  
          # Create transaction entries
          TransactionEntry.create!(account: "Accounts Receivable", debit: shipping, credit: 0.0, description: "Cash expected for shipping on orders", category: "Shipping", order: order)
          TransactionEntry.create!(account: "Shipping Revenue", debit: 0.0, credit: shipping, description: "Revenue for shipping", category: "Shipping", order: order)
          TransactionEntry.create!(account: "Accounts Receivable", debit: order.total_price_before_tax, credit: 0.0, description: "Cash expected for orders", category: "Sales", order: order)
          TransactionEntry.create!(account: "Revenue", debit: 0.0, credit: order.total_price_before_tax, description: "Revenue for orders", category: "Sales", order: order)
          TransactionEntry.create!(account: "Accounts Receivable", debit: order.total_tax, credit: 0.0, description: "Cash expected for taxes", category: "Taxes", order: order)
          TransactionEntry.create!(account: "Sales Tax Payable", debit: 0.0, credit: order.total_tax, description: "Cash to be paid for sales tax", category: "Taxes", order: order)
  
          # Create the payments
          if payment_1_id.present?
            Payment.create!(payment_id: payment_1_id, amount: payment_1_amount, order: order)
            TransactionEntry.create!(account: "Cash", debit: payment_1_amount, credit: 0.0, description: "Cash received", category: "Payments", order: order)
            TransactionEntry.create!(account: "Accounts Receivable", debit: 0.0, credit: payment_1_amount, description: "Removal of expectation of cash", category: "Payments", order: order)
          end
  
          if payment_2_id.present?
            Payment.create!(payment_id: payment_2_id, amount: payment_2_amount, order: order)
            TransactionEntry.create!(account: "Cash", debit: payment_2_amount, credit: 0.0, description: "Cash received", category: "Payments", order: order)
            TransactionEntry.create!(account: "Accounts Receivable", debit: 0.0, credit: payment_2_amount, description: "Removal of expectation of cash", category: "Payments", order: order)
          end
        end
  
        render json: { message: 'Data import completed successfully!' }, status: :ok
      rescue => e
        render json: { error: e.message }, status: :unprocessable_entity
      end
    end
  end