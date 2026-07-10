Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D51379C49;
	Fri, 10 Jul 2026 05:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783661476; cv=none; b=Qt5RxJHEA3o+gDGpUgvhjHjr1eUbwUO9fJ8q1v6P6JXvFu14H4OYSa3UjI4Gfut91Oe5cBCr3/VhNV6afm1cvvM+WBs7o9hgM2TwYT5bLGvC/DCWuZ+tjK3vGsfcA8sQI19MS3Pj49zm0Mkbk4PNi5KT0lPTw9cTTwUj2wyEJeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783661476; c=relaxed/simple;
	bh=hkSle40hvPkgCxPiifxmuclyWzd9fTgjPZ/t/hWhm/o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GXXVAMfoNrrIBEQtOQr2jJ6pcOxtmFqJpsUvGLcrpCmVRiUsrxRs5SzpktQdruwyjreQwl2JSg7F2i0TjjR+r7XJP6bx45dzvop07prGjcJIHmyqpNVc/vp2fTVEK8hj/t0aLWd0hAYDxv/XkFDtx5D8yvkWCD6HeLiMlIE8SRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cT1WPQZb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cT1WPQZb"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 29D40C2BCFA;
	Fri, 10 Jul 2026 05:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1783661476;
	bh=hkSle40hvPkgCxPiifxmuclyWzd9fTgjPZ/t/hWhm/o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=cT1WPQZbIDi51GeFAFmnTygt0OzLeYXfiVqTqYJchNaPOJxXGkf3HjjBindXmxYsd
	 d7Fo6YU2owLSlVWqN0N55deUIUEqDRG6+wUf0cKAw6puKZLsnF6mAuglfc0+Rg+y5B
	 0edJGffecRTrLn5hQIHaMa6cMP+08VDzIWNuBtyd9tlDp6Wctk7oc9kSYmcFCD1doR
	 mT9Zh8vaCW52vzvkVBg9nOqbThSQY1dqXR0UBIn6gLgtzr6T6Q+GoSopHvPfmbnKrg
	 d6RmgPlTauhMnhnJSy3vV/qznQq+fekFQ6qT8MV41lLj/+shq899rqQVYlnd0cj8Lu
	 xFluisbdbMAcA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F500C44506;
	Fri, 10 Jul 2026 05:31:16 +0000 (UTC)
From: Eugene Mavick via B4 Relay <devnull+m.mavick.dev@kernel.org>
Date: Fri, 10 Jul 2026 13:30:41 +0800
Subject: [PATCH v2 3/5] percpu-refcount: add ref_trace_final_put trace
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-refcount-final-put-trace-v2-3-557cfce860a2@mavick.dev>
References: <20260710-refcount-final-put-trace-v2-0-557cfce860a2@mavick.dev>
In-Reply-To: <20260710-refcount-final-put-trace-v2-0-557cfce860a2@mavick.dev>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1198; i=m@mavick.dev;
 h=from:subject:message-id;
 bh=vVWsfTjSGw6e33WP2d/uyqteLjy9dxiqe2AmCt04NhY=;
 b=owGbwMvMwCU2V/5U3e1aE3/G02pJDFkBzT23Y8+p1rz80Pf3zukIvlrR8BPlk+R2vosu3mV2d
 LV6zJ2GjlIWBjEuBlkxRZaarAT3jJWzEo2PTuqBmcPKBDKEgYtTACaikcnw33GWVshuP6V7871q
 F876Xb3cRlpp61dTl08/Ttf0FjyYVcjI0DhBdLP4GyN3Hak/N6we3ausMRAOW5Uovu/0vzVGEf3
 9nAA=
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
index d73a1c08c3e3..f870ac0e8c06 100644
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
+		do_trace_ref_final_put(ref);
 		ref->data->release(ref);
+	}
 
 	rcu_read_unlock();
 }

-- 
2.51.2


