Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39252A59;
	Sat, 19 Oct 2024 19:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729366195; cv=none; b=hRN6rL7fcCMbV03V+z4IUAJzeopariZaxyKmya9M9uPDk5oO4Oiuq6c5YkanrEinn6Ezh0JlJu78GEpGLTQho+nkm9piZb8fLe0TNfKpL14F3e2xb4sD6kv9kbO9f7p2O4Qyra2KhCiGjCcQIehgMQe55mK3x4nOFKiJObbRFWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729366195; c=relaxed/simple;
	bh=e/bZ/6qu4+8ZIh7lBsxWSX2qAbUed7FU+h5KuxoPDuQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=kf2lyulUKcADe//mt/ReG7ZmohWLE/bg563RdP4G7cB6yeG+06ayjY7CWf7zZfSrKTxaM9vUhpRlm6ZZG2Xg723nReFx2dltVRqIpKbljGQgVw6t0u0P8lPOTlSGzC3JWUhlFkPtxFHhalZaM3DT0LR5QoZrM1cAz6bcaPrQzTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91AC1C4CEC5;
	Sat, 19 Oct 2024 19:29:53 +0000 (UTC)
Date: Sat, 19 Oct 2024 15:29:51 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux trace kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Ryan Roberts <ryan.roberts@arm.com>
Subject: [PATCH] fgraph: Separate size of ret_stack from PAGE_SIZE
Message-ID: <20241019152951.053f9646@rorschach.local.home>
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

The ret_stack (shadow stack used by function graph infrastructure) is
currently defined as PAGE_SIZE. But some architectures which have 64K
PAGE_SIZE, this is way overkill. Also there's an effort to allow the
PAGE_SIZE to be defined at boot up.

Hard code it for now to 4096. In the future, this size may change and even
be dependent on specific architectures.

Link: https://lore.kernel.org/all/e5067bb8-0fcd-4739-9bca-0e872037d5a1@arm.com/

Suggested-by: Ryan Roberts <ryan.roberts@arm.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/fgraph.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index ee829d65f301..51e81b299a0d 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -153,7 +153,7 @@ enum {
  * SHADOW_STACK_OFFSET:	The size in long words of the shadow stack
  * SHADOW_STACK_MAX_OFFSET: The max offset of the stack for a new frame to be added
  */
-#define SHADOW_STACK_SIZE	(PAGE_SIZE)
+#define SHADOW_STACK_SIZE	(4096)
 #define SHADOW_STACK_OFFSET	(SHADOW_STACK_SIZE / sizeof(long))
 /* Leave on a buffer at the end */
 #define SHADOW_STACK_MAX_OFFSET				\
-- 
2.45.2

