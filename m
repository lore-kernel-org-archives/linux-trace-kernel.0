Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 686CA314A99
	for <linux-trace-kernel@vger.kernel.org>; Fri, 19 Sep 2025 14:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758291037; cv=none; b=Ix4C5ih6lkVUlq7Rg9Kk0zgAkk5qz8cYhoqQet1fqJIqoKeueKSNeCSnpxj+KLoFvM0dEiAaDwbtW3gOzyDb46fjTCttDwof6jv08zCgFsXgA36bW+k/Rk/Z6qzTh+ry+1rxEy3/2oJprBTKH4RBPvNDMHxPbI9JPgPJblU6Cjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758291037; c=relaxed/simple;
	bh=JEgQH/hx0gfCIgaH3JsGviLZ9oYHPX/3+A5PUXMXsS4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M/Iqw7+YZueIsn5yjyQlXah5qr+Zjoro/96EgWioTMp9lq/MZwjEv2/iUUWLbI0HBXiVw9wyjIzC8wWVNFyPkmwltZFxb2vG5InO5kPQNYsM4JkER7qGkK6ej+A0eRuzfrh2rW64eOOTybcG4NyloCaVGVQgjsGiHNGP5NRqHkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aAsFIYIz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aAsFIYIz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758291034;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ctd0sbj59+cEEyKjmHKbm9ENMgLs3vvkYmQ4XSPQF6A=;
	b=aAsFIYIzIXAGeZK+/FPi2AGzdfQoo7FJxjxc50zEixErKMU5EqrjNqG4hpI6dOQD8CMzyx
	yHP4jCLXcLUeJEpYt7d1fFmAoaSLxvah0hMcRnskSJB+bGAUr+WkGS+Vh2nfb/BR493KM+
	eGX592xFKKKYFCcZLk3CEWX7Y0FD0Bg=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-659-lXIqJh4DOZGQafETFfdwEQ-1; Fri,
 19 Sep 2025 10:10:28 -0400
X-MC-Unique: lXIqJh4DOZGQafETFfdwEQ-1
X-Mimecast-MFC-AGG-ID: lXIqJh4DOZGQafETFfdwEQ_1758291027
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 66FC61955ECF;
	Fri, 19 Sep 2025 14:10:27 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (unknown [10.45.224.13])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2841819560BB;
	Fri, 19 Sep 2025 14:10:21 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-trace-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Cc: Gabriele Monaco <gmonaco@redhat.com>,
	Nam Cao <namcao@linutronix.de>,
	Tomas Glozar <tglozar@redhat.com>,
	Juri Lelli <jlelli@redhat.com>,
	Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: [PATCH v2 04/20] Documentation/rv: Adapt documentation after da_monitor refactoring
Date: Fri, 19 Sep 2025 16:09:38 +0200
Message-ID: <20250919140954.104920-5-gmonaco@redhat.com>
In-Reply-To: <20250919140954.104920-1-gmonaco@redhat.com>
References: <20250919140954.104920-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Previous changes refactored the da_monitor header file to avoid using
macros. This implies a few changes in how to import and use da_monitor
helpers:

 DECLARE_DA_MON_<TYPE>(name, type) is substituted by
 #define RV_MON_TYPE RV_MON_<TYPE>

 da_handle_event_<name>() is substituted by
 da_handle_event()

Update the documentation to reflect the changes.

Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 Documentation/trace/rv/monitor_synthesis.rst | 44 ++++++++++----------
 1 file changed, 21 insertions(+), 23 deletions(-)

diff --git a/Documentation/trace/rv/monitor_synthesis.rst b/Documentation/trace/rv/monitor_synthesis.rst
index ac808a7554f5..ce0c1a5104d4 100644
--- a/Documentation/trace/rv/monitor_synthesis.rst
+++ b/Documentation/trace/rv/monitor_synthesis.rst
@@ -100,54 +100,52 @@ rv/da_monitor.h
 
 This initial implementation presents three different types of monitor instances:
 
-- ``#define DECLARE_DA_MON_GLOBAL(name, type)``
-- ``#define DECLARE_DA_MON_PER_CPU(name, type)``
-- ``#define DECLARE_DA_MON_PER_TASK(name, type)``
+- ``#define RV_MON_TYPE RV_MON_GLOBAL``
+- ``#define RV_MON_TYPE RV_MON_PER_CPU``
+- ``#define RV_MON_TYPE RV_MON_PER_TASK``
 
-The first declares the functions for a global deterministic automata monitor,
-the second for monitors with per-cpu instances, and the third with per-task
-instances.
+The first sets up functions declaration for a global deterministic automata
+monitor, the second for monitors with per-cpu instances, and the third with
+per-task instances.
 
-In all cases, the 'name' argument is a string that identifies the monitor, and
-the 'type' argument is the data type used by rvgen on the representation of
-the model in C.
+In all cases, the C file must include the $(MODEL_NAME).h file (generated by
+`rvgen`), for example, to define the per-cpu 'wip' monitor, the `wip.c` source
+file must include::
 
-For example, the wip model with two states and three events can be
-stored in an 'unsigned char' type. Considering that the preemption control
-is a per-cpu behavior, the monitor declaration in the 'wip.c' file is::
-
-  DECLARE_DA_MON_PER_CPU(wip, unsigned char);
+  #define RV_MON_TYPE RV_MON_PER_CPU
+  #include "wip.h"
+  #include <rv/da_monitor.h>
 
 The monitor is executed by sending events to be processed via the functions
 presented below::
 
-  da_handle_event_$(MONITOR_NAME)($(event from event enum));
-  da_handle_start_event_$(MONITOR_NAME)($(event from event enum));
-  da_handle_start_run_event_$(MONITOR_NAME)($(event from event enum));
+  da_handle_event($(event from event enum));
+  da_handle_start_event($(event from event enum));
+  da_handle_start_run_event($(event from event enum));
 
-The function ``da_handle_event_$(MONITOR_NAME)()`` is the regular case where
+The function ``da_handle_event()`` is the regular case where
 the event will be processed if the monitor is processing events.
 
 When a monitor is enabled, it is placed in the initial state of the automata.
 However, the monitor does not know if the system is in the *initial state*.
 
-The ``da_handle_start_event_$(MONITOR_NAME)()`` function is used to notify the
+The ``da_handle_start_event()`` function is used to notify the
 monitor that the system is returning to the initial state, so the monitor can
 start monitoring the next event.
 
-The ``da_handle_start_run_event_$(MONITOR_NAME)()`` function is used to notify
+The ``da_handle_start_run_event()`` function is used to notify
 the monitor that the system is known to be in the initial state, so the
 monitor can start monitoring and monitor the current event.
 
 Using the wip model as example, the events "preempt_disable" and
 "sched_waking" should be sent to monitor, respectively, via [2]::
 
-  da_handle_event_wip(preempt_disable_wip);
-  da_handle_event_wip(sched_waking_wip);
+  da_handle_event(preempt_disable_wip);
+  da_handle_event(sched_waking_wip);
 
 While the event "preempt_enabled" will use::
 
-  da_handle_start_event_wip(preempt_enable_wip);
+  da_handle_start_event(preempt_enable_wip);
 
 To notify the monitor that the system will be returning to the initial state,
 so the system and the monitor should be in sync.
-- 
2.51.0

