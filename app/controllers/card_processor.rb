class CardProcessor
  def charge(name, card, exp, amount)
    raise StandardError("credit service is down")
  end
end