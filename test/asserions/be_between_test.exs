defmodule BeBetweenTest do

  use ExUnit.Case

  defmodule SomeSpec do
    use ESpec
    context "Success" do
      it do: expect(1+1).to be_between(1, 3)
      it do: expect(1+1).to_not be_between(3, 5)
    end

    context "Errors" do
      it do: expect(1+1).to be_between(3, 5)
      it do: expect(1+1).to_not be_between(1,3)
    end
  end

  setup_all do
    examples = ESpec.Runner.run_examples(SomeSpec.examples, SomeSpec)
    { :ok,
      success: Enum.slice(examples, 0, 1),
      errors: Enum.slice(examples, 2, 3)
    }
  end

  test "Success", context do
    Enum.each(context[:success], fn(ex) ->
      assert(ex.success == true)
    end)
  end

  test "Errors", context do
    Enum.each(context[:errors], fn(ex) ->
      assert(ex.success == false)
    end)
  end

end