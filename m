Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DBDFF510;
	Sun, 23 Mar 2025 19:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742757714; cv=none; b=BI2JFOhwQn91e/MQgl7bBE+Vt5Gav0j28qVbAF+5AV/rdM62c0eAX8LErdy0w8n1Su/A0vx0eLWEBvV7vUn0QnTIE39Z5oWQt+cZjFI+3Qxc4CRMITkvgmGdg0oduZQqI0Z1Yt5cFapa2DOqzm6TfGODGd2wrJUbA1pquoA6aqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742757714; c=relaxed/simple;
	bh=iPBfgq/D02S5iq7ZZ8C9YgzHVAKbAHGPtLmnJVSkfv8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=FwgcZdVNm66QpuUdKuP1KwNIXxn6VrtMxKmxDMasw1uaVcFCqK2d07ItNs/p0HZMMW8y1ntwGUj49/PQYXuvXh0LVTeqNGvFN5bHKUCJNLrzIEuKCDXv9aZG4R4XSO1aTSOyj0DqxgYL/2FqKveuOkxD5WEZYhV1oWHD9vUKEis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D240C4CEE2;
	Sun, 23 Mar 2025 19:21:52 +0000 (UTC)
Date: Sun, 23 Mar 2025 15:21:51 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux trace kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Douglas Raillard
 <douglas.raillard@arm.com>
Subject: [PATCH] tracing: Do not use PERF enums when perf is not defined
Message-ID: <20250323152151.528b5ced@batman.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

From: Steven Rostedt <rostedt@goodmis.org>

An update was made to up the module ref count when a synthetic event is
registered for both trace and perf events. But if perf is not configured
in, the perf enums used will cause the kernel to fail to build.

Fixes: a1e3ad43115e ("tracing: Ensure module defining synth event cannot be unloaded while tracing")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202503232230.TeREVy8R-lkp@intel.com/
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_events_synth.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_events_synth.c b/kernel/trace/trace_events_synth.c
index d91205bc9f61..5976545403ea 100644
--- a/kernel/trace/trace_events_synth.c
+++ b/kernel/trace/trace_events_synth.c
@@ -859,8 +859,10 @@ static int synth_event_reg(struct trace_event_call *call,
 	struct synth_event *event = container_of(call, struct synth_event, call);
 
 	switch (type) {
-	case TRACE_REG_REGISTER:
+#ifdef CONFIG_PERF_EVENTS
 	case TRACE_REG_PERF_REGISTER:
+#endif
+	case TRACE_REG_REGISTER:
 		if (!try_module_get(event->mod))
 			return -EBUSY;
 		break;
@@ -871,8 +873,10 @@ static int synth_event_reg(struct trace_event_call *call,
 	int ret = trace_event_reg(call, type, data);
 
 	switch (type) {
-	case TRACE_REG_UNREGISTER:
+#ifdef CONFIG_PERF_EVENTS
 	case TRACE_REG_PERF_UNREGISTER:
+#endif
+	case TRACE_REG_UNREGISTER:
 		module_put(event->mod);
 		break;
 	default:
-- 
2.47.2

