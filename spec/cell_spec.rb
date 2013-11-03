require 'spec_helper'

describe RubyLife::Cell do
  let(:cell) { RubyLife::Cell.new }

  it 'can live and die' do
    cell.live!
    expect(cell.alive?).to be_true
    cell.die!
    expect(cell.alive?).to be_false
  end

  it 'takes an optional status' do
    dead_cell = RubyLife::Cell.new(:dead)
    expect(dead_cell.alive?).to be_false
  end
end

