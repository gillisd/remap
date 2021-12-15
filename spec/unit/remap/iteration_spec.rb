# frozen_string_literal: true

describe Remap::Iteration do
  describe "#call" do
    using Remap::State::Extension
    subject(:iteration) do
      described_class.call(state: state, value: state.value)
    end

    let(:state) { state!(input, fatal_id: :fatal_id) }

    context "when enumerable" do
      context "when hash" do
        subject(:result) do
          iteration.call do |value|
            state.set(value.downcase)
          end
        end

        let(:input) { { one: "ONE", two: "TWO" } }
        let(:output) { input.transform_values(&:downcase) }

        it "invokes block" do
          expect(result).to contain(output)
        end
      end

      context "when not array or hash" do
        subject(:result) do
          iteration.call do |value|
            state.set(value.downcase)
          end
        end

        let(:input) { "value" }
        let(:output) { input.downcase }

        it_behaves_like "a fatal exception" do
          let(:attributes) do
            { value: input }
          end
        end
      end

      context "when array" do
        subject(:result) do
          iteration.call do |value|
            state.set(value.downcase)
          end
        end

        let(:input) { ["ONE", "TWO"] }
        let(:output) { input.map(&:downcase) }

        it "invokes block" do
          expect(result).to contain(output)
        end
      end
    end
  end
end
