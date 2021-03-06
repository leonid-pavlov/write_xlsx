# -*- coding: utf-8 -*-
require 'helper'

class TestRegressionComment10 < Test::Unit::TestCase
  def setup
    setup_dir_var
  end

  def teardown
    File.delete(@xlsx) if File.exist?(@xlsx)
  end

  def test_comment10
    @xlsx = 'comment10.xlsx'
    workbook  = WriteXLSX.new(@xlsx)
    worksheet = workbook.add_worksheet

    worksheet.write('A1', 'Foo')
    worksheet.write_comment('B2', 'Some text', :color => 51)

    # Set the author to match the target XLSX file.
    worksheet.comments_author = 'John'

    workbook.close
    compare_xlsx_for_regression(
                                File.join(@regression_output, @xlsx),
                                @xlsx,
                                nil,
                                { 'xl/workbook.xml' => ['<workbookView'] })
  end
end
