Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A62CA6F
	for <linux-trace-kernel@vger.kernel.org>; Thu, 14 Aug 2025 12:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755174119; cv=none; b=X04KNT2SlYf+QV8e7O8rcnBDdmjhDxPQ69OUfP+M0dOTJVrLNw9tG6jeUK+I0YPQgz7TdhRJHiaNwUw7EYRLydr2xRh+jdY2wKEX1o6Vx3zTgmGastjYTLP38xxpn+mUqyz5TPlt5hPuoPsOVhr6keQ8fjfbp/d1YxgeSSGcxck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755174119; c=relaxed/simple;
	bh=uOaDapUnKb+qTs1ZJn6rke2cm5asdDzUV3c5syC+dkw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ul5uoD3QPgtWi3vlsRGvvYLCCtc7N4gtItw9OV0TlwibmilDMNAqpYa6+eczjcTHCJEbX5UGVe3P0+Duw36A0n0OOYNmKSmDO7S+o5g93Rf7iw1BlV8EidzKgiNYb6/fJygd3wmvV1w1vaE/YVHSk0LyR0gCxuMLN6wpO8Nolso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LhEZp03m; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LhEZp03m"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755174116;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=/+Mfk5PWyl7ilhAxz30LR861r4iNY/M2FmAaRCro/hU=;
	b=LhEZp03mkKkIR6CRNlZ/gU1xy82sSA3MvsVdhqGPaLFsHKYyKJ1LNTXrryVYkIYYhryo11
	BkZ1LdAvgi1OYFgkrI36ajibA230KE1x4wv+fuw8i7jeySqkg8XatGt6R7UsHrrbMGx51b
	jffbkovOUOZ1CaWQE0Fxdhvwtc+7CwU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-518-b_tJ3AOxNnyXcKEeFaslcg-1; Thu,
 14 Aug 2025 08:21:53 -0400
X-MC-Unique: b_tJ3AOxNnyXcKEeFaslcg-1
X-Mimecast-MFC-AGG-ID: b_tJ3AOxNnyXcKEeFaslcg_1755174112
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 37A6B197753E;
	Thu, 14 Aug 2025 12:21:52 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.22.15])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9FD4F180035C;
	Thu, 14 Aug 2025 12:21:48 +0000 (UTC)
From: Gabriele Paoloni <gpaoloni@redhat.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: Gabriele Paoloni <gpaoloni@redhat.com>
Subject: [PATCH v2] tracing: add kernel documentation for trace_array_set_clr_event, trace_set_clr_event and supporting functions
Date: Thu, 14 Aug 2025 14:21:41 +0200
Message-ID: <20250814122141.109076-1-gpaoloni@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

As per Linux Kernel documentation guidelines
(https://docs.kernel.org/doc-guide/kernel-doc.html),
<<Every function that is exported to loadable modules using
EXPORT_SYMBOL or EXPORT_SYMBOL_GPL should have a kernel-doc
comment>>;
hence this patch adds detailed kernel-doc headers documentation
for trace_array_set_clr_event(), trace_set_clr_event() and the
main functions in the respective call-trees that support their
functionalities.

For each of the documented functions, as part of the extensive
description, a set of "Function's expectations" and "Assumptions
of Use" are described in a way that facilitate:

1) evaluating the current code and any proposed modification
   to behave as described;

2) writing kernel tests to verify the code to behave as described.

Signed-off-by: Gabriele Paoloni <gpaoloni@redhat.com>
---
Changes from v1:
- Added "Context:" information
- Added "Assumptions of Use"
- __ftrace_event_enable_disable Function's expectations have been
  rewritten to replace the soft mode flag with the soft mode reference
  counter
- Addressed other comments from https://lore.kernel.org/linux-trace-kernel/20250620085618.4489-1-gpaoloni@redhat.com/T/#u
---
 kernel/trace/trace_events.c | 150 ++++++++++++++++++++++++++++++++----
 1 file changed, 133 insertions(+), 17 deletions(-)

diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 9f3e9537417d..9bad5e9669df 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -763,6 +763,58 @@ void trace_event_enable_tgid_record(bool enable)
 	} while_for_each_event_file();
 }
 
+/**
+ * __ftrace_event_enable_disable - enable or disable a trace event
+ * @file: trace event file associated with the event.
+ * @enable: 0 or 1 respectively to disable/enable the event.
+ * @soft_disable: 1 or 0 respectively to mark if the enable parameter IS or
+ * IS NOT a soft enable/disable.
+ *
+ * Function's expectations:
+ * - If soft_disable is 1 a soft mode reference counter associated with the
+ *   trace event shall be increased or decreased according to the enable
+ *   parameter being 1 (enable) or 0 (disable) respectively.
+ *   If the soft mode reference counter is > 0 before the increase or after
+ *   the decrease, no other actions shall be taken.
+ *
+ * - if soft_disable is 1 and the soft mode reference counter is 0 before
+ *   the increase or after the decrease, an enable value set to 0 or 1 shall
+ *   result in disabling or enabling the use of trace_buffered_event
+ *   respectively.
+ *
+ * - If soft_disable is 1 and enable is 0 and the soft mode reference counter
+ *   reaches zero and if the soft disabled flag is set (i.e. if the event was
+ *   previously enabled with soft_disable = 1), tracing for the trace point
+ *   event shall be disabled and the soft disabled flag shall be cleared.
+ *
+ * - If soft_disable is 0 and enable is 0, tracing for the trace point event
+ *   shall be disabled only if the soft mode reference counter is 0.
+ *   Additionally the soft disabled flag shall be set or cleared according to
+ *   the soft mode reference counter being greater than 0 or 0 respectively.
+ *
+ * - If enable is 1, tracing for the trace point event shall be enabled (if
+ *   previously disabled); in addition, if soft_disable is 1 and the soft mode
+ *   reference counter is 0 before the increase, the soft disabled flag shall
+ *   be set.
+ *
+ * - When enabling or disabling tracing for the trace point event
+ *   the flags associated with comms and tgids shall be checked and, if set,
+ *   respectively tracing of comms and tgdis at sched_switch shall be
+ *   enabled/disabled.
+ *
+ * Assumptions of Use:
+ * - for thread-safe execution, event_mutex shall be locked before calling
+ *   this function;
+ * - the file input pointer is assumed to be a valid one;
+ * - the enable input parameter shall not be set to any value other than 0
+ *   or 1.
+ *
+ * Context: process context.
+ *
+ * Return:
+ * * 0 on success
+ * * any error returned by the event register or unregister callbacks
+ */
 static int __ftrace_event_enable_disable(struct trace_event_file *file,
 					 int enable, int soft_disable)
 {
@@ -1296,8 +1348,46 @@ static void remove_event_file_dir(struct trace_event_file *file)
 	event_file_put(file);
 }
 
-/*
- * __ftrace_set_clr_event(NULL, NULL, NULL, set) will set/unset all events.
+/**
+ * __ftrace_set_clr_event_nolock - enable or disable an event within a system.
+ * @tr: target trace_array containing the events list.
+ * @match: target system or event name (NULL for any).
+ * @sub: target system name (NULL for any).
+ * @event: target event name (NULL for any).
+ * @set: 1 to enable, 0 to disable.
+ * @mod: target module name (NULL for any).
+ *
+ * Function's expectations:
+ * - If mod is set, the mod name shall be sanitized by replacing all '-' with
+ *   '_' to match the modules' naming convention used in the Kernel.
+ *
+ * - From the events' list in the input tr, the ensemble of events to be enabled
+ *   or disabled shall be selected according to the input match, sub, event and
+ *   mod parameters. Each of these parameters, if set, shall restrict the events
+ *   ensemble to those with a matching parameter's name.
+ *
+ * - For each of the selected events the IGNORE_ENABLE flag shall be checked,
+ *   and, if not set, ftrace_event_enable_disable shall be invoked passing the
+ *   input set parameter to either enable or disable the event.
+ *
+ * Assumptions of Use:
+ * - for thread-safe execution, event_mutex shall be locked before calling
+ *   this function;
+ * - the tr input pointer is assumed to be a valid one;
+ * - the set input parameter shall not be set to any value other than 0
+ *   or 1.
+ *
+ * NOTE: __ftrace_set_clr_event_nolock(NULL, NULL, NULL, set, NULL) will
+ * set/unset all events.
+ *
+ * Context: process context.
+ *
+ * Return:
+ * * 0 on success
+ * * %-EINVAL - the input parameters do not match any registered event
+ * * %-ENOMEM -  memory allocation fails for the module pointer
+ * * any value returned by the first call to ftrace_event_enable_disable that
+ * returned an error
  */
 static int
 __ftrace_set_clr_event_nolock(struct trace_array *tr, const char *match,
@@ -1440,16 +1530,32 @@ int ftrace_set_clr_event(struct trace_array *tr, char *buf, int set)
 }
 
 /**
- * trace_set_clr_event - enable or disable an event
- * @system: system name to match (NULL for any system)
- * @event: event name to match (NULL for all events, within system)
- * @set: 1 to enable, 0 to disable
+ * trace_set_clr_event - enable or disable an event within a system.
+ * @system: system name (NULL for any system).
+ * @event: event name (NULL for all events, within system).
+ * @set: 1 to enable, 0 to disable.
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
+ *
+ * - This function shall properly lock/unlock the global event_mutex
+ *   before/after invoking ftrace_set_clr_event_nolock.
+ *
+ * Assumptions of Use:
+ * - the set input parameter shall not be set to any value other than 0
+ *   or 1.
+ *
+ * Context: process context, locks and unlocks event_mutex.
+ *
+ * Return:
+ * * 0 on success
+ * * %-ENODEV - the global tracer cannot be retrieved
+ * * any other error condition returned by __ftrace_set_clr_event_nolock
  */
 int trace_set_clr_event(const char *system, const char *event, int set)
 {
@@ -1463,17 +1569,27 @@ int trace_set_clr_event(const char *system, const char *event, int set)
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
+ *
+ * Context: process context, locks and unlocks event_mutex.
  *
- * Returns 0 on success, -EINVAL if the parameters do not match any
- * registered events.
+ * Return:
+ * * 0 on success
+ * * %-ENOENT - the input tr is NULL
+ * * any other error condition returned by __ftrace_set_clr_event_nolock
  */
 int trace_array_set_clr_event(struct trace_array *tr, const char *system,
 		const char *event, bool enable)
-- 
2.48.1

