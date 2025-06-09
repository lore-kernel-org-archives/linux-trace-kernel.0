Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E824A3C;
	Mon,  9 Jun 2025 17:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749489903; cv=none; b=YZjjnk76c7QsWag/QhIreeq4QIkCPL/0BGQZImI6Rikt9Qx2GzM1HiCz3jCopb8y3rnMpD3urvtmjAvrSiXtktp9UORGFFJ1j9KGWXFbpR//XKagEKoI/RpwnDUYPyNAzLTB5yumHsOIiWNSUW7m04eyLblvE2lmzFpvK0h0m0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749489903; c=relaxed/simple;
	bh=u8Q4VBy21QNllu02EWfp1To+h1q7k65+Y8ZMOX6IbBQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=GDcmlMJ5RZUgR/LtpQSrboclLmeAUd6+5lD0SeheiwnCdGEPLh60Ii4eyeg0jJMOtrw/utuQx8RIYrcj9MASnix5xo8XVUx7KgP/YKITaIE4Qx+xX++jkOazOMgPlE3ejsCYtbEo1IpbpSFhM+zY6o4Uea+4M7+YXTorp8QW6c4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf14.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id 568ADBD357;
	Mon,  9 Jun 2025 17:16:06 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf14.hostedemail.com (Postfix) with ESMTPA id B47172D;
	Mon,  9 Jun 2025 17:16:04 +0000 (UTC)
Date: Mon, 9 Jun 2025 13:17:32 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH] tracing: Use queue_rcu_work() to free filters
Message-ID: <20250609131732.04fd303b@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: B47172D
X-Stat-Signature: 8g1ezoxdzbyxr89zqtnzib3z8hyt6nkx
X-Rspamd-Server: rspamout05
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+n2ThMA2oOBbuZkjIUEaqh0CKb4hyi+IM=
X-HE-Tag: 1749489364-656785
X-HE-Meta: U2FsdGVkX1/ReBRy8BMyom0XNTxN9K3srsKnlJmKpoQ80igGHg0Oce/SWaQl3dZyxZrn2ukFCAjK6jrWhItVs82AjKQIPZm/ter3Amnwvasx3qtTX5sqByIU3Jmw31aIDO1mUerxHaY2fkNyUb7BZvWqq0QoX6qbN5Kf0txmT5x+QkpWBfFYJ4tAh3uVwHSpHEqZFTwmrEi0YVxtV3e9MbkQM3k3iIXxD4rTZ/SZ+2/RDFEDjbVgWTYnK0DiJdICwF5WnjaDVTBjs0aTzwYR0UXY1Qpg2hRCoV8M7siuhlXZQm0mksyrMGN6KuZPdsRB/nIsE7agCoVv7F+PuAa1o9sCC+RFaJjKzZjDvUIoUSOBBAPCsB9UThcdsSYUBiPQQneU/PwN8KlOd3h5gDthkA==

From: Steven Rostedt <rostedt@goodmis.org>

Freeing of filters requires to wait for both an RCU grace period as well as
a RCU task trace wait period after they have been detached from their
lists. The trace task period can be quite large so the freeing of the
filters was moved to use the call_rcu*() routines. The problem with that is
that the callback functions of call_rcu*() is done from a soft irq and can
cause latencies if the callback takes a bit of time.

The filters are freed per event in a system and the syscalls system
contains an event per system call, which can be over 700 events. Freeing 700
filters in a bottom half is undesirable.

Instead, move the freeing to use queue_rcu_work() which is done in task
context.

Link: https://lore.kernel.org/all/9a2f0cd0-1561-4206-8966-f93ccd25927f@paulmck-laptop/

Fixes: a9d0aab5eb33 ("tracing: Fix regression of filter waiting a long time on RCU synchronization")
Suggested-by: "Paul E. McKenney" <paulmck@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
Note, I added a Fixes tag but not a stable tag as this is a nice-to-have
but doesn't hit the level of critical fix to backport or add to an rc
release. If someone wants to back port it, feel free.

 kernel/trace/trace_events_filter.c | 28 ++++++++++++++++++++--------
 1 file changed, 20 insertions(+), 8 deletions(-)

diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index ea8b364b6818..b6fe8167ef01 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -1344,13 +1344,14 @@ struct filter_list {
 
 struct filter_head {
 	struct list_head	list;
-	struct rcu_head		rcu;
+	union {
+		struct rcu_head		rcu;
+		struct rcu_work		rwork;
+	};
 };
 
-
-static void free_filter_list(struct rcu_head *rhp)
+static void free_filter_list(struct filter_head *filter_list)
 {
-	struct filter_head *filter_list = container_of(rhp, struct filter_head, rcu);
 	struct filter_list *filter_item, *tmp;
 
 	list_for_each_entry_safe(filter_item, tmp, &filter_list->list, list) {
@@ -1361,9 +1362,20 @@ static void free_filter_list(struct rcu_head *rhp)
 	kfree(filter_list);
 }
 
+static void free_filter_list_work(struct work_struct *work)
+{
+	struct filter_head *filter_list;
+
+	filter_list = container_of(to_rcu_work(work), struct filter_head, rwork);
+	free_filter_list(filter_list);
+}
+
 static void free_filter_list_tasks(struct rcu_head *rhp)
 {
-	call_rcu(rhp, free_filter_list);
+	struct filter_head *filter_list = container_of(rhp, struct filter_head, rcu);
+
+	INIT_RCU_WORK(&filter_list->rwork, free_filter_list_work);
+	queue_rcu_work(system_wq, &filter_list->rwork);
 }
 
 /*
@@ -1462,7 +1474,7 @@ static void filter_free_subsystem_filters(struct trace_subsystem_dir *dir,
 	tracepoint_synchronize_unregister();
 
 	if (head)
-		free_filter_list(&head->rcu);
+		free_filter_list(head);
 
 	list_for_each_entry(file, &tr->events, list) {
 		if (file->system != dir || !file->filter)
@@ -2307,7 +2319,7 @@ static int process_system_preds(struct trace_subsystem_dir *dir,
 	return 0;
  fail:
 	/* No call succeeded */
-	free_filter_list(&filter_list->rcu);
+	free_filter_list(filter_list);
 	parse_error(pe, FILT_ERR_BAD_SUBSYS_FILTER, 0);
 	return -EINVAL;
  fail_mem:
@@ -2317,7 +2329,7 @@ static int process_system_preds(struct trace_subsystem_dir *dir,
 	if (!fail)
 		delay_free_filter(filter_list);
 	else
-		free_filter_list(&filter_list->rcu);
+		free_filter_list(filter_list);
 
 	return -ENOMEM;
 }
-- 
2.47.2

