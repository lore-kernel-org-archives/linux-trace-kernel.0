Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794558556;
	b=v/C6PuMoixLeK7UURDoRAT9NFOhMXYwJemYGeWSxyWu2BQchg0wxGwdFdexNO9D71lrO
	 q9FCquwvITXXB0kwwZhBGLzFbbBPc+KwAvnwRbJKFAkMsx+24zsosjsROqcK3beKO+GdC
	 UawYfEXujKihVpJ3x77CCeYAABOGP9Nu0ByN+gLpReLMd+zzzOnR7ghiDxWWkwOKrXqru
	 AQTNrcE+BbEznMY/jQG1BhHOBJ8SZPZA74w3JvPOGjnoNzRDhtJ7ccL6JfqnLJMuLr7SO
	 hhEeBldXLfCntr4lknjErOnoaafR24YEHreYPGSgEw+D5xbkGFjqe7YjGn6U9OBzqYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794558556;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:User-Agent:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=DZV4gQZAUJNcBQXwAOUQAHIyYUTe+7KEUuKIehGNzIM=;
	b=AVzGWx+qoqxXeuCd5J5hjooebxnk7aTglnQTF7ReN7ZFaYBmiS8mL0epkF3vIhNVkJLH
	 YXxAUcpBftW7x6+CtjQERgxxHkxtGeSAJri5sANpsndPe23rPjM18okxuF9FDM6VSQkQB
	 laVNQu8fIn4bcbidOH+I4Y6nk6v4OfPAcknEx0IK1k5Kzniadt+qsUXcxv/T64xCtJtB4
	 98wc2jMnUabk7kSJ3ZtCLLfG3jQBr/bztpgfCzU29LOchF+4jGf42y3CMeUsBhp0l5vVF
	 Q9G42oY7ARe8VGH/JQym3u+3e+dnkV8OkQ43CJHeYaUNhY8tBxZebZPU/eoJ06HRgzg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BV4smHPq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE5960A2608;
	Fri, 13 Nov 2026 08:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BV4smHPq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ED811F000C4;
	Fri, 13 Nov 2026 08:29:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794558556;
	bh=DZV4gQZAUJNcBQXwAOUQAHIyYUTe+7KEUuKIehGNzIM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BV4smHPqoo9DWtB6lF8WJz+F01KWAtz4gbPNcHmI5+tBdrRHlrkoUFrQfJMCOJdXb
	 2QQ5oImmAmKbgxyr7IXaK2x1aWxEjnp1Y83px0+ZEhsGq9RVZ6LlaKd4gPESu5w12P
	 NjXWPPvInr8/+RKKH7VLs5HU9Y1euixhyHtQU2ctxnIRVJmbta+7jBbWrGspDT8jrI
	 f2kOaNcR8mIeGxoTgV+cVpwP7HwP5OKWtVn0MRcYQaQaZrBGKAiyw5V33NpXOP4e0B
	 JraYuAc115AblePYPwAUsA7ZFePWWuesY3GuXL6wOhr8PX75//jW6w+FWtYZYLK9jH
	 o6FOVSzUJhOSQ==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v3 08/13] tracing/probes: Reject array count on non-dereference string sources
Date: Fri, 13 Nov 2026 17:29:13 +0900
Message-ID: <179455855309.403392.4197028577158545202.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <179455847934.403392.15146485751358774349.stgit@devnote2>
References: <179455847934.403392.15146485751358774349.stgit@devnote2>
User-Agent: StGit/0.19
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

The runtime array loop (FETCH_OP_LP_ARRAY) for string types requires a
preceding memory dereference instruction so it can advance the pointer
address on each iteration. Non-dereference string sources such as $comm,
immediate strings, and eprobe event fields cannot be indexed as pointer
arrays, but finalize_fetch_insn() still accepts an array count on them
and emits an invalid FETCH_OP_LP_ARRAY sequence.

Reject string array counts when the preceding operation is not a memory
dereference.

Fixes: 40b53b771806 ("tracing: probeevent: Add array type support")
Cc: stable@vger.kernel.org
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
Changes in v2:
 - Add Fixes and Cc: stable tags.
---
 kernel/trace/trace_probe.c |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index eee5353ef5c7..9c789ca316b7 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -1990,6 +1990,12 @@ static int finalize_fetch_insn(struct fetch_insn *code,
 			 * For the symstr, it doesn't need to dereference, thus
 			 * it just get the value.
 			 */
+			if (parg->count && (code->op != FETCH_OP_DEREF &&
+					    code->op != FETCH_OP_UDEREF)) {
+				trace_probe_log_err(ctx->offset + type_offset,
+						    BAD_STRING);
+				return -EINVAL;
+			}
 			code++;
 			if (code->op != FETCH_OP_NOP) {
 				trace_probe_log_err(ctx->offset, TOO_MANY_OPS);

