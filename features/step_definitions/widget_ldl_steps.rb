Given('I have at least one Cholesterol-ldl registered') do
    @expected_ldl = FactoryBot.create :ldl, :date => Time.now,
                                                      :profile => @my_profile,
                                                      :value => 13
  
    @another_ldl = FactoryBot.create :ldl, :date => Time.now,
                                                      :profile => @my_profile,
                                                      :value => 20
                                                      
    expect(@my_profile.ldls.size).to be(2)
  end
  
  Then('I should see a Cholesterol-ldl widget with the most recent register') do
    widget = find('#widget_latest_cholesterol')
  
    expect(widget).to have_content("LDL: #{@expected_ldl.value} mg/dl")
    expect(widget).to have_content("Registered: #{@expected_ldl.date.to_date()}")
  end