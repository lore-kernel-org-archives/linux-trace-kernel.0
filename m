Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C70B347BDB;
	Sat,  8 Aug 2026 13:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786196541; cv=none; b=c/badxAIDxxQJZNknB/La5WQfBxIcDTkTNxG0qq+5KsACdWITjm8LIjFVhf12YAwKG6jDdKavL3wdmr1dm9HyFCsqIqnk6lOwqC+rPS1DLyIh1y6yfepP9avZ5/bgG0sOqFtUrl40ypGkY/uA3+cFG2eqfGV+1KvKjpUJDVHVR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786196541; c=relaxed/simple;
	bh=ax5mqWp8kmZfi0V/V4twhAQ5Pv36ElL97AlTpmnmZao=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=PM3KIcI1zHo/B1CBorxsJGe3pFYTu/ZlLfUHOXePD0w5v+3HJ9/9MHrU7ahbZN1CtCi/nw/ZZlEJlQJA8EtGpBhgQYeUE7oz0AhcsYYw4nTOAevO+UbeszLFtQRPoRH62KFrW2+gbbnC2QvTMsjTJXaYdpPsW8rAHSocYYO9wBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf04.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id 4511C1A0393;
	Sat,  8 Aug 2026 13:42:18 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf04.hostedemail.com (Postfix) with ESMTPA id 9DDBD20024;
	Sat,  8 Aug 2026 13:42:16 +0000 (UTC)
Date: Sat, 8 Aug 2026 09:42:15 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux trace kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>
Subject: [PATCH] eventfs: Use children field for rcu head and add memory
 barriers
Message-ID: <20260808094215.4252430d@robin>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 8jqdbs1wg5ijtggwr9wgus5mi1gtu9bt
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 9DDBD20024
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19U7sKuTfa13Q1otWXNlk460qZPYqBJZN8=
X-HE-Tag: 1786196536-827298
X-HE-Meta: U2FsdGVkX19PEgz8x82pDYBZYyIYjNooDtc+RZxKvKbNX1frl/DMsrmQaR4K5usySx6/eaVVS/PkJ3uJxxzYmsEIRUE7maqCTLEQIX9YEqusorRpUkHGaz3VxqllzEoUW6QairjNXD22Chg9XnNTzwcOcYb1a7ZY13giOKKU48/UEUqu49NYWFV0J8OcrpI9Fqmlizrb992dPtDKXhcm/nNrpDe6qd3uNv+PZZ8mq3yxV67JniLY25TV/VczUScCKG/2f0sE4wO04nMqoZtcx/2uoFb+6DClqk6jxRZXltrE8jljBP8CtZUQo1U4Fft4dCJmd2+gPy8TMK1tl9xlH2j8TiiuOZWCD5OWwmtelKkmcy5ozG4Dz69W8CjT/TXC+VoCsQ50tVeqpOaG2ZDfO+VUSh5bjZT7BEXe3Xp4JhzIeIEZDqTGq0fYuQNV7WGaqGH5LOJI8RfjJ2/1T1yKkqDElIpOe29ZvR0X+YUsddwOEltrsl3u8KRjbmCnAKS3jzp7BBJlcGHYnRtT6xVl0OLQ9dv2Usf7U7me6eQKZfK8qiQ2LEnQmhWtmgHWLAT7

From: Steven Rostedt <rostedt@goodmis.org>

When an eventfs inode is freed, it sets ei->is_freed and then uses its
ei->list to add it to the srcu link list as the list field is a union with
the rcu list head. As the ei->list is used to iterate over an SRCU
protected list without taking the eventfs_mutex, there's nothing stopping
the iteration over that list to see the ei->rcu instead of the ei->list
and it will read a corrupt target.

To fix this, change the union of the rcu list head with the children list.
On freeing the eventfs inode, set the is_free and execute a smp_wmb()
before adding the eventfs inode to the SRCU list.

On iteration of the ei->children list, at the start, execute a smp_rmb()
and then read the is_freed of the ei to see if the children list is still
valid. If is_freed is set, then the ei_child read is not valid and the
loop should exit immediately.

Cc: stable@vger.kernel.org
Fixes: 704f960dbee2f ("eventfs: Read ei->entries before ei->children in eventfs_iterate()")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20260806022719.375354-1-shuangpeng.kernel%40gmail.com
Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
Changes since v2: https://patch.msgid.link/20260807204441.75a7db89@gandalf.local.home

- Fix comment about smp_wmb() being in put_ei() and not free_ei().

 fs/tracefs/event_inode.c | 24 ++++++++++++++++++++++++
 fs/tracefs/internal.h    |  4 ++--
 2 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index 39c7a34531e8..bc82d3284a2e 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -124,7 +124,17 @@ static inline void put_ei(struct eventfs_inode *ei)
 static inline void free_ei(struct eventfs_inode *ei)
 {
 	if (ei) {
+		/* The ei should have no children if it is being freed. */
+		WARN_ON_ONCE(!list_empty(&ei->children));
 		ei->is_freed = 1;
+		/*
+		 * The SRCU iteration has a smp_rmb() to make sure it
+		 * sees a child (that may have already been freed)
+		 * before it reads is_free. If is_free is set, it must
+		 * not use the child it acquired from ei->children, as
+		 * the list may be used for SRCU.
+		 */
+		smp_wmb();
 		put_ei(ei);
 	}
 }
@@ -627,6 +637,20 @@ static int eventfs_iterate(struct file *file, struct dir_context *ctx)
 	list_for_each_entry_srcu(ei_child, &ei->children, list,
 				 srcu_read_lock_held(&eventfs_srcu)) {
 
+		/*
+		 * If the ei is being freed, then the ei->children may be
+		 * being used as the rcu list, which means the next element
+		 * may be garbage. The ei->is_free is set before switching
+		 * the ei->children over to ei->rcu. The read memory barrier
+		 * here makes sure the ei_child is read before is_free is
+		 * updated.
+		 *
+		 * Matches the smp_wmb() in free_ei()
+		 */
+		smp_rmb();
+		if (ei->is_freed)
+			return -EINVAL;
+
 		if (c > 0) {
 			c--;
 			continue;
diff --git a/fs/tracefs/internal.h b/fs/tracefs/internal.h
index a4a7f8431aff..c61481d04c8e 100644
--- a/fs/tracefs/internal.h
+++ b/fs/tracefs/internal.h
@@ -46,11 +46,11 @@ struct eventfs_attr {
  * @ino:	The saved inode number
  */
 struct eventfs_inode {
+	struct list_head	list;
 	union {
-		struct list_head	list;
+		struct list_head	children;
 		struct rcu_head		rcu;
 	};
-	struct list_head		children;
 	const struct eventfs_entry	*entries;
 	const char			*name;
 	struct eventfs_attr		*entry_attrs;
-- 
2.53.0

