Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53E611FBEB0;
	Thu, 13 Mar 2025 11:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741865154; cv=none; b=Zo/fSNRr4ULCSOveP6fijl1bBpgQM028VvovD9JyuEfvoYC6dHu4fwkkbzWB73yMb3CwRPZUUZEVgs6j3Zc1FHL6vCuFgYhWBlc8IxNj9aDC33vy2bWRD6M/4cJ1KfsjAX5eGfo3ZZR5dKoujr+X1BNG3R8vKsmUaJT+SHqQ/ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741865154; c=relaxed/simple;
	bh=YpYglxxRz7tATMDjDJpYUkT2GzRqVlbut1UJgnIcBz8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=OiwQCQgXuKLuGXRHuhpeDB36ZSVE44oua5bDzKfSpnKgvalZaVYsUsX6RsHj/FSY6CvBYSI28m1iwyi+WIdLMlq8kGEMXiX3jzWpx4vvQgO1xtsus2LuXeHe2sq4xxcrQsUF6BC+R0UXZo83QOC+GaQm6epKfSNOOBgHksBUgDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BF03C4CEDD;
	Thu, 13 Mar 2025 11:25:52 +0000 (UTC)
Date: Thu, 13 Mar 2025 07:25:50 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux trace kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Dan Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH] tracing: Initialize scratch_size to zero to prevent UB
Message-ID: <20250313072550.4027402a@batman.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

From: Steven Rostedt <rostedt@goodmis.org>

In allocate_trace_buffer() the following code:

  buf->buffer = ring_buffer_alloc_range(size, rb_flags, 0,
				      tr->range_addr_start,
				      tr->range_addr_size,
				      struct_size(tscratch, entries, 128));

  tscratch = ring_buffer_meta_scratch(buf->buffer, &scratch_size);
  setup_trace_scratch(tr, tscratch, scratch_size);

has undefined behavior if ring_buffer_alloc_range() fails because
"scratch_size" is not initialize. If the allocation fails, then
buf->buffer will be NULL. The ring_buffer_meta_scratch() will return
NULL immediately if it is passed a NULL buffer and it will not update
scratch_size. Then setup_trace_scratch() will return immediately if
tscratch is NULL.

Although there's no real issue here, but it is considered undefined
behavior to pass an uninitialized variable to a function as input, and
UBSan may complain about it.

Just initialize scratch_size to zero to make the code defined behavior and
a little more robust.

Link: https://lore.kernel.org/all/44c5deaa-b094-4852-90f9-52f3fb10e67a@stanley.mountain/

Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index c3c79908766e..66dc62233393 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -9387,7 +9387,7 @@ allocate_trace_buffer(struct trace_array *tr, struct array_buffer *buf, int size
 {
 	enum ring_buffer_flags rb_flags;
 	struct trace_scratch *tscratch;
-	unsigned int scratch_size;
+	unsigned int scratch_size = 0;
 
 	rb_flags = tr->trace_flags & TRACE_ITER_OVERWRITE ? RB_FL_OVERWRITE : 0;
 
-- 
2.47.2

