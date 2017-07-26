module Bookings
  module Policies
    class CapacityPolicy

      def self.allowed?(assignments, size)
        new(assignments, size).allowed?
      end

      def initialize(assignments, size)
        @assignments = assignments
        @size = size
      end

      def allowed?
        @assignments.any? { |assignment| assignment.num_open >= @size }
      end
    end
  end
end
