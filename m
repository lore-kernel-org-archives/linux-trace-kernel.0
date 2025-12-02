Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24BCD2737F3;
	Tue,  2 Dec 2025 21:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764710216; cv=none; b=s3bXx4tD6YIXyW4gXEd/Hbb6iW29suVW3fKyvKnT3MLlAgaeoSD6i9UbZv+aiOBNUqH/PJ+otu7qRSuN/IHCuezmT4ZV3OyThuL/OyUXD5wU+DHpvh5nSRgg+jMED/iFxr8wwTFEaYC9k7W5Mv2t4S4G+1UfiLaoTOOiv5Eo0pI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764710216; c=relaxed/simple;
	bh=rrTwEteZsQ60FJN9X8Wb1ibt/PJbHWBeqyPa/5vEBe0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=jrulayVhQgXECuHWC6wA0u6GfzMkN9W6UBYd2NBxAzvKEIzWQuSG9JTVZss8EwGb78d4s4AsDYHHqxdJf4Q0Mlkcyx3EUlxRxkVz/BLX85hrovW3YzBIjlm9qtbinHju87oBBYXssMDzarpq5So0WmgIfCLTfbL6QR/ZLTB3F60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf15.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id D59A412CEA;
	Tue,  2 Dec 2025 21:16:52 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf15.hostedemail.com (Postfix) with ESMTPA id 3D63718;
	Tue,  2 Dec 2025 21:16:51 +0000 (UTC)
Date: Tue, 2 Dec 2025 16:17:51 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, syzkaller-bugs@googlegroups.com
Subject: [PATCH] tracing: Fix enabling of tracing on file release
Message-ID: <20251202161751.24abaaf1@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: iqbzn3pj6ed48kp6gx3h79horu8iiqs9
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: 3D63718
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18A2cX94A4tICqUNxVyxtpGTNvooXyttGI=
X-HE-Tag: 1764710211-804670
X-HE-Meta: U2FsdGVkX1/fWSLY9ykh4dTmrSHowimPYjVzn/sVTfwta9Os3aWhacN6fQdfWxYhIPxvGzcQeTbpYBm8t5xJTdNJ6lw4fLCEvvQOpXlI9Ea4H2wP2asq9IFwdSiaSaaJ7O6UbCbFP0rPjsy8OFfkXpzbD1+87DHGpoPniFJGgU2xm6AaNcIiyFD4xt9t6qqjTHUFoS6Y1OTf6ruCVMy+TAPKp2gwfTylUlrboY2Sf+aUjp70bSZgsAOPgyXqcVKV9JLEcr4AKZCnicRSoA/biQ7w9SYuVa5QKzuo3PAEbWTL1dVLUI5RzknevwRLg+wGK80MBucaa73rOCQGThUs4G2jEFSGdCXnA5FW+n6Mk3yi4hFe2R1973QiDvn9I362UZnuDcpde/HI5vXr4/nJ3r657YAYjpGFK846AgWowevLLygzjf57+Rev3Q2hyw6W0aQZHMUNxovHurVrLIXj5T6qUgXjI9uoQafP3I2kVZw=

From: Steven Rostedt <rostedt@goodmis.org>

The trace file will pause tracing if the tracing instance has the
"pause-on-trace" option is set. This happens when the file is opened, and
it is unpaused when the file is closed. When this was first added, there
was only one user that paused tracing. On open, the check to pause was:

   if (!iter->snapshot && (tr->trace_flags & TRACE_ITER(PAUSE_ON_TRACE)))

Where if it is not the snapshot tracer and the "pause-on-trace" option is
set, then it increments a "stop_count" of the trace instance.

On close, the check is:

   if (!iter->snapshot && tr->stop_count)

That is, if it is not the snapshot buffer and it was stopped, it will
re-enable tracing.

Now there's more places that stop tracing. This means, if something else
stops tracing the tr->stop_count will be non-zero, and that means if the
trace file is closed, it will decrement the stop_count even though it
never incremented it. This causes a warning because when the user that
stopped tracing enables it again, the stop_count goes below zero.

Instead of relying on the stop_count being set to know if the close of
the trace file should enable tracing again, add a new flag to the trace
iterator. The trace iterator is unique per open of the trace file, and if
the open stops tracing set the trace iterator PAUSE flag. On close, if the
PAUSE flag is set, then re-enable it again.

Fixes: 06e0a548bad0f ("tracing: Do not disable tracing when reading the trace file")
Reported-by: syzbot+ccdec3bfe0beec58a38d@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/692f44a5.a70a0220.2ea503.00c8.GAE@google.com/
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/linux/trace_events.h | 1 +
 kernel/trace/trace.c         | 6 ++++--
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index 04307a19cde3..3690221ba3d8 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -138,6 +138,7 @@ enum trace_iter_flags {
 	TRACE_FILE_LAT_FMT	= 1,
 	TRACE_FILE_ANNOTATE	= 2,
 	TRACE_FILE_TIME_IN_NS	= 4,
+	TRACE_FILE_PAUSE	= 8,
 };
 
 
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 3d433a426e5f..7b9d93147d01 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -4709,8 +4709,10 @@ __tracing_open(struct inode *inode, struct file *file, bool snapshot)
 	 * If pause-on-trace is enabled, then stop the trace while
 	 * dumping, unless this is the "snapshot" file
 	 */
-	if (!iter->snapshot && (tr->trace_flags & TRACE_ITER(PAUSE_ON_TRACE)))
+	if (!iter->snapshot && (tr->trace_flags & TRACE_ITER(PAUSE_ON_TRACE))) {
+		iter->iter_flags |= TRACE_FILE_PAUSE;
 		tracing_stop_tr(tr);
+	}
 
 	if (iter->cpu_file == RING_BUFFER_ALL_CPUS) {
 		for_each_tracing_cpu(cpu) {
@@ -4842,7 +4844,7 @@ static int tracing_release(struct inode *inode, struct file *file)
 	if (iter->trace && iter->trace->close)
 		iter->trace->close(iter);
 
-	if (!iter->snapshot && tr->stop_count)
+	if (iter->iter_flags & TRACE_FILE_PAUSE)
 		/* reenable tracing if it was previously enabled */
 		tracing_start_tr(tr);
 
-- 
2.51.0

