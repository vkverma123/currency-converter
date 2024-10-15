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

<img width="839" alt="Screenshot 2567-10-15 at 18 20 50" src="https://github.com/user-attachments/assets/55ec8213-10c8-425e-8524-dc231e329c1c">


### Bad Request: 400 and returns validation error messages accordingly

- if `from_currency`, `to_currency` and `original_amount` are null

<img width="851" alt="Screenshot 2567-10-15 at 18 21 34" src="https://github.com/user-attachments/assets/b923a570-f0aa-4dc0-97b1-ecde19e3b63f">

- if `original amount` is null

<img width="850" alt="Screenshot 2567-10-15 at 18 22 27" src="https://github.com/user-attachments/assets/5803bd52-a18b-4970-b2ac-40ebeb96cf8b">

- if `from_currency`, `to_currency` are null and `original_amount` is 0

<img width="859" alt="Screenshot 2567-10-15 at 18 23 02" src="https://github.com/user-attachments/assets/4e0b5647-f9fc-4670-ac2f-10abbf6fa51c">

- if `original_amount` is less than 0

<img width="867" alt="Screenshot 2567-10-15 at 18 23 25" src="https://github.com/user-attachments/assets/eb6a94b1-44d8-4abd-b28b-897d7e187f72">

- if `from_currency` is not in valid format

<img width="858" alt="Screenshot 2567-10-15 at 22 24 23" src="https://github.com/user-attachments/assets/b5cc8cca-541e-44b1-818e-d1813c1f0177">

- if `from_currency` and `to_currency` are not in valid format

<img width="876" alt="Screenshot 2567-10-15 at 22 26 03" src="https://github.com/user-attachments/assets/9b42a03c-8c40-4659-a63b-45dc5ab5e301">

- if `from_currency` and `to_currency` are same

<img width="863" alt="Screenshot 2567-10-15 at 18 24 30" src="https://github.com/user-attachments/assets/0cf02f67-d2f5-4e18-ba3f-95a67c864bde">

- if `to_currency` is empty

<img width="854" alt="Screenshot 2567-10-15 at 18 25 45" src="https://github.com/user-attachments/assets/b252ab96-46bd-4cbf-90cb-758ecf6c0c60">

- if `from_currency` is null and `to_currency` is empty

<img width="859" alt="Screenshot 2567-10-15 at 18 25 58" src="https://github.com/user-attachments/assets/381a6200-0c44-4578-8190-598c8e759839">

- if `to_currency` is more than 3 characters (invalid format)

<img width="893" alt="Screenshot 2567-10-15 at 22 29 01" src="https://github.com/user-attachments/assets/79fecedf-5841-4b70-b909-e1be90966cfa">


- if `to_currency` is small case 3 characters (invalid format)

<img width="878" alt="Screenshot 2567-10-15 at 22 30 16" src="https://github.com/user-attachments/assets/5ff733cb-122e-430c-b1ce-bca320d418ef">

- if `original_amount` is not decimal

<img width="871" alt="Screenshot 2567-10-15 at 23 29 36" src="https://github.com/user-attachments/assets/2fe04e37-c5db-4b4d-8425-27be4fa24867">


### Not Found : 404 and returns validation error messages accordingly

- if `to_currency` is unsupported currency

<img width="874" alt="Screenshot 2567-10-15 at 18 25 17" src="https://github.com/user-attachments/assets/bf350592-0212-4aa6-af93-01d3beb7e377">


# Unit Tests (Passed)

<img width="383" alt="Screenshot 2567-10-15 at 23 47 32" src="https://github.com/user-attachments/assets/1f64fd8c-2c3d-4187-92d1-366d5ad9128b">



