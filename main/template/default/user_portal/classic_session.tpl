{% set session_image = 'window_list.png'|img(32, row.title) %}

{% for row in session %}
    <div class="panel panel-default">
        {% if not row.show_simple_session_info %}
            {% set collapsable = '' %}
            {% if row.course_list_session_style %} {# If not style then no show header #}
                <div class="panel-heading">
                    {% if row.course_list_session_style == 1 or row.course_list_session_style == 2 %} {# Session link #}
                        {% if remove_session_url == true %}
                            {{ session_image }} {{ row.title }}
                        {% else %}
                            {# Default link #}
                            {% set session_link = _p.web_main ~ 'session/index.php?session_id=' ~ row.id %}

                            {% if row.course_list_session_style == 2 and row.courses|length == 1 %}
                                {# Linkt to first course #}
                                {% set session_link = row.courses.0.link %}
                            {% endif %}

                            <a href="{{ session_link }}">
                                {{ session_image }} {{ row.title }}
                            </a>
                        {% endif %}
                    {% elseif row.course_list_session_style == 3 %} {# Collapsible panel #}
                        {# Foldable #}
                        <a role="button" data-toggle="collapse" data-parent="#page-content" href="#collapse_{{ row.id }}"
                           aria-expanded="false">
                            {{ session_image }} {{ row.title }}
                        </a>
                        {% set collapsable = 'collapse' %}
                    {% endif %}
                    {% if row.show_actions %}
                        <div class="pull-right">
                            <a href="{{ _p.web_main ~ "session/resume_session.php?id_session=" ~ row.id }}">
                                <img src="{{ "edit.png"|icon(22) }}" width="22" height="22" alt="{{ "Edit"|get_lang }}"
                                     title="{{ "Edit"|get_lang }}">
                            </a>
                        </div>
                    {% endif %}
                </div>
            {% endif %}
            <div class="session panel-body {{ collapsable }}" id="collapse_{{ row.id }}">
                <div class="row">
                    <div class="col-md-12">
                        {% if row.show_description %}
                            {{ row.description }}
                        {% endif %}
                        <ul class="info-session list-inline">
                            {% if row.coach_name %}
                                <li>
                                    <i class="fa fa-user" aria-hidden="true"></i>
                                    {{ row.coach_name }}
                                </li>
                            {% endif %}

                            {% if row.date %}
                                <li>
                                    <i class="fa fa-calendar" aria-hidden="true"></i>
                                    {{ row.date }}
                                </li>
                            {% elseif row.duration %}
                                <li>
                                    <i class="fa fa-calendar" aria-hidden="true"></i>
                                    {{ row.duration }}
                                </li>
                            {% endif %}
                        </ul>
                        <div class="sessions-items">
                        {% for item in row.courses %}
                            <div class="courses">
                                <div class="row">
                                    <div class="col-md-2">
                                        <a href="{{ item.link }}" class="thumbnail">
                                            <img class="img-responsive"
                                                 src="{{ item.thumbnails ? item.thumbnails : item.icon }}">
                                        </a>
                                    </div>
                                    <div class="col-md-10">
                                        <h4>{{ item.title }}</h4>
                                        <div class="list-teachers">
                                            {% if item.coaches|length > 0 %}
                                                <img src="{{ 'teacher.png'|icon(16) }}" width="16" height="16">
                                                {% for coach in item.coaches %}
                                                    {{ loop.index > 1 ? ' | ' }}
                                                    <a href="{{ _p.web_ajax ~ 'user_manager.ajax.php?' ~ {'a': 'get_user_popup', 'user_id': coach.user_id, 'session_id': row.id, 'course_id': item.real_id }|url_encode() }}"
                                                       data-title="{{ coach.full_name }}" class="ajax">
                                                        {{ coach.firstname }}, {{ coach.lastname }}
                                                    </a>
                                                {% endfor %}
                                            {% endif %}
                                        </div>
                                    </div>

                                    {% if item.student_info %}
                                        {% if item.student_info.progress is not null or item.student_info.score is not null or item.student_info.certificate is not null %}
                                            <div class="course-student-info">
                                                <div class="student-info">
                                                    {% if (item.student_info.progress is not null) %}
                                                        {{ "StudentCourseProgressX" | get_lang | format(item.student_info.progress) }}
                                                    {% endif %}

                                                    {% if (item.student_info.score is not null) %}
                                                        {{ "StudentCourseScoreX" | get_lang | format(item.student_info.score) }}
                                                    {% endif %}

                                                    {% if (item.student_info.certificate is not null) %}
                                                        {{ "StudentCourseCertificateX" | get_lang | format(item.student_info.certificate) }}
                                                    {% endif %}
                                                </div>
                                            </div>
                                        {% endif %}
                                    {% endif %}
                                </div>
                            </div>
                        {% endfor %}
                        </div>
                    </div>
                </div>
            </div>
        {% else %}
            <div class="panel-heading">
                <a href="{{ _p.web_main ~ 'session/index.php?session_id=' ~ row.id }}">
                    <img id="session_img_{{ row.id }}" src="{{ "window_list.png"|icon(32) }}" alt="{{ row.title }}"
                         title="{{ row.title }}">
                    {{ row.title }}
                </a>
            </div>
            <!-- view simple info -->
            <div class="panel-body">
                <div class="row">
                    <div class="col-md-2">
                        <a class="thumbnail" href="{{ _p.web_main ~ 'session/index.php?session_id=' ~ row.id }}">
                            <img class="img-responsive"
                                 src="{{ row.image ? _p.web_upload ~ row.image : 'session_default.png'|icon() }}"
                                 alt="{{ row.title }}" title="{{ row.title }}">
                        </a>
                    </div>
                    <div class="col-md-10">
                        <div class="info-session">
                            <p>{{ row.subtitle }}</p>
                            {% if row.show_description %}
                                <div class="description">
                                    {{ row.description }}
                                </div>
                            {% endif %}
                        </div>
                    </div>
                </div>
            </div>
            <!-- end view simple info -->
        {% endif %}
    </div>
{% endfor %}