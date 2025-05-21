Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 678DB267AF6
	for <linux-trace-kernel@vger.kernel.org>; Wed, 21 May 2025 12:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747831728; cv=none; b=ipggc1LxO0gyPM3MsGgrPS4SSP/anllw0eazVyOd9L0Q77cJbZDPL9UG7h5Mc4H6rU7crG53hMrkuAuuTOtW1V0KBW/rjZJZvmi7OQ/Q7GbAG6e6pfC3xjg7HJQJqiF30vO/roQnNsp0igUw90i2NQk51S4k8/nJnK0mIbB3YHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747831728; c=relaxed/simple;
	bh=eiukvXR/ytNIZoerhQAQuvgv7H3SOBv2zF1m1EwSLsA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ayLRnvWNJNhc2wpDFKEIBB0Nw38uJe+xWaC9GiPtGDKAK3wE+ulUO35pnO9jQ92H/BFGzDlhnVXHUKLobkW+lG+6sxrmh/5MS9pNGUWGp/czr/+w+862WZATqpWJ5SO2L1qfXKgrgcvT3AI91bNbi+TQvyijoqQG/VSpzP8r0so=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gKW3Vf+M; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gKW3Vf+M"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747831725;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=c8a8Yw3t1BooLuhPEHoxGkD+ZXKtgxmE4Tce93zXGi8=;
	b=gKW3Vf+M6i8WTgEM4BV0Z76Nn8hFU//5JGwg7QaXiTTBeDJmeQkvgvjdygLgNm5gOhpA2R
	be5nLscf4+BPaM9s8Tj/EvJddEs9MRZJY0TdL4rR7EKnhT+vBqOsWCyJU1JpQmr/e6YlMC
	H08jdqzMAsE/ZQTdcLeEJqvL+JLUWQM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-332-i8QQFZfXOFGSelbQnPgC2A-1; Wed,
 21 May 2025 08:48:40 -0400
X-MC-Unique: i8QQFZfXOFGSelbQnPgC2A-1
X-Mimecast-MFC-AGG-ID: i8QQFZfXOFGSelbQnPgC2A_1747831718
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AF1901800877;
	Wed, 21 May 2025 12:48:38 +0000 (UTC)
Received: from fedora.. (unknown [10.44.22.27])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 17D9219560AB;
	Wed, 21 May 2025 12:48:35 +0000 (UTC)
From: Gabriele Paoloni <gpaoloni@redhat.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: Gabriele Paoloni <gpaoloni@redhat.com>
Subject: [RFC PATCH] tracing: add kernel documentation for trace_array_set_clr_event, trace_set_clr_event and supporting functions
Date: Wed, 21 May 2025 14:48:29 +0200
Message-ID: <20250521124829.123720-1-gpaoloni@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

As per Linux Kernel documentation guidelines
(https://docs.kernel.org/doc-guide/kernel-doc.html),
<<Every function that is exported to loadable modules using
EXPORT_SYMBOL or EXPORT_SYMBOL_GPL should have a kernel-doc
comment>>; hence this patch adds detailed kernel-doc headers
documentation for trace_array_set_clr_event, trace_set_clr_event
and the main functions in the respective call-trees that support
their functionalities.
For each of the documented functions, as part of the extensive
description, a set of "Function's expectations" are described in
a way that facilitate:
1) evaluating the current code and any proposed modification
   to behave as described;
2) writing kernel tests to verify the code to behave as described.

Signed-off-by: Gabriele Paoloni <gpaoloni@redhat.com>
---
While working on the documentation of __ftrace_event_enable_disable,
I realized that the EVENT_FILE_FL_SOFT_MODE flag is mainly used
internally in the function itself, whereas it is EVENT_FILE_FL_SOFT_DISABLED
that prevents tracing the event.
In this perspective I see that, starting from the initial state, if for
a specific event we invoke __ftrace_event_enable_disable with enable=1
and soft_disable=0, the EVENT_FILE_FL_ENABLED is set whereas
EVENT_FILE_FL_SOFT_MODE and EVENT_FILE_FL_SOFT_DISABLED are not.
Now if for that event we invoke __ftrace_event_enable_disable again with
enable=1 and soft_disable=1, EVENT_FILE_FL_ENABLED stays set,
EVENT_FILE_FL_SOFT_MODE is set, while EVENT_FILE_FL_SOFT_DISABLED
remains not set. Instead if from the initial state we directly invoke
__ftrace_event_enable_disable with enable=1 and soft_disable=1, all
the status flag mentioned above are all set (EVENT_FILE_FL_ENABLED,
EVENT_FILE_FL_SOFT_MODE and EVENT_FILE_FL_SOFT_DISABLED).
Now I wonder if:
a) such a behaviour is consistent with the code expectation;
b) if it would make sense to have a standard enable invocation followed
   by a soft enable invocation to end up in the same state as a single
   invocation of soft enable;
c) eventually if we could get rid of the soft_mode flag and simplify
   the code to only use the soft_disabled flag.

Probably there are aspects that I am missing and I really appreciate
your inputs/views

Thanks
Gab
---
 kernel/trace/trace_events.c | 125 +++++++++++++++++++++++++++++++-----
 1 file changed, 109 insertions(+), 16 deletions(-)

diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 069e92856bda..25e44586a985 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -752,6 +752,54 @@ void trace_event_enable_tgid_record(bool enable)
 	} while_for_each_event_file();
 }
 
+/*
+ * __ftrace_event_enable_disable - enable or disable a trace event
+ * @file: trace event file associated with the event.
+ * @enable: 0 or 1 respectively to disable/enable the event (any other value is
+ * invalid).
+ * @soft_disable: 1 or 0 respectively to mark if the enable parameter IS or
+ * IS NOT a soft enable/disable.
+ *
+ * Function Expectations:
+ * - If soft_disable is 1 a reference counter associated with the trace
+ * event shall be increased or decreased according to the enable parameter
+ * being 1 (enable) or 0 (disable) respectively.
+ * If the reference counter is > 0 before the increase or after the decrease,
+ * no other actions shall be taken.
+ *
+ * - if soft_disable is 1 and the trace event reference counter is 0 before
+ * the increase or after the decrease, an enable value set to 0 or 1 shall set
+ * or clear the soft mode flag respectively; this is characterized by disabling
+ * or enabling the use of trace_buffered_event respectively.
+ *
+ * - If soft_disable is 1 and enable is 0 and the reference counter reaches
+ * zero and if the soft disabled flag is set (i.e. if the event was previously
+ * enabled with soft_disable = 1), tracing for the trace point event shall be
+ * disabled and the soft disabled flag shall be cleared.
+ *
+ * - If soft_disable is 0 and enable is 0, tracing for the trace point event
+ * shall be disabled only if the soft mode flag is clear (i.e. event previously
+ * enabled with soft_disable = 0). Additionally the soft disabled flag shall be
+ * set or cleared according to the soft mode flag being set or clear
+ * respectively.
+ *
+ * - If enable is 1, tracing for the trace point event shall be enabled (if
+ * previously disabled); in addition if soft_disable is 1 and the reference
+ * counter is 0 before the increase, the soft disabled flag shall be set.
+ *
+ * - When enabling or disabling tracing for the trace point event
+ * the flags associated with comms and tgids shall be checked and, if set,
+ * respectively tracing of comms and tgdis at sched_switch shall be
+ * enabled/disabled.
+ *
+ * Returns 0 on success, or any error returned by the event register or
+ * unregister callbacks.
+ *
+ * NOTE: in order to invoke this code in a thread-safe way, event_mutex shall
+ * be locked before calling it.
+ * NOTE: the validity of the input pointer file shall be checked by the caller
+ *
+ */
 static int __ftrace_event_enable_disable(struct trace_event_file *file,
 					 int enable, int soft_disable)
 {
@@ -1285,7 +1333,37 @@ static void remove_event_file_dir(struct trace_event_file *file)
 }
 
 /*
- * __ftrace_set_clr_event(NULL, NULL, NULL, set) will set/unset all events.
+ * __ftrace_set_clr_event_nolock - enable or disable an event within a system
+ * (thread-unsafe).
+ * @tr: target trace_array containing the events list (shall be a non-NULL
+ * valid pointer).
+ * @match: target system or event name (NULL for any).
+ * @sub: target system name (NULL for any).
+ * @event: target event name (NULL for any).
+ * @set: 1 to enable, 0 to disable (any other value is invalid).
+ * @mod: target module name (NULL for any).
+ *
+ * Function's Expectations:
+ * - If mod is set, the mod name shall be sanitized by replacing all '-' with
+ *   '_' to match the modules' naming convention used in the Kernel.
+ * - From the events' list in the input tr, the ensemble of events to be enabled
+ *   or disabled shall be selected according to the input match, sub, event and
+ *   mod parameters. Each of these parameters, if set, shall restrict the events
+ *   ensemble to those with a matching parameter's name.
+ * - For each of the selected events the IGNORE_ENABLE flag shall be checked,
+ *   and, if not set, ftrace_event_enable_disable shall be invoked passing the
+ *   input set parameter to either enable or disable the event.
+ *
+ * Returns 0 on success, -EINVAL if the parameters do not match any registered
+ * events, -ENOMEM if memory allocation fails for the module pointer or the
+ * error condition returned by the first call to ftrace_event_enable_disable
+ * that returned an error.
+ *
+ * NOTE: in order to invoke this code in a thread-safe way, event_mutex shall
+ * be locked before calling it.
+ * NOTE: the validity of the input pointer tr shall be checked by the caller.
+ * NOTE: __ftrace_set_clr_event_nolock(NULL, NULL, NULL, set, NULL) will
+ * set/unset all events.
  */
 static int
 __ftrace_set_clr_event_nolock(struct trace_array *tr, const char *match,
@@ -1428,16 +1506,24 @@ int ftrace_set_clr_event(struct trace_array *tr, char *buf, int set)
 }
 
 /**
- * trace_set_clr_event - enable or disable an event
- * @system: system name to match (NULL for any system)
- * @event: event name to match (NULL for all events, within system)
- * @set: 1 to enable, 0 to disable
+ * trace_set_clr_event - enable or disable an event within a system.
+ * @system: system name (NULL for any system).
+ * @event: event name (NULL for all events, within system).
+ * @set: 1 to enable, 0 to disable (any other value is invalid).
  *
  * This is a way for other parts of the kernel to enable or disable
  * event recording.
  *
- * Returns 0 on success, -EINVAL if the parameters do not match any
- * registered events.
+ * Function's expectations:
+ * - This function shall retrieve the pointer of the global trace array (global
+ *   tracer) and pass it, along the rest of input parameters, to
+ *   __ftrace_set_clr_event_nolock.
+ * - This function shall properly lock/unlock the global event_mutex
+ *   before/after invoking ftrace_set_clr_event_nolock.
+ *
+ * Returns 0 on success, -ENODEV if the global tracer cannot be retrieved,
+ * -EINVAL if the parameters do not match any registered events, any other
+ * error condition returned by __ftrace_set_clr_event_nolock.
  */
 int trace_set_clr_event(const char *system, const char *event, int set)
 {
@@ -1451,17 +1537,24 @@ int trace_set_clr_event(const char *system, const char *event, int set)
 EXPORT_SYMBOL_GPL(trace_set_clr_event);
 
 /**
- * trace_array_set_clr_event - enable or disable an event for a trace array.
- * @tr: concerned trace array.
- * @system: system name to match (NULL for any system)
- * @event: event name to match (NULL for all events, within system)
- * @enable: true to enable, false to disable
+ * trace_array_set_clr_event - enable or disable an event within a system for
+ * a trace array.
+ * @tr: input trace array.
+ * @system: system name (NULL for any system).
+ * @event: event name (NULL for all events, within system).
+ * @enable: true to enable, false to disable.
  *
- * This is a way for other parts of the kernel to enable or disable
- * event recording.
+ * This is a way for other parts of the kernel to enable or disable event
+ * recording.
+ *
+ * Fumction's expectations:
+ * - This function shall properly lock/unlock the global event_mutex
+ *   before/after invoking ftrace_set_clr_event_nolock passing along the same
+ *   input parameters.
  *
- * Returns 0 on success, -EINVAL if the parameters do not match any
- * registered events.
+ * Returns 0 on success, -ENOENT if the input tr is NULL, -EINVAL if the
+ * parameters do not match any registered events, any other error condition
+ * returned by __ftrace_set_clr_event_nolock.
  */
 int trace_array_set_clr_event(struct trace_array *tr, const char *system,
 		const char *event, bool enable)
-- 
2.48.1

