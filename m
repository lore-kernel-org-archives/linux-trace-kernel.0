Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794184151;
	b=KoKSeMNvgTT5VdBWqS0zNBbsrz2QGMtMevOTMRjHmAVZeRJNFpZDqJc0eUgpGYEfQltu
	 JtZyt4MShAl0+buX6Bsx8OUSfS87/mAUBWU79vWbO4nBRctEo7d3tFIvBPZ5C4xZtr32a
	 e31PkqwVw26yKR4PpuIaQrtLFxWH3/EU2lLoD2gRajgeu6NdXMOYnptqw51Hf0sGpW8ZB
	 fEFdqbs0V/Aeoi3r2WgwC4DDuwYQfnMGSyvqb/sjmLBWJroUV86swP5Cm/qUF2WoeLk7i
	 rZLWonqq+g/rEwI5t9abGltUmeGRIz4zHHrQ4V9qCXicdlbc4RCT1k/R/5jaOENFUng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794184151;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:User-Agent:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=85/R79zRci9a8TpvEfV+raNUQYY5+QIn/8GrIGmCD6w=;
	b=1Mu8u/hjSk6RQrTNKJsw/ghwCTpfxFHSFBahT0SjYrE/HJW8EFlBRNI1O3kJ8JEhJ8cX
	 i+92XR2VN8+YMUkW4/u1OM/As4RHHQtfqn+0yJhtYP8KZ6LkQqRsTteIu+q5KSa7COHBE
	 ulsF1mXDyf6XsDE38KIigPEkgT9Qkc4NyBk/FPuxHjrked0Zsv9FoZ7wIAe+VgOB1m7gU
	 OQswkDn1PJyAaGhH5VoH5w3x2EkztY3vLjc6RAUqYvvhQ24rnucYi/I6oHwuHSu/EvaMK
	 RZ5PAkS3/bq9YPVryQBzA67YMjsMY+coUm+AHR8xX3oO/wPpsJqNSm95OfN3VpBtZMg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GZI63uQh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A63D4606A31C;
	Mon,  9 Nov 2026 00:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GZI63uQh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD1CC1F0089F;
	Mon,  9 Nov 2026 00:29:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794184151;
	bh=85/R79zRci9a8TpvEfV+raNUQYY5+QIn/8GrIGmCD6w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GZI63uQh+6ECdHYZZXjTMOpgzn3LA7xD7s2M59O8v/UrA18RO5fYJWwHdVWRJlesY
	 wz+O0whXnenQB1gjFPt0MQPDcEuQeShjJPrR8em36ewvwsRRo0Nb0DcMxNGyaGg0BP
	 1QZiXIpwctV8DLallUm9zo5DddN1jRdMLpN/Qg9meDh8fjcPGHFP7rW321KuLwnAkr
	 WEBxLFn005P2QCm6GHljhBH+RuREt5AJE9S9k6IelzKZ36eFVcfjq7WMjSPZjypVo4
	 lJfvpijRdTfMKakNccN4TML8xRDI1kIgk7udMSoiEV9Qzah2KxeUr5IoPbH32s0o6s
	 0ZYTKcLWo0oXA==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH 07/12] tracing/probes: Fix user-space dereference string array store type
Date: Mon,  9 Nov 2026 09:29:07 +0900
Message-ID: <179418414754.227715.9900534226622724613.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <179418408457.227715.1485179201014819821.stgit@devnote2>
References: <179418408457.227715.1485179201014819821.stgit@devnote2>
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

When finalizing a string array argument (e.g. +0u(%reg):string[N]),
finalize_fetch_insn() advances the instruction pointer to a new slot
for the store operation before checking whether the preceding operation
was FETCH_OP_UDEREF. As a result, user-space dereference string arrays
with type "string" emit FETCH_OP_ST_STRING (kernel memory read) instead
of FETCH_OP_ST_USTRING.

Check for FETCH_OP_UDEREF before advancing the instruction pointer.

Fixes: e65f7ae7f4da ("tracing/probe: Support user-space dereference")
Cc: stable@vger.kernel.org
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/trace/trace_probe.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index 829fa6559b59..e62acf05a8ee 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -1952,6 +1952,8 @@ static int finalize_fetch_insn(struct fetch_insn *code,
 
 	/* Store operation */
 	if (parg->type->is_string) {
+		bool is_uderef;
+
 		/* Check bad combination of the type and the last fetch_insn. */
 		if (!strcmp(parg->type->name, "symstr")) {
 			if (code->op != FETCH_OP_REG && code->op != FETCH_OP_STACK &&
@@ -1971,6 +1973,7 @@ static int finalize_fetch_insn(struct fetch_insn *code,
 			}
 		}
 
+		is_uderef = (code->op == FETCH_OP_UDEREF);
 		if (!strcmp(parg->type->name, "symstr") ||
 		    (code->op == FETCH_OP_IMM || code->op == FETCH_OP_COMM ||
 		     code->op == FETCH_OP_IMMSTR) || code->op == FETCH_OP_TP_ARG ||
@@ -1991,8 +1994,7 @@ static int finalize_fetch_insn(struct fetch_insn *code,
 		}
 
 		/* If op == DEREF, replace it with STRING */
-		if (!strcmp(parg->type->name, "ustring") ||
-		    code->op == FETCH_OP_UDEREF)
+		if (!strcmp(parg->type->name, "ustring") || is_uderef)
 			code->op = FETCH_OP_ST_USTRING;
 		else if (!strcmp(parg->type->name, "symstr"))
 			code->op = FETCH_OP_ST_SYMSTR;

