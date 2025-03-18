Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFCD2EACD;
	Tue, 18 Mar 2025 18:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742321363; cv=none; b=QZy2urm0EdLvH6jC2RqVgPOikHV72ytubnvFkkOagHTFryOMECZWqMzi1bYM1QJyBfWHjxs1i24ojC345eJHkJYWCiPVm/tPaJoDq0wJ7aTIrYZWaWyV1yQYSvTCgGRZe97ckov1mSWHrh/EqU5ST9oyQVkZIpx31UpyCncPWo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742321363; c=relaxed/simple;
	bh=gL+b1yskOtM8nv5UYME0i0AR/DkzUhAbPpvDM0oUkAo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GWEpk8BsGWu3vmKWHYsvv5b1iWq8CDWQDe5o9SCslJGOBVgylozE8hIfv7lx8EbPxVEaD3qsM44NDs/GAZbU+OmGBiQzH8n9cQV7kowDKGkHg+4bCWSrob55hulgovZIwKJZTXPWNCmqU6mO7xqCirVds39oQ5+3l1JHpWXnvk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 806A813D5;
	Tue, 18 Mar 2025 11:09:29 -0700 (PDT)
Received: from e132430.arm.com (unknown [10.57.85.21])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 87F203F694;
	Tue, 18 Mar 2025 11:09:19 -0700 (PDT)
From: Douglas RAILLARD <douglas.raillard@arm.com>
To: rostedt@goodmis.org
Cc: douglas.raillard@arm.com,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH] tracing: Ensure module defining synth event cannot be unloaded while tracing
Date: Tue, 18 Mar 2025 18:09:05 +0000
Message-ID: <20250318180906.226841-1-douglas.raillard@arm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Douglas Raillard <douglas.raillard@arm.com>

Currently, using synth_event_delete() will fail if the event is being
used (tracing in progress), but that is normally done in the module exit
function. At that stage, failing is problematic as returning a non-zero
status means the module will become locked (impossible to unload or
reload again).

Instead, ensure the module exit function does not get called in the
first place by increasing the module refcnt when the event is enabled.

Signed-off-by: Douglas Raillard <douglas.raillard@arm.com>
---
 kernel/trace/trace_events_synth.c | 30 +++++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_events_synth.c b/kernel/trace/trace_events_synth.c
index e3f7d09e5512..bb7ef6e76991 100644
--- a/kernel/trace/trace_events_synth.c
+++ b/kernel/trace/trace_events_synth.c
@@ -852,6 +852,34 @@ static struct trace_event_fields synth_event_fields_array[] = {
 	{}
 };
 
+static int synth_event_reg(struct trace_event_call *call,
+		    enum trace_reg type, void *data)
+{
+	struct synth_event *event = container_of(call, struct synth_event, call);
+
+	switch (type) {
+	case TRACE_REG_REGISTER:
+	case TRACE_REG_PERF_REGISTER:
+		if (!try_module_get(event->mod))
+			return -EBUSY;
+		break;
+	default:
+		break;
+	}
+
+	int ret = trace_event_reg(call, type, data);
+
+	switch (type) {
+	case TRACE_REG_UNREGISTER:
+	case TRACE_REG_PERF_UNREGISTER:
+		module_put(event->mod);
+		break;
+	default:
+		break;
+	}
+	return ret;
+}
+
 static int register_synth_event(struct synth_event *event)
 {
 	struct trace_event_call *call = &event->call;
@@ -881,7 +909,7 @@ static int register_synth_event(struct synth_event *event)
 		goto out;
 	}
 	call->flags = TRACE_EVENT_FL_TRACEPOINT;
-	call->class->reg = trace_event_reg;
+	call->class->reg = synth_event_reg;
 	call->class->probe = trace_event_raw_event_synth;
 	call->data = event;
 	call->tp = event->tp;
-- 
2.43.0

