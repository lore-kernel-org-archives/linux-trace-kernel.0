Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B9D150285;
	Mon,  6 Jan 2025 16:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736179821; cv=none; b=lXfUkNDqTfKd7dbHe9pkQfv0H3+toJea93y4/TrfQdOoJrp4BeFrLfagUA/1EXZjze5vq5ztrcHWJ4wGcmFwHtfR65cHvghGHHXwNmeavRStSx+NuMLH/m7Xz3fDHmref1jBl1uCXkSAzemOWqLahGpYLz8hX6S7gqKWNZQwuvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736179821; c=relaxed/simple;
	bh=ZnV/QI7uCAl1pTFvSwYepwR49im6iPkx6dmzE/lKbeQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=a9TlSdmt6t0WKpwFrv6Njrj5JfCYGc32xGoo/Mac5oD55qm34JXiJcq4BMD7QSAXaEY9VLxUe326zCaW1dzYh8MN11SFA0ffBOJrItJ3Tz0kczTTlc4DCF0YJITpGLqt0c1TuNOAyLWlfK1MuNXM4quk+9YWYoYhRCz+OYpR5U0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C43CC4CED2;
	Mon,  6 Jan 2025 16:10:17 +0000 (UTC)
Date: Mon, 6 Jan 2025 11:11:43 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Dan Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH] tracing: Fix using ret variable in tracing_set_tracer()
Message-ID: <20250106111143.2f90ff65@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

From: Steven Rostedt <rostedt@goodmis.org>

When the function tracing_set_tracer() switched over to using the guard()
infrastructure, it did not need to save the 'ret' variable and would just
return the value when an error arised, instead of setting ret and jumping
to an out label.

When CONFIG_TRACER_SNAPSHOT is enabled, it had code that expected the
"ret" variable to be initialized to zero and had set 'ret' while holding
an arch_spin_lock() (not used by guard), and then upon releasing the lock
it would check 'ret' and exit if set. But because ret was only set when an
error occurred while holding the locks, 'ret' would be used uninitialized
if there was no error. The code in the CONFIG_TRACER_SNAPSHOT block should
be self contain. Make sure 'ret' is also set when no error occurred.

Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/r/202412271654.nJVBuwmF-lkp@intel.com/
Fixes: d33b10c0c73ad ("tracing: Switch trace.c code over to use guard()")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 0aaf442271e9..5aeb898054e7 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -6104,8 +6104,7 @@ int tracing_set_tracer(struct trace_array *tr, const char *buf)
 	if (t->use_max_tr) {
 		local_irq_disable();
 		arch_spin_lock(&tr->max_lock);
-		if (tr->cond_snapshot)
-			ret = -EBUSY;
+		ret = tr->cond_snapshot ? -EBUSY : 0;
 		arch_spin_unlock(&tr->max_lock);
 		local_irq_enable();
 		if (ret)
-- 
2.45.2

