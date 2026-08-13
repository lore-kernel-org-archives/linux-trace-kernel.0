Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F39AB341062;
	Thu, 13 Aug 2026 03:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786593070; cv=none; b=UDHkOlJJUkaQ0UAeK1DjWHg3zRI9NC/2eJOFBy2r/PIZY17+xid/4zgMabN3SiXKQowv83mk3bHKIgxuigG1xAwHiyBEZIPRW4+8l+mAx9n471WTDiqt4X2iUYBtV7FZ4RVSAq+QIbd5RFKEOqezxRQj5f73THV8Hh+Vg/r3ad0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786593070; c=relaxed/simple;
	bh=0mtxE/WEsIHruPQpODluMt+xs1Gkb+zYSYfoyG1vQss=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nqk2n8x33dISRu3XjFEouzgeg87cW8U9DeVzNDWhkX5En0rA4StvoNdAmk37NDyG1fV7NdpLvajsKxNlq5dwe9jAEX4ivhFVRT83TSb9s7nP8QAiHx9lP0jLKxaxrDBkou/a1EMauNGWBFcCc6yFeesIMv2uw6C2FcxSXtA0vsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mavick.dev; spf=pass smtp.mailfrom=mavick.dev; dkim=pass (2048-bit key) header.d=mavick.dev header.i=@mavick.dev header.b=MzfwnqSH; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mavick.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mavick.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mavick.dev header.i=@mavick.dev header.b="MzfwnqSH"
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4hLBGx30BCzMlLk;
	Thu, 13 Aug 2026 05:51:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mavick.dev; s=MBO0001;
	t=1786593065;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P8Jl8v7uhIYg0BWuM9zYsmcifoKGiiRIRhrZEbo+mEQ=;
	b=MzfwnqSHOYD5YM5aCrRFniW1OfkUeCU06L/n+43NoY1fVjkCGlzdsXMlgJPPfQBs1W8yZq
	D/lY82jW4YI/Eesc2eJBZhws8aafwSAGu+MBEubTcFqpZeY8Bxtt3PTi7E3XhqbTJi3ZXS
	WwwPUtcShTv8T/hFl3pt+O48G9rGGjvRYZrzqyRTSMCo4zi3SDcHfZdjt7TVZPrlkzTnvQ
	R34OT7PiMu2oKWIJ6qEBDjlg6x6JidqwIkxS9vlRy9I6YT7xYjbzf228K55w2Ompy09vw2
	eJlzTCI6tr3Z+/V+zTAwfGbvwPwJS1PnIvZQjQNlNBWtfoxxWb/9jf/eqZmZYw==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of m@mavick.dev designates 2001:67c:2050:b231:465::2 as permitted sender) smtp.mailfrom=m@mavick.dev
From: Eugene Mavick <m@mavick.dev>
Date: Thu, 13 Aug 2026 11:49:11 +0800
Subject: [PATCH v5 5/5] MAINTAINERS: add entries for refcount_final_put
 trace
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260813-refcount-final-put-trace-v5-5-6e8bf8a38b31@mavick.dev>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=642; i=m@mavick.dev;
 h=from:subject:message-id; bh=0mtxE/WEsIHruPQpODluMt+xs1Gkb+zYSYfoyG1vQss=;
 b=owGbwMvMwCU2V/5U3e1aE3/G02pJDFm1dgf1+nxWHu2zCrJQKOCau/GT8f4nLE8lNvmssjN7K
 PdTdq1jRykLgxgXg6yYIktNVoJ7xspZicZHJ/XAzGFlAhnCwMUpABO58JLhn374JIufT99E1jUv
 3r3d6GZUuF0ek2Hf3BmdHl08F1wydBn+R+xLW/NC4qv5s9D3F1SThVWNJdW/zdtdb8XGZc8i7qv
 GDwA=
X-Developer-Key: i=m@mavick.dev; a=openpgp;
 fpr=7C6A604768A99A6133C5928C9D1FCA7EDB7D344F
X-Rspamd-Queue-Id: 4hLBGx30BCzMlLk

Add new files added in the patch series to MAINTAINERS

Signed-off-by: Eugene Mavick <m@mavick.dev>
---
 MAINTAINERS | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 10e8253181d3..c37e4cd0e4ff 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4210,7 +4210,10 @@ S:	Maintained
 F:	Documentation/atomic_*.txt
 F:	arch/*/include/asm/atomic*.h
 F:	include/*/atomic*.h
+F:	include/linux/refcount_trace.h
 F:	include/linux/refcount.h
+F:	lib/refcount_trace.c
+F:	lib/tests/refcount_trace_kunit.c
 F:	scripts/atomic/
 F:	rust/kernel/sync/atomic.rs
 F:	rust/kernel/sync/atomic/

-- 
2.51.2

