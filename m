Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 721BA16CD33;
	Wed, 10 Jun 2026 04:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781064871; cv=none; b=l/MqEkG3WXUxuYVFZ4gYuglaW8BDSi/nA9Pmyrqs4SFrYqfZCfXSrxpR4eRrVZd0yz4wr/QBdAz/qMOQ3bQu+d0eFw8kDxa7EDPc5UpFnueucNCddsqGDHIRMrbyMucynPPgUVHoISq9GSu8/5blxiIaxdexLetrTwKZhHzNEcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781064871; c=relaxed/simple;
	bh=GzTxE5kq8+6POXEmEJlPP9+hbJX3J/GcP2zUFM2lHL4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ggGANOgbWAud30c00pQT3Knx+2IwSlekcbeuzkiYB7KaBhtpvfoS+8vuAKjtAJHXpSEzVjRna8sQuAu1899fAnXVasFPWr/uYLM2W1zg5ImbMUN0Xm4rqzHya5GwV73JaAm/Wrc0YWrZsVqeNeaQ3HulUNiMME0TUvoG5dWuZAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=TzrSq8Zw; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TzrSq8Zw"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 659KBXuR2134413;
	Wed, 10 Jun 2026 04:14:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=32BKbtvlJUFb4DcsHk7Q4qbxUOtTL
	xY0SzD4/nLhHew=; b=TzrSq8ZwPkCv+iyzdzUEsxFlvfe67IAsUiqoVzFqrPooU
	IH088ig/B8Z6dSN9JS7qsDg682t1j/t94LJZ+ggbNyGnA754sZsOhprhZofC4B6k
	BqzzzFAou/WHuNRjgEQe4GL6IMr+r0TCt3HegdS08bPXc5OVjH41+lYUGbiumfQc
	dUj98nMAXVEhzdrUKX2TCT5NGVYtBtq0gXtVMx0hcMaahykzgfdWeaCiYnK+D/OB
	hPbaNKNVJtEAoPy5DN1ugeekf2DWe54vL528I1PwQKrv9ThuLz9nyp+/0000Uj1u
	bhduJ8On15RA5EEkgzOA3N961owiIPSTO5CYKHtSg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4ema4y5u30-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Jun 2026 04:14:12 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 65A4D8bM002618;
	Wed, 10 Jun 2026 04:14:11 GMT
Received: from imran-metabox.au.oracle.com (dhcp-10-191-116-180.vpn.oracle.com [10.191.116.180])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4eq0680uxu-1;
	Wed, 10 Jun 2026 04:14:11 +0000 (GMT)
From: Imran Khan <imran.f.khan@oracle.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
        peterz@infradead.org
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] task_work: add tracepoints for task_work callbacks
Date: Wed, 10 Jun 2026 12:14:08 +0800
Message-Id: <20260610041408.2461637-1-imran.f.khan@oracle.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-10_01,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 mlxlogscore=999 phishscore=0 adultscore=0 malwarescore=0 spamscore=0
 lowpriorityscore=0 suspectscore=0 mlxscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2605130000 definitions=main-2606100036
X-Authority-Analysis: v=2.4 cv=ZMvnX37b c=1 sm=1 tr=0 ts=6a28e494 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=RD47p0oAkeU5bO7t-o6f:22 a=yPCof4ZbAAAA:8 a=peYP4jhWzMAHLV-GQdgA:9
X-Proofpoint-ORIG-GUID: oUBUOI_M1AlQyoP3EhWSLXU16ZRYAOe-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEwMDAzNiBTYWx0ZWRfX82w7qJ/ElJAC
 mlJyysXdacxo3h7p4buxG/Z4mBXaHxSXj4LZ3fAkV2fxlGK+U2R9naF/e00LaeTnKBL+9QfRXkV
 lF99pbt8tY+GLImXZIYgfD4hkZRJmdWjFsw/9ANn+JTtdCuzPoE0EvOWU+G2kT5qSIzDtINXtMX
 7DofNNPuoydThpUTKAZiHMxR8we3ZMbx06sUB4dO68EiXYS8MaBwl5gkU7035qGfaNU9E8aYhlx
 AYaUypU1Cfbj9EhIalZoD1k3FEV26IgVMwIf25lagVJd3inQ93RspJsc8BNJudK6Wtu0PsGzyEU
 B8+Em7MwGWVE8etyBLKtqIQ/Ib7JsrvWB+efxtLpzZQ/ZyaoJDCOjvD4uDkYsZtkG82Y3zNO+Yl
 c7ttxea7q1RasxRe28Nmg6YrOrOuDNfHSKdMrMKSLg0jjCdyltStPbHLAWd3wJPeWtYbr3P9D5g
 ikg+O6973feteaX2hzQ==
X-Proofpoint-GUID: oUBUOI_M1AlQyoP3EhWSLXU16ZRYAOe-

task_work tracepoints can be enabled by:

    echo 1 > /sys/kernel/tracing/events/task_work/enable

and trace logs would look like:

    ... task_work_add_request: target_comm=ls target_pid=227 work=ffff95d20641a508 func=____fput notify=TWA_RESUME
    ... task_work_add_done: target_comm=ls target_pid=227 work=ffff95d20641a508 ret=0
    ... task_work_add_request: target_comm=ls target_pid=227 work=ffff95d20641a5c8 func=____fput notify=TWA_RESUME
    ... task_work_add_done: target_comm=ls target_pid=227 work=ffff95d20641a5c8 ret=0
    ... task_work_add_request: target_comm=ls target_pid=227 work=ffff95d20641a688 func=____fput notify=TWA_RESUME
    ... task_work_add_done: target_comm=ls target_pid=227 work=ffff95d20641a688 ret=0
    ... task_work_add_request: target_comm=ls target_pid=227 work=ffff95d20641a748 func=____fput notify=TWA_RESUME
    ... task_work_add_done: target_comm=ls target_pid=227 work=ffff95d20641a748 ret=0
    ... task_work_run_start: comm=ls pid=227 work=ffff95d20641a748 func=____fput
    ... task_work_run_end: comm=ls pid=227 work=ffff95d20641a748 func=____fput
    ... task_work_run_start: comm=ls pid=227 work=ffff95d20641a688 func=____fput
    ... task_work_run_end: comm=ls pid=227 work=ffff95d20641a688 func=____fput
    ... task_work_run_start: comm=ls pid=227 work=ffff95d20641a5c8 func=____fput
    ... task_work_run_end: comm=ls pid=227 work=ffff95d20641a5c8 func=____fput
    ... task_work_run_start: comm=ls pid=227 work=ffff95d20641a508 func=____fput
    ... task_work_run_end: comm=ls pid=227 work=ffff95d20641a508 func=____fput

formatted as:
    target_comm=<comm of target task>
    target_pid=<pid of target task>
    work=<callback_head *>
    func=<callback_head->func>
    notify=<way to notify the target task>
    comm=<comm of current task executing func>
    pid=<pid of current task executing func>

Signed-off-by: Imran Khan <imran.f.khan@oracle.com>
---
 include/trace/events/task_work.h | 129 +++++++++++++++++++++++++++++++
 kernel/task_work.c               |  32 +++++++-
 2 files changed, 159 insertions(+), 2 deletions(-)
 create mode 100644 include/trace/events/task_work.h

diff --git a/include/trace/events/task_work.h b/include/trace/events/task_work.h
new file mode 100644
index 0000000000000..e43ffd607e7ec
--- /dev/null
+++ b/include/trace/events/task_work.h
@@ -0,0 +1,129 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM task_work
+
+#if !defined(_TRACE_TASK_WORK_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_TASK_WORK_H
+
+#include <linux/tracepoint.h>
+#include <linux/task_work.h>
+
+TRACE_DEFINE_ENUM(TWA_NONE);
+TRACE_DEFINE_ENUM(TWA_RESUME);
+TRACE_DEFINE_ENUM(TWA_SIGNAL);
+TRACE_DEFINE_ENUM(TWA_SIGNAL_NO_IPI);
+TRACE_DEFINE_ENUM(TWA_NMI_CURRENT);
+
+#define show_task_work_notify_mode(notify)			\
+	__print_symbolic(notify,				\
+		{ TWA_NONE,           "TWA_NONE" },		\
+		{ TWA_RESUME,         "TWA_RESUME" },		\
+		{ TWA_SIGNAL,         "TWA_SIGNAL" },		\
+		{ TWA_SIGNAL_NO_IPI,  "TWA_SIGNAL_NO_IPI" },	\
+		{ TWA_NMI_CURRENT,    "TWA_NMI_CURRENT" })
+
+/*
+ * task_work_add() is split into two events:
+ *
+ *   task_work:add_request - fires before the cmpxchg that enqueues
+ *                           @work. Guaranteed to happen-before any
+ *                           run_start has picked the @work.
+ *   task_work:add_done    - fires after the cmpxchg loop terminates,
+ *                           carrying the final ret value.
+ */
+TRACE_EVENT(task_work_add_request,
+
+	TP_PROTO(struct task_struct *task,
+		 struct callback_head *work,
+		 task_work_func_t func,
+		 enum task_work_notify_mode notify),
+
+	TP_ARGS(task, work, func, notify),
+
+	TP_STRUCT__entry(
+		__field(pid_t,		pid)
+		__array(char,		comm, TASK_COMM_LEN)
+		__field(void *,		work)
+		__field(void *,		func)
+		__field(int,		notify)
+	),
+
+	TP_fast_assign(
+		__entry->pid		= task->pid;
+		memcpy(__entry->comm, task->comm, TASK_COMM_LEN);
+		__entry->work		= work;
+		__entry->func		= func;
+		__entry->notify		= notify;
+	),
+
+	TP_printk("target_comm=%s target_pid=%d work=%p func=%ps notify=%s",
+		__entry->comm, __entry->pid, __entry->work,
+		__entry->func, show_task_work_notify_mode(__entry->notify))
+);
+
+TRACE_EVENT(task_work_add_done,
+
+	TP_PROTO(struct task_struct *task,
+		 struct callback_head *work,
+		 int ret),
+
+	TP_ARGS(task, work, ret),
+
+	TP_STRUCT__entry(
+		__field(pid_t,		pid)
+		__array(char,		comm, TASK_COMM_LEN)
+		__field(void *,		work)
+		__field(int,		ret)
+	),
+
+	TP_fast_assign(
+		__entry->pid		= task->pid;
+		memcpy(__entry->comm, task->comm, TASK_COMM_LEN);
+		__entry->work		= work;
+		__entry->ret		= ret;
+	),
+
+	TP_printk("target_comm=%s target_pid=%d work=%p ret=%d",
+		__entry->comm, __entry->pid, __entry->work, __entry->ret)
+);
+
+DECLARE_EVENT_CLASS(task_work_run_template,
+
+	TP_PROTO(struct task_struct *task,
+		 struct callback_head *work,
+		 task_work_func_t func),
+
+	TP_ARGS(task, work, func),
+
+	TP_STRUCT__entry(
+		__field(pid_t,		pid)
+		__array(char,		comm, TASK_COMM_LEN)
+		__field(void *,		work)
+		__field(void *,		func)
+	),
+
+	TP_fast_assign(
+		__entry->pid		= task->pid;
+		memcpy(__entry->comm, task->comm, TASK_COMM_LEN);
+		__entry->work		= work;
+		__entry->func		= func;
+	),
+
+	TP_printk("comm=%s pid=%d work=%p func=%ps",
+		__entry->comm, __entry->pid, __entry->work, __entry->func)
+);
+
+DEFINE_EVENT(task_work_run_template, task_work_run_start,
+	TP_PROTO(struct task_struct *task, struct callback_head *work,
+		 task_work_func_t func),
+	TP_ARGS(task, work, func));
+
+DEFINE_EVENT(task_work_run_template, task_work_run_end,
+	TP_PROTO(struct task_struct *task, struct callback_head *work,
+		 task_work_func_t func),
+	TP_ARGS(task, work, func));
+
+#endif /* _TRACE_TASK_WORK_H */
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
diff --git a/kernel/task_work.c b/kernel/task_work.c
index 0f7519f8e7c93..ed04a8c7116de 100644
--- a/kernel/task_work.c
+++ b/kernel/task_work.c
@@ -4,6 +4,9 @@
 #include <linux/task_work.h>
 #include <linux/resume_user_mode.h>
 
+#define CREATE_TRACE_POINTS
+#include <trace/events/task_work.h>
+
 static struct callback_head work_exited; /* all we need is ->next == NULL */
 
 #ifdef CONFIG_IRQ_WORK
@@ -60,6 +63,7 @@ int task_work_add(struct task_struct *task, struct callback_head *work,
 		  enum task_work_notify_mode notify)
 {
 	struct callback_head *head;
+	task_work_func_t func;
 
 	if (notify == TWA_NMI_CURRENT) {
 		if (WARN_ON_ONCE(task != current))
@@ -70,10 +74,25 @@ int task_work_add(struct task_struct *task, struct callback_head *work,
 		kasan_record_aux_stack(work);
 	}
 
+	/*
+	 * Snapshot work->func before the cmpxchg below publishes @work.
+	 * After publish, a concurrent task_work_run() on @task may invoke
+	 * the callback and free @work, after which dereferencing work->func
+	 * to fill the tracepoint payload would cause UAF error.
+	 */
+	func = work->func;
+
+	/*
+	 * Emit add_request BEFORE the cmpxchg loop.
+	 * Tracing here guarantees add_request is seen before any possible
+	 * run_start.
+	 */
+	trace_task_work_add_request(task, work, func, notify);
+
 	head = READ_ONCE(task->task_works);
 	do {
 		if (unlikely(head == &work_exited))
-			return -ESRCH;
+			goto out_esrch;
 		work->next = head;
 	} while (!try_cmpxchg(&task->task_works, &head, work));
 
@@ -100,7 +119,12 @@ int task_work_add(struct task_struct *task, struct callback_head *work,
 		break;
 	}
 
+	trace_task_work_add_done(task, work, 0);
 	return 0;
+
+out_esrch:
+	trace_task_work_add_done(task, work, -ESRCH);
+	return -ESRCH;
 }
 
 /**
@@ -229,8 +253,12 @@ void task_work_run(void)
 		raw_spin_unlock_irq(&task->pi_lock);
 
 		do {
+			task_work_func_t func = work->func;
+
 			next = work->next;
-			work->func(work);
+			trace_task_work_run_start(task, work, func);
+			func(work);
+			trace_task_work_run_end(task, work, func);
 			work = next;
 			cond_resched();
 		} while (work);
-- 
2.43.0

