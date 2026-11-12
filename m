Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794446893;
	b=GOGx1NtxJdPFLCLarOqkwu+usyEJsopXcNPHuNw0ffO76BReU9j3bhNQCnjG4nXKl7lJ
	 tc5sImlMMWHOtGj5BLqSzA04+YrNrc/48CwtBySgPzHYQXcDFXJSbEsABBFKDiWgIVRDz
	 EmevxoEY0ziZho4I/tSyl8P/484SG+sdsHMV2LuEeDpdi71yjz6Ysa8QPulOtQPeXfM5F
	 6WtvB2cb6iyp8i5ezgpKpZORdsJk6twXSFBH3nKsfJNBqKpGMdEnClUBL194NAlDgny1E
	 /rW/gVHmSLV4BRkSrcaO82q1j1ULjhVuKndCaJvjGdXpHGS5EjCWW5+zxO00kCJSpaA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794446893;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:User-Agent:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=rWWW59Q/ezlTNLCcJslwzdBdYcLA3PiSzf5gryNJ8hM=;
	b=GwhPhSoBMOAX68RX4xldABT+igBvTI/LhC1+KORf21y3dosljJYJsMVXkn8SJXiTcaax
	 KL7NcN/tJ36DpqtY+Yfatb/SVqlDV7EMxSydsTHnS/6nvzxAlLJrWGkzgsE8IugFLp5Sz
	 caBFHVdoIveri+7yPyZhz7kIc4vWSinv8moM+ovx2fq8AmctFAt+C3b/xT+W8YviS2rRj
	 Q0KU6VUfryz6dn03mXVuOWVB6l8BrkgBokriurWyyFZGRXhLM/zQCEMePuMl9K+htrhMk
	 F1MJsMphR9HlffS63HxWr0KHJ6l9ckfztFBJ47lyKDxpH3GvG7AVWnlVR7UPAWUEq0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FYG33QPd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F907606A31C;
	Thu, 12 Nov 2026 01:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FYG33QPd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E2111F00A05;
	Thu, 12 Nov 2026 01:28:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794446893;
	bh=rWWW59Q/ezlTNLCcJslwzdBdYcLA3PiSzf5gryNJ8hM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FYG33QPdMkpvypdKUkWrflaPpCnOqw+eV0WlGVAHKLCl+FwV8vgJz9d3D7D5fa83I
	 s4OriUtGXH21UGHsLHrJEBX8C2Y2xD3JtQaxUN3SAYxvmx6SjqCgV/D65pae0Tb5R+
	 R1FkVBUJAptFmkIOtpIytmHmjWM2wyTCpDfzMN9sy6g3cV8hlKVbgcGQFGSTv39Lc9
	 Uuzb3QChfkqYwWArvzDhl1r8OBHlVVoxZx17YEMhpBbBBCgUE+yBX8CY6upHmQlPYw
	 shA7IqOY+4pcVioooaVbat2lFBoMXjJ+6gR6E1QRH1lye/OXqeiQP2ZJb9CkVWGuVc
	 QR+Q5m3d07jYw==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v2 10/13] tracing/probes: Allow symstr type for function entry arguments in return probes
Date: Thu, 12 Nov 2026 10:28:09 +0900
Message-ID: <179444688986.345731.2259328518477342348.stgit@devnote2>
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

Function entry arguments accessed in return probes ($argN or BTF entry
arguments) are fetched from the entry data buffer via FETCH_OP_EDATA,
which was omitted from the allowed operations for the "symstr" type and
rejected with BAD_SYMSTRING.

Allow FETCH_OP_EDATA to be formatted as "symstr".

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/trace/trace_probe.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index 9be546f12053..f0837db354a9 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -1959,7 +1959,8 @@ static int finalize_fetch_insn(struct fetch_insn *code,
 		if (!strcmp(parg->type->name, "symstr")) {
 			if (code->op != FETCH_OP_REG && code->op != FETCH_OP_STACK &&
 			    code->op != FETCH_OP_RETVAL && code->op != FETCH_OP_ARG &&
-			    code->op != FETCH_OP_DEREF && code->op != FETCH_OP_TP_ARG) {
+			    code->op != FETCH_OP_DEREF && code->op != FETCH_OP_TP_ARG &&
+			    code->op != FETCH_OP_EDATA) {
 				trace_probe_log_err(ctx->offset + type_offset,
 						    BAD_SYMSTRING);
 				return -EINVAL;

