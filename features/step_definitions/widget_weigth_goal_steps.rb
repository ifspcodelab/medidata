Given('I have at least one Weight Goal registered') do
    @expected_weight_goal = FactoryBot.create :weight_goal, :date => Time.now,
                                                      :profile => @my_profile,
                                                      :value => 75.0
                                                      
    expect(@my_profile.weight_goal.value).to be(@expected_weight_goal.value)
  end

  Then('I should see a weight goal widget with the most recent register') do
    widget = find('#widget_lastest_weight')

    expect(widget).to have_content("Weight Goal: #{@expected_weight_goal.value} Kg")
    #expect(widget).to have_content("Registered: #{@expected_weight_goal.date.to_date()}")
  end 