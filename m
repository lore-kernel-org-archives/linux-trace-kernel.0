Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A5FCC6FD1F
	for <linux-trace-kernel@archiver.kernel.org>; Wed, 22 Mar 2023 15:20:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbjCVPUO (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Wed, 22 Mar 2023 11:20:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231312AbjCVPUN (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 11:20:13 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DEAAA5A900;
        Wed, 22 Mar 2023 08:20:11 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 820C84B3;
        Wed, 22 Mar 2023 08:20:55 -0700 (PDT)
Received: from e123648.arm.com (unknown [10.57.18.173])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D02B43F71E;
        Wed, 22 Mar 2023 08:20:08 -0700 (PDT)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Cc:     rostedt@goodmis.org, mhiramat@kernel.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
        vschneid@redhat.com, delyank@fb.com, lukasz.luba@arm.com,
        qyousef@google.com
Subject: [PATCH 0/3] Add basic tracing for uclamp and schedutil
Date:   Wed, 22 Mar 2023 15:18:40 +0000
Message-Id: <20230322151843.14390-1-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

Hi all,

The task scheduler feature: Uclamp, begins to take off. To better understand
the dynamics in the task scheduler and CPU frequency requests we need some
better tracing.
In schedutil (cpufreq governor) we allow to enter the scheduler
and make the frequency change. Although, there is some limit in regards to how
often this can happen. That min period is provided by the cpufreq driver.
Thus, some of the cpufreq requests might be filter out and the frequency won't
be changed (hopefuly will be set a bit later). We would like to know about
those situations, especially in context of the user-space hints made via
Uclamp for particular tasks.
This patch set aims to add base for our toolkits and post-processing trace
analyzes.

Regards,
Lukasz Luba

Lukasz Luba (3):
  sched/tp: Add new tracepoint to track uclamp set from user-space
  cpufreq: schedutil: Refactor sugov_update_shared() internals
  schedutil: trace: Add tracing to capture filter out requests

 include/trace/events/sched.h     |  4 ++++
 include/trace/events/schedutil.h | 17 +++++++++++++++++
 kernel/sched/core.c              |  5 +++++
 kernel/sched/cpufreq_schedutil.c | 32 ++++++++++++++++++++++----------
 4 files changed, 48 insertions(+), 10 deletions(-)
 create mode 100644 include/trace/events/schedutil.h

-- 
2.17.1

