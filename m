Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09991320A24;
	Fri, 30 Jan 2026 15:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769787460; cv=none; b=KyGroEz5lUdjtaUOz/RAaDfxGa01uRGM7em1ebL4xIwU+9GBMWUcashV3MJHqJ/F/UWF5I+G0ZV+u5m4XLb6l5WdFcoulFZHgeTbSdehwklPDJ6rx4DpH6OV1vQfyCQAKo1a+UOukudtBGOQpOyppLHOMfSLXKs2d4108E6QkZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769787460; c=relaxed/simple;
	bh=cvBoUHc90uwT8+QGNQTOvd2TE7HD3B72yoXI5e5qlgo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=dYcMAGjK0PWAwgan1URn8KGWUd3ODShslcK22oBa4hEJD2DkRefnOY+NboJBexf6tIoesNiCcceExYe8PD/y26XXd0YtGZ0Zo8Xx/nwy7uWu3gal78BRQgQqgdC9w9iuSTWYSLvcJlNIcTjLny/exNrBu7v9Fy1M7nIFlrDBlo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf16.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id 1C3C31A05DE;
	Fri, 30 Jan 2026 15:37:32 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf16.hostedemail.com (Postfix) with ESMTPA id 79D082000D;
	Fri, 30 Jan 2026 15:37:30 +0000 (UTC)
Date: Fri, 30 Jan 2026 10:37:45 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>
Subject: [PATCH] tracing: Add kerneldoc to trace_event_buffer_reserve()
Message-ID: <20260130103745.1126e4af@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 79D082000D
X-Stat-Signature: jtay8okbyj8bmwrbs7n3byw99we4yfi9
X-Rspamd-Server: rspamout08
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19Uk3K9dYe3PJTEK4rqhT11a2/NHYV1chM=
X-HE-Tag: 1769787450-821352
X-HE-Meta: U2FsdGVkX1/8CoTuOxNhL6jkRQ+JKSSgRZ3MpA8MJQ5xnda9iye+kIisntQbZxWJ0rj+ueqCDniQQwrp9coepJdt8dc65zQXRoNItLkMo7aHvRdj75citjeCfnWy+mmyFVHJj97HK30uQiVvMkPqBkppDCQgG17D4iPA30Tvzd24sfuESw1TpR5ZOq+QiP7lZ3ju3zbb+hMxMD8V++2OPJIlWkS+79BMCoq07KujXc3T5Q74Ba/6h0s7JaWEy5lxDMcfRiU9yx4w25BMnf/JWt+XRGDxgVP5o9fKWPff7qqvcoEI2YXrQmhMPwX/WU/Ou0qtmGWenCq5ukwP4IFp4U9sqvHGJ12E8G5PJNseYaALELVs+bhxjH4me10Qq9au

From: Steven Rostedt <rostedt@goodmis.org>

Add a appropriate kerneldoc to trace_event_buffer_reserve() to make it
easier to understand how that function is used.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_events.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 4972e1a2b5f3..af6d1fe5cab7 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -649,6 +649,22 @@ bool trace_event_ignore_this_pid(struct trace_event_file *trace_file)
 }
 EXPORT_SYMBOL_GPL(trace_event_ignore_this_pid);
 
+/**
+ * trace_event_buffer_reserve - reserve space on the ring buffer for an event
+ * @fbuffer: information about how to save the event
+ * @trace_file: the instance file descriptor for the event
+ * @len: The length of the event
+ *
+ * The @fbuffer has information about the ring buffer and data will
+ * be added to it to be used by the call to trace_event_buffer_commit().
+ * The @trace_file is the desrciptor with information about the status
+ * of the given event for a specific trace_array instance.
+ * The @len is the length of data to save for the event.
+ *
+ * Returns a pointer to the data on the ring buffer or NULL if the
+ *   event was not reserved (event was filtered, too big, or the buffer
+ *   simply was disabled for write).
+ */
 void *trace_event_buffer_reserve(struct trace_event_buffer *fbuffer,
 				 struct trace_event_file *trace_file,
 				 unsigned long len)
-- 
2.51.0

