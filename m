Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794184169;
	b=Wy1aBMY1qGoNeGDBDObpLYjiRhQ/TjB/p3Fw5wzDi9PhHfasNwhD6XuLRCQdCdAT2oBD
	 kR65Xcsw/Vc2QAwxNyQiK5Q974WLEwdBZHdjDllh+r8poQAgn80zLMFvDxIABROJe/Olu
	 N2MiW5Lcp0A3Z9jsZtya2UVvNzRu0qTZmvzvPeeCqc+yo+AGv+++NmTxgHf0bYRagdufi
	 FkKK6Lc1NgzIVQQe7drPKCHHpa3Q2xiK7v9a72ks9ibFqamoEoSjoxoR+AMDK8PNZp55A
	 jL6dA4Dou4p5XKTHzfbJTttysIheIBJnxvEhorIY4HDELLgL5cNNki/p+6Dcam9IjSA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794184169;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:User-Agent:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=e4pl/+urMvjDa/IYNgk59FnORyJQCbarPULwiTBcwE4=;
	b=JWSyjmVG86etuzkDanEFE2Pbx+6TeJcWtZj6/8YqMgjiDtgXd5PIOtIvIKVZYtd6UcME
	 uJczQVF/SPtx0etSuP9klSHLTkjEc+COSI4jVQpw9ZhxrJ5PszjcpcXP0BAeVqvE20M1H
	 azXq8iI2pVF9A0bHl+/2dtuY8jWmh4gjnduKj1MRv2NKFmp5meRGF16XiY96mRquIQZQd
	 Rl+9cOutPyY4PsMFg8ICXg/pSQp3JYGoIC2Ro3dirQiNQ8IM4GM9V2OUQdIRgI1KS+LNP
	 pkuNhAFMtTX8fPS4dZZmnNhrTuSCNqR2ew9ZlrnmuaJD9uXoBM+mEKil8AIm5zY7qbg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mEpjT74l;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26751606A33C;
	Mon,  9 Nov 2026 00:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mEpjT74l
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B03041F008A7;
	Mon,  9 Nov 2026 00:29:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794184169;
	bh=e4pl/+urMvjDa/IYNgk59FnORyJQCbarPULwiTBcwE4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mEpjT74lS1ozvyjDgD1b3+6mqfk0hqePPxoXPXFUC10IfLaMlgRz/Gc3z7XhYdPaP
	 crMcE2Nr3k+i+6zF2X+1wOlHMuszSAe52krGrBmwFKTQLOC6qsPrcPLc5zEe9dyD4G
	 xk99t+RoioRYI0EeDkcWYGNNM9lK3XHCH6LuU2dqvxelsRQrUpVYqby1j1tZUVZJ8S
	 MsFN6Yhh1K2YjRAqFqjlnB1LXQluCT2D1WWh/wPQZmJF7guDl/AFNCMBo5w7f3soXk
	 WbCqjBl7t3xhLc6qxexfSluxIqd9cEnPyEKl1/EFmSYPbs+8uhsJ7GSoBpf2qo5lv6
	 3AbOZU30S0fqA==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH 09/12] tracing/probes: Allow symstr type for function entry arguments in return probes
Date: Mon,  9 Nov 2026 09:29:25 +0900
Message-ID: <179418416553.227715.17841891129776321634.stgit@devnote2>
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
index 0f544d415153..67453d0121c9 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -1958,7 +1958,8 @@ static int finalize_fetch_insn(struct fetch_insn *code,
 		if (!strcmp(parg->type->name, "symstr")) {
 			if (code->op != FETCH_OP_REG && code->op != FETCH_OP_STACK &&
 			    code->op != FETCH_OP_RETVAL && code->op != FETCH_OP_ARG &&
-			    code->op != FETCH_OP_DEREF && code->op != FETCH_OP_TP_ARG) {
+			    code->op != FETCH_OP_DEREF && code->op != FETCH_OP_TP_ARG &&
+			    code->op != FETCH_OP_EDATA) {
 				trace_probe_log_err(ctx->offset + type_offset,
 						    BAD_SYMSTRING);
 				return -EINVAL;

