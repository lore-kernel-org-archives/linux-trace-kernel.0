Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA03E243951;
	Wed,  9 Jul 2025 19:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752088910; cv=none; b=CXnZecdntWVWSsQpr9M2heS9Ve0Ztuqao69Rotjvl2xSicjIP6jElbqL4VlDF+ecvxvsnO3yAxGMAO1CRejPckR4Y0rA7UuV9Rg2ovMBdqmZ37YCrrgUtJisAn6kjjmH4iLUmntTDHvz87H/1XFIbKB7B7XcYK8xGvbCmI2fbqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752088910; c=relaxed/simple;
	bh=QikPuesc4B/13zDdpgGHsddz3vJrrDz110M8NWmMzvY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UMQHUypqYF7et2vOUb+C6xHdHrEqDZvlxf+jXMvoT3hLbpHyG5oNw+HDeUYw2DTSY3NZ/lPF4Bc1flHCd3zuuRKM9G+QuHa0RLHJuexBuwmKPwStByFJDwghgeopsMjuJioSNHEt96plkpgdrLkKKCHspP5TnVWckgGe+TBqdCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sd0sBo95; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jmeEHfTW; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sd0sBo95";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jmeEHfTW"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752088907;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GvaGJm6tNpJP8KHlvubeC777ZLLmkrS528HtYD07bQE=;
	b=sd0sBo95cAKp3UQwHX9qCDT1jo9be9bfryZ0R6dD+4xekiE1ngrrmYmPXKZnMwmL4SY1yf
	O1NptUJkqumLymcGH2QC6AjCEk6kUiHly9BAMuE/AocENH3plDCZiaupsO+lYILO9PvW/V
	qYjRX4aEMHJQOILucY7lVlAGvcynboaWITMczL/5zUa2zHeo4jYGZnSZzG45TzQ7dXl+vl
	BZLq0efKQC1mKQlPfELSZNmmBVHNgGIdDJ38056YcI0A5AI31tIVxh3Ed9gFMLzuoBsOJR
	/DIM6UYAI3qAvo18dVLe2/BoOAdolm67ZM8TLLg7LgLuONowrKEz+XYT3jIL0Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752088907;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GvaGJm6tNpJP8KHlvubeC777ZLLmkrS528HtYD07bQE=;
	b=jmeEHfTWVjh4WIUOSA6i0zd2A5tQA8+6S5BEJab0rcyLIyE3MSt4CEv2sUg/C8250+vMgW
	T2IQDl+YT1C9YiBw==
To: Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Gabriele Monaco <gmonaco@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>
Subject: [PATCH v13 11/12] rv: Add documentation for rtapp monitor
Date: Wed,  9 Jul 2025 21:21:22 +0200
Message-Id: <df0242d74c12511e82cc9d73c082def91a160c74.1752088709.git.namcao@linutronix.de>
In-Reply-To: <cover.1752088709.git.namcao@linutronix.de>
References: <cover.1752088709.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add documentation describing the rtapp monitor.

Reviewed-by: Gabriele Monaco <gmonaco@redhat.com>
Signed-off-by: Nam Cao <namcao@linutronix.de>
---
 Documentation/trace/rv/index.rst         |   1 +
 Documentation/trace/rv/monitor_rtapp.rst | 133 +++++++++++++++++++++++
 2 files changed, 134 insertions(+)
 create mode 100644 Documentation/trace/rv/monitor_rtapp.rst

diff --git a/Documentation/trace/rv/index.rst b/Documentation/trace/rv/inde=
x.rst
index e80e0057feb4..26042dff70bb 100644
--- a/Documentation/trace/rv/index.rst
+++ b/Documentation/trace/rv/index.rst
@@ -13,3 +13,4 @@ Runtime Verification
    monitor_wip.rst
    monitor_wwnr.rst
    monitor_sched.rst
+   monitor_rtapp.rst
diff --git a/Documentation/trace/rv/monitor_rtapp.rst b/Documentation/trace=
/rv/monitor_rtapp.rst
new file mode 100644
index 000000000000..c8104eda924a
--- /dev/null
+++ b/Documentation/trace/rv/monitor_rtapp.rst
@@ -0,0 +1,133 @@
+Real-time application monitors
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
+
+- Name: rtapp
+- Type: container for multiple monitors
+- Author: Nam Cao <namcao@linutronix.de>
+
+Description
+-----------
+
+Real-time applications may have design flaws such that they experience
+unexpected latency and fail to meet their time requirements. Often, these =
flaws
+follow a few patterns:
+
+  - Page faults: A real-time thread may access memory that does not have a
+    mapped physical backing or must first be copied (such as for copy-on-w=
rite).
+    Thus a page fault is raised and the kernel must first perform the expe=
nsive
+    action. This causes significant delays to the real-time thread
+  - Priority inversion: A real-time thread blocks waiting for a lower-prio=
rity
+    thread. This causes the real-time thread to effectively take on the
+    scheduling priority of the lower-priority thread. For example, the rea=
l-time
+    thread needs to access a shared resource that is protected by a
+    non-pi-mutex, but the mutex is currently owned by a non-real-time thre=
ad.
+
+The `rtapp` monitor detects these patterns. It aids developers to identify
+reasons for unexpected latency with real-time applications. It is a contai=
ner of
+multiple sub-monitors described in the following sections.
+
+Monitor pagefault
++++++++++++++++++
+
+The `pagefault` monitor reports real-time tasks raising page faults. Its
+specification is::
+
+  RULE =3D always (RT imply not PAGEFAULT)
+
+To fix warnings reported by this monitor, `mlockall()` or `mlock()` can be=
 used
+to ensure physical backing for memory.
+
+This monitor may have false negatives because the pages used by the real-t=
ime
+threads may just happen to be directly available during testing.  To minim=
ize
+this, the system can be put under memory pressure (e.g.  invoking the OOM =
killer
+using a program that does `ptr =3D malloc(SIZE_OF_RAM); memset(ptr, 0,
+SIZE_OF_RAM);`) so that the kernel executes aggressive strategies to recyc=
le as
+much physical memory as possible.
+
+Monitor sleep
++++++++++++++
+
+The `sleep` monitor reports real-time threads sleeping in a manner that may
+cause undesirable latency. Real-time applications should only put a real-t=
ime
+thread to sleep for one of the following reasons:
+
+  - Cyclic work: real-time thread sleeps waiting for the next cycle. For t=
his
+    case, only the `clock_nanosleep` syscall should be used with `TIMER_AB=
STIME`
+    (to avoid time drift) and `CLOCK_MONOTONIC` (to avoid the clock being
+    changed). No other method is safe for real-time. For example, threads
+    waiting for timerfd can be woken by softirq which provides no real-time
+    guarantee.
+  - Real-time thread waiting for something to happen (e.g. another thread
+    releasing shared resources, or a completion signal from another thread=
). In
+    this case, only futexes (FUTEX_LOCK_PI, FUTEX_LOCK_PI2 or one of
+    FUTEX_WAIT_*) should be used.  Applications usually do not use futexes
+    directly, but use PI mutexes and PI condition variables which are buil=
t on
+    top of futexes. Be aware that the C library might not implement condit=
ional
+    variables as safe for real-time. As an alternative, the librtpi library
+    exists to provide a conditional variable implementation that is correc=
t for
+    real-time applications in Linux.
+
+Beside the reason for sleeping, the eventual waker should also be
+real-time-safe. Namely, one of:
+
+  - An equal-or-higher-priority thread
+  - Hard interrupt handler
+  - Non-maskable interrupt handler
+
+This monitor's warning usually means one of the following:
+
+  - Real-time thread is blocked by a non-real-time thread (e.g. due to
+    contention on a mutex without priority inheritance). This is priority
+    inversion.
+  - Time-critical work waits for something which is not safe for real-time=
 (e.g.
+    timerfd).
+  - The work executed by the real-time thread does not need to run at real=
-time
+    priority at all.  This is not a problem for the real-time thread itsel=
f, but
+    it is potentially taking the CPU away from other important real-time w=
ork.
+
+Application developers may purposely choose to have their real-time applic=
ation
+sleep in a way that is not safe for real-time. It is debatable whether tha=
t is a
+problem. Application developers must analyze the warnings to make a proper
+assessment.
+
+The monitor's specification is::
+
+  RULE =3D always ((RT and SLEEP) imply (RT_FRIENDLY_SLEEP or ALLOWLIST))
+
+  RT_FRIENDLY_SLEEP =3D (RT_VALID_SLEEP_REASON or KERNEL_THREAD)
+                  and ((not WAKE) until RT_FRIENDLY_WAKE)
+
+  RT_VALID_SLEEP_REASON =3D FUTEX_WAIT
+                       or RT_FRIENDLY_NANOSLEEP
+
+  RT_FRIENDLY_NANOSLEEP =3D CLOCK_NANOSLEEP
+                      and NANOSLEEP_TIMER_ABSTIME
+                      and NANOSLEEP_CLOCK_MONOTONIC
+
+  RT_FRIENDLY_WAKE =3D WOKEN_BY_EQUAL_OR_HIGHER_PRIO
+                  or WOKEN_BY_HARDIRQ
+                  or WOKEN_BY_NMI
+                  or KTHREAD_SHOULD_STOP
+
+  ALLOWLIST =3D BLOCK_ON_RT_MUTEX
+           or FUTEX_LOCK_PI
+           or TASK_IS_RCU
+           or TASK_IS_MIGRATION
+
+Beside the scenarios described above, this specification also handle some
+special cases:
+
+  - `KERNEL_THREAD`: kernel tasks do not have any pattern that can be reco=
gnized
+    as valid real-time sleeping reasons. Therefore sleeping reason is not
+    checked for kernel tasks.
+  - `KTHREAD_SHOULD_STOP`: a non-real-time thread may stop a real-time ker=
nel
+    thread by waking it and waiting for it to exit (`kthread_stop()`). This
+    wakeup is safe for real-time.
+  - `ALLOWLIST`: to handle known false positives with the kernel.
+  - `BLOCK_ON_RT_MUTEX` is included in the allowlist due to its implementa=
tion.
+    In the release path of rt_mutex, a boosted task is de-boosted before w=
aking
+    the rt_mutex's waiter. Consequently, the monitor may see a real-time-u=
nsafe
+    wakeup (e.g. non-real-time task waking real-time task). This is actual=
ly
+    real-time-safe because preemption is disabled for the duration.
+  - `FUTEX_LOCK_PI` is included in the allowlist for the same reason as
+    `BLOCK_ON_RT_MUTEX`.
--=20
2.39.5

