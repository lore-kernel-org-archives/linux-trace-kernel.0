Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DEFA49E5C7;
	Wed,  2 Sep 2026 13:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788357245; cv=none; b=c3T0lH0GGprhH33g4MURqGpnagt5WSE57UhS77IITcoAqH4EyU/UQlUHFaLeLvLA1KKnIXiefBLZudBfbCR9e2IunWrnWsKFGaGW9znRKGNqR1cFAJJFzKyRVAD8vs4j4eOnjR8idixrQZ9gI/7svjJaJcGAfpvF5aOWoMiTPmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788357245; c=relaxed/simple;
	bh=2xhiSNl6rv+NV5hd3w1FW9ynAL8rnL8SoqADV1EVwNI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=sB79YXR1Jf9LWhGJ7mt3hZcGmcLrwG8AtELCDWZdkgWz0dvJwev/xni0yycnaxJZcvTcPa2JVqxHgafgn2zqVEI1zoZoORi/z1i3dCt6fulNZF8+IAfZEEBONXd7IYhiUJ9Mfz3SvbNKevkA7cs7o8piLWB+Ujo/4JeW78lhwl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=tqTd1v+a; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="tqTd1v+a"
Received: from omf08.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id EF6F3120221;
	Wed,  2 Sep 2026 13:54:01 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf08.hostedemail.com (Postfix) with ESMTPA id 5D64420025;
	Wed,  2 Sep 2026 13:54:00 +0000 (UTC)
Date: Wed, 2 Sep 2026 09:55:01 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>
Subject: [PATCH v2] ftrace: Synchronize the initialization of ftrace_ops
Message-ID: <20260902095501.6b59af20@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 6zarnnjh5qgyn5kgmchx3jecoi3fqz16
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 5D64420025
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18OSNDThE9QNvit8ihvgFlUFk6P0IMr36I=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=uqBwdvyULbyZePMiwHIC2xgx+6flyyWZas5DwoTT0r4=; b=tqTd1v+aDgwfEhF0TZxSSVHEopW9dKpaSySpB0Cl8xMNb4uGwTR5nsSIEXzLCoNB7s+fYhoVzGsDhTT8zqWt+Kqho3edGeDjP1htgmDEV2JiIeD8zPdORywehcGF4anIu1PZBxsMaUF+0FlFkwaOYds9zxbkvyY7Y35uzsSpWN8=
X-HE-Tag: 1788357240-278134
X-HE-Meta: U2FsdGVkX1+QPe7Uj9LrTdGDWiRX4Jvq/CI23WyodBUHXT2sAQJaw8cNbLppb5+PM4iPPXHeS5rIlKRECE5MtIxEmGetr3PMz8235IwpCHcJHFGGoZCbRUACfeP9Xs956SJWJPnN9+JNfVvnc2HRuF6AswmqYSVtICBK5S04VHi1mIKFNlCo1AQs+mH6xwj/n7JsyxK2uBGQ7f6kpGWe4rbC8qG44zLKeHPaju9q49BXngxvmFOvkUT9caF3wHtFBYkHaFMr2r4idlExp1j5hFhhVcXUactwQvkNh4BqeSj0JnCZvkeF/GbXyVVdSon+3PcN6RmsKOPVAD9AuAN8Xirf3NZwoyfHP28NFvYTFZg0+ZFmoBTIIlpTfPQleKTN21JOXM6cH1KcU2RwWZ7yqJDJpidfOqMtWXS6gUmXw5uyR8fFHuspftgV46iF0jUV9BZ9bXqaBrgMef8YPNpJNNtH0/jvjd/8JRBTfeEtydM=

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
Changes since v1: https://patch.msgid.link/20260901202020.09a1119a@robin

- Added smp_load_acquire() and smp_store_release() to make sure that
  the flags value that is compared is really updated after the code has
  been initialized. (Sashiko)

 kernel/trace/ftrace.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index c7cf36f2dd7b..53d5db60bfa5 100644
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
@@ -159,11 +161,18 @@ const struct ftrace_ops ftrace_nop_ops = {
 static inline void ftrace_ops_init(struct ftrace_ops *ops)
 {
 #ifdef CONFIG_DYNAMIC_FTRACE
-	if (!(ops->flags & FTRACE_OPS_FL_INITIALIZED)) {
+	unsigned long flags = smp_load_acquire(&ops->flags);
+
+	if (!(flags & FTRACE_OPS_FL_INITIALIZED)) {
+		guard(mutex)(&ops_mutex);
+		/* Could have been initialized before lock taken */
+		if (unlikely(ops->flags & FTRACE_OPS_FL_INITIALIZED))
+			return;
 		mutex_init(&ops->local_hash.regex_lock);
 		INIT_LIST_HEAD(&ops->subop_list);
 		ops->func_hash = &ops->local_hash;
-		ops->flags |= FTRACE_OPS_FL_INITIALIZED;
+		flags = ops->flags | FTRACE_OPS_FL_INITIALIZED;
+		smp_store_release(&ops->flags, flags);
 	}
 #endif
 }
-- 
2.53.0

