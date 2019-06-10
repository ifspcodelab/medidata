Given('I have at least one Cholesterol-vldl registered') do
    @expected_vldl = FactoryBot.create :vldl, :date => Time.now,
                                                      :profile => @my_profile,
                                                      :value => 15
  
    @another_vldl = FactoryBot.create :vldl, :date => Time.now,
                                                      :profile => @my_profile,
                                                      :value => 15
                                                      
    expect(@my_profile.vldls.size).to be(2)
  end
  
  Then('I should see a Cholesterol-vldl widget with the most recent register') do
    widget = find('#widget_latest_cholesterol')
  
    expect(widget).to have_content("VLDL: #{@expected_vldl.value} mg/dl")
    expect(widget).to have_content("Registered: #{@expected_vldl.date.to_date()}")
  end