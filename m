Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF30D2D60C;
	Sat, 19 Oct 2024 01:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729302734; cv=none; b=imXr0Up89OCtTuA+EGgY+TXLhPVoUlzI/hBD6Et3FNrUWhcgF2KfZYv6dzI/gdrywWikcMH8lPkX+OlCnxpB/yjlbtcDDsEgXdYtkFLkIIgPDY5TFFO/3E3CE39Bidyxe9si4rvIr/iWeSbWhdEu8X7dIIKvf7TbPl91K/98vLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729302734; c=relaxed/simple;
	bh=e7fIjt96GEw8FSmtSkAxFr9B2ZpDE+NnFFzWcVyRF3g=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=hnRtfE9N4e1LDXOWbrdQ0j/kICjBwjAiVbXulQwBOzQtG/nOqP8LrJHD6ICVWNyHLJDEqO4Q140f+iYCllEA7tI1tY7JSJeETsbLxa8+5c1uwWAavaDNgaS9prvT8RoG4uqre6UWd4DWAmMCbgC3IbFYMj5jCOPKDwrYYs2LFqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A62A4C4CEC3;
	Sat, 19 Oct 2024 01:52:13 +0000 (UTC)
Date: Fri, 18 Oct 2024 21:52:12 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux trace kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH] fgraph: Allocate ret_stack_list with proper size
Message-ID: <20241018215212.23f13f40@rorschach>
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

The ret_stack_list is an array of ret_stack shadow stacks for the function
graph usage. When the first function graph is enabled, all tasks in the
system get a shadow stack. The ret_stack_list is a 32 element array of
pointers to these shadow stacks. It allocates the shadow stack in batches
(32 stacks at a time), assigns them to running tasks, and continues until
all tasks are covered.

When the function graph shadow stack changed from an array of
ftrace_ret_stack structures to an array of longs, the allocation of
ret_stack_list went from allocating an array of 32 elements to just a
block defined by SHADOW_STACK_SIZE. Luckily, that's defined as PAGE_SIZE
and is much more than enough to hold 32 pointers. But it is way overkill
for the amount needed to allocate.

Change the allocation of ret_stack_list back to a kcalloc() of
FTRACE_RETSTACK_ALLOC_SIZE pointers.

Fixes: 42675b723b484 ("function_graph: Convert ret_stack to a series of longs")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/fgraph.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index 43f4e3f57438..41e7a15dcb50 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -1162,7 +1162,8 @@ static int start_graph_tracing(void)
 	unsigned long **ret_stack_list;
 	int ret;
 
-	ret_stack_list = kmalloc(SHADOW_STACK_SIZE, GFP_KERNEL);
+	ret_stack_list = kcalloc(FTRACE_RETSTACK_ALLOC_SIZE,
+				 sizeof(*ret_stack_list), GFP_KERNEL);
 
 	if (!ret_stack_list)
 		return -ENOMEM;
-- 
2.45.2

