require 'test_helper'

class ExpenseCardsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @expense_card = expense_cards(:one)
  end

  test "should get index" do
    get expense_cards_url
    assert_response :success
  end

  test "should get new" do
    get new_expense_card_url
    assert_response :success
  end

  test "should create expense_card" do
    assert_difference('ExpenseCard.count') do
      post expense_cards_url, params: { expense_card: { card_id: @expense_card.card_id, invoice_date: @expense_card.invoice_date, status: @expense_card.status, user_id: @expense_card.user_id, value: @expense_card.value } }
    end

    assert_redirected_to expense_card_url(ExpenseCard.last)
  end

  test "should show expense_card" do
    get expense_card_url(@expense_card)
    assert_response :success
  end

  test "should get edit" do
    get edit_expense_card_url(@expense_card)
    assert_response :success
  end

  test "should update expense_card" do
    patch expense_card_url(@expense_card), params: { expense_card: { card_id: @expense_card.card_id, invoice_date: @expense_card.invoice_date, status: @expense_card.status, user_id: @expense_card.user_id, value: @expense_card.value } }
    assert_redirected_to expense_card_url(@expense_card)
  end

  test "should destroy expense_card" do
    assert_difference('ExpenseCard.count', -1) do
      delete expense_card_url(@expense_card)
    end

    assert_redirected_to expense_cards_url
  end
end
