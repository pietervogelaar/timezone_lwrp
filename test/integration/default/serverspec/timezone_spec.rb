require 'serverspec'

# Required by serverspec
set :backend, :exec

def timezone
  command('/bin/date +%Z').stdout.strip
end

describe 'Server timezone' do
  it 'Should be Europe/Moscow' do
    expect(timezone).to eq('MSK')
  end
end
