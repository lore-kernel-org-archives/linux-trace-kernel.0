Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794961813;
	b=WcTAFlzFnZ2Dr3u0pIOnsRIQ1Vuuq9iZtNhCq+GGnhsR8QyzqEdGE8NKFEkx+nhbnJ7/
	 u85wBlmf/g8ph1JWvbkwMr9U7tURbe8a7Wh6zW9SACRyrUzur7T0Ga3to1mYPuZkFyA+M
	 Zf8+ot3O3GMMbgVpfMGfxOtFku6nSmUbeFwa7OBVBDCvg003AwJBKYpYbSzMBSdfdCqTq
	 WgwiJgmWtcnA1bQzP/Ic3btP+XocseIezvoc8cYroUCDWhHxzG9gxuFBJU8FyiWYOYwrT
	 s9UWZkKsNjpwzng4tUBqQRqY14iESd9iP5ZNWxSkvz/XwR0+kZgHbrs/8w8JDTV8rnw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794961813;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 X-Mailer:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Rspamd-Server:X-Rspamd-Queue-Id:X-Stat-Signature:X-Spam-Status:
	 X-Session-Marker:X-Session-ID:DKIM-Signature:X-HE-Tag:X-HE-Meta;
	bh=TNt3Z17t3bRhGix8HlO6667jgNM+KMBvKcrWZxo9JCk=;
	b=mWV02WefL8HHl1sdYFpXJDfg3CZbN/JESMYrBQCbhKQSs1SvyQs1EcugRtXqixSPos1e
	 kVHBEV9GCIxLWtjbplFOE2UJYpUT90kHZII5Oo7utY+FGHwIQ3iQmoweKllZlVwIxU34q
	 7HsM0c/ecMjjRk7TgUrzTSsejx2ZR/XdYePJO14djXnCA1yNLnEhvEFmjs9CLk9lAaSva
	 rui16JKgUAAcl3V4gaVSSGW7C9qxLQrEJK/k4uowOM56wnL50ygrmiyl7IqPyiHXArJ7l
	 JCqhEx1yQ7p+IJNnivi3CkLg9xJznbRzBSof87hCsvMF1+QUqgOhFDS8XvWwGQTX0fA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goodmis.org;
	spf=pass smtp.mailfrom=goodmis.org;
	dkim=pass header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=4Q216tSq;
	arc=none smtp.remote-ip=216.40.44.15
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0CE5606A332;
	Wed, 18 Nov 2026 00:30:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B0CE5606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=4Q216tSq
Received: from omf15.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id 905201C3EC9;
	Wed, 18 Nov 2026 00:30:10 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf15.hostedemail.com (Postfix) with ESMTPA id C237918;
	Wed, 18 Nov 2026 00:30:08 +0000 (UTC)
Date: Tue, 17 Nov 2026 19:30:07 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Vineet Gupta <vineet.gupta@linux.dev>,
 Peter Zijlstra <peterz@infradead.org>, Andrii Nakryiko
 <andrii.nakryiko@gmail.com>
Subject: [PATCH] fgraph: Read the task->ret_stack with a smp_load_acquire()
Message-ID: <20261117193007.6ee9f605@gandalf.local.home>
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
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: C237918
X-Stat-Signature: btcbwexwxx683qwb9jy9p358s5n5r3aq
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+a1BE97vlIcmjlRdP68bhzbtnwSTyvTG4=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=TNt3Z17t3bRhGix8HlO6667jgNM+KMBvKcrWZxo9JCk=; b=4Q216tSqb0xjtz0Qw5INZDVfvGNQju9U9iIGiF++yLa4xOojIayEsgmL8kWlj/fPZUlAbZjkrAVUQXT8QAZvmhQw1oggDpfzSHFS7Bn4VGDxkWU+FZ0OHSh/9PeIQh6mF2zAaP20RzwP2exJSi7avFd3GeKoXx9AslnR2EllLP0=
X-HE-Tag: 1794961808-985840
X-HE-Meta: U2FsdGVkX1+8joYwWiKl8OqRILOMsEFVbPyPtGeA5NqpvNEhIZ9Ah4qZAthN32koauYzowzpmxMhE4YOig1W7Qxp5pplY+8rKwMX2B9MIgrenCAnYpKu/9dkax8MKh8yjdbCoKDANx7hIgqmpq/k61CoMN2pH4ElOUz2IxgbaBwtR2ENmrRzgmLUR04oupXiAZVK6GaKdwJTCKYBhoKTgJrLuqKFpTHd3Vp29Q17xXxEOwdTxkvXUwZMd/6NlAy9bLG8pMyAWaDOlztkEUqQqep0Lyvt+QrB0KD9rAPsdiZNW8eHpEWgzCgjJyqDQUaZE0/q05KzavrA6U1o2fGJacf6G121s6i1FLwppqt6+NaZ48MqmhH9tArnMsd0fIBo3eB7wa/GvAF4uNmL+Ouigg==

From: Steven Rostedt <rostedt@goodmis.org>

The setting of task->ret_stack was switched from a smp_wmb() and the
update to the variable with a smp_store_release(). Match the reading of
the task->ret_stack with a smp_load_acquire() to replace the read and
smp_rmb().

Link: https://lore.kernel.org/all/20261021174406.2891598-2-vineet.gupta@linux.dev/

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/trace/fgraph.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index bbf6e4e2da2d..1383cc3db1b1 100644
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
-- 
2.53.0

