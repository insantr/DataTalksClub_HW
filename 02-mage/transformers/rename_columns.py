import re

if 'transformer' not in globals():
    from mage_ai.data_preparation.decorators import transformer
if 'test' not in globals():
    from mage_ai.data_preparation.decorators import test


@transformer
def transform(data, *args, **kwargs):
    """
    Rename columns in Camel Case to Snake Case, e.g. VendorID to vendor_id.
    """
    original_columns = data.columns.copy()
    data.columns = (data.columns
                    .str.replace('(?<=[a-z])(?=[A-Z])', '_', regex=True)
                    .str.lower()
                    )
    changed_columns_count = sum(original != changed for original, changed in zip(original_columns, data.columns))
    print(f"Number of changed columns: {changed_columns_count}")

    unique_vendor_ids = data['vendor_id'].unique()
    print(f"Existing values of VendorID: {unique_vendor_ids}")
    
    return data


@test
def test_output(output, *args) -> None:
    """
    Template code for testing the output of the block.
    """
    assert 'vendor_id' in output.columns, f"'vendor_id' column is not present (present: {output.columns})"
