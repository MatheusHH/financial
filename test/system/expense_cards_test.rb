require "application_system_test_case"

class ExpenseCardsTest < ApplicationSystemTestCase
  setup do
    @expense_card = expense_cards(:one)
  end

  test "visiting the index" do
    visit expense_cards_url
    assert_selector "h1", text: "Expense Cards"
  end

  test "creating a Expense card" do
    visit expense_cards_url
    click_on "New Expense Card"

    fill_in "Card", with: @expense_card.card_id
    fill_in "Invoice date", with: @expense_card.invoice_date
    fill_in "Status", with: @expense_card.status
    fill_in "User", with: @expense_card.user_id
    fill_in "Value", with: @expense_card.value
    click_on "Create Expense card"

    assert_text "Expense card was successfully created"
    click_on "Back"
  end

  test "updating a Expense card" do
    visit expense_cards_url
    click_on "Edit", match: :first

    fill_in "Card", with: @expense_card.card_id
    fill_in "Invoice date", with: @expense_card.invoice_date
    fill_in "Status", with: @expense_card.status
    fill_in "User", with: @expense_card.user_id
    fill_in "Value", with: @expense_card.value
    click_on "Update Expense card"

    assert_text "Expense card was successfully updated"
    click_on "Back"
  end

  test "destroying a Expense card" do
    visit expense_cards_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Expense card was successfully destroyed"
  end
end
