Given('I have at least one Cholesterol-hdl registered') do
  @expected_HDL = FactoryBot.create :hdl, :date => Time.now,
                                                    :profile => @my_profile,
                                                    :value => 13

  @another_HDL = FactoryBot.create :hdl, :date => Time.now,
                                                    :profile => @my_profile,
                                                    :value => 20
                                                    
  expect(@my_profile.hdls.size).to be(2)
end

Then('I should see a Cholesterol-hdl widget with the most recent register') do
  widget = find('#widget_latest_cholesterol')

  expect(widget).to have_content("HDL: #{@expected_HDL.value} mg/dl")
  expect(widget).to have_content("Registered: #{@expected_HDL.date.to_date()}")
end