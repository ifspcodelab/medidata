Given('I have at least one Cholesterol-total registered') do
    @expected_total = FactoryBot.create :total, :date => Time.now,
                                                      :profile => @my_profile,
                                                      :value => 15
  
    @another_total = FactoryBot.create :total, :date => Time.now,
                                                      :profile => @my_profile,
                                                      :value => 15
                                                      
    expect(@my_profile.totals.size).to be(2)
  end
  
  Then('I should see a Cholesterol-total widget with the most recent register') do
    widget = find('#widget_latest_cholesterol')
  
    expect(widget).to have_content("total: #{@expected_total.value} mg/dl")
    expect(widget).to have_content("Registered: #{@expected_total.date.to_date()}")
  end