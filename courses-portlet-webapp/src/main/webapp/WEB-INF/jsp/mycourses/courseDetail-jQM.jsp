<%--

    Licensed to Jasig under one or more contributor license
    agreements. See the NOTICE file distributed with this work
    for additional information regarding copyright ownership.
    Jasig licenses this file to you under the Apache License,
    Version 2.0 (the "License"); you may not use this file
    except in compliance with the License. You may obtain a
    copy of the License at:

    http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing,
    software distributed under the License is distributed on
    an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
    KIND, either express or implied. See the License for the
    specific language governing permissions and limitations
    under the License.

--%>

<jsp:directive.include file="/WEB-INF/jsp/header.jsp"/>
<%--
    Model Attributes:
        coursesByTerm   - CoursesByTerm
        instructorUrls  - Map<String, String>
        locationUrl     - Location
        course          - Course
 --%>
<portlet:renderURL var="courseListUrl">
    <portlet:param name="termCode" value="${coursesByTerm.termCode}"/>
</portlet:renderURL>

<div data-role="header" class="titlebar portlet-titlebar courses-back-div">
    <a data-role="button" data-icon="back" data-inline="true" class="courses-back-link" href="${ courseListUrl }"><spring:message code="back"/></a>
    <h2 class="title course-catalog-name">${ course.code }</h2>
</div>
<div class="portlet ptl-courses view-detail">
    <div class="portlet-content" data-role="content">
        
        <div class="course-details">
            <div class="titlebar">
                <h2 class="title"><a href="${course.url}">${ course.title }</a></h2>
                <h3 class="subtitle">${ course.school }</h3>
                <c:if test="${ not empty course.grade }">
                    <div class="grade"><span>${ course.grade }</span></div>
                </c:if>
            </div>
            <div>
                <div class="class-details">
                    <c:forEach items="${ course.instructors }" var="instructor">
                        <a data-role="button" class="instructor" title="instructor" href="${ instructorUrls[instructor.identifier] }">${ instructor.fullName }</a>
                    </c:forEach>
                    <c:forEach items="${ course.courseMeetings }" var="meeting">
                        <a data-role="button" class="location" href="${ locationUrls[meeting.location.identifier] }">${ meeting.time } at ${ meeting.location.displayName }</a>
                    </c:forEach>
                </div>
                <div class="class-announcements" style="margin-top: 30px;">
                    <div>
                        <c:choose>
                            <c:when test="${ fn:length(course.courseUpdates) == 0 }">
                                <p class="no-data"><spring:message code="no.updates"/></p>
                            </c:when>
                            <c:otherwise>
                                <ul data-role="listview" data-inset="true">
                                    <li data-role="list-divider"><spring:message code="updates"/></li>
                                    <c:forEach items="${ course.courseUpdates }" var="update">
                                        <li>
                                            <a href="${ update.url }">
                                                <h4 class="title">${ update.title }</h4>
                                                <p class="body">${ update.description }</p>
                                            </a>
                                        </li>
                                    </c:forEach>
                                </ul>   
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
        </div>

    </div>
</div>
