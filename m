Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 870192E54A5;
	Wed, 18 Jun 2025 11:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750246276; cv=none; b=fzDj6sO+y8S27/N90qPp0o4NDT1Vz1Kp7F5TyCNDpez1UYnJml1fjRUV46nM1GkD1eluTzyj+EwXqOGBVmvy8Xn8BsOduoQ7WJ+Fcrcoa/yMmLv3opzbjbjL1DccPFBWP0qb/Ll20t/iINaf28gZhve2q/Md3jmXzWEVUTSc50s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750246276; c=relaxed/simple;
	bh=9dW14Xdbu0kEZtNE1OYSmjDkQI66n9K60BpD8Qdr2EM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=f8cpY+j8rwfznXNAkoRxagQChieo0C/klneAQY9/dZlF67zVriPZb2btltvBij7G5Q16b30M/ZFejsERwLIF/2a5JqZUAcor6o9SqLd3b/srBD2NjdQ68ZSHQWdDS3egohghqKrCd75IszZlTwGJmXpWuNOo7HJcEgeENJ1JLRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf17.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id E41A11A141D;
	Wed, 18 Jun 2025 11:31:11 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf17.hostedemail.com (Postfix) with ESMTPA id 11E1A18;
	Wed, 18 Jun 2025 11:31:09 +0000 (UTC)
Date: Wed, 18 Jun 2025 07:31:17 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH] fgraph: Keep track of when fgraph_ops are registered or not
Message-ID: <20250618073117.024efb2e@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: 11E1A18
X-Stat-Signature: 5ckgk9qkt8mmft3hir1ufycnirzxb4wx
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18SMXOUaXQIGfWFH4hw4wEd0EKRZxhTG+k=
X-HE-Tag: 1750246269-15902
X-HE-Meta: U2FsdGVkX1+P1C/OQvYh1/Dp2qydXHXdDThwPY7OdyuhyDLj8Khs/DAiGUCQ7Hhq6PI491CCIMIuB44pZ1YUGHGVpD0mVomXAX+qDO/f0RhyX1Fx5sSWYO5tX4O6kr2QoeHPVw5Kt/eXswwaDnXGsSIe+NSMQRbpO4KsePuPKwX7CvdZ6exFff+pjTLE0kHJDJpnnBOUxogljuu+U+K+sCmYvC2B9GMgIldoSoQehw1U21/A9LY/V/HqDNd/dL+M6xj+A+fBIzjRhBACEkUpuWhQIT/6G52iDXTGZtKuCYauTjnmKMwi3IZYfzkRSVSQl9nQRCKbIgCer5+2k04gjvFc6c5NZhFbt2/pqe/s1US7mAc3yrbGOxuPBXvfkUjiabXLLDd4igRtCnI8kf4Ina37/EXxrYqcwkppaICnzEQC/UcgkasXyQ==

From: Steven Rostedt <rostedt@goodmis.org>

Add a warning if unregister_ftrace_graph() is called without ever
registering it, or if register_ftrace_graph() is called twice. This can
detect errors when they happen and not later when there's a side effect:

Link: https://lore.kernel.org/all/20250617120830.24fbdd62@gandalf.local.home/

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/fgraph.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index c5b207992fb4..c6bb6c68764f 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -1325,6 +1325,10 @@ int register_ftrace_graph(struct fgraph_ops *gops)
 	int ret = 0;
 	int i = -1;
 
+	if (WARN_ONCE(gops->ops.flags & FTRACE_OPS_FL_GRAPH,
+		      "function graph ops registered again"))
+		return -EBUSY;
+
 	guard(mutex)(&ftrace_lock);
 
 	if (!fgraph_stack_cachep) {
@@ -1401,17 +1405,21 @@ void unregister_ftrace_graph(struct fgraph_ops *gops)
 {
 	int command = 0;
 
+	if (WARN_ONCE(!(gops->ops.flags & FTRACE_OPS_FL_GRAPH),
+		      "function graph ops unregistered without registering"))
+		return;
+
 	guard(mutex)(&ftrace_lock);
 
 	if (unlikely(!ftrace_graph_active))
-		return;
+		goto out;
 
 	if (unlikely(gops->idx < 0 || gops->idx >= FGRAPH_ARRAY_SIZE ||
 		     fgraph_array[gops->idx] != gops))
-		return;
+		goto out;
 
 	if (fgraph_lru_release_index(gops->idx) < 0)
-		return;
+		goto out;
 
 	fgraph_array[gops->idx] = &fgraph_stub;
 
@@ -1434,4 +1442,6 @@ void unregister_ftrace_graph(struct fgraph_ops *gops)
 		unregister_trace_sched_switch(ftrace_graph_probe_sched_switch, NULL);
 	}
 	gops->saved_func = NULL;
+ out:
+	gops->ops.flags = 0;
 }
-- 
2.47.2

