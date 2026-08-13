Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE2662DF6F4;
	Thu, 13 Aug 2026 03:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786593041; cv=none; b=lOndmBGuarmq5WDfSNHue/JoHwlUqQZeN5UCh3Z5WqKfDXB93qgPp/80jBQ8aYxnswjG1jJHkHT1IWwA/hJQZie1SdHGrMus+ZeWyZmFFCJsar7udJMcXcxNm7TJddmJbBhcORj1dCTfvEmjB2QU2OmuLqkZ71tSgWEsDNHTCoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786593041; c=relaxed/simple;
	bh=d7MkGq8H8zm5dfWimycwfqvz6dfqxiscpXO2Kan5j58=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WGJKFac0Jc3Oa/1trlFPveNmvmzHgm73HxIHItutKdO/Kb9ZK/4HvirI2zjRZpFRBVdfxMh/TAdzPKtcs7zyQCBiAojxXi1zkP4ibViXiRcPjxuBQLC42eoCBr/EUse7DJKeH6ChnTsS6hoLgGk6Ghkqf4uhyHifZrXqxYW+zMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mavick.dev; spf=pass smtp.mailfrom=mavick.dev; dkim=pass (2048-bit key) header.d=mavick.dev header.i=@mavick.dev header.b=TZqm343h; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mavick.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mavick.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mavick.dev header.i=@mavick.dev header.b="TZqm343h"
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4hLBGM4VzszKnY1;
	Thu, 13 Aug 2026 05:50:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mavick.dev; s=MBO0001;
	t=1786593035;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p2aTAtzaBo15r45rnzIKt1YFOff3C6zZQXKjs0RwoRE=;
	b=TZqm343hlculBz0/mBe/XsJsfy+PMuEIL3W+5wlpU8uIMlx0O46lcF619P32GunYbacwFs
	TeeUeDLDtFPaezUjj5SBiSJimQy8ZIhi2XdulZ1eImEiZrA/GpMiFSOTRVHNWeyC6QCdx6
	QbO9bt6qfKrjYqUzUjEfz2RRG4Gzs3aOUrHjmMcAdkGiZ0dDFTxTypaf3BSAXcbM6fzCa6
	wR/lbVUE1UkljwahXAQXZGQj/7iSoUEjraQqXJsiEC5i9VsqKAlsmcRscgAvXEqPJmLP+0
	4Nwwba/54kF+8tfVB36DF60kN2PoPSJeGQVkoJQkv3oXfbgifeMzXllaBNrv3w==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of m@mavick.dev designates 2001:67c:2050:b231:465::2 as permitted sender) smtp.mailfrom=m@mavick.dev
From: Eugene Mavick <m@mavick.dev>
Date: Thu, 13 Aug 2026 11:49:08 +0800
Subject: [PATCH v5 2/5] refcount: add refcount_final_put tracepoint
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260813-refcount-final-put-trace-v5-2-6e8bf8a38b31@mavick.dev>
References: <20260813-refcount-final-put-trace-v5-0-6e8bf8a38b31@mavick.dev>
In-Reply-To: <20260813-refcount-final-put-trace-v5-0-6e8bf8a38b31@mavick.dev>
To: Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
 Boqun Feng <boqun@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Gary Guo <gary@garyguo.net>, Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Andrew Morton <akpm@linux-foundation.org>, Dennis Zhou <dennis@kernel.org>, 
 Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@gentwo.org>, 
 Dmitry Vyukov <dvyukov@google.com>, Andrey Konovalov <andreyknvl@gmail.com>, 
 Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>, 
 Andrey Ryabinin <ryabinin.a.a@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 linux-mm@kvack.org, kasan-dev@googlegroups.com, 
 Eugene Mavick <m@mavick.dev>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1864; i=m@mavick.dev;
 h=from:subject:message-id; bh=d7MkGq8H8zm5dfWimycwfqvz6dfqxiscpXO2Kan5j58=;
 b=owGbwMvMwCU2V/5U3e1aE3/G02pJDFm1dgdz7yiFsoXdCuBP27WwbKaA23lGK6eAT2uWZLFe2
 6Esz7C5o5SFQYyLQVZMkaUmK8E9Y+WsROOjk3pg5rAygQxh4OIUgImk32VkOOZ8vPf03WBZ4UPP
 ZI918QdanD+88ExExZbmxdV3eO8v2cjI8Fl23sdTzSbrHypN7AvnWfM46qyDoZEu1+MnfrGJ253
 28QMA
X-Developer-Key: i=m@mavick.dev; a=openpgp;
 fpr=7C6A604768A99A6133C5928C9D1FCA7EDB7D344F
X-Rspamd-Queue-Id: 4hLBGM4VzszKnY1

Add the refcount_final_put tracepoint to __refcount_sub_and_test()
and refcount_dec_if_one()

refcount_final_put fires when a reference
count reaches zero and the object enters its final release path.

refcount_final_put records three fields:
- caller: function that called the refcounting
  function(refcount_sub_and_test, percpu_ref_put_many)
- ip: return address of trace wrapper macro call
- obj: refcount object(struct percpu_ref, refcount_t)

Signed-off-by: Eugene Mavick <m@mavick.dev>
---
 include/linux/refcount.h | 2 ++
 lib/refcount.c           | 6 +++++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/linux/refcount.h b/include/linux/refcount.h
index ba7657ced281..23291a31d1be 100644
--- a/include/linux/refcount.h
+++ b/include/linux/refcount.h
@@ -107,6 +107,7 @@
 #include <linux/limits.h>
 #include <linux/refcount_types.h>
 #include <linux/spinlock_types.h>
+#include <linux/refcount_trace.h>
 
 struct mutex;
 
@@ -393,6 +394,7 @@ bool __refcount_sub_and_test(int i, refcount_t *r, int *oldp)
 
 	if (old > 0 && old == i) {
 		smp_acquire__after_ctrl_dep();
+		do_trace_refcount_final_put(r);
 		return true;
 	}
 
diff --git a/lib/refcount.c b/lib/refcount.c
index a207a8f22b3c..8b148b576503 100644
--- a/lib/refcount.c
+++ b/lib/refcount.c
@@ -7,6 +7,7 @@
 #include <linux/refcount.h>
 #include <linux/spinlock.h>
 #include <linux/bug.h>
+#include <linux/refcount_trace.h>
 
 #define REFCOUNT_WARN(str)	WARN_ONCE(1, "refcount_t: " str ".\n")
 
@@ -56,7 +57,10 @@ bool refcount_dec_if_one(refcount_t *r)
 {
 	int val = 1;
 
-	return atomic_try_cmpxchg_release(&r->refs, &val, 0);
+	bool ret = atomic_try_cmpxchg_release(&r->refs, &val, 0);
+
+	do_trace_refcount_final_put_cond(ret, r);
+	return ret;
 }
 EXPORT_SYMBOL(refcount_dec_if_one);
 

-- 
2.51.2

