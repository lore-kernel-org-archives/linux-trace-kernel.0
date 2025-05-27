Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA70D2DCBF0;
	Tue, 27 May 2025 19:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748375419; cv=none; b=kw0Hp2vF4K5TdUGGZ3+TnWsqQXo07QrIOollGE3suoxX11bcFOB1QTMuzfU6ex7EJTDgrMmUUqSfS92Wg9WTgWwdF7y4gCqr1/XVIKMO5JYd10USlW49hHMZREZGvq9zlvrF+52vHTcbPlsjjSMoYMCKPPeEDVcMr0Vovttyd1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748375419; c=relaxed/simple;
	bh=dV8TaxUw9B/U7sVtHJzAMm/STGMFsc5fuVvoZ7Dxg9o=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=kOAevrvXmTdHPJ8cPYq+izm/p4nHJ3MjLHY9vWkVfklBi4F6wJXmKELuS+3vQ2ly8S0sFBo5AiXpZdD8ds6qrM0GqTbYvp1ort2cTyekg3oZ00Li6iUsBbqfn0Jkf/VnRDs8EL3vzjxRA3AD1YNExe1/h53We6k1YtcU0VqzgZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89235C4CEE9;
	Tue, 27 May 2025 19:50:18 +0000 (UTC)
Date: Tue, 27 May 2025 15:51:16 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>
Subject: [PATCH] ring-buffer: Removed unnecessary if() goto out where out is
 the next line
Message-ID: <20250527155116.227f35be@gandalf.local.home>
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

In the function ring_buffer_discard_commit() there's an if statement that
jumps to the next line:

	if (rb_try_to_discard(cpu_buffer, event))
		goto out;
 out:

This was caused by the change that modified the way timestamps were taken
in interrupt context, and removed the code between the if statement and
the goto, but failed to update the conditional logic.

Fixes: a389d86f7fd0 ("ring-buffer: Have nested events still record running time stamp")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/ring_buffer.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index e2aa90dc8d9e..0a3be3a01d14 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -4681,10 +4681,7 @@ void ring_buffer_discard_commit(struct trace_buffer *buffer,
 	RB_WARN_ON(buffer, !local_read(&cpu_buffer->committing));
 
 	rb_decrement_entry(cpu_buffer, event);
-	if (rb_try_to_discard(cpu_buffer, event))
-		goto out;
-
- out:
+	rb_try_to_discard(cpu_buffer, event);
 	rb_end_commit(cpu_buffer);
 
 	trace_recursive_unlock(cpu_buffer);
-- 
2.47.2

