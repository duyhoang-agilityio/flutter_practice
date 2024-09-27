import 'package:flutter_test/flutter_test.dart';
import 'package:practice_advance/features/home/domain/entities/author.dart';

import '../../../../helper/utils.dart';

class AuthorModelFromJsonScenario extends AgbUTScenario<Author, Author> {
  AuthorModelFromJsonScenario()
      : super(
          description: '''
          Scenario: Test fromJson method for Author model
            Given a JSON map for an author
            When parsing the JSON to create an Author instance
            Then the Author instance should contain the correct properties''',
          when: () async {
            final json = {
              'id': 1,
              'title': 'Author 1',
              'body': 'Description of Author 1',
              'image': 'author1.png',
            };
            return Author.fromJson(json);
          },
          act: (Author author) async {
            return author;
          },
          expect: (Author result) {
            expect(result.name, equals('Author 1'));
            expect(result.desc, equals('Description of Author 1'));
            expect(result.image, equals('author1.png'));
          },
        );
}

class AuthorModelFromJsonListScenario
    extends AgbUTScenario<List<Author>, List<Author>> {
  AuthorModelFromJsonListScenario()
      : super(
          description: '''
          Scenario: Test fromJsonList method for Author model
            Given a JSON list with authors
            When parsing the JSON to create a list of Author instances
            Then the list should contain the correct Author instances''',
          when: () async {
            final json = [
              {
                'id': 1,
                'title': 'Author 1',
                'body': 'Description of Author 1',
                'image': 'author1.png'
              },
              {
                'id': 2,
                'title': 'Author 2',
                'body': 'Description of Author 2',
                'image': 'author2.png'
              },
            ];
            return Author.fromJsonList(json);
          },
          act: (List<Author> authors) async {
            return authors;
          },
          expect: (List<Author> result) {
            expect(result, isA<List<Author>>());
            expect(result.length, equals(2));
            expect(result[0].name, equals('Author 1'));
            expect(result[1].name, equals('Author 2'));
          },
        );
}
