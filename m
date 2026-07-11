Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E3B2D7D2E;
	Sat, 11 Jul 2026 04:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783744900; cv=none; b=gCp1otWMtjnFpgh2msIHIsjxu6AAyBTwyKYWVFNiIGx89/L1TxxTp/23W2svb6qX6/aF2Y84N/t7ODf+C+GJW0VnNtlyngsVz7Z0wDFFBYs1Rzuv9m1a/H+/1Xw8ZmmLL+507XIxr4uikhhZI0H9ZdQ2HV7gbdaqic71UaVEFF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783744900; c=relaxed/simple;
	bh=h+1tyznbFEOyuRy4iHAT3B3e7gGvTqt1Z3Rotq3NoN4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cOLCbXVWGG4bDhA/yog5+54dtR48YUht3ycEvq/MM+61LCg/z3oYW6B493v4FByXvNWVzxQI1TyxNjOPELDpUwGdw/llQn+L379Ut74H1nIwIBgentfQs9+sgPG53PwUU6wQ7xFb5Wz+hb4546sqosTrwcidFjOImWIf3edaJWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mavick.dev; spf=pass smtp.mailfrom=mavick.dev; dkim=pass (2048-bit key) header.d=mavick.dev header.i=@mavick.dev header.b=YKPgpTkN; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mavick.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mavick.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mavick.dev header.i=@mavick.dev header.b="YKPgpTkN"
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA512)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4gxwyR0NHYz8tyn;
	Sat, 11 Jul 2026 06:41:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mavick.dev; s=MBO0001;
	t=1783744895;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X2tAcnncj6o0PHFFxyod2DNFn1o5vZ+4t+GMElLi3co=;
	b=YKPgpTkNGHTkTmCpFJvuS4tmvjFHHnLcQnpxSY0fG3To+T2mWazjnSrVml1aTmPMLJatDv
	+KYB5awsHiUUOoOPgSNKwCAB8HgkMZCPiyvP6ZszW+J2BDYF6GEMjdoOaSI1QclRAtaU+b
	VnDUyd9idDjkuYGleHKVxXWpxjN53O00xtUOVNjBq8+pLFUayKd9xOC0iz6lCONcQMbxuY
	CZMp/DRgOiqSFrWexUbOLasDOnIi6I16CqFxBiqrGoPbPkabvJpHD9t6FcCC5QS3LCb4+M
	81c5XFlGW61FpcPANvkVzhuBZ6Z9sJm46WCVC//IyLYqk/3eNs+hSHB4dbfqgA==
From: Eugene Mavick <m@mavick.dev>
Date: Sat, 11 Jul 2026 12:40:23 +0800
Subject: [PATCH v3 5/5] MAINTAINERS: add entries for ref_trace_final_put
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260711-refcount-final-put-trace-v3-5-674c8f03d9f9@mavick.dev>
References: <20260711-refcount-final-put-trace-v3-0-674c8f03d9f9@mavick.dev>
In-Reply-To: <20260711-refcount-final-put-trace-v3-0-674c8f03d9f9@mavick.dev>
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
 b=owGbwMvMwCU2V/5U3e1aE3/G02pJDFmBJ21v2yzi+zRlaZGezLG5JizShe9a81LsYvQ/nV1kc
 muu64IvHaUsDGJcDLJiiiw1WQnuGStnJRofndQDM4eVCWQIAxenAEwk5zgjw6YdTc9mn0rWMTs2
 x5ljwrekf347GjOX7hLiMXs1WVH1WjIjw5pCnp3mIY8Wzpjy/JSF97mX+otcX1xIZtBkFpYJqpv
 UyAUA
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

