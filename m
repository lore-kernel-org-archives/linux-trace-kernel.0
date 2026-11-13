Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794558574;
	b=0yLpCk9CREOtDGk/MyndZmTbhvWSbjFFAg5HoIIlUJ826lZTlcjrDwuOfFqMY8gUhJi3
	 fxPy+cYE6LgXWQkbvTs+xJ9cUPoJbLhB1Bx9RQ7ijshDJFF/ZG4L4kZ20Xaj5RezNI5P1
	 8ElkwLbwTInjsmTXeDmOkdxO+GyvQTQxp9vv4iq0//ZoTp7feNBOR7TrukD+QXEDhdrcV
	 hXCNZac1msBfmrs5SLoz1NfF7UqEdlurNefbVoSDv8p8ROKigLx5hAa9cc6se0+b+c6Bb
	 mXpUcuXwVYAtVnX/KK1GWi9zYcVoyfriNrgC1522iu4MNk4D8hLlZR8+ynaLOvQ2vZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794558574;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:User-Agent:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=EF5DIfZ9Y99pubZVtfC2+MQ5VunckKy102q1PdbbPEM=;
	b=Ll92ujlTRQ4JWh9/twJWgwmXRWQ2Fl7oD3OGEzPyE+v6Ip9UlHlhINoCMK0JusDOd6WE
	 kPImqkEb1DSUdEgr3f6vlhOBaz2KDGJiSyp3ZThwA3O8Zr5Xk81abVOtZgCQLkEqaoE19
	 qcDTGSiQyHlrZ52WbSnw6RAVDzTc6Z9oqVcsIoVFkMGpBRsOanxYTuHR2e84kcqfRx3li
	 uyhQ9VrozhjIVkxdHhrJo64wKt1awUloRGQjKG6r2HGUN3z3s/yi9nBC97VyyWIyYiy2H
	 x/aogq/Pbs0tBTxBU/UQtvD3Sdp4jFnsrdAiYFaNf9Z2BeWUJ9uKtO2U660u3oMopaQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cVsmWEJE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB98960A3830;
	Fri, 13 Nov 2026 08:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cVsmWEJE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 277981F000C4;
	Fri, 13 Nov 2026 08:29:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794558574;
	bh=EF5DIfZ9Y99pubZVtfC2+MQ5VunckKy102q1PdbbPEM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cVsmWEJEbRBJKo2Kf/mktW8VNak8yNhdwrfUSoki/+l7W9h88RT7ToLqd38YbLCFO
	 CeW7Hqlgy2pz82sklEMr/O3oWp6HBXDX6UGSV/mytFayjquGEaq36Czb8GdG3n5FXQ
	 qO6nMhX3Ajdg+smoZupGi/37/9caUZysNRbKYTD9VdAA5+i5pAWy0mXBfyhsVRYyK3
	 FiSVtT/twMU54F2j+H9aWZLUYDd3eJzNUJ/idgiBVlS6Nzh+1ILSzQx4WdY5CNM9po
	 tTRxNh0RRdhnBCXoa1S343udDWiUIdx71NeZqFX8W/ENuJehfMs7WxTPYOTosc8vng
	 xWgnF3AJjpVWw==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v3 10/13] tracing/probes: Allow symstr type for function entry arguments in return probes
Date: Fri, 13 Nov 2026 17:29:30 +0900
Message-ID: <179455857080.403392.10171666250083335438.stgit@devnote2>
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
index 9c789ca316b7..65dc5c19deae 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -1962,7 +1962,8 @@ static int finalize_fetch_insn(struct fetch_insn *code,
 		if (!strcmp(parg->type->name, "symstr")) {
 			if (code->op != FETCH_OP_REG && code->op != FETCH_OP_STACK &&
 			    code->op != FETCH_OP_RETVAL && code->op != FETCH_OP_ARG &&
-			    code->op != FETCH_OP_DEREF && code->op != FETCH_OP_TP_ARG) {
+			    code->op != FETCH_OP_DEREF && code->op != FETCH_OP_TP_ARG &&
+			    code->op != FETCH_OP_EDATA) {
 				trace_probe_log_err(ctx->offset + type_offset,
 						    BAD_SYMSTRING);
 				return -EINVAL;

