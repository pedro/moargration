require "./test/test_helper"

describe Moargration do
  describe "parse_ignore_definition" do
    it "reads a table with a simple field" do
      Moargration.parse("table:field").must_equal("table" => %w( field ))
    end

    it "reads a table with multiple fields" do
      Moargration.parse("table:f1,f2").must_equal("table" => %w( f1 f2 ))
    end

    it "reads multiple tables" do
      Moargration.parse("t1:f1,f2 t2:f1").must_equal("t1" => %w( f1 f2 ), "t2" => %w( f1 ))
    end

    it "ignores tables without fields" do
      Moargration.parse("t1:f1 t2 t3:f1").must_equal("t1" => %w( f1 ), "t3" => %w( f1 ))
    end
  end

  describe "hack_active_record" do
    it "hacks the model to ignore the specified columns" do
      Moargration.columns_to_ignore = { "samples" => %w( f1 ) }
      Sample.columns.map(&:name).wont_include("f1")
    end

    it "doesn't affect other models" do
      Moargration.columns_to_ignore = { "samples" => %w( f1 ) }
      User.columns.map(&:name).must_include("f1")
    end
  end
end
