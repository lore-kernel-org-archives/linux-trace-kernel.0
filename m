Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8089B274B39;
	Wed,  2 Sep 2026 00:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788308426; cv=none; b=TEWZedbGMnFSQzUZW2u1LuQcPMM9ZQuUlZLfgtPU42WqOt7/81/E4++e54AVkKh/BgPYFrPLRmGKFDnKEXT6oyghW62gpkbO1RHk/Ki9VZx2vxjE3f8F376K5r7UXt1kyMjOJzQ6hTXsJH54ycBGaKn1BBc+QnAgifVGHT0NDy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788308426; c=relaxed/simple;
	bh=VlEHZbFW9ACmfVW8/MximRPKDtK2a2mfWzh9bdtib9g=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=IdPhfJAtpktxtxyUppR2/oUo4ZYCB6BbhpXR2eIAGimpIlmBkOuJJXA9o94QhbGtlTsYdEXGoqMpJTEWJ8QMUVvR60bgjjI/qJ08guPJzn+M+izPxVdI+guvulj0Fhps09vKx/nrBjVVSDz8IT9sYQwXpvbLoSDUpNSEOMo97Is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=L4XlSbHg; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="L4XlSbHg"
Received: from omf03.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id 033091C2385;
	Wed,  2 Sep 2026 00:20:22 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf03.hostedemail.com (Postfix) with ESMTPA id 547766000A;
	Wed,  2 Sep 2026 00:20:21 +0000 (UTC)
Date: Tue, 1 Sep 2026 20:20:20 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux trace kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>
Subject: [PATCH] ftrace: Synchronize the initialization of ftrace_ops
Message-ID: <20260901202020.09a1119a@robin>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: 547766000A
X-Stat-Signature: xkmhzfn9wqe5p5tk4ctofxbt1b7xrhyj
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/Vd0YKPynon/A0n6jsflIc+bfepM3p8OQ=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=CPxPfhi5uxCnldEpHuk02XO7Nb4pMWeYxC2Qvk6eEUQ=; b=L4XlSbHgkAoZy3k6K8xDhEpfq6fnx2oMVFKjmehNV1LilAmOAQOW1T8+95uvdEbqSE0dZ55zI18vQXecrAReT7CmQBkwAs8sIRDmTW1F3iU1xxHYLMsSX+faaQ6BeBENYuxqFPqFMf9B1VsENvRJEaKcd6rdnJBnbA07Ha87vXo=
X-HE-Tag: 1788308421-718504
X-HE-Meta: U2FsdGVkX1/wXkL2ArePiT8XnI8de4qsr+kQWRB2o9iUL2Vt/yan52fCYNvmkPMG86SechMFYRTOCD4zSdbZmBePV50BltEYjHskjN+RD0DOAwm5mhbtnGUwPDkwCrMTTh/1EjAjgB1SArSd2d0ZNqf3gHW78TKRbl1pMzeKzULbQfpHiZZWggGjkjv0jAi2prracDLbm7W+JbTFBJDCjJMy1j1NH3waZQMC0HzA0WhKpMTRQVq06Yd9Ddf7ckbQUugaH0sBjmJ13JGrSx/x0nTtYaxAbECTTMOgYq0Jy2vlmdSsxd2LRf9dcWafFx+QTMfXrqTDACKtpolxelqsQQUv3V6kJrWo+06ipcRlDSw043GDhr6E+k4zj/o0SgFLuw/vOFgjd9ckZGv/Qpw5/Q==

From: Steven Rostedt <rostedt@goodmis.org>

There's some internal state that ftrace_ops needs to have set, but since
it can be declared outside of the ftrace.c code, it calls
ftrace_ops_init() on the ops in every global function. The issue is that
if two tasks call it on the same ops at the same time it is possible to
have the initialization of one corrupt the initialization of the other
call.

Create a ops_mutex to use to synchronize every initialization of the
ftrace_ops. The mutex is taken within checking the ftrace_ops flag that
states it was initializied but the flag is checked again after the mutex
has been taken. Checking first outside the mutex allows it to shortcut
having to take the mutex. But then the check needs to be done again after
the mute is taken in case of races.

Cc: stable@vger.kernel.org
Fixes: f04f24fb7e48d ("ftrace, kprobes: Fix a deadlock on ftrace_regex_lock")
Reported-by: sashiko-bot@kernel.org
Close: https://lore.kernel.org/all/20260829025528.49A831F000E9@smtp.kernel.org/
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/trace/ftrace.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index c7cf36f2dd7b..0a49a1819c4d 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -75,6 +75,8 @@
 	.func_hash		= &opsname.local_hash,			\
 	.local_hash.regex_lock	= __MUTEX_INITIALIZER(opsname.local_hash.regex_lock), \
 	.subop_list		= LIST_HEAD_INIT(opsname.subop_list),
+/* Used only to synchronize the initialization of ftrace_ops */
+static DEFINE_MUTEX(ops_mutex);
 #else
 #define INIT_OPS_HASH(opsname)
 #endif
@@ -160,6 +162,10 @@ static inline void ftrace_ops_init(struct ftrace_ops *ops)
 {
 #ifdef CONFIG_DYNAMIC_FTRACE
 	if (!(ops->flags & FTRACE_OPS_FL_INITIALIZED)) {
+		guard(mutex)(&ops_mutex);
+		/* Could have been initialized before lock taken */
+		if (unlikely(ops->flags & FTRACE_OPS_FL_INITIALIZED))
+			return;
 		mutex_init(&ops->local_hash.regex_lock);
 		INIT_LIST_HEAD(&ops->subop_list);
 		ops->func_hash = &ops->local_hash;
-- 
2.53.0

