# frozen_string_literal: true

module Remap
  class Iteration
    class Other < Concrete
      attribute :value, Types::Any, alias: :other
      attribute :state, Types::State

      using State::Extension

      # @see Base#map
      def call(&block)
        block[other]._
      end
    end
  end
end
