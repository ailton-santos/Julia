{
  "nbformat": 4,
  "nbformat_minor": 0,
  "metadata": {
    "colab": {
      "provenance": []
    },
    "kernelspec": {
      "name": "julia",
      "display_name": "Julia"
    },
    "language_info": {
      "name": "julia"
    }
  },
  "cells": [
    {
      "cell_type": "code",
      "source": [
        "#Comando Print\n",
        "println(\"hello world\")"
      ],
      "metadata": {
        "colab": {
          "base_uri": "https://localhost:8080/"
        },
        "id": "tfnuuEkeh-at",
        "outputId": "61b6eef3-8769-478b-e55e-eaf9ab58931e"
      },
      "execution_count": 1,
      "outputs": [
        {
          "output_type": "stream",
          "name": "stdout",
          "text": [
            "hello world\n"
          ]
        }
      ]
    },
    {
      "cell_type": "code",
      "source": [
        "#Definindo as dimensões\n",
        "comprimento = 5.5\n",
        "largura = 3.2"
      ],
      "metadata": {
        "colab": {
          "base_uri": "https://localhost:8080/"
        },
        "id": "4paDBPf80ZMZ",
        "outputId": "538b8e81-50df-4d67-f4ee-cc9b9e9695e7"
      },
      "execution_count": 5,
      "outputs": [
        {
          "output_type": "execute_result",
          "data": {
            "text/plain": [
              "3.2"
            ]
          },
          "metadata": {},
          "execution_count": 5
        }
      ]
    },
    {
      "cell_type": "code",
      "source": [
        "area =comprimento * largura"
      ],
      "metadata": {
        "colab": {
          "base_uri": "https://localhost:8080/"
        },
        "id": "eNPAAYGA0rZE",
        "outputId": "394dd78a-b617-419d-9b21-4b6af05b0551"
      },
      "execution_count": 6,
      "outputs": [
        {
          "output_type": "execute_result",
          "data": {
            "text/plain": [
              "17.6"
            ]
          },
          "metadata": {},
          "execution_count": 6
        }
      ]
    },
    {
      "cell_type": "code",
      "source": [
        "println(\"O comprimento do cômodo é: \", comprimento, \"metros\")\n",
        "println(\"A largura do cômodo é: \", largura, \"metros\")\n",
        "println(\"A Area do cômodo é: \", area, \"metros quadrados\")"
      ],
      "metadata": {
        "colab": {
          "base_uri": "https://localhost:8080/"
        },
        "id": "btFhyodB01h1",
        "outputId": "142cfa1c-9017-4e4b-d273-9cad9ee8599a"
      },
      "execution_count": 8,
      "outputs": [
        {
          "output_type": "stream",
          "name": "stdout",
          "text": [
            "O comprimento do cômodo é: 5.5metros\n",
            "A largura do cômodo é: 3.2metros\n",
            "A Area do cômodo é: 17.6metros quadrados\n"
          ]
        }
      ]
    },
    {
      "cell_type": "code",
      "source": [
        "# function to calculate the volume of a sphere\n",
        "function sphere_vol(r)\n",
        "    # julia allows Unicode names (in UTF-8 encoding)\n",
        "    # so either \"pi\" or the symbol π can be used\n",
        "    return 4/3*pi*r^3\n",
        "end\n",
        "\n",
        "# functions can also be defined more succinctly\n",
        "quadratic(a, sqr_term, b) = (-b + sqr_term) / 2a\n",
        "\n",
        "# calculates x for 0 = a*x^2+b*x+c, arguments types can be defined in function definitions\n",
        "function quadratic2(a::Float64, b::Float64, c::Float64)\n",
        "    # unlike other languages 2a is equivalent to 2*a\n",
        "    # a^2 is used instead of a**2 or pow(a,2)\n",
        "    sqr_term = sqrt(b^2-4a*c)\n",
        "    r1 = quadratic(a, sqr_term, b)\n",
        "    r2 = quadratic(a, -sqr_term, b)\n",
        "    # multiple values can be returned from a function using tuples\n",
        "    # if the return keyword is omitted, the last term is returned\n",
        "    r1, r2\n",
        "end\n",
        "\n",
        "vol = sphere_vol(3)\n",
        "\n",
        "using Printf\n",
        "@printf \"volume = %0.3f\\n\" vol\n",
        "#> volume = 113.097\n",
        "\n",
        "quad1, quad2 = quadratic2(2.0, -2.0, -12.0)\n",
        "println(\"result 1: \", quad1)\n",
        "#> result 1: 3.0\n",
        "println(\"result 2: \", quad2)\n",
        "#> result 2: -2.0"
      ],
      "metadata": {
        "colab": {
          "base_uri": "https://localhost:8080/"
        },
        "id": "JKBEP6uQy9Uw",
        "outputId": "36170870-4976-4453-a286-62a99656833f"
      },
      "execution_count": 2,
      "outputs": [
        {
          "output_type": "stream",
          "name": "stdout",
          "text": [
            "volume = 113.097\n",
            "result 1: 3.0\n",
            "result 2: -2.0\n"
          ]
        }
      ]
    },
    {
      "cell_type": "code",
      "source": [],
      "metadata": {
        "id": "5qQak3ryzLl6"
      },
      "execution_count": null,
      "outputs": []
    }
  ]
}