Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0DBECC;
	Thu, 14 Nov 2024 04:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731557299; cv=none; b=HIHO1GxK2uyZLmFVwJAUCWCCC8tPP3bqmm43XJL19VNoA8kYv+UoHvTAxbh7zF96tbPUHcxWnxvbaB1P5u34LIVJAll281dvS7H7cd3rNxA/A3OsSmlupUQ/fZAkSQYAF5wbbbbGuVeK1r32c6OndAwsfY4jx+mDd6Oti6zJojc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731557299; c=relaxed/simple;
	bh=OvOTzO8f57FmoPKejOIMqjs+MzfgJB4W8bsZ8b/PN74=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=tXGNXfuuDJQlybBQRw4JC47WaU7N09WkBhaKIR3yi84DcVIqB0eLSLwNiGBj7DtJkybGUPjVz01o2kcOr0lbnxsjFgB2DUQlKaH+jpWAurGK6zxlCjOG+JiLZM5qwLCuqQx1oyK6Vi80+DY/XUYEpVhMFw7fp7ZSjekiebu6vqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA2A4C4CED0;
	Thu, 14 Nov 2024 04:08:18 +0000 (UTC)
Date: Wed, 13 Nov 2024 23:08:39 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>
Subject: [PATCH] Revert: "ring-buffer: Do not have boot mapped buffers hook
 to CPU hotplug"
Message-ID: <20241113230839.6c03640f@gandalf.local.home>
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

A crash happened when testing cpu hotplug with respect to the memory
mapped ring buffers. It was assumed that the hot plug code was adding a
per CPU buffer that was already created that caused the crash. The real
problem was due to ref counting and was fixed by commit 2cf9733891a4
("ring-buffer: Fix refcount setting of boot mapped buffers").

When a per CPU buffer is created, it will not be created again even with
CPU hotplug, so the fix to not use CPU hotplug was a red herring. In fact,
it caused only the boot buffer to be created.

Revert that change as it was not the culprit of the fix it was intended to
be.

Fixes: 912da2c384d5 ("ring-buffer: Do not have boot mapped buffers hook to CPU hotplug")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/ring_buffer.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 3ea4f7bb1837..5807116bcd0b 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -2337,12 +2337,9 @@ static struct trace_buffer *alloc_buffer(unsigned long size, unsigned flags,
 	if (!buffer->buffers[cpu])
 		goto fail_free_buffers;
 
-	/* If already mapped, do not hook to CPU hotplug */
-	if (!start) {
-		ret = cpuhp_state_add_instance(CPUHP_TRACE_RB_PREPARE, &buffer->node);
-		if (ret < 0)
-			goto fail_free_buffers;
-	}
+	ret = cpuhp_state_add_instance(CPUHP_TRACE_RB_PREPARE, &buffer->node);
+	if (ret < 0)
+		goto fail_free_buffers;
 
 	mutex_init(&buffer->mutex);
 
-- 
2.45.2

