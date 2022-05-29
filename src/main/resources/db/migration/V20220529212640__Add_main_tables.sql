create sequence seq_graph_id;
create table graph
(
    graph_id numeric primary key default nextval('seq_graph_id'),
    category varchar(100) not null,
    theme    varchar(100) not null
);

create sequence seq_node_id;
create table node
(
    node_id numeric primary key default nextval('seq_node_id'),
    name    varchar(100) not null
);

create sequence seq_graph_node_id;
create table graph_node
(
    graph_node_id numeric primary key default nextval('seq_graph_node_id'),
    graph_id      numeric
        constraint fk_graph_node_graph_id references graph (graph_id),
    node_id       numeric
        constraint fk_graph_node_node_id references node (node_id)
);

create sequence seq_graph_path_id;
create table graph_path
(
    graph_path_id        numeric primary key default nextval('seq_graph_path_id'),
    parent_graph_node_id numeric
        constraint fk_graph_path_parent_graph_node_id references graph_node (graph_node_id),
    child_graph_node_id  numeric
        constraint fk_graph_path_child_graph_node_id references graph_node (graph_node_id)
);

create sequence seq_question_task_id;
create table question_task
(
    question_task_id numeric primary key default nextval('seq_question_task_id'),
    graph_path_id    numeric
        constraint fk_question_task_graph_path_id references graph_path (graph_path_id),
    task_name        text not null,
    task_text        text not null,
    right_answer     text
);

create sequence seq_user_account_id;
create table user_account
(
    user_account_id  numeric primary key default nextval('seq_user_account_id'),
    login    varchar(100) not null,
    password varchar(100) not null
);

create sequence seq_user_task_id;
create table user_task
(
    user_task_id numeric primary key default nextval('seq_user_task_id'),
    question_task_id numeric constraint fk_user_task_question_task_id references question_task(question_task_id),
    user_account_id numeric constraint fk_user_task_user_account_id references user_account(user_account_id),
    user_answer text,
    is_right boolean default false
);