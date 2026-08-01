Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D515434E3F;
	Sat,  1 Aug 2026 11:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785582079; cv=none; b=CFiZqvgkwTPnQ9ZATHrixy87blYMYurshBbZyVoEWqZJil+Ct3Z3pAQCTnFldbDN5GK/lSmfJkDbBkmXR0yPvL/MGMYw1FAIIUFnjX/ahZQWt0RUxsE/cFlkF9pdopjHgURvCsLqxjyyA+78ypn4RxMRXq7BynuIM4/d1a7sTnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785582079; c=relaxed/simple;
	bh=h+1tyznbFEOyuRy4iHAT3B3e7gGvTqt1Z3Rotq3NoN4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qV73fl1/Env1adXHVWJkg+IiV69ncFL26CQmCwtLMqCXbGWQdMRMUW51h9dPJmCRQ/MaskIMCQch/F2hWeVIATCGUBBRcUUobW8k9FsjpAW57w7/C8EtCOtXsQ//Dy532dFLzTYtuPMuBzSm8Fo6go101QhTnCi/q3utf151A44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mavick.dev; spf=pass smtp.mailfrom=mavick.dev; dkim=pass (2048-bit key) header.d=mavick.dev header.i=@mavick.dev header.b=AorQS7Si; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mavick.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mavick.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mavick.dev header.i=@mavick.dev header.b="AorQS7Si"
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4hC0Np31s8zMlGF;
	Sat, 01 Aug 2026 13:01:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mavick.dev; s=MBO0001;
	t=1785582074;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X2tAcnncj6o0PHFFxyod2DNFn1o5vZ+4t+GMElLi3co=;
	b=AorQS7Si71jqPNImikVnoCdY3qQL7ZkJwLQy0kMLeWprNO4dp1Mi/DQu7E90vUsqDkQ3M7
	CIKww38MOhb6LFa2MtMfYVwU7Di045mM5wTIJUV31WiQUcBbsKa8vGfAt26mSLvoFvIX/c
	KEBrtvolW72taHH1DAIO4Jz+ewR5dquLLIOX1JvTkOCDSmlljLqkONjT9CJnZjGjBuWwd2
	9lHznKBGJELfD1PYQ3fBtrmax/gvFcFP6qV6+SKHJ06Hr0WvVusixGCMRIzuIMlZTAaaYE
	t2O7JBGq/t+FMsuzJmYrSQBzj1aDaJfxqfZyMSVK0cegXQyUcxC8eNko6YpjFQ==
From: Eugene Mavick <m@mavick.dev>
Date: Sat, 01 Aug 2026 18:59:45 +0800
Subject: [PATCH v4 5/5] MAINTAINERS: add entries for ref_trace_final_put
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260801-refcount-final-put-trace-v4-5-2e58678f0ffd@mavick.dev>
References: <20260801-refcount-final-put-trace-v4-0-2e58678f0ffd@mavick.dev>
In-Reply-To: <20260801-refcount-final-put-trace-v4-0-2e58678f0ffd@mavick.dev>
To: Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
 Boqun Feng <boqun@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Gary Guo <gary@garyguo.net>, Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Andrew Morton <akpm@linux-foundation.org>, Dennis Zhou <dennis@kernel.org>, 
 Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@gentwo.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 linux-mm@kvack.org, Eugene Mavick <m@mavick.dev>
X-Developer-Signature: v=1; a=openpgp-sha256; l=627; i=m@mavick.dev;
 h=from:subject:message-id; bh=h+1tyznbFEOyuRy4iHAT3B3e7gGvTqt1Z3Rotq3NoN4=;
 b=kA0DAAoWnR/Kftt9NE8ByyZiAGpt0bGgjb/NhgHvR4Tr44j/3KJicMhoZci7EHLmotrvEr3vp
 Ih1BAAWCgAdFiEEfGpgR2ipmmEzxZKMnR/Kftt9NE8FAmpt0bEACgkQnR/Kftt9NE+eYwD+LJwi
 Q+XJqOR3j9bhKBUOvGMA3SsNpH1gfTfMSJdnq7MBANwbO5fyJD8wpKF8RYRyJmx5jOJLld3w9EH
 8Mwz7jVQJ
X-Developer-Key: i=m@mavick.dev; a=openpgp;
 fpr=7C6A604768A99A6133C5928C9D1FCA7EDB7D344F

Add new files added in the patch series to MAINTAINERS

Signed-off-by: Eugene Mavick <m@mavick.dev>
---
 MAINTAINERS | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 10e8253181d3..2dbb7441906e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4210,7 +4210,10 @@ S:	Maintained
 F:	Documentation/atomic_*.txt
 F:	arch/*/include/asm/atomic*.h
 F:	include/*/atomic*.h
+F:	include/linux/ref_trace.h
 F:	include/linux/refcount.h
+F:	lib/ref_trace.c
+F:	lib/tests/ref_trace_kunit.c
 F:	scripts/atomic/
 F:	rust/kernel/sync/atomic.rs
 F:	rust/kernel/sync/atomic/

-- 
2.51.2

