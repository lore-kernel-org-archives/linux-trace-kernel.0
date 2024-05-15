Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B3C38FA3;
	Wed, 15 May 2024 05:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715749561; cv=none; b=C6XafUAb2O8DYMHJrFGQb7iEKEcDmWl3EMnWoxSD7ugVjQUaukWqAwYZJWzQ5lPrLAIu2K/FLblSxUko3H6WgZrjUhvVmsj0zTCUAun1Lbod99OYO9Pnl6LbRDW+l+Cxf5WTIvVPv6haZfurB5xNbiidT4pNnDsKM5m4kQZBbG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715749561; c=relaxed/simple;
	bh=OzHSy/KSpuIOanBUBmL7ptmwmGssfiNVRIQKnLPo09Y=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=T2RhoN/f1L+UXndsyRGBqRhshjWudqwDxRybQ+/T5Rz9qnKmZ/0lhHnVp7A9V7GKepUXMRmjhNQDi7vVogAiGXa7DPj0uOb4ItuE0D9k5nC4lZ/gxaXtVusr3hLIJnU0tapPE4tGjqyGIlW2bRka5YmTg0t51FCyngiHb0ZrLEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 492ABC116B1;
	Wed, 15 May 2024 05:06:00 +0000 (UTC)
Date: Wed, 15 May 2024 01:05:58 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux trace kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH] ring-buffer: Add cast to unsigned long addr passed to
 virt_to_page()
Message-ID: <20240515010558.4abaefdd@rorschach.local.home>
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

The sub-buffer pages are held in an unsigned long array, and when it is
passed to virt_to_page() a cast is needed.

Link: https://lore.kernel.org/all/20240515124808.06279d04@canb.auug.org.au/

Fixes: 117c39200d9d ("ring-buffer: Introducing ring-buffer mapping functions")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/ring_buffer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index a02c7a52a0f5..7345a8b625fb 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -6283,7 +6283,7 @@ static int __rb_map_vma(struct ring_buffer_per_cpu *cpu_buffer,
 	}
 
 	while (p < nr_pages) {
-		struct page *page = virt_to_page(cpu_buffer->subbuf_ids[s]);
+		struct page *page = virt_to_page((void *)cpu_buffer->subbuf_ids[s]);
 		int off = 0;
 
 		if (WARN_ON_ONCE(s >= nr_subbufs)) {
-- 
2.43.0

