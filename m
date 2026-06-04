Received: from mail.ilvokhin.com (mail.ilvokhin.com [178.62.254.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B295F3976BA;
	Thu,  4 Jun 2026 07:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.62.254.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780557333; cv=none; b=aATAcXqa5lcYMJW6c3LQg3kSDKM6GiB0q8b3A1mphGxjTdIugLi/x8mpX/lIREb3x9op+39OO/E4dsA6uvQG5C/RWezQwqI5B8dTaMEO8s+UEGC/ypK28XIdFUiGtV2IcGAYpdv3Pj1wofuaPaK3rjZQQb7on6Sg4NlGwuMwYac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780557333; c=relaxed/simple;
	bh=eOTSJGSvaXkjHXqunTfnKYt4gU6nZavkVCq35bHNNNA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qzWy5X9oxUOC73gtqnDmFdW3imrRP9WLbUsLkkmtYaeblmJh2vFpcxctDj5oCxGBhEoT2MQuJWwz0rBcYOpZAaJcwZMke8fVnINGMirBPSLnPr9pog/+WbtUggkJGIPpqqgJNuHge+MWdAlBE2d0x/2XJoYG1mbiGQKdnkBLXOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ilvokhin.com; spf=pass smtp.mailfrom=ilvokhin.com; dkim=pass (1024-bit key) header.d=ilvokhin.com header.i=@ilvokhin.com header.b=LQAD3bDw; arc=none smtp.client-ip=178.62.254.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ilvokhin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ilvokhin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ilvokhin.com header.i=@ilvokhin.com header.b="LQAD3bDw"
Received: from localhost.localdomain (shell.ilvokhin.com [138.68.190.75])
	(Authenticated sender: d@ilvokhin.com)
	by mail.ilvokhin.com (Postfix) with ESMTPSA id B36E6D1155;
	Thu, 04 Jun 2026 07:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ilvokhin.com;
	s=mail; t=1780557330;
	bh=TG6KIx+oIC2b0cGiCH0bSSlQMFTnLC97rQasKVI++8k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LQAD3bDwyvsD6e6zgIbTkydrhSi2OY3DrxUPAIxUtBHYRxeboFoyaUhHD3IO7DaQq
	 ltIkn2U67MYXRL0AxGkKCp7OTOw5687ogyaat7n3mlWs9JrYmao80P1bhcDOUUzUke
	 XKqfW8bnYhrMcEGHq8h+JLSI7dBYHmwZ6RQcVGw0=
From: Dmitry Ilvokhin <d@ilvokhin.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Dennis Zhou <dennis@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Christoph Lameter <cl@gentwo.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Boqun Feng <boqun@kernel.org>,
	Waiman Long <longman@redhat.com>
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	kernel-team@meta.com,
	Dmitry Ilvokhin <d@ilvokhin.com>,
	Usama Arif <usama.arif@linux.dev>
Subject: [PATCH v7 1/3] tracing/lock: Remove unnecessary linux/sched.h include
Date: Thu,  4 Jun 2026 07:15:05 +0000
Message-ID: <85e14a0685c1d46c3e80de2dc01358a48169b263.1780506267.git.d@ilvokhin.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1780506267.git.d@ilvokhin.com>
References: <cover.1780506267.git.d@ilvokhin.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

None of the trace events in lock.h reference anything from
linux/sched.h. Remove the unnecessary include.

Signed-off-by: Dmitry Ilvokhin <d@ilvokhin.com>
Acked-by: Usama Arif <usama.arif@linux.dev>
---
 include/trace/events/lock.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/trace/events/lock.h b/include/trace/events/lock.h
index 8e89baa3775f..da978f2afb45 100644
--- a/include/trace/events/lock.h
+++ b/include/trace/events/lock.h
@@ -5,7 +5,6 @@
 #if !defined(_TRACE_LOCK_H) || defined(TRACE_HEADER_MULTI_READ)
 #define _TRACE_LOCK_H
 
-#include <linux/sched.h>
 #include <linux/tracepoint.h>
 
 /* flags for lock:contention_begin */
-- 
2.53.0-Meta

