Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2256220B1E5;
	Tue,  8 Oct 2024 18:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728412360; cv=none; b=Qe7AYX56iSzM7/BaoyX5wsqROFt6Zy0z8Y+ziYaL4NI6B5NnGCNoUcjorz/nOawz0XfcS/kdaxp/pPPTtlrb9VY+EaMAeizgFszMcNuxNKpdAFfKcqHyJxuYkuqFBLaEzuMGGZh5CkebilED5XC+2bWxXfnp3T/UFYsprmxVF0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728412360; c=relaxed/simple;
	bh=0FfDYnXMTG/JsCokRVjwyaALkft25mZFiJ+o6dDSIAk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=FkmghwhtOeH6FNsKboxnnIpfQuP0L+1NUvpVrlTyoOZuSVZYIF7QIMEsxw8uIlbH2Nl/oXuxB9TGpKfmaXfngHFILhoDtmv5n6iWMErXAl4ns7+6GLPlm18SOrO1yXrWRk+mldBt+5XmnwPJrQC9bIHpEiOExqqYyb2ihQUXu8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68393C4CECE;
	Tue,  8 Oct 2024 18:32:39 +0000 (UTC)
Date: Tue, 8 Oct 2024 14:32:42 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>
Subject: [PATCH] ring-buffer: Do not have boot mapped buffers hook to CPU
 hotplug
Message-ID: <20241008143242.25e20801@gandalf.local.home>
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

The boot mapped ring buffer has its buffer mapped at a fixed location
found at boot up. It is not dynamic. It cannot grow or be expanded when
new CPUs come online.

Do not hook fixed memory mapped ring buffers to the CPU hotplug callback,
otherwise it can cause a crash when it tries to add the buffer to the
memory that is already fully occupied.

Fixes: be68d63a139bd ("ring-buffer: Add ring_buffer_alloc_range()")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/ring_buffer.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 77dc0b25140e..fb04445f92c3 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -2337,9 +2337,12 @@ static struct trace_buffer *alloc_buffer(unsigned long size, unsigned flags,
 	if (!buffer->buffers[cpu])
 		goto fail_free_buffers;
 
-	ret = cpuhp_state_add_instance(CPUHP_TRACE_RB_PREPARE, &buffer->node);
-	if (ret < 0)
-		goto fail_free_buffers;
+	/* If already mapped, do not hook to CPU hotplug */
+	if (!start) {
+		ret = cpuhp_state_add_instance(CPUHP_TRACE_RB_PREPARE, &buffer->node);
+		if (ret < 0)
+			goto fail_free_buffers;
+	}
 
 	mutex_init(&buffer->mutex);
 
-- 
2.45.2

