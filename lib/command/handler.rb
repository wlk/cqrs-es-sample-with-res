module Command
  class Handler
    def initialize(repository:, **_)
      @repository = repository
    end

    protected
    def with_aggregate(aggregate_id)
      aggregate = build(aggregate_id)
      yield aggregate
      repository.store(aggregate)
    end

    private
    attr_accessor :repository

    def build(aggregate_id)
      aggregate_class.new(aggregate_id).tap do |aggregate|
        repository.load(aggregate)
      end
    end
  end
end
