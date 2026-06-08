Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA4753D6692;
	Mon,  8 Jun 2026 14:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780928712; cv=none; b=NNcoM8qIf2AoXKN7qy1QjaIH8MFto8wXkeXEVXBP5tTzMnoNCCXAk63c1MYLpX2WyoW6cJrvCCPFtrtxcZiDWsnQBsusbQ4Re1lt7JBA1G+glhwCaML5TyawVtVWGkW5koW7ii0mhlw8o9C8tphO8D2mAwZ92LEGZ6Hk5ijwAbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780928712; c=relaxed/simple;
	bh=HZJtSvOJll4jTVWRRxieHiVVjPwzVlIrDAhkyhTBbaQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hb+lu7ImBkoTuGZhQeFXisSLqrzkAJM17rpqYhJIjKoNr+UitpZEmbV/TgdxApxP9BEpfV37Zia2fNwIx94IpbxBGRX2By+nmcn8l9sBf4IkDXCObon44whLJZDqqMR5WA0RqCtOP1NdRlZwSqVx4gxHoHcHw/PAg25gmsatS7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=afT52TO0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="afT52TO0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6953F1F00893;
	Mon,  8 Jun 2026 14:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780928710;
	bh=wtjV5ZRRw8hPfEPfsfZ4zbPwmpEihOdeIGlBAiEVMEk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=afT52TO0XaH0Txcj98Cq0DVhh4JKKtOQQWUKpgfk4ZtCaBkTB2l2LM/CfA1Gq1M6a
	 2iWH5SEW+lhF247VlSzTB3t9OhoNJZHSOBQm1/p40fgsP1WevWtpWp9sgqxwUfyu8q
	 qLUlCCHobPng70IbVdjBk9DcUh9rdJlaxqi/3uoss+uvASXxZFusWEQU6usc22lx5j
	 ybu7KK+GR2MJuIcjhqsD5GgB/7ggFJfmpEuVmOxuZYfekHmxtXqqkeejJO+9Q85RDQ
	 t8tWUnP++asNklqwel613qR/sLuiv//14tZNtTcCYqFBdMtA7Oy1gZz8yWkzE0Dee2
	 C/oRZ/hgT2JpQ==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [RFC PATCH 5/7] tracing/probes: Add +CPU() and +PCPU() dereference method to fetcharg
Date: Mon,  8 Jun 2026 23:25:06 +0900
Message-ID: <178092870611.163648.7277795674989278181.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <178092865666.163648.10457567771536160909.stgit@devnote2>
References: <178092865666.163648.10457567771536160909.stgit@devnote2>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

When tracing the kernel local variables, sometimes we need to get the
CPU local variables. To access it, current simple dereference is not
enough.

Thus, introduce a special +CPU() dereference to access per-cpu variable
for the current CPU (accessing other CPU variable may race with
updates on other CPUs). Also +PCPU() is for accessing per-cpu pointer.

 +CPU(pcp)

is equal to

 this_cpu_read(pcp)

And

 +PCPU(pcp)

 is equal to

  this_cpu_ptr(pcp)

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 Documentation/trace/eprobetrace.rst |    3 ++
 Documentation/trace/fprobetrace.rst |    3 ++
 Documentation/trace/kprobetrace.rst |    3 ++
 kernel/trace/trace.c                |    1 +
 kernel/trace/trace_probe.c          |   48 +++++++++++++++++++++--------------
 kernel/trace/trace_probe.h          |    2 +
 kernel/trace/trace_probe_tmpl.h     |   30 ++++++++++++++++++----
 7 files changed, 65 insertions(+), 25 deletions(-)

diff --git a/Documentation/trace/eprobetrace.rst b/Documentation/trace/eprobetrace.rst
index dcf92d5b4175..0c7878df02f6 100644
--- a/Documentation/trace/eprobetrace.rst
+++ b/Documentation/trace/eprobetrace.rst
@@ -40,6 +40,9 @@ Synopsis of eprobe_events
   $comm		: Fetch current task comm.
   $current	: Fetch the address of the current task_struct.
   +|-[u]OFFS(FETCHARG) : Fetch memory at FETCHARG +|- OFFS address.(\*3)(\*4)
+  +CPU(FETCHARG) : Fetch memory at FETCHARG address on the CPU specified by CPU.
+                  This is useful for fetching per-CPU variables.
+  +PCPU(FETCHARG) : Fetch memory address at FETCHARG address on the per-CPU area.
   \IMM		: Store an immediate value to the argument.
   NAME=FETCHARG : Set NAME as the argument name of FETCHARG.
   FETCHARG:TYPE : Set TYPE as the type of FETCHARG. Currently, basic types
diff --git a/Documentation/trace/fprobetrace.rst b/Documentation/trace/fprobetrace.rst
index 3392cab016b3..c851f98bb310 100644
--- a/Documentation/trace/fprobetrace.rst
+++ b/Documentation/trace/fprobetrace.rst
@@ -52,6 +52,9 @@ Synopsis of fprobe-events
   $comm         : Fetch current task comm.
   $current      : Fetch the address of the current task_struct.
   +|-[u]OFFS(FETCHARG) : Fetch memory at FETCHARG +|- OFFS address.(\*4)(\*5)
+  +CPU(FETCHARG) : Fetch memory at FETCHARG address on the CPU specified by CPU.
+                  This is useful for fetching per-CPU variables.
+  +PCPU(FETCHARG) : Fetch memory address at FETCHARG address on the per-CPU area.
   \IMM          : Store an immediate value to the argument.
   NAME=FETCHARG : Set NAME as the argument name of FETCHARG.
   FETCHARG:TYPE : Set TYPE as the type of FETCHARG. Currently, basic types
diff --git a/Documentation/trace/kprobetrace.rst b/Documentation/trace/kprobetrace.rst
index 81e4fe38791d..bc806fd82a91 100644
--- a/Documentation/trace/kprobetrace.rst
+++ b/Documentation/trace/kprobetrace.rst
@@ -55,6 +55,9 @@ Synopsis of kprobe_events
   $comm		: Fetch current task comm.
   $current      : Fetch the address of the current task_struct.
   +|-[u]OFFS(FETCHARG) : Fetch memory at FETCHARG +|- OFFS address.(\*3)(\*4)
+  +CPU(FETCHARG) : Fetch memory at FETCHARG address on the CPU specified by CPU.
+                  This is useful for fetching per-CPU variables.
+  +PCPU(FETCHARG) : Fetch memory address at FETCHARG address on the per-CPU area.
   \IMM		: Store an immediate value to the argument.
   NAME=FETCHARG : Set NAME as the argument name of FETCHARG.
   FETCHARG:TYPE : Set TYPE as the type of FETCHARG. Currently, basic types
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index e185a006cb08..2b8c8ac4036a 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -4332,6 +4332,7 @@ static const char readme_msg[] =
 	"\t           $stack<index>, $stack, $retval, $comm, $current\n"
 #endif
 	"\t           +|-[u]<offset>(<fetcharg>), \\imm-value, \\\"imm-string\"\n"
+	"\t           +CPU(<fetcharg>), +PCPU(<fetcharg>)\n"
 	"\t     kernel return probes support: $retval, $arg<N>, $comm\n"
 	"\t     type: s8/16/32/64, u8/16/32/64, x8/16/32/64, char, string, symbol,\n"
 	"\t           b<bit-width>@<bit-offset>/<container-size>, ustring,\n"
diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index 2c5deb1e1463..fa6757222fe6 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -1396,26 +1396,36 @@ parse_probe_arg(char *arg, const struct fetch_type *type,
 
 	case '+':	/* deref memory */
 	case '-':
-		if (arg[1] == 'u') {
-			deref = FETCH_OP_UDEREF;
-			arg[1] = arg[0];
-			arg++;
-		}
-		if (arg[0] == '+')
-			arg++;	/* Skip '+', because kstrtol() rejects it. */
-		tmp = strchr(arg, '(');
-		if (!tmp) {
-			trace_probe_log_err(ctx->offset, DEREF_NEED_BRACE);
-			return -EINVAL;
-		}
-		*tmp = '\0';
-		ret = kstrtol(arg, 0, &offset);
-		if (ret) {
-			trace_probe_log_err(ctx->offset, BAD_DEREF_OFFS);
-			break;
+		if (str_has_prefix(arg, "+CPU(")) {
+			deref = FETCH_OP_DEREF_CPU;
+			arg += 5;
+			ctx->offset += 5;
+		} else if (str_has_prefix(arg, "+PCPU(")) {
+			deref = FETCH_OP_CPU_PTR;
+			arg += 6;
+			ctx->offset += 6;
+		} else {
+			if (arg[1] == 'u') {
+				deref = FETCH_OP_UDEREF;
+				arg[1] = arg[0];
+				arg++;
+			}
+			if (arg[0] == '+')
+				arg++;	/* Skip '+', because kstrtol() rejects it. */
+			tmp = strchr(arg, '(');
+			if (!tmp) {
+				trace_probe_log_err(ctx->offset, DEREF_NEED_BRACE);
+				return -EINVAL;
+			}
+			*tmp = '\0';
+			ret = kstrtol(arg, 0, &offset);
+			if (ret) {
+				trace_probe_log_err(ctx->offset, BAD_DEREF_OFFS);
+				break;
+			}
+			ctx->offset += (tmp + 1 - arg) + (arg[0] != '-' ? 1 : 0);
+			arg = tmp + 1;
 		}
-		ctx->offset += (tmp + 1 - arg) + (arg[0] != '-' ? 1 : 0);
-		arg = tmp + 1;
 		tmp = strrchr(arg, ')');
 		if (!tmp) {
 			trace_probe_log_err(ctx->offset + strlen(arg),
diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
index f2b31089779c..bec04bcc4226 100644
--- a/kernel/trace/trace_probe.h
+++ b/kernel/trace/trace_probe.h
@@ -100,6 +100,8 @@ enum fetch_op {
 	// Stage 2 (dereference) op
 	FETCH_OP_DEREF,		/* Dereference: .offset */
 	FETCH_OP_UDEREF,	/* User-space Dereference: .offset */
+	FETCH_OP_DEREF_CPU,	/* Per-CPU Dereference for this CPU */
+	FETCH_OP_CPU_PTR,	/* Per-CPU pointer for this CPU */
 	// Stage 3 (store) ops
 	FETCH_OP_ST_RAW,	/* Raw: .size */
 	FETCH_OP_ST_MEM,	/* Mem: .offset, .size */
diff --git a/kernel/trace/trace_probe_tmpl.h b/kernel/trace/trace_probe_tmpl.h
index f630930288d2..82d753decf48 100644
--- a/kernel/trace/trace_probe_tmpl.h
+++ b/kernel/trace/trace_probe_tmpl.h
@@ -129,25 +129,43 @@ process_fetch_insn_bottom(struct fetch_insn *code, unsigned long val,
 	struct fetch_insn *s3 = NULL;
 	int total = 0, ret = 0, i = 0;
 	u32 loc = 0;
-	unsigned long lval = val;
+	unsigned long lval, llval = val;
 
 stage2:
 	/* 2nd stage: dereference memory if needed */
 	do {
-		if (code->op == FETCH_OP_DEREF) {
-			lval = val;
+		lval = val;
+		switch (code->op) {
+		case FETCH_OP_DEREF:
 			ret = probe_mem_read(&val, (void *)val + code->offset,
 					     sizeof(val));
-		} else if (code->op == FETCH_OP_UDEREF) {
-			lval = val;
+			break;
+		case FETCH_OP_UDEREF:
 			ret = probe_mem_read_user(&val,
 				 (void *)val + code->offset, sizeof(val));
-		} else
 			break;
+		case FETCH_OP_DEREF_CPU:
+		case FETCH_OP_CPU_PTR:
+			if (!is_kernel_percpu_address(val)) {
+				ret = -EFAULT;
+				break;
+			}
+			val = (unsigned long)this_cpu_ptr((void __percpu *)val);
+			if (code->op == FETCH_OP_DEREF_CPU)
+				ret = probe_mem_read(&val, (void *)val, sizeof(val));
+			else
+				ret = 0;
+			break;
+		default:
+			lval = llval;
+			goto out;
+		}
 		if (ret)
 			return ret;
+		llval = lval;
 		code++;
 	} while (1);
+out:
 
 	s3 = code;
 stage3:

