Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 779E521D591;
	Mon,  3 Aug 2026 03:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785726527; cv=none; b=Ks6UyYT23PFxX/EAlGqRqTq1QpsFyZUBpte/YSiKIs5V4ue51wRRju7PhSDG0zGsKFeR4iKCPCl+OyVZKdcBIUliYtifDsN+SiE4r5aofaImtnhR9czhFRF8j7P1Z0NnhK+mkuAmmUbN3WFhLgT5Bk+znRfzkIuYp86ULwZ7kL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785726527; c=relaxed/simple;
	bh=0fC2HwCRIFcCrs3ltNep+FsM4xnYbnLKqqnXNQeaXhk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cEIY/4OJhglbQ3fipw9CWzhU1IGY4+zJbww2SilL2aLNgbTMQ8xCj8lhasiSJKRwUevFfbSipvrQn/jO5ym6vdKfT6ujQwt3QMLgb09VCBFzl+ThMnsrn4gp9p72LX6CwP3MqQlhJ+P7bUkXI+ZxgxA28PWT47zEs4EnolsBRjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M0nnGk3z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M0nnGk3z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4D8D1F000E9;
	Mon,  3 Aug 2026 03:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785726526;
	bh=h4jzrK0qB2ii5BU47guq1FVmhiViYIRCb7dp2eL6bLI=;
	h=From:To:Cc:Subject:Date;
	b=M0nnGk3zkUSWA2driyZJueYnP8vbEf2Ey0+FaxRYKLnFMFxqzaCSpPiMl9zNsRutO
	 S3hlpjlz/ZpUPyJw/1nTsKBXtrA4E31sofnxuq7VwNoNGmUwA7HvhRFdwzVSLYpiI7
	 xnVITMU8BWdwrVoPUzIz3r8oEG/+6xvJ205RB6oH16nxJGZi9mEeYBFeBI58O5qWnp
	 xb+kXnxpYqw7p8KH2mwWJiejWLrHbKfRteRZhTBKCTf1x5PhAewwsAp0INGT6kEP/s
	 uQPTLPMYdox7sS5MQe0zSx8uaUMRUQueUu7LI2u02C00EBmM0+NUdxkrr5Zyj23nHR
	 FsDDO3JSilvZw==
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH] ftrace: Fix off-by-one fentry site disable in ftrace_free_mem()
Date: Sun,  2 Aug 2026 20:08:35 -0700
Message-ID: <d0a6a1deda9836c614a11c458fef2c8cf321333a.1785726456.git.jpoimboe@kernel.org>
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
 kernel/trace/ftrace.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index f93e34dd2328..7d8b736f0d86 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -8293,8 +8293,11 @@ void ftrace_free_mem(struct module *mod, void *start_ptr, void *end_ptr)
 	struct ftrace_init_func *func, *func_next;
 	LIST_HEAD(clear_hash);
 
+	if (start >= end)
+		return;
+
 	key.ip = start;
-	key.flags = end;	/* overload flags, as it is unsigned long */
+	key.flags = end - 1;	/* overload flags, as it is unsigned long */
 
 	mutex_lock(&ftrace_lock);
 
-- 
2.54.0

