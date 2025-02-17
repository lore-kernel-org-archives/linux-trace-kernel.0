Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 446B821D5AC
	for <linux-trace-kernel@vger.kernel.org>; Mon, 17 Feb 2025 13:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739797995; cv=none; b=NZgStWAOsVK+mb5/THB8Arv/3kG+LLjJlFIYGOV83iV2fwm0TYhWNFmqtxLlM4et5wyG7TD0H6wOQxl4NjP915hDFhbz6kuqXgfj+rnf3Cv8XWy5WNHMI04nuf8drhxZtIaU3KDp2Ss1fUnTglVAb5YPMYgP0LZIYVeN+cIjoZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739797995; c=relaxed/simple;
	bh=IY7DU1BhjQRR5Coi7wNZ7++4LSEJz4/d+wLFVatOJNE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aGx1E57fqgajDrCQHBgz3LjAnw6xXVtTzv+DYgnSyspWx37uw+7iT0GF7sW+KLfyXaxvPIoz4OI5bvTLi7o0Hp/ocDrzcLjjyi9YgKoGIjulMnAxWUNwR/aEXI629fE0MG9MnjELxaxlEo+7uswfHww/cfgAGbHrzaXJZhgpj4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FZIo9Vbf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FZIo9Vbf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739797992;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rPPwrQnu9UKt/4NbsUXxMh/AuN498RxwAC9aj1izwuk=;
	b=FZIo9Vbf1Bk0wygpvY9wVzld+FrwMcFcTWI6BwKnlNFcfj5utJgpF4ZR/PP9vvKDPsXDL8
	8LO05lZc8k0ZbvrSsW9GJaHwwcLxYT2M2BRLTC6tuNnDfA1lAKwhZnM3+LRYbV1/NfYTvF
	KOw/Jj/BVHe/8mjCqXtB5NpyAljmYcQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-558-ygTBp7HxNZW0OzQPQN47oQ-1; Mon,
 17 Feb 2025 08:13:09 -0500
X-MC-Unique: ygTBp7HxNZW0OzQPQN47oQ-1
X-Mimecast-MFC-AGG-ID: ygTBp7HxNZW0OzQPQN47oQ_1739797988
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DA4ED1800876;
	Mon, 17 Feb 2025 13:13:07 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.com (unknown [10.44.32.190])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0ADFE1800360;
	Mon, 17 Feb 2025 13:13:03 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-doc@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: Gabriele Monaco <gmonaco@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	Clark Williams <williams@redhat.com>
Subject: [PATCH v2 10/11] Documentation/rv: Add docs for the sched monitors
Date: Mon, 17 Feb 2025 14:12:01 +0100
Message-ID: <20250217131206.388485-11-gmonaco@redhat.com>
In-Reply-To: <20250217131206.388485-1-gmonaco@redhat.com>
References: <20250217131206.388485-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Add man page and kernel documentation for the sched monitors, as sched
is a container of other monitors, document all in the same page.
sched is the first nested monitor, also explain what is a nested monitor
and how enabling containers or children monitors work.

To: Ingo Molnar <mingo@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: John Kacur <jkacur@redhat.com>
Cc: Clark Williams <williams@redhat.com>
Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 Documentation/tools/rv/rv-mon-sched.rst  |  69 +++++++++
 Documentation/trace/rv/monitor_sched.rst | 171 +++++++++++++++++++++++
 2 files changed, 240 insertions(+)
 create mode 100644 Documentation/tools/rv/rv-mon-sched.rst
 create mode 100644 Documentation/trace/rv/monitor_sched.rst

diff --git a/Documentation/tools/rv/rv-mon-sched.rst b/Documentation/tools/rv/rv-mon-sched.rst
new file mode 100644
index 0000000000000..da0fe4c79ae52
--- /dev/null
+++ b/Documentation/tools/rv/rv-mon-sched.rst
@@ -0,0 +1,69 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+============
+rv-mon-sched
+============
+-----------------------------
+Scheduler monitors collection
+-----------------------------
+
+:Manual section: 1
+
+SYNOPSIS
+========
+
+**rv mon sched** [*OPTIONS*]
+
+**rv mon <NESTED_MONITOR>** [*OPTIONS*]
+
+**rv mon sched:<NESTED_MONITOR>** [*OPTIONS*]
+
+DESCRIPTION
+===========
+
+The scheduler monitor collection is a container for several monitors to model
+the behaviour of the scheduler. Each monitor describes a specification that
+the scheduler should follow.
+
+As a monitor container, it will enable all nested monitors and set them
+according to OPTIONS.
+Nevertheless nested monitors can also be activated independently both by name
+and by specifying sched: , e.g. to enable only monitor tss you can do any of:
+
+    # rv mon sched:tss
+
+    # rv mon tss
+
+See kernel documentation for further information about this monitor:
+<https://docs.kernel.org/trace/rv/monitor_sched.html>
+
+OPTIONS
+=======
+
+.. include:: common_ikm.rst
+
+NESTED MONITOR
+==============
+
+The available nested monitors are:
+  * scpd: schedule called with preemption disabled
+  * snep: schedule does not enable preempt
+  * sncid: schedule not called with interrupt disabled
+  * snroc: set non runnable on its own context
+  * sco: scheduling context operations
+  * tss: task switch while scheduling
+
+SEE ALSO
+========
+
+**rv**\(1), **rv-mon**\(1)
+
+Linux kernel *RV* documentation:
+<https://www.kernel.org/doc/html/latest/trace/rv/index.html>
+
+AUTHOR
+======
+
+Written by Gabriele Monaco <gmonaco@redhat.com>
+
+.. include:: common_appendix.rst
diff --git a/Documentation/trace/rv/monitor_sched.rst b/Documentation/trace/rv/monitor_sched.rst
new file mode 100644
index 0000000000000..24b2c62a3bc26
--- /dev/null
+++ b/Documentation/trace/rv/monitor_sched.rst
@@ -0,0 +1,171 @@
+Scheduler monitors
+==================
+
+- Name: sched
+- Type: container for multiple monitors
+- Author: Gabriele Monaco <gmonaco@redhat.com>, Daniel Bristot de Oliveira <bristot@kernel.org>
+
+Description
+-----------
+
+Monitors describing complex systems, such as the scheduler, can easily grow to
+the point where they are just hard to understand because of the many possible
+state transitions.
+Often it is possible to break such descriptions into smaller monitors,
+sharing some or all events. Enabling those smaller monitors concurrently is,
+in fact, testing the system as if we had one single larger monitor.
+Splitting models into multiple specification is not only easier to
+understand, but gives some more clues when we see errors.
+
+The sched monitor is a set of specifications to describe the scheduler behaviour.
+It includes several per-cpu and per-task monitors that work independently to verify
+different specifications the scheduler should follow.
+
+To make this system as straightforward as possible, sched specifications are *nested*
+monitors, whereas sched itself is a *container*.
+From the interface perspective, sched includes other monitors as sub-directories,
+enabling/disabling or setting reactors to sched, propagates the change to all monitors,
+however single monitors can be used independently as well.
+
+It is important that future modules are built after their container (sched, in
+this case), otherwise the linker would not respect the order and the nesting
+wouldn't work as expected.
+To do so, simply add them after sched in the Makefile.
+
+Specifications
+--------------
+
+The specifications included in sched are currently a work in progress, adapting the ones
+defined in by Daniel Bristot in [1].
+
+Currently we included the following:
+
+Monitor tss
+~~~~~~~~~~~
+
+The task switch while scheduling (tss) monitor ensures a task switch happens
+only in scheduling context, that is inside a call to `__schedule`::
+
+                     |
+                     |
+                     v
+                   +-----------------+
+                   |     thread      | <+
+                   +-----------------+  |
+                     |                  |
+                     | schedule_entry   | schedule_exit
+                     v                  |
+    sched_switch                        |
+  +---------------                      |
+  |                       sched         |
+  +-------------->                     -+
+
+Monitor sco
+~~~~~~~~~~~
+
+The scheduling context operations (sco) monitor ensures changes in a task state
+happen only in thread context::
+
+
+                        |
+                        |
+                        v
+    sched_set_state   +------------------+
+  +------------------ |                  |
+  |                   |  thread_context  |
+  +-----------------> |                  | <+
+                      +------------------+  |
+                        |                   |
+                        | schedule_entry    | schedule_exit
+                        v                   |
+                                            |
+                       scheduling_context  -+
+
+Monitor snroc
+~~~~~~~~~~~~~
+
+The set non runnable on its own context (snroc) monitor ensures changes in a
+task state happens only in the respective task's context. This is a per-task
+monitor::
+
+                        |
+                        |
+                        v
+                      +------------------+
+                      |  other_context   | <+
+                      +------------------+  |
+                        |                   |
+                        | sched_switch_in   | sched_switch_out
+                        v                   |
+    sched_set_state                         |
+  +------------------                       |
+  |                       own_context       |
+  +----------------->                      -+
+
+Monitor scpd
+~~~~~~~~~~~~
+
+The schedule called with preemption disabled (scpd) monitor ensures schedule is
+called with preemption disabled::
+
+                       |
+                       |
+                       v
+                     +------------------+
+                     |    cant_sched    | <+
+                     +------------------+  |
+                       |                   |
+                       | preempt_disable   | preempt_enable
+                       v                   |
+    schedule_entry                         |
+    schedule_exit                          |
+  +-----------------      can_sched        |
+  |                                        |
+  +---------------->                      -+
+
+Monitor snep
+~~~~~~~~~~~~
+
+The schedule does not enable preempt (snep) monitor ensures a schedule call
+does not enable preemption::
+
+                        |
+                        |
+                        v
+    preempt_disable   +------------------------+
+    preempt_enable    |                        |
+  +------------------ | non_scheduling_context |
+  |                   |                        |
+  +-----------------> |                        | <+
+                      +------------------------+  |
+                        |                         |
+                        | schedule_entry          | schedule_exit
+                        v                         |
+                                                  |
+                          scheduling_contex      -+
+
+Monitor sncid
+~~~~~~~~~~~~~
+
+The schedule not called with interrupt disabled (sncid) monitor ensures
+schedule is not called with interrupt disabled::
+
+                       |
+                       |
+                       v
+    schedule_entry   +--------------+
+    schedule_exit    |              |
+  +----------------- |  can_sched   |
+  |                  |              |
+  +----------------> |              | <+
+                     +--------------+  |
+                       |               |
+                       | irq_disable   | irq_enable
+                       v               |
+                                       |
+                        cant_sched    -+
+
+References
+----------
+
+[1] - https://bristot.me/linux-task-model
-- 
2.48.1

