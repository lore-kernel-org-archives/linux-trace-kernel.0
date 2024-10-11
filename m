Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B077199231;
	Fri, 11 Oct 2024 20:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728679935; cv=none; b=hJHK1BcT6QruKTTzMpe1anXl7aJ5PQDf1McaEnKwA+BkhQ1L6yWpVIOr2PM9xD6N/kbZ4N5znSZ18OHUpgschka33IZH+IgZIJuvW9klISirMJ+m7K2+mC6dSz+n96fAfO1FqPA5kyj2SXCl8bGZyPTySYGYb9Hzgi6NpGny+SM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728679935; c=relaxed/simple;
	bh=/mEtVoE39iP2Qc58gy8XZrokqEhMtz0bKnzSQsjF+j4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=kWXPXVQcgFt59vP4kDKAQje3ELE++i1CE2S1vkqWjljjG/GSf2rqstsqapHuZAmZhjgA4Zq3ZKsOxO52H5qGHA/nLBRyYE1d+qtuRSxgZ7WTPmJhbfmxgbFmIdKDLcT/PdkZYKb4A8JM972XVIqZNyPVr++9WQkBnM9XfIekE5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C89AC4CEC3;
	Fri, 11 Oct 2024 20:52:14 +0000 (UTC)
Date: Fri, 11 Oct 2024 16:52:24 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>
Subject: [PATCH] ring-buffer: Fix refcount setting of boot mapped buffers
Message-ID: <20241011165224.33dd2624@gandalf.local.home>
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

A ring buffer which has its buffered mapped at boot up to fixed memory
should not be freed. Other buffers can be. The ref counting setup was
wrong for both. It made the not mapped buffers ref count have zero, and the
boot mapped buffer a ref count of 1. But an normally allocated buffer
should be 1, where it can be removed.

Keep the ref count of a normal boot buffer with its setup ref count (do
not decrement it), and increment the fixed memory boot mapped buffer's ref
count.

Fixes: e645535a954ad ("tracing: Add option to use memmapped memory for trace boot instance")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index c01375adc471..5ba40f39c8b5 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -10610,10 +10610,10 @@ __init static void enable_instances(void)
 		 * cannot be deleted by user space, so keep the reference
 		 * to it.
 		 */
-		if (start)
+		if (start) {
 			tr->flags |= TRACE_ARRAY_FL_BOOT;
-		else
-			trace_array_put(tr);
+			tr->ref++;
+		}
 
 		while ((tok = strsep(&curr_str, ","))) {
 			early_enable_events(tr, tok, true);
-- 
2.45.2

