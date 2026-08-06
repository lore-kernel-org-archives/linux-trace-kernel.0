Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D199287246;
	Thu,  6 Aug 2026 04:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785992215; cv=none; b=PZoRy7ExScjbgrVKB6ocHHIrId/F/Arn7+zncIGfNKvt+B9PQp2rSR3i/gQh08LEKP42Gbv7ZafDL8b5dp6l7AxBVaTFE2ExrSzSSZxM8pbGe8xKmSr2WFP9MuOzszopYGdYHNK1t3fCDKmT5ppVPKYhtJj/2ecxpRNN2Y1kzFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785992215; c=relaxed/simple;
	bh=JB+7l4s5oMpm0hwgT63PQU9tsrgKcqpD+w2cv1g/joY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kig+oWS5L9NDtlGQMwQ2haWVKaFTX8MyLQxpNoxikCRx828skVclQhPq86cT8nK7eif80Rp0Re0R4Hf9y/VV4txw9vss4AOyYHvFrS7dSY1pRQGphbESmFn3dmLho6AcPrdFarooRQKNZ/8dNqvfjbp1NNR9Jsjmr8kPBQ9GJSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lQuW2oEc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lQuW2oEc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B790C1F000E9;
	Thu,  6 Aug 2026 04:56:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785992214;
	bh=LueuOhm0TxashHbSXdaA6DESHRWStPQsbnY2D/xxb+I=;
	h=From:To:Cc:Subject:Date;
	b=lQuW2oEc3BFf3WH01Dcwt+efS0iX74iSualsJIeZFasGRKeHqBXFLVrF1J7C5wtBO
	 8RvKLG9cY+mknxa1dZ3+syt5D/nf8GpIBLGtGqumJaDGc6axTiPT4S3CFM7VZA6hdJ
	 NeUe7dINc2pZ9gDBj4xhaOu899iLgP+dg0CHEZ1yFsrwN9I/mBaQc5Ql/BmfSIo6Ri
	 QnSfYTY+w4B7gvKSMuDnay+LfNoxoAGnMMVib29heXWiQOjwMm8144gHTeuVV/c6/a
	 CtBlGpj16vSvJQ0WWJLc3fWjO3ywwAKhGESEwM29FvdYv3R4oqoqKETHBBV621IXas
	 Hk33stwt9ftYw==
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v2] ftrace: Fix off-by-one fentry site disable in ftrace_free_mem()
Date: Wed,  5 Aug 2026 21:56:46 -0700
Message-ID: <1b5ccfa8095bdb1277f84af1c2c2e2205aca03ae.1785992188.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a module's init text is freed, do_init_module() calls
ftrace_free_mem() with a half-open [start, end) range.  However the
ftrace_cmp_recs() comparator treats the upper bound as inclusive, as all
its other users do, passing 'ip + size - 1'.  So ftrace_free_mem() can
delete a record sitting exactly at 'end', which is outside the freed
range.

For a kernel without CFI or IBT, the first record of a function is at
the function start, which for the first function in a module is also the
base of its text allocation.  As the module allocator packs its regions,
that address is often the 'end' passed by a neighboring module's
do_init_module(), causing the first function's ftrace location to get
disabled, preventing an attempt to livepatch it:

  livepatch: failed to find location for function 'pcspkr_probe'

Convert the exclusive end to the inclusive 'end - 1' the comparator
expects, and return early for an empty range to avoid the subtraction
from underflowing when the init text size is zero.

Fixes: 42c269c88dc1 ("ftrace: Allow for function tracing to record init functions on boot up")
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 kernel/trace/ftrace.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index f93e34dd23288..6bde28d56f41b 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -8283,7 +8283,8 @@ static void add_to_clear_hash_list(struct list_head *clear_list,
 void ftrace_free_mem(struct module *mod, void *start_ptr, void *end_ptr)
 {
 	unsigned long start = (unsigned long)(start_ptr);
-	unsigned long end = (unsigned long)(end_ptr);
+	/* end is inclusive and end_ptr is exclusive */
+	unsigned long end = (unsigned long)(end_ptr) - 1;
 	struct ftrace_page **last_pg = &ftrace_pages_start;
 	struct ftrace_page *tmp_page = NULL;
 	struct ftrace_page *pg;
@@ -8293,6 +8294,9 @@ void ftrace_free_mem(struct module *mod, void *start_ptr, void *end_ptr)
 	struct ftrace_init_func *func, *func_next;
 	LIST_HEAD(clear_hash);
 
+	if (start_ptr >= end_ptr)
+		return;
+
 	key.ip = start;
 	key.flags = end;	/* overload flags, as it is unsigned long */
 
-- 
2.54.0

