Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DFCA33E34E;
	Thu, 13 Aug 2026 03:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786593051; cv=none; b=LkRHfQMbLJa0Y0ySAGG+DySBiuDkhALD5SiAK63Yu6qUwhoK2gcyyfJZ6oIaWF3NsW0vHt8z0nyDPLOOVXRGb2dBn2Uqu9M7EQ0wntZLny34ca+xY3T8Ccsj3ZBHsDukVUyEWzOyCk1aDwwYdqJmaItWdLNtAvsfD03AcMPndSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786593051; c=relaxed/simple;
	bh=h9+L+Ie+ahOzZJ0p77dLgmKslR+819Hu82i3Gm1bQ7c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=b7dk65bUH10IKLgBV1Wkkele37i2y9PWYZFNJdZS/17F6EGUiu5VGwbjKpyKX8+4BOcObMikiRSs8qILv/itQr0UnWri7PKbv6ZTxi9a3mjPjaExqKmE2DdD7Ul+nSxVNw1pfkyWQ8PMeRKdHoy1q4joN8KEjrFe130BWRMbbIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mavick.dev; spf=pass smtp.mailfrom=mavick.dev; dkim=pass (2048-bit key) header.d=mavick.dev header.i=@mavick.dev header.b=dYmKnJeS; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mavick.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mavick.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mavick.dev header.i=@mavick.dev header.b="dYmKnJeS"
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4hLBGY1Xvfz8txG;
	Thu, 13 Aug 2026 05:50:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mavick.dev; s=MBO0001;
	t=1786593045;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d2nbvdvUXZ2bcKFVdCqAMhlt7dahLAQjc/Eewymj1aE=;
	b=dYmKnJeSbmhsSN8xaUg5TWfGokwgTCmkfyDM1gUK/Mlp6FKTXRupNI3oQLiPnsbQiII28y
	0LOfBc4MCfXuNf2NjXQWo+2cAj7BbqUi+2yzVLQjJJx3YmrhHtylOmmFIb0fi0ckWD8rxJ
	YfV/tTSNIF53624kluAI0Cu3XLw3pVvA0NR4wSdPK/ZY7JcIUnCWeWm3HDv4egOKhmAD7Z
	y15aJY30icZtAFMoqiRChRwSSJnFQNDcmN9RlIq1hwytqzBtuBpnHlw1SnPAjB8+wTzRtc
	Mnp+5T2qi2pgt641Qz4OUqwdzl2JpRW1C41rnfTjFlgb21YIJHdhmpZWR7iUvQ==
From: Eugene Mavick <m@mavick.dev>
Date: Thu, 13 Aug 2026 11:49:09 +0800
Subject: [PATCH v5 3/5] percpu-refcount: add refcount_final_put tracepoint
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260813-refcount-final-put-trace-v5-3-6e8bf8a38b31@mavick.dev>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1460; i=m@mavick.dev;
 h=from:subject:message-id; bh=h9+L+Ie+ahOzZJ0p77dLgmKslR+819Hu82i3Gm1bQ7c=;
 b=owGbwMvMwCU2V/5U3e1aE3/G02pJDFm1dgcNpzLPPVhwRDyp4oLsy4zFJmqF/dfzGa5vcz+T9
 7j5WFp8RykLgxgXg6yYIktNVoJ7xspZicZHJ/XAzGFlAhnCwMUpABOZ+ZrhD8ddnQoj44suWa43
 Qt885Hoct+bWshvFt/xddTbxXrD2MWD4Z+yjdXqtQDmfUx3/vT1/kntFjk8Ntq4x23Gynjlk2r/
 rHAA=
X-Developer-Key: i=m@mavick.dev; a=openpgp;
 fpr=7C6A604768A99A6133C5928C9D1FCA7EDB7D344F

Add the refcount_final_put tracepoint to percpu_ref_put_many().
The tracepoint fires when the atomic counter reaches zero in the
atomic fallback path (after percpu_ref_kill() has been called).

refcount_final_put records three fields:
- caller: function that called the refcounting
  function(refcount_sub_and_test, percpu_ref_put_many)
- ip: return address of trace wrapper macro call
- obj: refcount object(struct percpu_ref, refcount_t)

Signed-off-by: Eugene Mavick <m@mavick.dev>
---
 include/linux/percpu-refcount.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/linux/percpu-refcount.h b/include/linux/percpu-refcount.h
index d73a1c08c3e3..244992b2f746 100644
--- a/include/linux/percpu-refcount.h
+++ b/include/linux/percpu-refcount.h
@@ -55,6 +55,7 @@
 #include <linux/rcupdate.h>
 #include <linux/types.h>
 #include <linux/gfp.h>
+#include <linux/refcount_trace.h>
 
 struct percpu_ref;
 typedef void (percpu_ref_func_t)(struct percpu_ref *);
@@ -331,8 +332,10 @@ static inline void percpu_ref_put_many(struct percpu_ref *ref, unsigned long nr)
 
 	if (__ref_is_percpu(ref, &percpu_count))
 		this_cpu_sub(*percpu_count, nr);
-	else if (unlikely(atomic_long_sub_and_test(nr, &ref->data->count)))
+	else if (unlikely(atomic_long_sub_and_test(nr, &ref->data->count))) {
+		do_trace_refcount_final_put(ref);
 		ref->data->release(ref);
+	}
 
 	rcu_read_unlock();
 }

-- 
2.51.2

