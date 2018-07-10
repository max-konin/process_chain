# frozen_string_literal: true

RSpec.describe ProcessChain do
  it 'has a version number' do
    expect(ProcessChain::VERSION).not_to be nil
  end

  class TestProcessChain
    include ProcessChain

    def validate_user
      if_success do
        if results.user[:name].nil?
          return_fail errors: { name: 'can not be blank' }, user: results.user
        else
          return_success
        end
      end
    end

    def save_user
      user = results.user
      if_success do
        user.is_saved = true
        return_success user: user
      end
      if_fail do
        user.is_saved = false
        return_fail user: user
      end
    end
  end

  describe '#success?' do
    subject { TestProcessChain.new success: success }
    context 'when pass success? to constructor as true' do
      let(:success) { true }
      it { is_expected.to be_success }
    end

    context 'when pass success? to constructor as false' do
      let(:success) { false }
      it { is_expected.not_to be_success }
    end
  end

  describe '#if_success' do
    let(:process) { TestProcessChain.new success: success }
    before { @do_smth = false }

    subject { process.if_success { @do_smth = true } }

    context 'when pass success? to constructor as true' do
      let(:success) { true }
      it { expect { subject }.to change { @do_smth }.to true }
    end

    context 'when pass success? to constructor as false' do
      let(:success) { false }
      it { expect { subject }.not_to(change { @do_smth }) }
    end
  end

  describe '#if_fail' do
    let(:process) { TestProcessChain.new success: success }
    before { @do_smth = false }

    subject { process.if_fail { @do_smth = true } }

    context 'when pass success? to constructor as true' do
      let(:success) { true }
      it { expect { subject }.not_to(change { @do_smth }) }
    end

    context 'when pass success? to constructor as false' do
      let(:success) { false }
      it { expect { subject }.to change { @do_smth }.to true }
    end
  end

  describe '#return_success' do
    let(:process) { TestProcessChain.new }
    let(:new_result) { { 'user_id' => 1 } }
    subject { process.return_success new_result }

    it { is_expected.to be_a TestProcessChain }
    it { is_expected.to be_success }
    it { expect(subject.results).to eq new_result }
  end

  describe '#return_fail' do
    let(:process) { TestProcessChain.new }
    let(:new_result) { { 'user_id' => 1 } }
    subject { process.return_fail new_result }

    it { is_expected.to be_a TestProcessChain }
    it { is_expected.not_to be_success }
    it { expect(subject.results).to eq new_result }
  end

  describe 'chaining' do
    let(:process) { TestProcessChain.new input: { user: user } }
    subject do
      process.validate_user
             .save_user
    end
    context 'when user is valid' do
      let(:user) { { name: 'John' } }

      it { is_expected.to be_a TestProcessChain }
      it { is_expected.to be_success }
      it { expect(subject.results.user[:is_saved]).to be_truthy }
    end
    context 'when user is not valid' do
      let(:user) { {} }

      it { is_expected.to be_a TestProcessChain }
      it { is_expected.not_to be_success }
      it { expect(subject.results.user[:is_saved]).to be_falsey }
    end
  end
end
