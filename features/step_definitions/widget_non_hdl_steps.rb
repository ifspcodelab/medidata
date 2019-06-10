Given('I have at least one Cholesterol-non-hdl registered') do
    @expected_NON_HDL = FactoryBot.create :non_hdl, :date => Time.now,
                                                      :profile => @my_profile,
                                                      :value => 13
  
    @another_NON_HDL = FactoryBot.create :non_hdl, :date => Time.now,
                                                      :profile => @my_profile,
                                                      :value => 20
                                                      
    expect(@my_profile.non_hdls.size).to be(2)
  end
  
  Then('I should see a Cholesterol-non-hdl widget with the most recent register') do
    widget = find('#widget_latest_cholesterol')
  
    expect(widget).to have_content("NON-HDL: #{@expected_NON_HDL.value} mg/dl")
    expect(widget).to have_content("Registered: #{@another_NON_HDL.date.to_date()}")
  end