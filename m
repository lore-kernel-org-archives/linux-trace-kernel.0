Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.17
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794963675;
	b=rI+mP9H0X8uVTYBESVeJaE+S1ipMEhkyzNyEaJ0JJyIQPXKyvXV7cM9fssMTLk1QgXaA
	 3uRk0yWU7eyehOiN/pfHqJrV6b0cqjOdcvNjC3xZyg8fSOvmbOok8Sx04ej6BmxFMyfQ3
	 b4i0Qe+UcBmsKcdONhitxp7PKxNl5FSKJP/U494yQa4chNW7j+xq7rNhw0QEqU2M06r29
	 dRYs015sQMc8216LC50gGo/W10FNezejnXQFsOyKA67cowVHb/L/Y/cQ58oQU697qTErf
	 aHilHIJUArcuYW90ub0I/pi0kmtsBLYZifOfkg34V7a2jPJdNr2JKDEw8RmZq6cMCjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794963675;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 X-Mailer:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Rspamd-Queue-Id:X-Rspamd-Server:X-Stat-Signature:X-Spam-Status:
	 X-Session-Marker:X-Session-ID:DKIM-Signature:X-HE-Tag:X-HE-Meta;
	bh=z8kxQvUj5zwDtnCB080k4EdHPlhtNHftETeHTO27jgg=;
	b=BmyvqnQa0k55CrVOnQk++hkDDi8eQBGPjNAoclvmfu7eclRcOM/MaGYbsH2PF3z3mgwp
	 MOviK9LNkcbf57nDT9FqbYzo+ODlIU7HMzx5iYbFhzfKEcJJDoyvXg4kOAnABG3o26JkI
	 W6F5UXVWrPGxUQqRuBVytX9kC4IwpMxV//2/OZNvBIMUBg7AGOG0INstIjJAIMzIimzvM
	 yR4dw+KqIyu18cMBpGovMN2zDPplfmByLKMP9ArRG2X9qnPuF2qAd7aJGam4FsOEpFSoU
	 9foq1iLGJJEkazq9AXm1JWZaf04W2ifTB/sn7yYPMI+T++J1A0FWaG/YwVOO1iOjZLw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goodmis.org;
	spf=pass smtp.mailfrom=goodmis.org;
	dkim=pass header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=CI16MtWb;
	arc=none smtp.remote-ip=216.40.44.17
Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA03B606A31C;
	Wed, 18 Nov 2026 01:01:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EA03B606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=CI16MtWb
Received: from omf11.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id DB4B8A8058;
	Wed, 18 Nov 2026 01:01:11 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf11.hostedemail.com (Postfix) with ESMTPA id 0CB3D2002F;
	Wed, 18 Nov 2026 01:01:09 +0000 (UTC)
Date: Tue, 17 Nov 2026 20:01:08 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Vineet Gupta <vineet.gupta@linux.dev>,
 Peter Zijlstra <peterz@infradead.org>, Andrii Nakryiko 
 <andrii.nakryiko@gmail.com>
Subject: [PATCH v2] fgraph: Read the task->ret_stack with a
 smp_load_acquire()
Message-ID: <20261117200108.35179ae8@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 0CB3D2002F
X-Rspamd-Server: rspamout08
X-Stat-Signature: n6iuqb1tzp4ny67jk6j6hud3x97jo6hk
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1839B2/p1aN0UnNhIQkPtxSQFvvLWrh3eM=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=z8kxQvUj5zwDtnCB080k4EdHPlhtNHftETeHTO27jgg=; b=CI16MtWbHnegZMt01qa5m39wM8MKVSowXY1aH5mDJ7gXXZOITzY9JBaB4/6kQMeewdZ5R264k6q76zp/yJuz8OD7Bal0QBkAK4hoDmZWIs9CvCiE64gjrCN4k4XeEJL/SWm8Y1n3yPI5KLK5VhBK1izreHR3wTpUiqCFB5M9LtE=
X-HE-Tag: 1794963669-680933
X-HE-Meta: U2FsdGVkX1+KXaERXqylp9ckUPVn5GZt89lqUWwsRuHxzdEf+6+XK/NY6UF5kDmVSlFHvYQmfg2wBMJCGrYhT2rqLw/a4zuTr1iTWemLXSgUKGpcblnmuYxa2BrluHFEuA2LqLWCVMwMhthP7lODrEP+GHYm1saY9G21RN1niMMQRKca2JNgHvecF3Ri2J450jXHh0REkDx5SQocUzWcX/EYAR9djI+WKTniT/YcoP7BjiVAqOK49Pv2vBgKH8OXhWdArxO9EIZOfW4ZkvVXlFblYZfFDmApZbRpkQx5uBNltXwUl9BZg+BP8CRyCOSxg8cosYCr2iSejErgTZRwgFgw85IKDQiI4aslNjXvFZ+fGRat+wh0iTBb4EQ3T+OO3a6lFxEezdXtYf0Cqtn1aEXMuHFSgMDqTeycQp3+fxmtV0SVuQaPVTtql93vtv2A3q9pxJ50wPudJ89VmKL61nqHdzjxYkp6IUunneFa4Qk=

From: Steven Rostedt <rostedt@goodmis.org>

The setting of task->ret_stack was switched from a smp_wmb() and the
update to the variable with a smp_store_release(). Match the reading of
the task->ret_stack with a smp_load_acquire() to replace the read and
smp_rmb().

Also update graph_init_task() to use smp_store_release().

Link: https://lore.kernel.org/all/20261021174406.2891598-2-vineet.gupta@linux.dev/

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
Changse since v1: https://patch.msgid.link/20261117193007.6ee9f605@gandalf.local.home

- Updated graph_init_task() to use smp_store_release() (Sashiko)

 kernel/trace/fgraph.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index bbf6e4e2da2d..0748eb67dea7 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -568,7 +568,11 @@ ftrace_push_return_trace(unsigned long ret, unsigned long func,
 	if (unlikely(ftrace_graph_is_dead()))
 		return -EBUSY;
 
-	if (!current->ret_stack)
+	/*
+	 * We must make sure the ret_stack is tested before we read
+	 * anything else (See alloc_retstack_tasklist()).
+	 */
+	if (!smp_load_acquire(&current->ret_stack))
 		return -EBUSY;
 
 	BUILD_BUG_ON(SHADOW_STACK_SIZE % sizeof(long));
@@ -576,12 +580,6 @@ ftrace_push_return_trace(unsigned long ret, unsigned long func,
 	/* Set val to "reserved" with the delta to the new fgraph frame */
 	val = (FGRAPH_TYPE_RESERVED << FGRAPH_TYPE_SHIFT) | FGRAPH_FRAME_OFFSET;
 
-	/*
-	 * We must make sure the ret_stack is tested before we read
-	 * anything else.
-	 */
-	smp_rmb();
-
 	/*
 	 * Check if there's room on the shadow stack to fit a fraph frame
 	 * and a bitmap word.
@@ -1125,8 +1123,7 @@ graph_init_task(struct task_struct *t, unsigned long *ret_stack)
 	t->curr_ret_stack = 0;
 	t->curr_ret_depth = -1;
 	/* make curr_ret_stack visible before we add the ret_stack */
-	smp_wmb();
-	t->ret_stack = ret_stack;
+	smp_store_release(&t->ret_stack, ret_stack);
 }
 
 /*
-- 
2.53.0

