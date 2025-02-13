Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C1B628A2D5;
	Thu, 13 Feb 2025 18:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739472085; cv=none; b=OftMqkwzuKtp5KsBMDOwpsUB09ZEgbXDiVQGuPLAS/Wze6x/vzQxy38LHUiyC0UHAnz1T/LC+kgCa4/y229JEInNpVRJMGUzxdh/NyCMzdhmQChtZKskmkddPkbS6FB5aG47vipwUsuOM5bAE1KH2zjBZ1tdAKXE6CYOpHu2U8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739472085; c=relaxed/simple;
	bh=Oyc8wZuhJGqZ1+4qJrVrWM9RlgPcYMLmEUUOsWS8QCs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=ZLulDlb6/QSpRLSeZgx2o5uDiIz1Cz7uB7Hqa9kL/U0/p/Giu7Mw0YKSaxLql2MAYH0ShXWsqE9OR/GO9LdeLyryfrSvZfJ6H8EE+zLJ8VZrQbD2hLoQNFa3aEnbQbw/IBhhKLoDtU2BDdnBbsDyfT1lXuPaMceK9kV2CSTcg1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1A0EC4CEE7;
	Thu, 13 Feb 2025 18:41:22 +0000 (UTC)
Date: Thu, 13 Feb 2025 13:41:32 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Vincent Donnefort <vdonnefort@google.com>
Subject: [PATCH] tracing: Have the error of __tracing_resize_ring_buffer()
 passed to user
Message-ID: <20250213134132.7e4505d7@gandalf.local.home>
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

Currently if __tracing_resize_ring_buffer() returns an error, the
tracing_resize_ringbuffer() returns -ENOMEM. But it may not be a memory
issue that caused the function to fail. If the ring buffer is memory
mapped, then the resizing of the ring buffer will be disabled. But if the
user tries to resize the buffer, it will get an -ENOMEM returned, which is
confusing because there is plenty of memory. The actual error returned was
-EBUSY, which would make much more sense to the user.

Cc: stable@vger.kernel.org
Fixes: 117c39200d9d7 ("ring-buffer: Introducing ring-buffer mapping functions")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 1496a5ac33ae..25ff37aab00f 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -5977,8 +5977,6 @@ static int __tracing_resize_ring_buffer(struct trace_array *tr,
 ssize_t tracing_resize_ring_buffer(struct trace_array *tr,
 				  unsigned long size, int cpu_id)
 {
-	int ret;
-
 	guard(mutex)(&trace_types_lock);
 
 	if (cpu_id != RING_BUFFER_ALL_CPUS) {
@@ -5987,11 +5985,7 @@ ssize_t tracing_resize_ring_buffer(struct trace_array *tr,
 			return -EINVAL;
 	}
 
-	ret = __tracing_resize_ring_buffer(tr, size, cpu_id);
-	if (ret < 0)
-		ret = -ENOMEM;
-
-	return ret;
+	return __tracing_resize_ring_buffer(tr, size, cpu_id);
 }
 
 static void update_last_data(struct trace_array *tr)
-- 
2.47.2

