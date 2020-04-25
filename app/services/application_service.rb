class ApplicationService
  attr_reader :args

  def self.call(*args, &block)
    new(*args, &block).call
  end
end
