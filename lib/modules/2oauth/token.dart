class Token {
  final String scope;
  final String userId;
  final String teamId;
  final String accessToken;
  final String tokenType;

  Token(this.scope, this.userId, this.teamId, this.accessToken, this.tokenType);
  Token.fromJson(Map<String, dynamic> json)
      : scope = json['scope'],
        userId = json['user_id'],
        teamId = json['team_id'],
        accessToken = json['access_token'],
        tokenType = json['token_type'];

  Map<String, dynamic> toJson() => {
        'scope': scope,
        'user_id': userId,
        'team_id': teamId,
        'access_token': accessToken,
        'token_type': tokenType
      };
}
