Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794446875;
	b=pwWMQY+I7PNGxJjuKcUrwVHpbzHzSqIHlXPtvgfyXGVzlBFfd/ZVUskZ6EZnAu/LQQ6G
	 sUvFKOdaIjFykQUbaKfgtP7wHy5bmyeb65AhdUc7e05J1pQYMLZapv9EFrPuA++HGlUXU
	 Y0sVu5Gg5acMEAewVdMdtRcYCu/NH4mcNphlPNZ78FrcWRsTuej2RPzwIM8jZ8e583iCP
	 VQvdXlLzqBq9M0fechaabrbybskt+3KR7dPhcJBMJdMyqPIOCWRPPrvWT539mozZmkuU6
	 ge44mB3/PdDPCYkTHFaKiXtKBwg1D85hVMeFCi0xZ9T7IhU9KsbOQnw7KZb4lPr+Tcg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794446875;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:User-Agent:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=JsOk1/HpczF+F/v2GALBaK7LtXJNOrH8UEP218XJ7Cg=;
	b=gypuN05rPHHlgg89OQ226NlrpGX0nfETMTxwe/edWpvH6fwZiz7Aik7nxKKgSHpdrT5f
	 uAjcEtBsxCQMkKT/TUynpSPmCpglfVqHAFpaR/jhBXrQVH0MmQC8U1evyKOYUz83xmXyW
	 h4gHhkReJs16giifumUycUgHF/0e8BjIbXPV+WSU/F7IM6GuX27oJ9fNiYHrcrZew/P8i
	 7YajkNBaeqPMx2D20JY4j9ZrJOOFQUJav2HGBYVejjdift4ywZnY1V8mmoQdNz7uxum87
	 /tYwmCpZB5YmMf7Rh1Sh4uCKmjdozW5KtpaYuzRUYwQq8fGb7w3u1f3V+AdKo9LLApw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eDmoJ76l;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62613606A31C;
	Thu, 12 Nov 2026 01:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eDmoJ76l
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B97F61F00A05;
	Thu, 12 Nov 2026 01:27:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794446875;
	bh=JsOk1/HpczF+F/v2GALBaK7LtXJNOrH8UEP218XJ7Cg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eDmoJ76lBRPx8XQhsxdOTudOw94WyK5Emz6lebwW5YcjBxDjgBoZ/b3eBek05wEwu
	 uZCRZaD8c1V0G9RaPOMVGE/Swo+2IHPEDEE1r/JsxX196ibcatJDcMwb3j0g0vXaT1
	 dnTdzVpMgVm0rldl4b5Kzl4ramQmMvEcqbYuUQZp2ffp48AN4i9bakAmjknqQYneDZ
	 GkFyZpDY+b4hff02e7qdf3wW2FhQRf83to2/hXF5BfqCrejoMLr5wH+IaNK8llqBXW
	 imMsjRijr+s7jES1uTT4Twq4ybbvzc4u9pVuqlO5aAtGJ/NBOAmO4+WCtIlzTFUC53
	 IJq3fN9jAVO2w==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v2 08/13] tracing/probes: Reject array count on non-dereference string sources
Date: Thu, 12 Nov 2026 10:27:51 +0900
Message-ID: <179444687143.345731.11752638185843399541.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <179444679892.345731.5271591537517106679.stgit@devnote2>
References: <179444679892.345731.5271591537517106679.stgit@devnote2>
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
index e98113808257..9be546f12053 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -1987,6 +1987,12 @@ static int finalize_fetch_insn(struct fetch_insn *code,
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

