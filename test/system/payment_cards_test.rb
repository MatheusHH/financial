require "application_system_test_case"

class PaymentCardsTest < ApplicationSystemTestCase
  setup do
    @payment_card = payment_cards(:one)
  end

  test "visiting the index" do
    visit payment_cards_url
    assert_selector "h1", text: "Payment Cards"
  end

  test "creating a Payment card" do
    visit payment_cards_url
    click_on "New Payment Card"

    fill_in "Account", with: @payment_card.account_id
    fill_in "Card", with: @payment_card.card_id
    fill_in "Invoice payment date", with: @payment_card.invoice_payment_date
    fill_in "User", with: @payment_card.user_id
    fill_in "Value", with: @payment_card.value
    click_on "Create Payment card"

    assert_text "Payment card was successfully created"
    click_on "Back"
  end

  test "updating a Payment card" do
    visit payment_cards_url
    click_on "Edit", match: :first

    fill_in "Account", with: @payment_card.account_id
    fill_in "Card", with: @payment_card.card_id
    fill_in "Invoice payment date", with: @payment_card.invoice_payment_date
    fill_in "User", with: @payment_card.user_id
    fill_in "Value", with: @payment_card.value
    click_on "Update Payment card"

    assert_text "Payment card was successfully updated"
    click_on "Back"
  end

  test "destroying a Payment card" do
    visit payment_cards_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Payment card was successfully destroyed"
  end
end
