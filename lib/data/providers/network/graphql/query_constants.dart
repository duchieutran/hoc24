// ignore_for_file: constant_identifier_names

const REGISTER_QUERY = """
  mutation RegisterUser(\$formRegisterUser: FormRegisterUser!) {
    registerUser: registerUser(formRegisterUser: \$formRegisterUser) {
      _id
      id
      name
      username
      username_hoc24
      email
      registertime
      tel
      alias
      block
      block_post
      block_course
      block_discuss
      images
    }
  }
""";

const GET_USER_QUERY = """
  query GetUser(\$iduser: String!, \$access_token: String) {
    getUser: getUser(iduser: \$iduser, access_token: \$access_token) {
      _id
      id
      name
      username
      username_hoc24
      email
      registertime
      tel
      alias
      block
      block_post
      block_course
      block_discuss
      images
      grades
      userInfo {
        count_question
        count_answer
        count_follower
        count_following
        score_gp
        score_sp
        count_award
        school
        city
        isFollow
      }
    }
  }
""";

const UPDATE_USER_QUERY = """
  mutation UpdateUser(
  \$formUpdateUser: FormUpdateUser!,
  \$access_token: String!) {
    updateUser: updateUser(
      formUpdateUser: \$formUpdateUser,
      access_token: \$access_token)
  }
""";

const DELETE_ACCOUNT_QUERY = """
  mutation DeleteAccount(\$token: String!, \$access_token: String!) {
    deleteAccount(token: \$token, access_token: \$access_token)
  }
""";

const SEND_EMAIL_FORGET_QUERY = """
  mutation SendMailForgetPassword
    (\$email: String!) {
      sendMailForgetPassword: 
        sendMailForgetPassword(
        email: \$email)
  }
""";

const GET_NOTIFICATION_QUERY = """
  query FetchNoti(\$filter: FilterNoti!,
    \$pagination: Pagination,
    \$access_token: String!,
    \$after: String,
    \$first: Int = 15,
    \$before: String,
    \$last: Int
  ) {
    fetchNoti: 
      fetchNoti(filter: \$filter,
      pagination: \$pagination,
      access_token: \$access_token,
      after: \$after,
      first: \$first,
      before: \$before,
      last: \$last
    ) {
      edges {
        node {
          id
          from_user
          to_user
          content_type
          content_id
          content_pa
          created
          viewed
          other
          url
          id_group
          id_courseware
          info_from_user {
            _id
            name
            images
          }
          info_to_user {
            _id
            name
            images
          }
          info_noti {
            icon
            message
          }        
        }
      }
      pageInfo {
        hasNextPage
        endCursor
      }
    }
  }
""";

const GET_COUNT_NOTIFICATION_QUERY = """
  query CountNoti(
  \$filter: FilterNoti!,
  \$access_token: String!) {
    countNoti: countNoti(
      filter: \$filter,
      access_token: \$access_token)
  }
""";

const UPDATE_NOTIFICATION_QUERY = """
  mutation UpdateNoti(
    \$formUpdateNoti: FormUpdateNoti!,
	  \$access_token: String!
  ) {
    updateNoti: updateNoti(
    formUpdateNoti: \$formUpdateNoti,
    access_token: \$access_token
    )
  }
""";

const GET_CONVERSATION_QUERY = """
  query FetchMessageItem(
  \$filter: FilterMessageItem!,
  \$pagination: Pagination,
  \$access_token: String!,
  \$after: String,
  \$first: Int = 10,
  \$before: String,
  \$last: Int
  ) {
    fetchMessageItem: fetchMessageItem(
      filter: \$filter,
      pagination: \$pagination,
      access_token: \$access_token,
      after: \$after,
      first: \$first,
      before: \$before,
      last: \$last
    ) {
      edges {
        node {
          info_from_user {
            _id
            name
            images
          }
          info_to_user {
            _id
            name
            images
          }
          lastmess
          countmess
          created
          block
        }
      }
      pageInfo {
        hasNextPage
        endCursor
      }
    }
  }
""";

const GET_COUNT_MESSAGE_QUERY = """
  query CountMessage(
    \$filter: FilterMessage!,
	  \$access_token: String!
  ) {
    countMessage: countMessage(
    filter: \$filter,
    access_token: \$access_token) 
  }
""";

const UPDATE_MESSAGE_QUERY = """
  mutation UpdateMessage(
  \$formUpdateMessage: FormUpdateMessage!,
  \$access_token: String!
  ) {
    updateMessage: updateMessage(
      formUpdateMessage: \$formUpdateMessage,
      access_token: \$access_token
    )
  }
""";

const GET_CHAT_QUERY = """
  query FetchMessage(
    \$filter: FilterMessage!,
    \$pagination: Pagination,
    \$access_token: String!,
    \$after: String,
    \$first: Int = 10,
    \$before: String,
    \$last: Int
    ) {
      fetchMessage: fetchMessage(
        filter: \$filter,
        pagination: \$pagination,
        access_token: \$access_token,
        after: \$after,
        first: \$first,
        before: \$before,
        last: \$last
      ) {
        edges {
          node {
            send
            receive
            created
            readed
            content
            senddel
            receivedel
          }
        }
        pageInfo {
          hasNextPage
          endCursor
        }
      }
    }
""";

const SEND_MESSAGE_QUERY = """
  mutation CreateMessage(
    \$formCreateMessage: FormCreateMessage!,
    \$access_token: String!
  ) {
    createMessage: createMessage(
      formCreateMessage: \$formCreateMessage,
      access_token: \$access_token
    ) {
      _id
      send
      receive
      created
      readed
      content
      senddel
      receivedel
    }
  }
""";

const GET_BANNER_QUERY = """
  query Banner {
      banner: banner {
      image
      route
      }
    }
""";

const GET_SUBJECTS_QUERY = """
  query Subjects(
    \$grade: Int,
    \$type_book: EnumTypeBook) {
      subjects: subjects(
        grade: \$grade,
        type_book: \$type_book) {
        id
        name
        alias
        mingrade
        maxgrade
        publish
        old
        new
        books {
        _id
        name
      }  
      }
    }
""";

const GET_BOOKS_QUERY = """
  query Books(
    \$filter: FilterBook!,
    \$grade: Int,
    \$subject: Int,
    \$access_token: String) {
      books: books(
        filter: \$filter,
        access_token: \$access_token) {
          _id
          name
          alias
          grades
          subjects
          info(
            grade: \$grade,
            subject: \$subject) {
              count_chapter
              count_lesson
          }
        }
    }
""";

const GET_CATEGORIES_QUERY = """
  query Categories(
    \$filter: FilterCategory!,
    \$access_token: String) {
      categories: categories(
      filter: \$filter,
      access_token: \$access_token) {
        _id
        id
        id_subject
        title
        id_grade
        id_parent
        order
        count_questions
        count_other
        count_sgk
        file
        status
        sub_cate_university
        refered
        test_id
        video
        listq
        complete
        id_contribute_category
        week
        timed
        typed
        children {
          _id
          id
          title
          typed
          status
          complete
          order
          count_questions
          count_sgk
          count_other
          file
          week
        }
      }
    }
""";

const GET_USER_BOARDS_QUERY = """
  query FetchUserBoards(
    \$filter: FilterUserBoard!, 
    \$pagination: Pagination,
    \$access_token: String,
    \$after: String,
    \$first: Int = 15,
    \$before: String,
    \$last: Int
  ) {
    fetchUserBoards: 
      fetchUserBoards(filter: \$filter,
      pagination: \$pagination,
      access_token: \$access_token,
      after: \$after,
      first: \$first,
      before: \$before,
      last: \$last
    ) {
      edges {
        node {
          id_subject
          sweek
          smonth
          iduser
          sum_all
          typed
          user {
            _id
            id
            name
            username
            username_hoc24
            email
            images
          }
        }
      }
      pageInfo {
        hasNextPage
        endCursor
      }
    }
  }
""";

const GET_EXAMINATION_QUERY = """
  query FetchExamination(
  \$filter: FilterExamination!,
  \$pagination: Pagination,
  \$access_token: String,
  \$after: String,
  \$first: Int = 10,
  \$before: String,
  \$last: Int
  ) {
    fetchExaminations:
      fetchExaminations(
      filter: \$filter,
      pagination: \$pagination,
      access_token: \$access_token,
      after: \$after,
      first: \$first,
      before: \$before,
      last: \$last
    ) {
      edges {
        node {
          id
          title
          id_subject
          id_grade
          time
          created
          modified
          ex_type
          subject {
            name
          } 
          user {
            _id
            name
          }
        }
      }
      pageInfo {
        hasNextPage
        endCursor
      }
    }
  }
""";

const GET_ARTICLE_CATEGORIES_QUERY = """
  query ArticleCategories(
 \$filter: FilterArticleCategory!,
 \$access_token: String,
 \$limit_feature_article: Int!
  ) {
    articleCategories:
    articleCategories(
      filter: \$filter,
      access_token: \$access_token) {
      id
      title
      alias
      description
      feature_article(
      limit: \$limit_feature_article) {
        id
        title
        content
        abs
        author
        created
        id_category
        status
        access
        feature
        public_comment
        thumb
      }
    }
  }
""";

const GET_ARTICLES_QUERY = """
  query fetchArticles(
  \$filter: FilterArticle!,
  \$pagination: Pagination,
  \$access_token: String,
  \$after: String,
  \$first: Int = 10,
  \$before: String,
  \$last: Int
  ) {
    fetchArticles: 
      fetchArticles(filter: \$filter,
      pagination: \$pagination,
      access_token: \$access_token,
      after: \$after,
      first: \$first,
      before: \$before
      last: \$last
    ) {
      edges {
        node {
          id
          title
          content
          abs
          author
          created
          id_category
          status
          access
          feature
          public_comment
          thumb
        }
      }
      pageInfo {
        hasNextPage
        endCursor
      }
    }
  }
""";

const GET_FOLLOWERS_QUERY = """
  query FetchFollow(\$filter: FilterFollow!,
	\$pagination: Pagination,
  \$access_token: String!,
  \$after: String,
  \$first: Int=15,
  \$before: String,
  \$last: Int
  ) {
    fetchFollow: fetchFollow(filter:\$filter,
      pagination: \$pagination,
      access_token: \$access_token,
      after: \$after,
      first: \$first,
      before: \$before,
      last: \$last
    ) {
      edges {
        node {
          id
          user_follower {
            _id
            name
            images
            userInfo {
              isFollow
            }
          }
          user_following {
            _id
            name
            images
            userInfo {
              isFollow
            }
          }
        }
      }
      pageInfo {
        hasNextPage
        endCursor
      }
    }
  }
""";

const FOLLOW_USER_QUERY = """
  mutation FollowUser(\$iduser: String!,
  \$access_token: String!) {
    followUser: followUser(
      iduser: \$iduser,
      access_token: \$access_token
    )
  }
""";
