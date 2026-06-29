Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 074B73F825E
	for <linux-trace-kernel@vger.kernel.org>; Mon, 29 Jun 2026 08:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782722253; cv=none; b=j+iFR/dcDOLSOTkbnJ9CGXACQHpgumzULItN6dZN++8gWm/DWkt8xJ0c2VmAqpz2AA65iKfJYmjA8dDZfc+mXXPsXhHCKGIumu7vpLhKf0+2nsCeCXNtkznewsr5H1iV9W6Swc7r/9vNMXg8stZI82EAUrZ7RZW6Cuv5EkrkmNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782722253; c=relaxed/simple;
	bh=giU2J8dHLRb7c3ea0FQ1OEq4mLUzp9+a2ptzJ2ue4qU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=gdYb+W2UWMhDFvlVm0rjSRM2VQO45r4GDYcM2LfISR+hlmadHqIvrpCJl1IC20EkIkQ7PxbI+54m8wgq+/Il2bhIPwzc5p9klV9zSkUz7WKv5rd+/rb2a5bVCjcncv+KYT8JY2EzlAIrtqpKqjTqYVizx5ESiN16j+XBUtMgSQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eSyXqc3p; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eSyXqc3p"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782722251;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9QKEIDXX1s/K4NXuJBjEmLIkyMh1/If5EH6/StWaXLc=;
	b=eSyXqc3pPzNGwjsih+mRpcMYRS/nulClC9/2m/WcLD6XOL1HnNXg0cBh2dT7BWilPq9/mx
	rBanTD+hQH9cEgqtg7Zi3e0uERpx8sYK33k3wCRfxz1tz4uFbcN/LWmIc/X768xOxvCzw8
	c+4dEcXkx2xjORh6MuGIPCC8wDcRh30=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-688-k60G_2q7MwK96ngRWViiBA-1; Mon,
 29 Jun 2026 04:37:28 -0400
X-MC-Unique: k60G_2q7MwK96ngRWViiBA-1
X-Mimecast-MFC-AGG-ID: k60G_2q7MwK96ngRWViiBA_1782722247
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 503BE1956095;
	Mon, 29 Jun 2026 08:37:27 +0000 (UTC)
Received: from fedora.brq.redhat.com (unknown [10.43.17.109])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3499C1774;
	Mon, 29 Jun 2026 08:37:24 +0000 (UTC)
From: Tomas Glozar <tglozar@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Tomas Glozar <tglozar@redhat.com>
Cc: John Kacur <jkacur@redhat.com>,
	Luis Goncalves <lgoncalv@redhat.com>,
	Crystal Wood <crwood@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Wander Lairson Costa <wander@redhat.com>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>
Subject: [PATCH 4/4] Documentation/rtla: Document unsetting options
Date: Mon, 29 Jun 2026 10:36:54 +0200
Message-ID: <20260629083654.1548925-4-tglozar@redhat.com>
In-Reply-To: <20260629083654.1548925-1-tglozar@redhat.com>
References: <20260629083654.1548925-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Mimecast-MFC-PROC-ID: xzej_gj9oG_rl6pYp9eQwclh1Lb0x02Q1ZCS8mXmq0M_1782722247
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Add an appendix documenting how to unset options in RTLA. For options
where unsetting is currently not supported, add a note into the
respective section.

An additional note is added for --on-threshold trace. As it is
considered distinct from --trace, it is not reverted by --no-trace.

Signed-off-by: Tomas Glozar <tglozar@redhat.com>
---
 Documentation/tools/rtla/common_appendix.txt    | 17 +++++++++++++++++
 Documentation/tools/rtla/common_options.txt     | 13 ++++++++++++-
 .../tools/rtla/common_osnoise_options.txt       |  4 ++++
 .../tools/rtla/common_timerlat_options.txt      |  4 ++++
 4 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/Documentation/tools/rtla/common_appendix.txt b/Documentation/tools/rtla/common_appendix.txt
index 68cb15840d3a9..ad610ed02a240 100644
--- a/Documentation/tools/rtla/common_appendix.txt
+++ b/Documentation/tools/rtla/common_appendix.txt
@@ -1,5 +1,22 @@
 .. SPDX-License-Identifier: GPL-2.0
 
+UNSETTING OPTIONS
+=================
+
+The effect of most command line options can be reverted by prepending "no-" to
+the long variant of the option, for example:
+
+$ rtla timerlat top -p 100 --no-period
+
+resets the period back to the default value of 1000 us.
+
+If a command line option sets multiple RTLA parameters at once, the inverted
+option will revert all of them, even if they were not set by the particular
+option. For example, since using "--auto" implies "--trace", specifying
+"--trace --no-auto" will also disable trace output, just like if "--no-trace"
+was specified.
+
+
 SIGINT BEHAVIOR
 ===============
 
diff --git a/Documentation/tools/rtla/common_options.txt b/Documentation/tools/rtla/common_options.txt
index 6caa51d029347..38da1cf443a48 100644
--- a/Documentation/tools/rtla/common_options.txt
+++ b/Documentation/tools/rtla/common_options.txt
@@ -22,10 +22,14 @@
 
         Enable an event in the trace (**-t**) session. The argument can be a specific event, e.g., **-e** *sched:sched_switch*, or all events of a system group, e.g., **-e** *sched*. Multiple **-e** are allowed. It is only active when **-t** or **-a** are set.
 
+        This option cannot be unset.
+
 **--filter** *<filter>*
 
         Filter the previous **-e** *sys:event* event with *<filter>*. For further information about event filtering see https://www.kernel.org/doc/html/latest/trace/events.html#event-filtering.
 
+        This option cannot be unset.
+
 **--trigger** *<trigger>*
         Enable a trace event trigger to the previous **-e** *sys:event*.
         If the *hist:* trigger is activated, the output histogram will be automatically saved to a file named *system_event_hist.txt*.
@@ -37,6 +41,8 @@
 
         For further information about event trigger see https://www.kernel.org/doc/html/latest/trace/events.html#event-triggers.
 
+        This option cannot be unset.
+
 **-P**, **--priority** *o:prio|r:prio|f:prio|d:runtime:period*
 
         Set scheduling parameters to the |tool| tracer threads, the format to set the priority are:
@@ -78,7 +84,8 @@
 
           Saves trace output, optionally taking a filename. Alternative to -t/--trace.
           Note that unlike -t/--trace, specifying this multiple times will result in
-          the trace being saved multiple times.
+          the trace being saved multiple times, and --no-trace will not disable trace
+          output when enabled through this option.
 
         - *signal,num=<sig>,pid=<pid>*
 
@@ -107,6 +114,8 @@
 
         |actionsperf|
 
+        This option cannot be unset.
+
 **--on-end** *action*
 
         Defines an action to be executed at the end of tracing.
@@ -124,6 +133,8 @@
 
         This runs rtla with the default options, and saves trace output at the end.
 
+        This option cannot be unset.
+
 **-h**, **--help**
 
         Print help menu.
diff --git a/Documentation/tools/rtla/common_osnoise_options.txt b/Documentation/tools/rtla/common_osnoise_options.txt
index bd3c4f4991939..5fc70c0016158 100644
--- a/Documentation/tools/rtla/common_osnoise_options.txt
+++ b/Documentation/tools/rtla/common_osnoise_options.txt
@@ -24,11 +24,15 @@
         Stop the trace if a single sample is higher than the argument in microseconds.
         If **-T** is set, it will also save the trace to the output.
 
+        This option cannot be unset.
+
 **-S**, **--stop-total** *us*
 
         Stop the trace if the total sample is higher than the argument in microseconds.
         If **-T** is set, it will also save the trace to the output.
 
+        This option cannot be unset.
+
 **-T**, **--threshold** *us*
 
         Specify the minimum delta between two time reads to be considered noise.
diff --git a/Documentation/tools/rtla/common_timerlat_options.txt b/Documentation/tools/rtla/common_timerlat_options.txt
index 100840f4c0ed0..e36898438a0b0 100644
--- a/Documentation/tools/rtla/common_timerlat_options.txt
+++ b/Documentation/tools/rtla/common_timerlat_options.txt
@@ -23,10 +23,14 @@
 
         Stop trace if the *IRQ* latency is higher than the argument in us.
 
+        This option cannot be unset.
+
 **-T**, **--thread** *us*
 
         Stop trace if the *Thread* latency is higher than the argument in us.
 
+        This option cannot be unset.
+
 **-s**, **--stack** *us*
 
         Save the stack trace at the *IRQ* if a *Thread* latency is higher than the
-- 
2.54.0

