Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E85422D4F1;
	Thu, 29 May 2025 17:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748541399; cv=none; b=LhEqiYmG3/byfU8jwkzhRnE2s+pmu2tIS6Dz8Wj6jv4UOOAxjZSO4ZGA7UT28RdYpAlRAdGQan34CQi8vE9OTwaiYknxB/eIszEUXCowSDhld6LX9yzbpEO7HJ3JfOzc2x6DiPMVAR8EaX2UKv8f7IsGIG/B86HdPsmrB9EiXMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748541399; c=relaxed/simple;
	bh=nBaPFnGZ8zAqrt7XWiu/CTvg3TapI+TMSoVy9JURpek=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=sme0LmHmxyj/9DxzHYZOOZCDRIn3aAIfXe1FYcWJnUl9z18iMT38pdpxT6o69Q/SwLTWljr+v+4qox5mRR2CC/eLugQ/0lxkmawbskhek1BK7iy4toZYSA3CjeUxE/oFGGEh7NomhliYowWcUCj6GpFeVyRUmIipUYo1iPohKNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEC59C4CEE7;
	Thu, 29 May 2025 17:56:37 +0000 (UTC)
Date: Thu, 29 May 2025 13:57:39 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Juergen Gross <jgross@suse.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Masami Hiramatsu
 <mhiramat@kernel.org>
Subject: [PATCH] genirq/matrix: Remove unused irq_matrix_alloc_reserved
 tracepoint
Message-ID: <20250529135739.26e5c075@gandalf.local.home>
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

The tracepoint irq_matrix_alloc_reserved was added but never used.
Remove it.

Link: https://lore.kernel.org/all/20250529130138.544ffec4@gandalf.local.home/

Fixes: ec0f7cd273dc4 ("genirq/matrix: Add tracepoints")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/trace/events/irq_matrix.h | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/include/trace/events/irq_matrix.h b/include/trace/events/irq_matrix.h
index 267d4cbbf360..93244078b4e6 100644
--- a/include/trace/events/irq_matrix.h
+++ b/include/trace/events/irq_matrix.h
@@ -138,14 +138,6 @@ DEFINE_EVENT(irq_matrix_global_update, irq_matrix_assign_system,
 	TP_ARGS(bit, matrix)
 );
 
-DEFINE_EVENT(irq_matrix_cpu, irq_matrix_alloc_reserved,
-
-	TP_PROTO(int bit, unsigned int cpu,
-		 struct irq_matrix *matrix, struct cpumap *cmap),
-
-	TP_ARGS(bit, cpu, matrix, cmap)
-);
-
 DEFINE_EVENT(irq_matrix_cpu, irq_matrix_reserve_managed,
 
 	TP_PROTO(int bit, unsigned int cpu,
-- 
2.47.2

