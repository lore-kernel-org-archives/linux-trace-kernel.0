Received: from mail-pj1-f67.google.com (mail-pj1-f67.google.com [209.85.216.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF0720E334
	for <linux-trace-kernel@vger.kernel.org>; Fri, 16 Jan 2026 03:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768535444; cv=none; b=PwCLI3roBt/gKI0Kd4dJfHq1AGB/fppYERNTlzvY5/emyvpfKu10MEe3DGujCLcLY47VBw9/+h66M4p9doO/XrKQrLl9bRx4R6vIRV+4n3Itwpctt31Plymd8TiqBiUXfKOPsrFxXu2vOXPqrkRGNLlmV1k8ZyP4ZsDAQjqLMi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768535444; c=relaxed/simple;
	bh=zY4lZ/WMgcwk7KKWgJshhVk7lhJb+yixU/AKr0hQg7o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XSCslBDmHGGIkfTuE1sHRbexD9t/UFvMOJoh/1ZEHlHIqaLPbyorVTQjW4AXppuwhbHkUyt/36uVqFtTZx7WWwtceWwPg9saJwm4aZIXIatxUg4tn6UTLsUCZE/IDg/Y/IsvvgPh9RVxGSDAqkykGY0lCiew1Vqqmm62svLzdzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lpl0y07W; arc=none smtp.client-ip=209.85.216.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lpl0y07W"
Received: by mail-pj1-f67.google.com with SMTP id 98e67ed59e1d1-34f634dbfd6so1143756a91.2
        for <linux-trace-kernel@vger.kernel.org>; Thu, 15 Jan 2026 19:50:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768535441; x=1769140241; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=slOe1FPJhANQ1vYoC8HEpAu7LLkuMBjol/KDdw72Pdw=;
        b=Lpl0y07WMPHwr8G+d0TDk9fDHg5C0Xs9Yw+7OgBcZ13/8xY8Ht1zjp47PYY17pYSSD
         /2lDmt+KJDvUZTqVukCJKTXoINUfeeQdNrme+1dWmD6HrWeILqLZFx8l3SaswgBo+uEf
         C8UbmxbEtIzYRKHPVBgGvBOQYMrMVZM6rQ61gF65I9+ENOemJjERZGkrbdr4+54LxhVq
         PxXSxQ7o++yHedCwDA19rk+Hsxh2XCeVyKUVbaZIZ+mSrJGPyLLO8nrVd6SK9kgEwXpz
         rNF/5MKOJ2NTIM+XWuIHNUinLdorjSOW8JfQATDvly0Gz18oJvPwabH0aW2OXvpUOM+v
         vDzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768535441; x=1769140241;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=slOe1FPJhANQ1vYoC8HEpAu7LLkuMBjol/KDdw72Pdw=;
        b=R3O17BiAlmpNN5TU0n7NPscl5BchTPDpdQHyUh2nV0Spb9rspIyL6UwxaK8BhcSrwV
         6yFsyCRXujkW5dd6KHPy2fcPmOffRuRVnfMwaBcJT5MOZEFjdCoTC3liNUoEOvno1kTI
         UdoQoh7ASQlRfy67c3PnaBkJYlya45L7V+9vyPAFLi3D1zZxIaTeXBs8LBBzVe0EQUZN
         CjUl5QaJffz5/pPJLIkyF5sL5Jht45kgGH0jdRTBLpl6S1JrCJ2jvCaOriOgfi9cOT9c
         2jOkY2fAs6SH2k31MJiwhrh9FgxmZVmkAwnxqrTNYMGq7pDgkiwBVt+bp+7zBVTQ72R3
         IfUw==
X-Forwarded-Encrypted: i=1; AJvYcCXM0qVNImjdtV3VyCmBZ+RDdMEYEWw24B8STslfnnEt6/YSgUFGcEnXhYsyjO7eLOYNLe9UkhzCaUyuPSC60wT9l1k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNpDKxRPqbH6Ah7ybgfLVM3hrRAzSPGfw/8jR53uQeENMT2RBT
	eEHDzJlHyak8EvklUHhI+P+VKx3jlNIDz8yTYSSdCg5ytRYC/A3L/LbC
X-Gm-Gg: AY/fxX5EpWcCEqf7WfW89NiEHMzZZeyR2TY9Xv6JifXpftv3bidGooH+bepaqZooPiM
	h/YLP09Vv32ZDYPptIfGZ7s+XSuX28KBVbuU/7KPghPGvqknJZ7kKRLPrj4ZJlmxy0n91hlZBQQ
	m3y2z273W/rmLY8eEsfnFaI+s+AntHSjRlM4jyLHo4EgB7KPBqNbpxR5CrWbkR6a31B80tC4/LQ
	2eug7BMz1fPuR7/kh5zyz+IGzE5ii0h7/3ejf6N6GdwRRariXOMCNLUiWCcJb9176rFwMZMv6ON
	6PjgdHBoETsZz+7xEq4o6ZqGf5C3H5Qoxyzud9/43eoE3uS2sSWjVR0Btx5L98qRA0PEteVhfWx
	wiGp8rexJQCkYoaE2AlpfVCYuhnQr3Z2wjoPzg1lyodLqogQDGMoqrLdmY+5WsKgTauEA/w5L3i
	bW15etsN4=
X-Received: by 2002:a17:90b:2f44:b0:34a:48ff:694 with SMTP id 98e67ed59e1d1-35272fa908emr1225888a91.31.1768535441060;
        Thu, 15 Jan 2026 19:50:41 -0800 (PST)
Received: from 7940hx ([160.187.0.149])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c5edf37c9d7sm684504a12.35.2026.01.15.19.50.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 19:50:40 -0800 (PST)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: ast@kernel.org
Cc: daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	mattbobrowski@google.com,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH bpf-next 1/2] bpf: support bpf_get_func_arg() for BPF_TRACE_RAW_TP
Date: Fri, 16 Jan 2026 11:50:23 +0800
Message-ID: <20260116035024.98214-2-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260116035024.98214-1-dongml2@chinatelecom.cn>
References: <20260116035024.98214-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For now, bpf_get_func_arg() and bpf_get_func_arg_cnt() is not supported by
the BPF_TRACE_RAW_TP, which is not convenient to get the argument of the
tracepoint, especially for the case that the position of the arguments in
a tracepoint can change.

The target tracepoint BTF type id is specified during loading time,
therefore we can get the function argument conut from the function
prototype instead of the stack.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 kernel/bpf/verifier.c    | 28 ++++++++++++++++++++++++----
 kernel/trace/bpf_trace.c |  4 ++--
 2 files changed, 26 insertions(+), 6 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index faa1ecc1fe9d..6dee0defa291 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -23316,8 +23316,18 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 		/* Implement bpf_get_func_arg inline. */
 		if (prog_type == BPF_PROG_TYPE_TRACING &&
 		    insn->imm == BPF_FUNC_get_func_arg) {
-			/* Load nr_args from ctx - 8 */
-			insn_buf[0] = BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, -8);
+			if (eatype == BPF_TRACE_RAW_TP) {
+				int nr_args;
+
+				if (!prog->aux->attach_func_proto)
+					return -EINVAL;
+				nr_args = btf_type_vlen(prog->aux->attach_func_proto);
+				/* Save nr_args to reg0 */
+				insn_buf[0] = BPF_MOV64_IMM(BPF_REG_0, nr_args);
+			} else {
+				/* Load nr_args from ctx - 8 */
+				insn_buf[0] = BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, -8);
+			}
 			insn_buf[1] = BPF_JMP32_REG(BPF_JGE, BPF_REG_2, BPF_REG_0, 6);
 			insn_buf[2] = BPF_ALU64_IMM(BPF_LSH, BPF_REG_2, 3);
 			insn_buf[3] = BPF_ALU64_REG(BPF_ADD, BPF_REG_2, BPF_REG_1);
@@ -23369,8 +23379,18 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 		/* Implement get_func_arg_cnt inline. */
 		if (prog_type == BPF_PROG_TYPE_TRACING &&
 		    insn->imm == BPF_FUNC_get_func_arg_cnt) {
-			/* Load nr_args from ctx - 8 */
-			insn_buf[0] = BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, -8);
+			if (eatype == BPF_TRACE_RAW_TP) {
+				int nr_args;
+
+				if (!prog->aux->attach_func_proto)
+					return -EINVAL;
+				nr_args = btf_type_vlen(prog->aux->attach_func_proto);
+				/* Save nr_args to reg0 */
+				insn_buf[0] = BPF_MOV64_IMM(BPF_REG_0, nr_args);
+			} else {
+				/* Load nr_args from ctx - 8 */
+				insn_buf[0] = BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, -8);
+			}
 
 			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, 1);
 			if (!new_prog)
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 6e076485bf70..9b1b56851d26 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1734,11 +1734,11 @@ tracing_prog_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 	case BPF_FUNC_d_path:
 		return &bpf_d_path_proto;
 	case BPF_FUNC_get_func_arg:
-		return bpf_prog_has_trampoline(prog) ? &bpf_get_func_arg_proto : NULL;
+		return &bpf_get_func_arg_proto;
 	case BPF_FUNC_get_func_ret:
 		return bpf_prog_has_trampoline(prog) ? &bpf_get_func_ret_proto : NULL;
 	case BPF_FUNC_get_func_arg_cnt:
-		return bpf_prog_has_trampoline(prog) ? &bpf_get_func_arg_cnt_proto : NULL;
+		return &bpf_get_func_arg_cnt_proto;
 	case BPF_FUNC_get_attach_cookie:
 		if (prog->type == BPF_PROG_TYPE_TRACING &&
 		    prog->expected_attach_type == BPF_TRACE_RAW_TP)
-- 
2.52.0

