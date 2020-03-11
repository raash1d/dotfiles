initmlproject() {
    # ├── README.md          <- The top-level README for developers.
    # ├── conf               <- Space for credentials
    # │
    # ├── data
    # │   ├── 01_raw         <- Immutable input data
    # │   ├── 02_intermediate<- Cleaned version of raw
    # │   ├── 03_processed   <- Data used to develop models
    # │   ├── 04_models      <- trained models
    # │   ├── 05_model_output<- model output
    # │   └── 06_reporting   <- Reports and input to frontend
    # │
    # ├── docs               <- Space for Sphinx documentation
    # │
    # ├── notebooks          <- Jupyter notebooks. Naming convention is
    # |                         date YYYYMMDD (for ordering),
    # │                         the creator's initials, and a short `-` 
    # |                         delimited description.
    # │
    # ├── references         <- Data dictionaries, manuals, etc. 
    # │
    # ├── results            <- Final analysis docs.
    # │
    # ├── requirements.txt   <- The requirements file for reproducing the 
    # |                         analysis environment.
    # │
    # ├── .gitignore         <- Avoids uploading data, credentials, 
    # |                         outputs, system files etc
    # │
    # └── src                <- Source code for use in this project.
    #     ├── __init__.py    <- Makes src a Python module
    #     │
    #     ├── d00_utils      <- Functions used across the project
    #     │   └── remove_accents.py
    #     │
    #     ├── d01_data       <- Scripts to reading and writing data etc
    #     │   └── load_data.py
    #     │
    #     ├── d02_intermediate<- Scripts to transform data from raw to 
    #     |   |                  intermediate
    #     │   └── create_int_payment_data.py
    #     │
    #     ├── d03_processing <- Scripts to turn intermediate data into 
    #     |   |                 modelling input
    #     │   └── create_master_table.py
    #     │
    #     ├── d04_modelling  <- Scripts to train models and then use 
    #     |   |                  trained models to make predictions. 
    #     │   └── train_model.py
    #     │
    #     ├── d05_model_evaluation<- Scripts that analyse model 
    #     |   |                      performance and model selection.
    #     │   └── calculate_performance_metrics.py
    #     │    
    #     ├── d06_reporting  <- Scripts to produce reporting tables
    #     │   └── create_rpt_payment_summary.py
    #     │
    #     └── d07_visualisation<- Scripts to create frequently used plots
    #         └── visualise_patient_journey.py

    touch README.md
    touch LICENSE

    mkdir conf
    touch conf/config.yml

    mkdir data
    cd data
        mkdir 01_raw
        mkdir 02_intermediate
        mkdir 03_processed
        mkdir 04_models
        mkdir 05_model_output
        mkdir 06_reporting
    cd ..

    mkdir docs
    mkdir notebooks
    mkdir references
    mkdir results

    touch requirements.txt
    touch .gitignore

    mkdir src
    cd src
        touch __init__.py
        mkdir d00_utils
        mkdir d01_data
        mkdir d02_intermediate
        mkdir d03_processing
        mkdir d04_modelling
        mkdir d06_reporting
        mkdir d07_visualisation
    cd ..

    mkdir tests
    cd tests
        touch __init__.py
        mkdir d00_utils
        mkdir d01_data
        mkdir d02_intermediate
        mkdir d03_processing
        mkdir d04_modelling
        mkdir d06_reporting
    cd ..
}

initpysimpleproject() {
    # helloworld/
    # │
    # ├── .gitignore
    # ├── helloworld.py
    # ├── LICENSE
    # ├── README.md
    # ├── requirements.txt
    # ├── setup.py
    # └── tests.py


    touch .gitignore
    touch "${PWD##*/}.py" # to get current folder name
    touch LICENSE
    touch README.md
    touch requirements.txt
    touch setup.py
    touch tests.py
}

initpysinglepackageproject() {
    # helloworld/
    # │
    # ├── helloworld/
    # │   ├── __init__.py
    # │   ├── helloworld.py
    # │   └── helpers.py
    # │
    # ├── tests/
    # │   ├── helloworld_tests.py
    # │   └── helpers_tests.py
    # │
    # ├── .gitignore
    # ├── LICENSE
    # ├── README.md
    # ├── requirements.txt
    # └── setup.py

    mkdir src
    cd src
        touch __init__.py
        touch "${PWD##*/}.py" # to get current folder name
        touch helpers.py
    cd ..

    mkdir tests
    cd tests
        touch "${PWD##*/}_tests.py"
        touch helpers_tests.py
    cd ..

    touch .gitignore
    touch LICENSE
    touch README.md
    touch requirements.txt
    touch setup.py
}

initpyproject() {
    # helloworld/
    # │
    # ├── bin/
    # │
    # ├── docs/
    # │   ├── hello.md
    # │   └── world.md
    # │
    # ├── helloworld/
    # │   ├── __init__.py
    # │   ├── runner.py
    # │   ├── hello/
    # │   │   ├── __init__.py
    # │   │   ├── hello.py
    # │   │   └── helpers.py
    # │   │
    # │   └── world/
    # │       ├── __init__.py
    # │       ├── helpers.py
    # │       └── world.py
    # │
    # ├── data/
    # │   ├── input.csv
    # │   └── output.xlsx
    # │
    # ├── tests/
    # │   ├── hello
    # │   │   ├── helpers_tests.py
    # │   │   └── hello_tests.py
    # │   │
    # │   └── world/
    # │       ├── helpers_tests.py
    # │       └── world_tests.py
    # │
    # ├── .gitignore
    # ├── LICENSE
    # └── README.md

    mkdir bin
    mkdir docs

    mkdir src
    cd src
        touch __init__.py
        touch runner.py

        mkdir hello
        cd hello
            touch __init__.py
            touch hello.py
            touch helpers.py
        cd ..

        mkdir world
        cd world
            touch __init__.py
            touch world.py
            touch helpers.py
        cd ..
    cd ..

    mkdir data
    touch data/input.csv
    touch data/output.csv

    mkdir tests
    cd tests
        mkdir hello
        touch hello/hello_tests.py
        touch hello/helpers_tests.py

        mkdir world
        touch world/world_tests.py
        touch world/helpers_tests.py
    cd ..

    touch .gitignore
    touch LICENSE
    touch README.md
}

initdjangoproject() {
    # project/
    # │
    # ├── app/
    # │   ├── __init__.py
    # │   ├── admin.py
    # │   ├── apps.py
    # │   │
    # │   ├── migrations/
    # │   │   └── __init__.py
    # │   │
    # │   ├── models.py
    # │   ├── tests.py
    # │   └── views.py
    # │
    # ├── docs/
    # │
    # ├── project/
    # │   ├── __init__.py
    # │   ├── settings.py
    # │   ├── urls.py
    # │   └── wsgi.py
    # │
    # ├── static/
    # │   └── style.css
    # │
    # ├── templates/
    # │   └── base.html
    # │
    # ├── .gitignore
    # ├── manage.py
    # ├── LICENSE
    # └── README.md

    mkdir app
    cd app
        touch __init__.py
        touch admin.py
        touch apps.py
        touch models.py
        touch tests.py
        touch views.py

        mkdir migrations
        touch migrations/__init__.py
    cd ..

    mkdir docs

    mkdir project
    cd project
        touch __init__.py
        touch settings.py
        touch urls.py
        touch wsgi.py
    cd ..

    mkdir static
    touch static/style.css

    mkdir templates
    touch templates/base.html

    touch .gitignore
    touch manage.py
    touch LICENSE
    touch README.md
}

initflaskproject() {
    # flaskr/
    # │
    # ├── flaskr/
    # │   ├── ___init__.py
    # │   ├── db.py
    # │   ├── schema.sql
    # │   ├── auth.py
    # │   ├── blog.py
    # │   ├── templates/
    # │   │   ├── base.html
    # │   │   ├── auth/
    # │   │   │   ├── login.html
    # │   │   │   └── register.html
    # │   │   │
    # │   │   └── blog/
    # │   │       ├── create.html
    # │   │       ├── index.html
    # │   │       └── update.html
    # │   │ 
    # │   └── static/
    # │       └── style.css
    # │
    # ├── tests/
    # │   ├── conftest.py
    # │   ├── data.sql
    # │   ├── test_factory.py
    # │   ├── test_db.py
    # │   ├── test_auth.py
    # │   └── test_blog.py
    # │
    # ├── venv/
    # │
    # ├── .gitignore
    # ├── setup.py
    # └── MANIFEST.in

    mkdir "${PWD##*/}" # to get current folder name
    cd "${PWD##*/}"
        touch __init__.py
        touch db.py
        touch schema.sql
        touch auth.py
        touch blog.py

        mkdir templates
        cd templates
            touch base.html
            mkdir auth
            cd auth
                touch login.html
                touch register.html
            cd ..

            mkdir blog
            cd blog
                touch create.html
                touch index.html
                touch update.html
            cd ..
        cd ..

        mkdir static
        touch static/style.css
    cd ..

    mkdir tests
    cd tests
        touch conftest.py
        touch data.sql
        touch test_factory.py
        touch test_db.py
        touch test_auth.py
        touch test_blog.py
    cd ..

    mkdir venv

    touch .gitignore
    touch setup.py
    touch MANIFEST.in
}

initproject() {
    case "$1" in
    py)
        case $2 in
        ml)
            echo -n "Creating ML project structure..."
            initmlproject
            echo "done."
            ;;
        simple)
            echo -n "Creating simple python project structure..."
            initpysimpleproject
            echo "done."
            ;;
        singlepackage) 
            echo -n "Creating single package python project structure..."
            initpysinglepackageproject
            echo "done."
            ;;
        project)
            echo -n "Creating full python project structure..."
            initpyproject
            echo "done."
            ;;
        *)
            echo "Usage: $0 $1 <ml | simple | singlepackage | project>"
            ;;
        esac
        ;;
    web)
        case $2 in
        django)
            echo -n "Creating Django project..."
            initdjangoproject
            echo "done."
            ;;
        flask)
            echo -n "Creating Flask project..."
            initflaskproject
            echo "done."
            ;;
        *)
            echo "Usage: $0 $1 <django | flask>"
            ;;
        esac
        ;;
    *)
        echo "Usage: $0 <py|c|cpp|js|web|help>"
        ;;
    esac
}