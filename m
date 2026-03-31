Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D783BC67C;
	Tue, 31 Mar 2026 20:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774989510; cv=none; b=TV2jtX6yaFp+1twszuRUNGuWQTyQYXTJVvXIkl7wFIJSjAhP8HZ1orXId7NJ/u9AfG+Qzz1YO9yAPgYJ4dhsVZoNpzOD+PkvePPa2Ho2Bv0hrajXp4Mz+0Z0b3/3sOErAUeQi3zuEdgOZmGH12RRh/GgVwo3Zvib88pnhknuebY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774989510; c=relaxed/simple;
	bh=y/YsXJ9+vTBgnYxGcxqYPOwsCsME/a7rPkIizqAe9WM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=evI2DWHYA+zgV52xFTndWtAYUcL010p28EUMK2MVpL93szrmPc9LwMOThNk+O3dGsyZdIk6QhSCHEEYfsKwaaMGxShpFhlb6twMG3W0h1vB/FHoBCkG2b+OzeIzdpmODouqe8dAY6LqTjgebi4SPt+Kxc0/oU+w3Ms53iY0/yMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf18.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id 75FD913AA37;
	Tue, 31 Mar 2026 20:38:27 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf18.hostedemail.com (Postfix) with ESMTPA id BC12231;
	Tue, 31 Mar 2026 20:38:25 +0000 (UTC)
Date: Tue, 31 Mar 2026 16:39:24 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, John Stultz <jstultz@google.com>
Subject: [PATCH] tracing: Allow backup to save persistent ring buffer before
 it starts
Message-ID: <20260331163924.6ccb3896@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: rz1aq6i1qmdqt77rd5q77wbmm74za4j6
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: BC12231
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/fgAP/eWcCq+cUg1ZN0gJ5gtgZ8LR8q7g=
X-HE-Tag: 1774989505-524426
X-HE-Meta: U2FsdGVkX1+7RTW9Bu7/Cjjjz4c2CMfeaV/usldx8SSYJ/U8sgvNoFC+chdHaMqj0FvlKjx9ff1TmemUZztY2jZl3oCOR0NL8u7OPWKh+OSqrEU0kfMZpRlS6Oo1dX3UMLoIruhvnjnOTzs3ux1LA81oH5FWgNPW75jccHFg7PygY2P/tyzIa8RkFBDtGhf8hAhaJHNSM1te63HwUQ/Eh4mRxGZUbUCIsDN2+7jbOAncUARMEAicKryMrzM5PEiNZEXAXeeyBzRHlLTP2rfU2KedegHCsjHCE6IGt97BjsEIfW2AmCx07PM44ZCvQuQ7mI8Silm+o0QROpZQONlrP4LFB23U2aMKNybHU5i641xClIMOtC07f8GaesMMWhst

From: Steven Rostedt <rostedt@goodmis.org>

When the persistent ring buffer was first introduced, it did not make
sense to start tracing for it on the kernel command line. That's because
if there was a crash, the start of events would invalidate the events from
the previous boot that had the crash.

But now that there's a "backup" instance that can take a snapshot of the
persistent ring buffer when boot starts, it is possible to have the
persistent ring buffer start events at boot up and not lose the old events.

Update the code where the boot events start after all boot time instances
are created. This will allow the backup instance to copy the persistent
ring buffer from the previous boot, and allow the persistent ring buffer
to start tracing new events for the current boot.

  reserve_mem=100M:12M:trace trace_instance=boot_mapped^@trace,sched trace_instance=backup=boot_mapped

The above will create a boot_mapped persistent ring buffer and enabled the
scheduler events. If there's a crash, a "backup" instance will be created
holding the events of the persistent ring buffer from the previous boot,
while the persistent ring buffer will once again start tracing scheduler
events of the current boot.

Now the user doesn't have to remember to start the persistent ring buffer.
It will always have the events started at each boot.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace.c | 22 ++++++++++++++++++++++
 kernel/trace/trace.h |  5 ++++-
 2 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index ef55b48064da..5b46083f6f94 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -10871,9 +10871,31 @@ __init static void enable_instances(void)
 			tr->range_name = no_free_ptr(rname);
 		}
 
+		/*
+		 * Save the events to start and enabled them after all boot instances
+		 * have been created.
+		 */
+		tr->boot_events = curr_str;
+	}
+
+	/* Enable the events after all boot instances have been created */
+	list_for_each_entry(tr, &ftrace_trace_arrays, list) {
+
+		if (!tr->boot_events || !(*tr->boot_events)) {
+			tr->boot_events = NULL;
+			continue;
+		}
+
+		curr_str = tr->boot_events;
+
+		/* Clear the instance if this is a persistent buffer */
+		if (tr->flags & TRACE_ARRAY_FL_LAST_BOOT)
+			update_last_data(tr);
+
 		while ((tok = strsep(&curr_str, ","))) {
 			early_enable_events(tr, tok, true);
 		}
+		tr->boot_events = NULL;
 	}
 }
 
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index b001fbba0881..e68f9c2027eb 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -405,7 +405,10 @@ struct trace_array {
 	unsigned char		trace_flags_index[TRACE_FLAGS_MAX_SIZE];
 	unsigned int		flags;
 	raw_spinlock_t		start_lock;
-	const char		*system_names;
+	union {
+		const char	*system_names;
+		char		*boot_events;
+	};
 	struct list_head	err_log;
 	struct dentry		*dir;
 	struct dentry		*options;
-- 
2.51.0

