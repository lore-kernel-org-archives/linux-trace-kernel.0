Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46DF42505D6
	for <linux-trace-kernel@vger.kernel.org>; Fri, 20 Jun 2025 08:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750409804; cv=none; b=JX9S7wq5pDvjmXRNiNthXwsbbm4ST9rN1OfNjLkiPLLDxcjYvqxtPc/PBZ5XHALL2mmV2zk4+kop5eMV/r2z4f2Izi7U8bh8vXLIdysPeY/X9IPzIMtZ3r/DEjZvMpdjEpDMyhDuP2ndscX5uY6LY3qyfdbPYq0MPvfQLUzlfQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750409804; c=relaxed/simple;
	bh=kT834MvHbP89pLjhtcmn/9DSD+4ck5nUp6NBpaX65jM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JeTRqd3hqahw7zrQY3wTOFuyy9gTHIRZRjBe1r2yY621yBTdUJVBjbHbHo5+/eMCdcjPQCRLtsS/2Mftl31oZHck1HafmYhDJmPaaQ7mY0sMu91xfV1lyY/O0c0/871dTqfF1/uP/9IPFP8lGQbU1x8yn1v8h1EBDyXdKOrlcUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WjaY9yhU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WjaY9yhU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750409801;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=QHUMSg7PxNE16EsoxOjiC+rrVYGmbTOpJbJumyBpqxU=;
	b=WjaY9yhUajKzVJbJQkVdkY2Fa8oo8/+rluxU33dGDFtDQUAHyOcposlg+ByHbDaLs7ahXi
	uz4yRm8fRz2tc287IB8JLD6UPgAK6vEXCTr6gVDGVuUmQoJCH1ZPdPM4RXkUnBCpvz0ayP
	uu4Pl/KeXtZm83dJO1F8mjnD+8sV/ko=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-688-rtS-FWd6MQmF4xtABjAkRQ-1; Fri,
 20 Jun 2025 04:56:35 -0400
X-MC-Unique: rtS-FWd6MQmF4xtABjAkRQ-1
X-Mimecast-MFC-AGG-ID: rtS-FWd6MQmF4xtABjAkRQ_1750409794
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 05CEA1800366;
	Fri, 20 Jun 2025 08:56:34 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.242.29])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0C1CE195609D;
	Fri, 20 Jun 2025 08:56:30 +0000 (UTC)
From: Gabriele Paoloni <gpaoloni@redhat.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: Gabriele Paoloni <gpaoloni@redhat.com>
Subject: [RFC PATCH RESEND] tracing: add kernel documentation for trace_array_set_clr_event, trace_set_clr_event and supporting functions
Date: Fri, 20 Jun 2025 10:56:18 +0200
Message-ID: <20250620085618.4489-1-gpaoloni@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

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
Re-sending as no feedbacks have been received.
---
 kernel/trace/trace_events.c | 125 +++++++++++++++++++++++++++++++-----
 1 file changed, 109 insertions(+), 16 deletions(-)

diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 120531268abf..4bd1f6e73ef1 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -763,6 +763,54 @@ void trace_event_enable_tgid_record(bool enable)
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
+ * Function's expectations:
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
@@ -1296,7 +1344,37 @@ static void remove_event_file_dir(struct trace_event_file *file)
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
+ * Function's expectations:
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
@@ -1439,16 +1517,24 @@ int ftrace_set_clr_event(struct trace_array *tr, char *buf, int set)
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
@@ -1462,17 +1548,24 @@ int trace_set_clr_event(const char *system, const char *event, int set)
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
+ * Function's expectations:
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

