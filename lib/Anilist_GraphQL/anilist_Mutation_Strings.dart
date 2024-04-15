const AddAnime = '''
            mutation AddAnime(\$animeId: Int!) {
              SaveMediaListEntry(mediaId: \$animeId, status: PLANNING) {
                id
                status
              }
            }
          ''';
