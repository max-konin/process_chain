# frozen_string_literal: true

require 'process_chain/version'

# Base module for process chains
module ProcessChain
  # :nodoc:
  def self.included(base)
    base.send :include, InstanceMethods

    base.instance_eval do
      attr_reader :results
    end
  end

  # :nodoc:
  module InstanceMethods
    # Constructor
    # @param input [Hash] input data for process
    # @param success [true false] result of latest process
    # @raise [ArgumentError] when input is not a Hash
    # @return a new instance of class
    def initialize(input: {}, success: true)
      raise ArgumentError, '"input" should be a Hash' unless input.is_a? Hash
      @success = success
      @results = input
    end

    # @return [true false]
    def success?
      @success
    end

    # Execute passed code block if chain is success
    # @yield code block to be executed on success
    def if_success
      return self unless success?
      yield if success?
    end

    # Execute passed code block if chain is not success
    # @yield code block to be executed on fail
    def if_fail
      return self if success?
      yield
    end

    # Returns a new success instace of chain
    # @param results [Hash] a new input for next process
    def return_success(results = nil)
      self.class.new input: build_new_result(results)
    end

    # Returns a new fail instace of chain
    # @param results [Hash] a new input for next process
    def return_fail(results = nil)
      self.class.new input: build_new_result(results), success: false
    end

    private

    def build_new_result(input)
      input || results.dup
    end
  end
end
