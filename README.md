# Currency Converter

## Requirements

- Elixir
- Docker

## Setup

1. Install dependencies:

```shell
$ mix deps.get
```

2. Start Postgres with Docker:

```shell
$ docker compose up -d
```

3. Create the database and run migrations:

```shell
$ mix ecto.setup
```

4. Run seeds migrations

```shell
$ mix ecto.seeds
```

5. Start your Phoenix server:

```shell
$ mix phx.server
```

It will be available on [`localhost:10000`](http://localhost:10000)


## Endpoints

| Endpoint                      | Request(Action)  |
| ----------------------------- | ---------------  |
| `v1/api/convert-currency`     | Convert Currency |


# Currency Converter API Documentation 

## Overview

The **Currency Conversion API** provides a straightforward way to convert one currency to another based on mock conversion rates.
Converted Amount will be rounded off to 2 decimal places.

## Method: 
`GET`

## URL:
http://localhost:10000/v1/api/convert-currency


## Query Parameters:
| Parameter         | Type    | Description                                                                 | Required |
|-------------------|---------|-----------------------------------------------------------------------------|----------|
| `from_currency`   | String  | The 3 characters currency code you are converting **from** (e.g., USD, EUR) | Yes      |
| `to_currency`     | String  | The 3 characters currency code you are converting **to** (e.g., INR, GBP).  | Yes      |
| `original_amount` | Decimal | The amount of money to be converted from `from_currency` to `to_currency`.  | Yes      |

## Example Request:

`GET /v1/api/convert-currency?from_currency=USD&to_currency=THB&original_amount=40`


## Success Response:
- **Code**: 200 OK  
- **Content** (example):
  ```json 
  { 
    "data": {
        "to_currency": "THB",
        "original_amount": "40",
        "from_currency": "USD",
        "issued_at": "2024-10-15T16:27:03.689754Z",
        "converted_amount": "1298",
        "exchange_rate": "32.45"
    },
    "success": true
  }

## Response Fields

| Parameter         | Type    | Description                                                                 
|-------------------|---------|-----------------------------------------------------------------------------
| `from_currency`   | String  | The 3 characters currency code you are converting **from** (e.g., USD, EUR) 
| `to_currency`     | String  | The 3 characters currency code you are converting **to** (e.g., INR, GBP).   
| `original_amount` | Decimal | The amount of money to be converted in the `from_currency`.
| `converted_amount`| Decimal | The amount of money converted to `to_currency`.
| `exchange_rate  ` | Decimal | Exchange rate of `from_currency` to `to_currency`.
| `issued_at`       | DateTime| Timestamp of currency conversion.

## API Responses (snapshots)

### Success: 200 OK

![image](https://github.com/user-attachments/assets/68b329ea-92c1-457f-ba9b-e6d873b6d510)



### Bad Request: 400 and returns validation error messages accordingly

- if `from_currency`, `to_currency` and `original_amount` are null

![image](https://github.com/user-attachments/assets/1601d8ff-9f5b-459d-a4d2-bba075fe89fb)


- if `original amount` is null

![image](https://github.com/user-attachments/assets/c85a6a32-f3d2-483c-8402-bdd11ce30364)


- if `from_currency`, `to_currency` are null and `original_amount` is 0

![image](https://github.com/user-attachments/assets/67a6e64c-f6e1-4b6e-bffc-58c768007dcc)

- if `original_amount` is less than 0

<img width="829" alt="Screenshot 2567-10-16 at 00 13 04" src="https://github.com/user-attachments/assets/7c273987-0cd1-47fb-8234-28c0d3920cf9">


- if `from_currency` is not in valid format

![image](https://github.com/user-attachments/assets/6c7379e2-ae80-4089-965f-c07e15c54a0a)

- if `from_currency` and `to_currency` are not in valid format

![image](https://github.com/user-attachments/assets/c0944c36-c668-4f30-83ea-d44bbc930055)


- if `from_currency` and `to_currency` are same

![image](https://github.com/user-attachments/assets/63f179de-d87e-41fa-9bff-174d7b0a0c90)


- if `to_currency` is empty

![image](https://github.com/user-attachments/assets/a0b1c054-dc8a-48dd-9309-60cdc14f616d)


- if `from_currency` is null and `to_currency` is empty

![image](https://github.com/user-attachments/assets/c259aab4-2ec8-412b-9e24-d7abbc51fe45)


- if `to_currency` is more than 3 characters (invalid format)

![image](https://github.com/user-attachments/assets/a53373c2-b8dc-4194-bc9a-341b73fa97ea)


- if `to_currency` is small case 3 characters (invalid format)

![image](https://github.com/user-attachments/assets/e93153e9-bd4d-4e7b-8948-c4cd0d410906)

- if `original_amount` is not decimal

![image](https://github.com/user-attachments/assets/4741b9ef-d457-4100-862a-643536f0bd29)


### Not Found : 404 and returns validation error messages accordingly

- if `to_currency` is unsupported currency

![image](https://github.com/user-attachments/assets/36d08418-63a3-4964-b65b-32ff0af0e40f)



# Unit Tests (Passed)

<img width="336" alt="Screenshot 2567-10-16 at 07 54 35" src="https://github.com/user-attachments/assets/1fa14462-4823-45d7-a6c0-5f47a02e3794">



