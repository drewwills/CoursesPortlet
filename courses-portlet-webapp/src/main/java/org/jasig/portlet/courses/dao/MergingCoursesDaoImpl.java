/**
 * Licensed to Jasig under one or more contributor license
 * agreements. See the NOTICE file distributed with this work
 * for additional information regarding copyright ownership.
 * Jasig licenses this file to you under the Apache License,
 * Version 2.0 (the "License"); you may not use this file
 * except in compliance with the License. You may obtain a
 * copy of the License at:
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing,
 * software distributed under the License is distributed on
 * an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 * KIND, either express or implied. See the License for the
 * specific language governing permissions and limitations
 * under the License.
 */

package org.jasig.portlet.courses.dao;

import java.util.List;

import javax.annotation.Resource;
import javax.portlet.PortletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.jasig.portlet.courses.model.wrapper.CourseSummaryWrapper;

public class MergingCoursesDaoImpl implements ICoursesDao {

    protected final Log log = LogFactory.getLog(getClass());
    
    private List<ICoursesDao> courseDaos;
    
    @Resource(name="courseDaos")
    public void setCourseDaos(List<ICoursesDao> courseDaos) {
        this.courseDaos = courseDaos;
    }

    @Override
    public CourseSummaryWrapper getSummary(PortletRequest request) {
        CourseSummaryWrapper wrapper = new CourseSummaryWrapper();
        
        for (ICoursesDao dao : courseDaos) {
            try {
                CourseSummaryWrapper daoSummary = dao.getSummary(request);
                wrapper.getTerms().addAll(daoSummary.getTerms());
                if (daoSummary.getCredits() != null) {
                    wrapper.setCredits(daoSummary.getCredits());
                }
                if (daoSummary.getGpa() != null) {
                    wrapper.setGpa(daoSummary.getGpa());
                }
            } catch (Exception e) {
                log.error("Exception reading course dao", e);
            }
        }

        return wrapper;
    }

}
