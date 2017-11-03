describe 'Twilio Environment' do
  it 'has a set twilio phone number' do
    expect(ENV['TWILIO_NUMBER']).not_to be_nil
  end

  it 'has a set Account SID' do
    expect(ENV['ACCOUNT_SID']).not_to be_nil
  end

  it 'has a set Auth Token' do
    expect(ENV['AUTH_TOKEN']).not_to be_nil
  end
end