Received: from mout-y-111.mailbox.org (mout-y-111.mailbox.org [91.198.250.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E6D3E4C99;
	Mon,  6 Jul 2026 07:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.198.250.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783324657; cv=none; b=chgy/e4iRThqKksR3KwJZsP3hk+NIfxtphaofTKgV+Lma5w2XpVWpaikjR8nCe3DqL5wwFrDRpEYm3hpAc8Olgqc9kWP+oC93SrwGgn0YIMHrpTePS6YLpQUK7LukAjn95xZBfdphWSrAarR4QnFvU8AtblOevdCCuDfuVV+gB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783324657; c=relaxed/simple;
	bh=/PtvR2dnazpQOJk7UFgwLIewlTHNG+dDvVdArf0En58=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=N9Jh7y89VyDiweDcAlYB7OBLbTtsZruk4+d896cqk1TaevncXlX/cGL09i4taVQxl/IzAH4mCNAZDWNv1NZxgulQmvm7mXObWP53DSJJWZO0yHwrogOEe7zsAQN6elRfiFlUPT4AajPt1CHgoeFFU9kE0iWdjhSNVupiBpnUXdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mavick.dev; spf=pass smtp.mailfrom=mavick.dev; arc=none smtp.client-ip=91.198.250.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mavick.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mavick.dev
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA512)
	(No client certificate requested)
	by mout-y-111.mailbox.org (Postfix) with ESMTPS id 4gspTr2cybzMldH;
	Sat, 04 Jul 2026 13:36:00 +0200 (CEST)
From: Eugene Mavick <m@mavick.dev>
Date: Sat, 04 Jul 2026 19:34:46 +0800
Subject: [PATCH 3/4] percpu-refcount: add ref_trace_final_put trace
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260704-refcount-final-put-trace-v1-3-b48746da1f27@mavick.dev>
References: <20260704-refcount-final-put-trace-v1-0-b48746da1f27@mavick.dev>
In-Reply-To: <20260704-refcount-final-put-trace-v1-0-b48746da1f27@mavick.dev>
To: Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
 Boqun Feng <boqun@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Gary Guo <gary@garyguo.net>, Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Andrew Morton <akpm@linux-foundation.org>, Dennis Zhou <dennis@kernel.org>, 
 Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@gentwo.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 linux-mm@kvack.org, Eugene Mavick <m@mavick.dev>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1195; i=m@mavick.dev;
 h=from:subject:message-id; bh=/PtvR2dnazpQOJk7UFgwLIewlTHNG+dDvVdArf0En58=;
 b=owGbwMvMwCU2V/5U3e1aE3/G02pJDFke759u3DTLoJNjhZ1qs6qnb/ur9Vdyg9u09i3ZXX0u6
 UKsscOKjlIWBjEuBlkxRZaarAT3jJWzEo2PTuqBmcPKBDKEgYtTACYitY2RYYVU/EPXZjbNnXfM
 X/W9eRQimHObqZnTk/1zxUZnxpRLqgz/0z6EdFW0F02TerHhhsM1sbl/7h0MU5/iYM/QZ/2K6UE
 +DwA=
X-Developer-Key: i=m@mavick.dev; a=openpgp;
 fpr=7C6A604768A99A6133C5928C9D1FCA7EDB7D344F

Add the ref_trace_final_put tracepoint to percpu_ref_put_many().
The tracepoint fires when the atomic counter reaches zero in the
atomic fallback path (after percpu_ref_kill() has been called).

Signed-off-by: Eugene Mavick <m@mavick.dev>
---
 include/linux/percpu-refcount.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/linux/percpu-refcount.h b/include/linux/percpu-refcount.h
index d73a1c08c3e3..55543ecdf60c 100644
--- a/include/linux/percpu-refcount.h
+++ b/include/linux/percpu-refcount.h
@@ -55,6 +55,7 @@
 #include <linux/rcupdate.h>
 #include <linux/types.h>
 #include <linux/gfp.h>
+#include <linux/ref_trace.h>
 
 struct percpu_ref;
 typedef void (percpu_ref_func_t)(struct percpu_ref *);
@@ -331,8 +332,10 @@ static inline void percpu_ref_put_many(struct percpu_ref *ref, unsigned long nr)
 
 	if (__ref_is_percpu(ref, &percpu_count))
 		this_cpu_sub(*percpu_count, nr);
-	else if (unlikely(atomic_long_sub_and_test(nr, &ref->data->count)))
+	else if (unlikely(atomic_long_sub_and_test(nr, &ref->data->count))) {
+		trace_ref_final_put(ref);
 		ref->data->release(ref);
+	}
 
 	rcu_read_unlock();
 }

-- 
2.51.2

