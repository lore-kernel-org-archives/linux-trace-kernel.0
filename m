Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 376FC30BF4F
	for <linux-trace-kernel@vger.kernel.org>; Thu, 23 Apr 2026 15:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776957520; cv=none; b=sQUTfepZQ3OIfBiNusj4wPmW+MyrWFy35xBHJOpGQ8+J3T0cYBfHnbvB+pPp2nyW8brSBw9qA8+gx4H7HAFpRB7v0xcSW8KhN0A9bcrB24ss+2DnrSqfM4wOsj/i+FD4cvqb3VTan4dodvVudXBAmctHaZqCPeWhKqbcbN8DzSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776957520; c=relaxed/simple;
	bh=i+05pOD95yC9cQlgWy+RVtvJuWffDTmCvOBKK+PssxM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JtZwfxE4y2LpsYE5NH4NwuOUbes2sPjA4Z0wzt4JPJF6xgvbqc6v5AcASiY2S08dOs3whxRMnmHAV/SaUan03wDIvfbRlpKTXn1cv8eg2akytkek1FSS4FBhinQgcpakgCBH9b9QJjR+e1xKvAVMPOOtgwcB2XP4HW4rWExqieA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F7+IEggq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F7+IEggq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776957517;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gtV32AASD8DSAT0iamG4FraqG03WbASgj2I1O6++EdE=;
	b=F7+IEggqOR7yugt91pLZM5DyHs/1nb6+T5PuvlnaL3dfr82ei060pmQWYuGzbeArK0UEQA
	0wrPe7+hAmF1f1m1uTz47Faw+iLQCH8ya7WlaNbwc5kYMV+DuetbIqbeiEy+QKFp727ML5
	ytkggvSnT41SD25+rrLMITp5zEneYmQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-616-rvyzww_GOOWsADmDmOnigA-1; Thu,
 23 Apr 2026 11:18:31 -0400
X-MC-Unique: rvyzww_GOOWsADmDmOnigA-1
X-Mimecast-MFC-AGG-ID: rvyzww_GOOWsADmDmOnigA_1776957510
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7236E195606A;
	Thu, 23 Apr 2026 15:18:29 +0000 (UTC)
Received: from ashelat-thinkpadp1gen5.boston.csb (unknown [10.74.80.103])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 940791800348;
	Thu, 23 Apr 2026 15:18:18 +0000 (UTC)
From: Anubhav Shelat <ashelat@redhat.com>
To: peterz@infradead.org,
	mingo@redhat.com,
	mhiramat@kernel.org,
	rostedt@goodmis.org,
	acme@kernel.org,
	namhyung@kernel.org
Cc: mathieu.desnoyers@efficios.com,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	james.clark@linaro.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Anubhav Shelat <ashelat@redhat.com>
Subject: [PATCH v3 2/3] perf: enable unprivileged syscall tracing with perf trace
Date: Thu, 23 Apr 2026 11:17:45 -0400
Message-ID: <20260423151746.16258-3-ashelat@redhat.com>
In-Reply-To: <20260423151746.16258-1-ashelat@redhat.com>
References: <20260423151746.16258-1-ashelat@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: vxtEObPC6FH8WVatZIp4oH6ZMGywyv3ay_zvABE3NPk_1776957510
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Allow unprivileged users to trace their own processes' syscalls using
perf trace, similar to strace without the intrusive overhead of ptrace().

Currently, perf trace requires CAP_PERFMON or paranoid level ≤ 1 even
though the kernel has existing infrastructure (TRACE_EVENT_FL_CAP_ANY)
specifically designed to mark syscall tracepoints as safe for
unprivileged access. To fix this:

1. Loosen the condition in perf_event_open() which requires privileges
for all events with exclude_kernel=0. This allows perf_event_open() to
bypass the paranoid check for task-attached tracepoint events. Ensure
that sample types which can expose kernel addresses to unprivileged
users are blocked.

2. Make the format and id tracefs files world-readable only for tracepoints
with TRACE_EVENT_FL_CAP_ANY, allowing unprivileged users to see syscall
tracepoint ids without exposing sensitive information.

Also add a check to perf_trace_event_perm() to ensure only
TRACE_EVENT_FL_CAP_ANY events can be traced.

Example usage after this change:
  $ perf trace ls          # works as unprivileged user
  $ perf trace             # system-wide, still requires privileges
  $ perf trace -p 1234     # requires ptrace permission on pid 1234

Assisted-by: Claude:claude-sonnet-4.5
Signed-off-by: Anubhav Shelat <ashelat@redhat.com>
---
 kernel/events/core.c            | 24 +++++++++++++++++++++---
 kernel/trace/trace_event_perf.c | 12 +++++++++++-
 kernel/trace/trace_events.c     |  8 ++++++--
 3 files changed, 38 insertions(+), 6 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 6d1f8bad7e1c..e9c53758574d 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -13833,9 +13833,27 @@ SYSCALL_DEFINE5(perf_event_open,
 		return err;
 
 	if (!attr.exclude_kernel) {
-		err = perf_allow_kernel();
-		if (err)
-			return err;
+		bool tp_bypass = false;
+
+		if (attr.type == PERF_TYPE_TRACEPOINT && pid != -1) {
+			/*
+			 * Block sample types that expose kernel addresses to
+			 * prevent KASLR bypass
+			 */
+			u64 kaddr_leak = PERF_SAMPLE_CALLCHAIN |
+					 PERF_SAMPLE_BRANCH_STACK |
+					 PERF_SAMPLE_ADDR |
+					 PERF_SAMPLE_REGS_INTR |
+					 PERF_SAMPLE_IP;
+
+			tp_bypass = !(attr.sample_type & kaddr_leak);
+		}
+
+		if (!tp_bypass) {
+			err = perf_allow_kernel();
+			if (err)
+				return err;
+		}
 	}
 
 	if (attr.namespaces) {
diff --git a/kernel/trace/trace_event_perf.c b/kernel/trace/trace_event_perf.c
index a6bb7577e8c5..e8347df7ede5 100644
--- a/kernel/trace/trace_event_perf.c
+++ b/kernel/trace/trace_event_perf.c
@@ -73,8 +73,18 @@ static int perf_trace_event_perm(struct trace_event_call *tp_event,
 	}
 
 	/* No tracing, just counting, so no obvious leak */
-	if (!(p_event->attr.sample_type & PERF_SAMPLE_RAW))
+	if (!(p_event->attr.sample_type & PERF_SAMPLE_RAW)) {
+		/*
+		 * Only allow CAP_ANY tracepoints for unprivileged
+		 * task-attached events in case kernel context is exposed.
+		 */
+		if (!p_event->attr.exclude_kernel && !perfmon_capable()) {
+			if (!(p_event->attach_state == PERF_ATTACH_TASK &&
+			      (tp_event->flags & TRACE_EVENT_FL_CAP_ANY)))
+				return -EACCES;
+		}
 		return 0;
+	}
 
 	/* Some events are ok to be traced by non-root users... */
 	if (p_event->attach_state == PERF_ATTACH_TASK) {
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index aa422dc80ae8..69be5561d0b8 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -3054,7 +3054,9 @@ static int event_callback(const char *name, umode_t *mode, void **data,
 	struct trace_event_call *call = file->event_call;
 
 	if (strcmp(name, "format") == 0) {
-		*mode = TRACE_MODE_READ;
+		*mode = (call->flags & TRACE_EVENT_FL_CAP_ANY) ?
+			(TRACE_MODE_READ | 0004) :
+			TRACE_MODE_READ;
 		*fops = &ftrace_event_format_fops;
 		return 1;
 	}
@@ -3090,7 +3092,9 @@ static int event_callback(const char *name, umode_t *mode, void **data,
 #ifdef CONFIG_PERF_EVENTS
 	if (call->event.type && call->class->reg &&
 	    strcmp(name, "id") == 0) {
-		*mode = TRACE_MODE_READ;
+		*mode = (call->flags & TRACE_EVENT_FL_CAP_ANY) ?
+			(TRACE_MODE_READ | 0004) :
+			TRACE_MODE_READ;
 		*data = (void *)(long)call->event.type;
 		*fops = &ftrace_event_id_fops;
 		return 1;
-- 
2.53.0

