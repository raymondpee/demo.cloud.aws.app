import pytest
import requests

# Base URL of the API
base_url = 'http://localhost:5000/api'

# Test the GET /api/books endpoint
def test_get_books():
    url = f'{base_url}/books'
    response = requests.get(url)
    assert response.status_code == 200
    assert len(response.json()) > 0

# Test the GET /api/books/<book_id> endpoint
def test_get_book():
    book_id = 1
    url = f'{base_url}/books/{book_id}'
    response = requests.get(url)
    assert response.status_code == 200
    assert response.json()["id"] == book_id

# Test the POST /api/books endpoint
def test_create_book():
    url = f'{base_url}/books'
    data = {
        'title': 'New Book',
        'author': 'New Author'
    }
    response = requests.post(url, json=data)
    assert response.status_code == 201
    assert response.json()["title"] == data["title"]
    assert response.json()["author"] == data["author"]

