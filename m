Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28C1D1AC44D;
	Tue, 27 May 2025 18:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748371527; cv=none; b=hSqZ6R3EkvB2MlGJuURaEk3F/6xjY9MifjhMkFw5F1Tx4crlDDgW/2U6hFdEfVj5oJ3ocwDzQXX6a/NfaOrywWcxZM3soxDLg552gtvCXKEoUUlEYkHk4LJT7sAOLvRYNkqnmdF2Vqpe5fO/5UFEAr221Y/YVuzj7HhfL384gko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748371527; c=relaxed/simple;
	bh=qbR1nvMOL/0w3B8hpSA7B5j6lT4nrk8IfSqFKcJ8hN0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=Gyqg4uqbHL1zPfh/n3rv3g3+BLW+wpNG3llh+tTgMVR7bkgbwOYgMGQZ0TR97B468Wsff9KmxhHlPTHfDRso6ve9a/5xXdz3THAbV8e7cyvw/gii46JVrsFUcBg+5JuS4Fdf7MfBeUzD4qb+BZJj49s6T4thIZBwCWA6AIAiMZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E91DAC4CEE9;
	Tue, 27 May 2025 18:45:25 +0000 (UTC)
Date: Tue, 27 May 2025 14:46:23 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>
Subject: [PATCH] ring-buffer: Simplify reset_disabled_cpu_buffer() with use
 of guard()
Message-ID: <20250527144623.77a9cc47@gandalf.local.home>
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

Use guard(raw_spinlock_irqsave)() in reset_disabled_cpu_buffer() to
simplify the locking.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/ring_buffer.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 10a4b26929ae..0b21d64e90c8 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -6112,21 +6112,16 @@ rb_reset_cpu(struct ring_buffer_per_cpu *cpu_buffer)
 /* Must have disabled the cpu buffer then done a synchronize_rcu */
 static void reset_disabled_cpu_buffer(struct ring_buffer_per_cpu *cpu_buffer)
 {
-	unsigned long flags;
-
-	raw_spin_lock_irqsave(&cpu_buffer->reader_lock, flags);
+	guard(raw_spinlock_irqsave)(&cpu_buffer->reader_lock);
 
 	if (RB_WARN_ON(cpu_buffer, local_read(&cpu_buffer->committing)))
-		goto out;
+		return;
 
 	arch_spin_lock(&cpu_buffer->lock);
 
 	rb_reset_cpu(cpu_buffer);
 
 	arch_spin_unlock(&cpu_buffer->lock);
-
- out:
-	raw_spin_unlock_irqrestore(&cpu_buffer->reader_lock, flags);
 }
 
 /**
-- 
2.47.2

