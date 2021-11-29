# frozen_string_literal: true

describe Remap::State::Extensions::Array do
  using described_class

  describe "#get" do
    subject(:result) { receiver.get(*path) }

    context "when path is empty" do
      let(:path) { [] }
      let(:receiver) { [] }

      it "throws a symbol" do
        expect { result }.to throw_symbol(:missing, [])
      end
    end

    context "when empty" do
      let(:receiver) { [] }
      let(:path) { [0] }

      it "throws a symbol" do
        expect { result }.to throw_symbol(:missing, [0])
      end
    end

    context "when not empty" do
      context "when value exists" do
        let(:receiver) { ["value"] }
        let(:path) { [0] }

        it { is_expected.to eq("value") }
      end

      context "when value does not exist" do
        let(:receiver) { [["value"]] }
        let(:path) { [0, 1] }

        it "throws a symbol" do
          expect { result }.to throw_symbol(:missing, [0, 1])
        end
      end
    end
  end
end