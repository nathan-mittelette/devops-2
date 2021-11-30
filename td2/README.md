## Create Index

```json
PUT /recipes
{
  "mappings": {
    "properties": {
      "name": { "type": "keyword" },
      "ingredients": {"type": "text"},
      "kitchen_tools": {"type": "text"},
      "preparation_time": {"type": "integer"},
      "cook_time": {"type": "integer"}
    }
  }
}
```

## Put data

```json
POST recipes/_doc
{
  "name": "Poulet au curry",
  "ingredients": [
    "blanc de poulet",
    "curry",
    "oignons",
    "poivre",
    "crème fraîche",
    "sel"
  ],
  "kitchen_tools": [
    "poêle",
    "couteau"
  ],
  "preparation_time": 5,
  "cook_time": 15
}
```

## Put many data

```json
POST recipes/_bulk
{"create":{}}
{"name":"Pâtes à la sauce tomate","ingredients":["pâtes","sauce tomate","sel"],"kitchen_tools":["pan"],"preparation_time":1,"cook_time":10}
{"create":{}}
{"name":"Boeuf bourguignon","ingredients":["boeuf","carottes","farine","bouillon","oignons","champignons","vin rouge","sel","poivre"],"kitchen_tools":["pressure cooker","knife"],"preparation_time":25,"cook_time":180}
```

## Query all

```json
GET recipes/_search
{
  "query": {
    "match_all": {}
  }
}
```

## Get recipes with filter

```json
GET recipes/_search
{
  "query": {
    "match": {
      "ingredients": "poivre"
    }
  },
  "_source": false,
  "fields": [
    "name"
  ]
}
```

## Get recipes by time 

```json
GET recipes/_search
{
  "query": {
    "bool": {
      "must": [
        {
          "range": {
            "preparation_time": {
              "gte": 1,
              "lte": 15
            }
          }
        },
        {
          "range": {
            "cook_time": {
              "gte": 5,
              "lte": 10
            }
          }
        }
      ]
    }
  },
  "_source": false,
  "fields": [
    "name"
  ]
}
```