shared_examples_for "a woocommerce resource" do
  context "class methods" do
    [:all, :find, :create, :count, :size].each do |method|
      it "respond to class method .#{method}" do
        expect(described_class).to respond_to method
      end
    end
  end

  context "instance methods" do
    subject { described_class.new }
    it "respond to instance methods" do
      expect(subject).to respond_to(:assign_attributes)
      expect(subject).to respond_to(:attributes)
      expect(subject).to respond_to(:create)
      expect(subject).to respond_to(:errors)
      expect(subject).to respond_to(:save)
      expect(subject).to respond_to(:update_attributes)
      expect(subject).to respond_to(:valid?)
    end
  end
end
