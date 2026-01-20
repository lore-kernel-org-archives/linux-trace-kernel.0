Received: from mail-pg1-f195.google.com (mail-pg1-f195.google.com [209.85.215.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B673A7DEF
	for <linux-trace-kernel@vger.kernel.org>; Tue, 20 Jan 2026 07:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768894269; cv=none; b=p5VWD6+BxqbpSrm1tYLrao5ssRZFJo72OgRNoxFR1IZYb8L/Z6Xv2r9oL9LtQL4dv3d9iAxHE++CqpUen7jo+V91tynjS5tE1hGOTj9B7HXVSqhgP3q9LLKQaap+AGFk/GkT4y74W8o26hvvlI8Zma1FTfzfDmO5LpeTx6GRZsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768894269; c=relaxed/simple;
	bh=ymRYVJhzeWdJ4sQTO/2s3yQRHdQfXonPvc7Kh15OU7o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NQ7yfO1uSZ91+y3W2RetgsC5TVH8idIG87ELPcGkWOz+mx4NR4H0SmKb++4dXS3Kh/gitYHAaxWwZdTLsnT4e3NVpmzpApKdGuq1M8G5de8KzP1p0YffYk0CPrVNM40kUJu564edVThKAY1ufJAP7D+smk+kyOa6LVV7mnZGQnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d/EiCrKw; arc=none smtp.client-ip=209.85.215.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d/EiCrKw"
Received: by mail-pg1-f195.google.com with SMTP id 41be03b00d2f7-c2af7d09533so3261478a12.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 19 Jan 2026 23:31:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768894267; x=1769499067; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7NLuN810LB84TxNhioCDEyB0yA1LlvJHeD3a2KMbZiY=;
        b=d/EiCrKwRVZ9rmnG9hCsEgyEwTB76Z++RrCYiCiLVJG3kOI5LdMOwadnOu+XPo2tes
         aH+hRD65esvwgSyHeOAaaxY8XH8CsmFpiHKia+u6t41g7rE7nhiyZbNdyXiRPoTepaeO
         1elVQHHrhR/Dn5tHp23NKo317dJDroPAfRYQs56fZYh7EiibKMDmcS+y3VmldOsaw54U
         s+va71QPJewTbHvOFaCxYXNMjy2ZVOgigFMfZj0OIPUvwgOggLSIDakRFIoXxOn85+kh
         2CwNp4aZltegmCJtZsPoV7kh3BHvfovK96QX2HWCpeLdmaWGl0xfptXkC4PJt+0+Tn22
         UimQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768894267; x=1769499067;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7NLuN810LB84TxNhioCDEyB0yA1LlvJHeD3a2KMbZiY=;
        b=TvsyB+m/ZcUKR7Z07YlmNxQhm7dWlfZkMVQIXL+IUw0EepOyd2smlE/3wgz4CsCKkS
         hjoJq/Nt/3Sgelf9MfiJ3iZZYUTml7yOsRDX5l6C4yEgptm0brpHjRfrGZfgkhkBhH+Z
         3bxic81JCny+y3+o2uynkFeyS+52fIQZ6ZwiC1/No70MqzfM/PwJu2Q9V+FcYt26KkB2
         9raGEnOPmqdlB8bpRKHAulxIRn7niqYxtexzoWcSJCQSqeOQiqdZBI2OHMbgiJBPZMFb
         CTGZFwXKa4cVdiUGJNalrdHLWkqsoJ0KPx0Dax2wEyrIyCPq9WW+2IPumhwEMutCvuHO
         ctog==
X-Forwarded-Encrypted: i=1; AJvYcCUF+Z20/fxkVjqtKXzP5zxY05VpQX8HwlHNBz+c20sIUAkT4xBbiosHcQ7L1zeqa+zysqRUikFJLFSSFQc1fNCc0nk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyl+jPewH8vglgFuq3kUWPNlin+mQEfzFlxnjwbGZ19Sj7IcpTu
	j3WZ8liwMM0029KNve2HDQkEojJUXmZquM/FiNm9bYvimIaWuJYPRJep
X-Gm-Gg: AY/fxX6gBpr/WUmyCyBx6gLFJ15QsI3q42iITNRnVsN4sK1vYjgwTgrI9g86wX/HaEe
	cOjF6jvW+hXbyx1m9N9GihAu8Z4+Foblu+sN2w5nKOBO9syoH1ScATdnEo5pZ95FIT5GEO68GN1
	gZnQaAanje/lG20TRXkexLaqv8lraN5DgCwRbJoXmbKx1pAe/mmPgFN5jJ8ucMktou3wAVJNaOX
	hVtAexmyXOxDoYf78+2m9DPDfjlzJps1GozfKjf0HLxH3ibCKT0nqdmmI1Ki0EtoArDjWZqmBpw
	nQdSKDh/CW0m0OjFOXyH3uchd9/5EPZVwoH6/+/8awi1XZDY7Cn5dhOvshoDWZhOwlsl9vgojLP
	V9Guz6J4VCHbzzTXrC8n/ogoQYeSa6H3TXCNERMqEijrRqt4Q//v3BzviRTewpW7bb9qBbLOLpF
	YRYfmTQO/9
X-Received: by 2002:a05:6a21:a8e:b0:35d:5d40:6d75 with SMTP id adf61e73a8af0-38dfe67bc7dmr12929011637.29.1768894266523;
        Mon, 19 Jan 2026 23:31:06 -0800 (PST)
Received: from 7950hx ([103.173.155.241])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c5edf2363e5sm10822395a12.4.2026.01.19.23.30.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 23:31:06 -0800 (PST)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: ast@kernel.org,
	andrii@kernel.org,
	yonghong.song@linux.dev
Cc: daniel@iogearbox.net,
	john.fastabend@gmail.com,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
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
Subject: [PATCH bpf-next v4 1/2] bpf: support bpf_get_func_arg() for BPF_TRACE_RAW_TP
Date: Tue, 20 Jan 2026 15:30:45 +0800
Message-ID: <20260120073046.324342-2-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260120073046.324342-1-dongml2@chinatelecom.cn>
References: <20260120073046.324342-1-dongml2@chinatelecom.cn>
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
therefore we can get the function argument count from the function
prototype instead of the stack.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
v4:
- fix the error of using bpf_get_func_arg() for BPF_TRACE_ITER

v3:
- remove unnecessary NULL checking for prog->aux->attach_func_proto

v2:
- for nr_args, skip first 'void *__data' argument in btf_trace_##name
  typedef
---
 kernel/bpf/verifier.c    | 32 ++++++++++++++++++++++++++++----
 kernel/trace/bpf_trace.c |  4 ++++
 2 files changed, 32 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 9de0ec0c3ed9..0b281b7c41eb 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -23323,8 +23323,20 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 		/* Implement bpf_get_func_arg inline. */
 		if (prog_type == BPF_PROG_TYPE_TRACING &&
 		    insn->imm == BPF_FUNC_get_func_arg) {
-			/* Load nr_args from ctx - 8 */
-			insn_buf[0] = BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, -8);
+			if (eatype == BPF_TRACE_RAW_TP) {
+				int nr_args = btf_type_vlen(prog->aux->attach_func_proto);
+
+				/*
+				 * skip first 'void *__data' argument in btf_trace_##name
+				 * typedef
+				 */
+				nr_args--;
+				/* Save nr_args to reg0 */
+				insn_buf[0] = BPF_MOV64_IMM(BPF_REG_0, nr_args);
+			} else {
+				/* Load nr_args from ctx - 8 */
+				insn_buf[0] = BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, -8);
+			}
 			insn_buf[1] = BPF_JMP32_REG(BPF_JGE, BPF_REG_2, BPF_REG_0, 6);
 			insn_buf[2] = BPF_ALU64_IMM(BPF_LSH, BPF_REG_2, 3);
 			insn_buf[3] = BPF_ALU64_REG(BPF_ADD, BPF_REG_2, BPF_REG_1);
@@ -23376,8 +23388,20 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 		/* Implement get_func_arg_cnt inline. */
 		if (prog_type == BPF_PROG_TYPE_TRACING &&
 		    insn->imm == BPF_FUNC_get_func_arg_cnt) {
-			/* Load nr_args from ctx - 8 */
-			insn_buf[0] = BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, -8);
+			if (eatype == BPF_TRACE_RAW_TP) {
+				int nr_args = btf_type_vlen(prog->aux->attach_func_proto);
+
+				/*
+				 * skip first 'void *__data' argument in btf_trace_##name
+				 * typedef
+				 */
+				nr_args--;
+				/* Save nr_args to reg0 */
+				insn_buf[0] = BPF_MOV64_IMM(BPF_REG_0, nr_args);
+			} else {
+				/* Load nr_args from ctx - 8 */
+				insn_buf[0] = BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, -8);
+			}
 
 			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, 1);
 			if (!new_prog)
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index f73e08c223b5..0efdad3adcce 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1734,10 +1734,14 @@ tracing_prog_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 	case BPF_FUNC_d_path:
 		return &bpf_d_path_proto;
 	case BPF_FUNC_get_func_arg:
+		if (prog->expected_attach_type == BPF_TRACE_RAW_TP)
+			return &bpf_get_func_arg_proto;
 		return bpf_prog_has_trampoline(prog) ? &bpf_get_func_arg_proto : NULL;
 	case BPF_FUNC_get_func_ret:
 		return bpf_prog_has_trampoline(prog) ? &bpf_get_func_ret_proto : NULL;
 	case BPF_FUNC_get_func_arg_cnt:
+		if (prog->expected_attach_type == BPF_TRACE_RAW_TP)
+			return &bpf_get_func_arg_cnt_proto;
 		return bpf_prog_has_trampoline(prog) ? &bpf_get_func_arg_cnt_proto : NULL;
 	case BPF_FUNC_get_attach_cookie:
 		if (prog->type == BPF_PROG_TYPE_TRACING &&
-- 
2.52.0

