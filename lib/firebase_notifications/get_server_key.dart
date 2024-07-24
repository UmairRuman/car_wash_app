import 'package:googleapis_auth/auth_io.dart';

class GetServiceKey {
  Future<String> getServiceKeyTokken() async {
    final scopes = [
      "https://www.googleapis.com/auth/userinfo.email",
      "https://www.googleapis.com/auth/firebase.database",
      "https://www.googleapis.com/auth/firebase.messaging",
    ];

    final client = await clientViaServiceAccount(
        ServiceAccountCredentials.fromJson({
          "type": "service_account",
          "project_id": "car-wash-app-86a16",
          "private_key_id": "7ee6881627ab67e35a34640f7749bf07d3bcf845",
          "private_key":
              "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQCvJtUQgeTbWKzM\n3DERUC6WjqzW3ln+9/tfSM3y7KgIHEHxHJZNtchY1PHdO5V9+ypsS07AKS76TK6U\nEmZGKBavg9K1ofLIKO2pgX5+3eykN/rRvX7XRulZ9KytTi2N0nIaTE/ebBcJLQjO\nV/yDimtS54UD0X2CnpCl2C9AsvTIDLmfy6534+Te2yENJqpZSI8rHHKwZ5tHBmjv\nIFYqiBuVDSVe1bdTg1ACcKTkV38T8Av7qaGNr4i8mP1eCihXTx5anZAKoV7xNXlM\nmRm3tOcEBWnqCiyPRAx0VSfoJjAGazPvDv1KQvxkjjZJ/KK66r47RZak31MUyTgE\nYWjXG3ZxAgMBAAECggEAAjFH38DmgN3pbNeRSCyTJriSvo5SPVQ0mfbe+BxhBpf2\n9doUIhUlVMJWpDyxlH4DRA+FxPdHAqRY15rq25Q3I3uQlMw6Diof/nwT3anww0X9\nnmhDORXmyCTdT/6PaKvymHRt2ASNncRp7K5Sh4GBMiyagEecLPlH6YGNJt/Om13z\nFgl7i0bsn+jmT0dF5p+q5dzEwBAN5Mu0c8+gFSPoAjG/ooLqZ4PY98QGxkR4Lkc5\nB6I3ftscAmkh+efcXXBc5LcrAmhD0eL5MrLSq+Tf1qxbZPvaVFRZaeqN9a77RDTd\nzEiHM+SJUtyKDGc1DIhyiJx43xceHSZiPRvOHUhfeQKBgQDo/wHahh+9NPS6tRsi\nBfi+7b2Qcyj3wS21N/LgJfzhuXtfpzVfZLGRA1nKQuaIMIoyacByETsZxFBdLIdb\n3f8aiCOjhX6a+n9Sjfm9WCNPBuQjTZVw4c0yWVLQhcn2RW93p8jCEG3/yEcfbdbj\nACAe6vAQpaufK5oOM/DgXrtTyQKBgQDAcc2WE7Y4pPBHKUAYrpDUo1wePrW9RmQc\nrVzZIOez/qxPpC9yIL9DJ4B4oelG2jjva1+bqur6N4wGft9uzbrKB22RELGTWnAR\ntJddtbhLK4aX/U9iVa7KG6Slto4Ded84Y7mx8pIF4woSeF3u7j4FnBU+/EemQMsv\nbvzPH2fRaQKBgQCfG9VWNxVhjdI51gcrWsydBZjYFew6FE90WzqeWxKvyow3q+XE\nuOyRTKp6dukaw5r8Bj+HJcEoPWlr10awM49LvQApYLYuezWLWKzc4l1qUBhnC0os\nBeaspVbqUxKx/IS8P3XXIIUdkNUQ319JMQK+Wk2J8LicP5g6brnlXouqEQKBgFoh\ncq4FUWS6KybI9RIaQA6269/mcuvQ2fZsY3314U71yfIK7YXAPJPRHmRhQIZEkkHf\nwgmARUknVtd7+F1G0WLpk7FLZj+jLbW9JN9oyoW6PvFUXCesBY7232gVVfHe1GLu\nofvrpeRH72GzKhtLTZUHAxRax5vf4Mm4a4L+LHtxAoGAXfmvsKK5Grivb9deHSlY\ng8AS6tOWNitW/4cdivBktPA/H4gLMx2WPruIm0UG58LJSotGVq/RTjiZLv4GZXJE\n1pAI2rt/98PKY2o8zrxgu8JlrukHPZB5R8sooRf3D83OARYJzxRXEIkioI6gmS+J\nCvG5dAVod4RSxiVVRTAiIxc=\n-----END PRIVATE KEY-----\n",
          "client_email":
              "firebase-adminsdk-zu88h@car-wash-app-86a16.iam.gserviceaccount.com",
          "client_id": "110869417638692686348",
          "auth_uri": "https://accounts.google.com/o/oauth2/auth",
          "token_uri": "https://oauth2.googleapis.com/token",
          "auth_provider_x509_cert_url":
              "https://www.googleapis.com/oauth2/v1/certs",
          "client_x509_cert_url":
              "https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-zu88h%40car-wash-app-86a16.iam.gserviceaccount.com",
          "universe_domain": "googleapis.com"
        }),
        scopes);
    final accesServerKey = client.credentials.accessToken.data;
    return accesServerKey;
  }
}
