Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B16E7146A66;
	Tue,  3 Jun 2025 12:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748952482; cv=none; b=oim4EXGbgcP4yTstpvRwrLg3lHlL0dpThcKfFwt7m3qI2/5W7V4CD/usMIVLCmzCHbtVFJ7/l5KGIUHy92h6+UFUsm+hzZpeiDqtgP7NMoUKDZxTDRjs/rOL0047wx/oanTPtIKvIyHxYjivzBUNvkiaVOUGhkC4JcD6A+udrog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748952482; c=relaxed/simple;
	bh=cKHzIUgnW7PSnuX/LD1d2vlKQO6VXKzAPDVdGxCLw4g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=u7hN0HddX814gT1WqRzSQJw0dY5MMgXMWt3Qnhe55ugB6u9m/g6svMBJ3uP1b4FS6OYloai0p9QQvReurSa7aL4G43xqj3/Zig0LjF9i66mUmQ+ySSr7I2Bo85ieblxI3i9T042tt0zZrSIh9UClxhxTNcZAkG6f160hXH1SYLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2F77412FC;
	Tue,  3 Jun 2025 05:07:42 -0700 (PDT)
Received: from e129166.arm.com (unknown [10.57.27.15])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E81923F673;
	Tue,  3 Jun 2025 05:07:55 -0700 (PDT)
From: Lukasz Luba <lukasz.luba@arm.com>
To: linux-kernel@vger.kernel.org
Cc: lukasz.luba@arm.com,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	andrii@kernel.org,
	linux-trace-kernel@vger.kernel.org,
	rafael@kernel.org
Subject: [PATCH] sched/tp: Add new tracepoint for tracking uclamp set from user-space
Date: Tue,  3 Jun 2025 13:07:14 +0100
Message-ID: <20250603120755.1028396-1-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The user-space can set uclamp value for a given task. It impacts task
placement decisions made by the task scheduler. The user-space services
can dynamically change the uclamp values for tasks. Tracking the uclamp
changes is a very useful information and helps to understand the system
behavior. It allows to track improvements in the OS middleware and
applications which start using uclamp mechanisms and report test results.

This tracepoint is going to help in the further development of combined
kernel and middleware solutions.

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---

Hi all,

This patch is an attempt to refresh a bit my previous attempt in this
area, which can be found here [1]. It's a smaller version than the
previous one.

It's based on next-20250530.

Regards,
Lukasz Luba

[1] https://lore.kernel.org/lkml/20230509122246.1702397-1-lukasz.luba@arm.com/


 include/trace/events/sched.h | 3 +++
 kernel/sched/core.c          | 1 +
 kernel/sched/syscalls.c      | 4 ++++
 3 files changed, 8 insertions(+)

diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
index 4e6b2910cec3f..1b14d5bbc9e2a 100644
--- a/include/trace/events/sched.h
+++ b/include/trace/events/sched.h
@@ -894,6 +894,9 @@ DECLARE_TRACE_CONDITION(sched_set_state,
 	TP_ARGS(tsk, state),
 	TP_CONDITION(!!(tsk->__state) != !!state));
 
+DECLARE_TRACE(uclamp_update_task,
+	TP_PROTO(struct task_struct *p, int uclamp_id,  unsigned int value),
+	TP_ARGS(p, uclamp_id, value));
 #endif /* _TRACE_SCHED_H */
 
 /* This part must be outside protection */
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index dce50fa57471d..2c3bf0b6830fa 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -116,6 +116,7 @@ EXPORT_TRACEPOINT_SYMBOL_GPL(sched_util_est_cfs_tp);
 EXPORT_TRACEPOINT_SYMBOL_GPL(sched_util_est_se_tp);
 EXPORT_TRACEPOINT_SYMBOL_GPL(sched_update_nr_running_tp);
 EXPORT_TRACEPOINT_SYMBOL_GPL(sched_compute_energy_tp);
+EXPORT_TRACEPOINT_SYMBOL_GPL(uclamp_update_task_tp);
 
 DEFINE_PER_CPU_SHARED_ALIGNED(struct rq, runqueues);
 
diff --git a/kernel/sched/syscalls.c b/kernel/sched/syscalls.c
index 547c1f05b667e..e8dbc7fbe99d5 100644
--- a/kernel/sched/syscalls.c
+++ b/kernel/sched/syscalls.c
@@ -430,12 +430,16 @@ static void __setscheduler_uclamp(struct task_struct *p,
 	    attr->sched_util_min != -1) {
 		uclamp_se_set(&p->uclamp_req[UCLAMP_MIN],
 			      attr->sched_util_min, true);
+		trace_uclamp_update_task_tp(p, UCLAMP_MIN,
+					    attr->sched_util_min);
 	}
 
 	if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MAX &&
 	    attr->sched_util_max != -1) {
 		uclamp_se_set(&p->uclamp_req[UCLAMP_MAX],
 			      attr->sched_util_max, true);
+		trace_uclamp_update_task_tp(p, UCLAMP_MAX,
+					    attr->sched_util_max);
 	}
 }
 
-- 
2.48.1

