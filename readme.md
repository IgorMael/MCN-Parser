# MCN Parser

MCN Parser is a Ruby application that allows you to search for cars and retrieve information from the Meu Carro Novo website. It provides a command-line interface to specify search criteria and retrieve car data in JSON format.

## Requirements

- Ruby (version 3.2.2)
- Bundler gem (version 2.4.10)

## Installation

1. Clone the repository:

   ```shell
   git clone https://github.com/your-username/meu-carro-novo.git

  ```

2. Navigate to the project directory:


  ```shell
    cd MCN
  ```

3. Install dependencies:

```shell
    bundle install
```

    Customize the configuration (optional):

    If you want to customize the default configuration options, create a config.yml file in the project directory and specify the desired values. See the "Configuration" section below for more details.

Usage

To search for cars and retrieve the data, use the following command:

shell

./mcn_parser ruby main.rb [options]

Replace [options] with the desired search criteria. The available options are as follows:

    -c, --cidade NOME: Specify the name of the city.
    -e, --uf UF: Specify the UF (state).
    -d, --ddd DDD: Specify the DDD (area code).
    -o, --output FILE: Specify the output file to save the results (default: STDOUT).
    -l, --limite LIMIT: Specify the maximum number of results to retrieve (default: 20). Use 0 to retrieve all results.
    -i, --images DIRECTORY: Specify the directory to save the downloaded car images (default: "images/").

For example, to search for cars in São Paulo with a limit of 10 results and save the output to a file named output.json, use the following command:

shell

ruby main.rb --cidade "São Paulo" --limite 10 --output output.json

Configuration

The application supports customizing the configuration options via a YAML file. To customize the options, follow these steps:

    Create a config.yml file in the project directory.

    Use the following structure in the YAML file:

    yaml

    busca:
      cidade: "Sao Paulo"
      uf: "SP"
      ddd: "11"
      limite: 10
    output: "output.json"
    image_directory: "custom_images/"

    Adjust the values according to your preferences.

    When the application starts, it will attempt to load the configuration from the config.yml file. Any values specified in the YAML file will override the default configuration.

License

This project is licensed under the MIT License.

csharp


Please customize the sections, placeholders, and instructions based on the specifics of