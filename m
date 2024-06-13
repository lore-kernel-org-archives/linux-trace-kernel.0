Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61952161;
	Thu, 13 Jun 2024 13:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718286747; cv=none; b=F+Uf0/1lFu0UzgH+kC3p31tGnhMFP+K+CyGEgxnR/0/y86MlUde8hWzSXt2DjFM3Ns1IBHkzNGWennR7nTMl83jHWGyrZ6gzFQZcPpZmDH0WaeiqkpfHmmHIAdaUrPS33ZKGB9uyJVAaoxma8lZJ2WUv8J5rjBHgS8+8lmtSlNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718286747; c=relaxed/simple;
	bh=9dHSMOKqQ7eHeWqhAwwz31AHL3NqJp2gEZYZPH2vk4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=Fxrgx+g2+S6WxZSgSFf4hC22+pF+WIcQgxl4xsQDBI2QPWBZ2BJ3U64LXC9HwJYsKVj0ZzeW07NFmLowWf2YjJZ5s3iNzT+N9+A6s1EavqF0ZeHf+BaBJ6Ug+s+YCMaKtVvflVPPCwZAg2gF00PFgmFKlA7z84iwSjb7D0Jbrlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 293EEC2BBFC;
	Thu, 13 Jun 2024 13:52:25 +0000 (UTC)
Date: Thu, 13 Jun 2024 09:52:23 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux trace kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Naresh Kamboju <naresh.kamboju@linaro.org>
Subject: [PATCH] function_graph: Add READ_ONCE() when accessing
 fgraph_array[]
Message-ID: <20240613095223.1f07e3a4@rorschach.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

In function_graph_enter() there's a loop that looks at fgraph_array[]
elements which are fgraph_ops. It first tests if it is a fgraph_stub op,
and if so skips it, as that's just there as a place holder. Then it checks
the fgraph_ops filters to see if the ops wants to trace the current
function.

But if the compiler reloads the fgraph_array[] after the check against
fgraph_stub, it could race with the fgraph_array[] being updated with the
fgraph_stub. That would cause the stub to be processed. But the stub has a
null "func_hash" field which will cause a NULL pointer dereference.

Add a READ_ONCE() so that the gops that is compared against the
fgraph_stub is also the gops that is processed later.

Link: https://lore.kernel.org/all/CA+G9fYsSVJQZH=nM=1cjTc94PgSnMF9y65BnOv6XSoCG_b6wmw@mail.gmail.com/

Fixes: cc60ee813b503 ("function_graph: Use static_call and branch to optimize entry function")
Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/fgraph.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index 8317d1a7f43a..fc205ad167a9 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -641,7 +641,7 @@ int function_graph_enter(unsigned long ret, unsigned long func,
 	{
 		for_each_set_bit(i, &fgraph_array_bitmask,
 					 sizeof(fgraph_array_bitmask) * BITS_PER_BYTE) {
-			struct fgraph_ops *gops = fgraph_array[i];
+			struct fgraph_ops *gops = READ_ONCE(fgraph_array[i]);
 			int save_curr_ret_stack;
 
 			if (gops == &fgraph_stub)
-- 
2.43.0

