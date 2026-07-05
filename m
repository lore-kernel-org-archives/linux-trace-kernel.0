Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F3B175A93;
	Sun,  5 Jul 2026 01:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783214479; cv=none; b=GuPuoGd64ispDLy3hC+AM1pRk1gHvZj4jrqGOp9a2eFHP+FoOTYa00nKZl27G6TteuyD3uGc9XVIoiD8/Cay8ENJlBGVySYBJzbwCFyC/m+eClUtNEVyrHK8grG6UEdFbRlZeKlZw7S0aIi+cnXMqjfsNMD6a6jW68r9PlfdYBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783214479; c=relaxed/simple;
	bh=092K+mnM9FfN5yXf2Xs+rcOrwMhZJL4+C3H4p6Evbq0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cytYNYppjG7Dc0rg2XqesMqFg8MdScw1+1uU81LrvzUCMH7oietghQMoYr4jyk4QC1axHmYq55Fjms4vKD4YUPdG+VVjGIx3QxcoqKARHSCdM+Yfv3OmIcIC1VdQyEuXBx3p4Nkkd9vNPzCnfRoqhJGl/NDdWGXN2SOk6W7sVzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WmlpUgeC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WmlpUgeC"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 44C46C2BCF4;
	Sun,  5 Jul 2026 01:21:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1783214479;
	bh=092K+mnM9FfN5yXf2Xs+rcOrwMhZJL4+C3H4p6Evbq0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=WmlpUgeCRJARUH1ajt3DFVXTJPRkqrRt+9nCSIWHQIddmCwDLH7Ljh9bKj1oV/IXE
	 4RtYb6dJH1yDSR1L8HZaDTubKnx9AAWVk9Ecqwz9KFUYUZ1wWBpAQ/SQnxq9A2HMH6
	 YVpOuCaqrmMomf0l9RcBw+R0q5WfnV488IVqEZwEtGCUfZPQrgxbVYu6XmA1IwzUNU
	 IML/rQTL+uD9deU8ShGIYGOH6t2v26/TnECTJSA7QXwEIsrT5jh/UsC5uMpbxaY1Iu
	 4qnKlpjPM5KU6cwdu9V4/iP738OOo+KUfSa7UGqjhkjg7lWuBcs3dae99/gGicjehm
	 mB5lkY60jmiww==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 261D5C43602;
	Sun,  5 Jul 2026 01:21:19 +0000 (UTC)
From: Eugene Mavick via B4 Relay <devnull+m.mavick.dev@kernel.org>
Date: Sun, 05 Jul 2026 09:20:53 +0800
Subject: [PATCH 3/4] percpu-refcount: add ref_trace_final_put trace
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260705-refcount-final-put-trace-v1-3-0ae936edb750@mavick.dev>
References: <20260705-refcount-final-put-trace-v1-0-0ae936edb750@mavick.dev>
In-Reply-To: <20260705-refcount-final-put-trace-v1-0-0ae936edb750@mavick.dev>
To: Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
 Boqun Feng <boqun@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Gary Guo <gary@garyguo.net>, Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Andrew Morton <akpm@linux-foundation.org>, Dennis Zhou <dennis@kernel.org>, 
 Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@gentwo.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 linux-mm@kvack.org, Eugene Mavick <m@mavick.dev>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1195; i=m@mavick.dev;
 h=from:subject:message-id;
 bh=/PtvR2dnazpQOJk7UFgwLIewlTHNG+dDvVdArf0En58=;
 b=owGbwMvMwCU2V/5U3e1aE3/G02pJDFmeGytPle5IS+VUk5v2rN96d+FJMUZOOe4Ts0+8SM9zi
 r3NKKHYUcrCIMbFICumyFKTleCesXJWovHRST0wc1iZQIYwcHEKwEQymxn++73x0W2tmSwVYj9p
 q39+llGwgofn3hNH3Xd6Vn1I37RdmJHhA2P6wZl9T9xnMTD0z24P2W+2YfGVWrNdB1d4xG85PrW
 EDQA=
X-Developer-Key: i=m@mavick.dev; a=openpgp;
 fpr=7C6A604768A99A6133C5928C9D1FCA7EDB7D344F
X-Endpoint-Received: by B4 Relay for m@mavick.dev/default with auth_id=850
X-Original-From: Eugene Mavick <m@mavick.dev>
Reply-To: m@mavick.dev

From: Eugene Mavick <m@mavick.dev>

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


