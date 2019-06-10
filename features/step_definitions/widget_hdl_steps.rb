Given('I have at least one Cholesterol-hdl registered') do
  @expected_hdl = FactoryBot.create :hdl, :date => Time.now,
                                                    :profile => @my_profile,
                                                    :value => 13

  @another_hdl = FactoryBot.create :hdl, :date => Time.now,
                                                    :profile => @my_profile,
                                                    :value => 20
                                                    
  expect(@my_profile.hdls.size).to be(2)
end

Then('I should see a Cholesterol-hdl widget with the most recent register') do
  widget = find('#widget_latest_cholesterol')

  expect(widget).to have_content("Cholesterol-HDL: #{@expected_hdl.value} mg/dl")
  expect(widget).to have_content("Registered: #{@expected_hdl.date.to_date()}")
end