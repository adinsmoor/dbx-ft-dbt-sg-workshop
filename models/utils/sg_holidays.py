import holidays
import pandas

#all python models need to be defined at the start with this specific syntax
def model(dbt, session):

#python models don't use Jinja. Here we are using dbt.config to create model configurations
#be sure to materialize python models as tables, and to specify the packages that were imported above
    dbt.config(
        materialized="table",
        packages=['pandas', 'holidays'],
        submission_method="all_purpose_cluster",
        cluster_id="1115-051524-8826usht"
    )

    sg_holidays = holidays.SG()

#python models don't use Jinja. Here we are using dbt.ref to create model references
    df = dbt.ref('date_spine').to_pandas_on_spark() # Spark 3.2+
# df = orders_df.toPandas() in earlier versions


#when creating a new column, it is recommended that you make it all caps
    df['is_holiday'] = df['date_day'].apply(lambda date: date in sg_holidays)


# convert back to PySpark
    df = df.to_spark()               # Spark 3.2+
    # df = session.createDataFrame(df) in earlier versions


#in dbt, you always need to return your data frame at the end of your models
    return df
