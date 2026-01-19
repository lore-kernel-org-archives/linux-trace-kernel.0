Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0861F91D6
	for <linux-trace-kernel@vger.kernel.org>; Mon, 19 Jan 2026 02:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768790270; cv=none; b=OxivYdxIgLMWq8YUtT5ICsF0ObAuUFqlItge6VecwPKRO1bNCZtzo8inN5vd5E9jnBwVH2NxvWcV7R5EtlcIRMRhTOwWOqBOUk1/znhT4MHoZLZmb7IgqrGuzKxcfHXCSIgHYSGfaBVjNgoM2SwXgr8Xjan55geIHvolpUuz8oU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768790270; c=relaxed/simple;
	bh=Q6QisaRcToNU+9dAs/6R0e31RVIED+7qcjILmQrFk9k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gu9c6mdTmYB+sPUjVy1dkEFzBK8HTX34t+63BMsjq3EHZST+HiNCcpt1qNhO4aDIw+t+lRNz0pmkcTjqvi1LuUc3bI9hm9SPrt9olh1YbrRCCJd4w1LYTfu/FfkXYw7eI1Fh1CtGTMIBQm+lSj2yHdkfoVJTmyk4ayUHERX435o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dqJr8rX2; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dqJr8rX2"
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-2a07f8dd9cdso23727065ad.1
        for <linux-trace-kernel@vger.kernel.org>; Sun, 18 Jan 2026 18:37:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768790269; x=1769395069; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3RDbE4NMRF9BAKqVTKl+RK/Ugc6GtBbotY5ablyCjC4=;
        b=dqJr8rX21WTHDxfm8QWWfmqrx5GGKwYvnhHM1R1m/oSHluahGf1j6S2YxmXKJSReDP
         cxU6SzSy/8rl8MlTzz1Vq1ghfPlqB3adgXQ8SbdTdSOjkBjPt6e9KPi1MxV77QI203gh
         6Epmz0ZVAsXjg3zECyHgFLFEYxlF8Eqicf5MCTQKpYzn9DSPCBflibvn//K8cz9j213P
         yo/US9TGtVgh4Xc+Pwegvq+IXTOupeQv2yQt20sMjsAbRh9+NAqM87mMPm7+AzMWE2zW
         GeoNyH6NWep6bXVtU3q6mPM4V6CZfsqsCaFR0AyWity5A2NpjFNSQ8toai81PaHFewiJ
         1Qug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768790269; x=1769395069;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3RDbE4NMRF9BAKqVTKl+RK/Ugc6GtBbotY5ablyCjC4=;
        b=BJa6mH6cCCcQHY0DBueD4Z61H7oT5PHcN/7Z6amsz/0Tpg6EUxEOYvkKwBqeiaYYK+
         CcwpWmcUguGWj14SVC0rMA4nOuiUTMoqpYcxD6ed5nhSD3S7QibfEfo+S9DZ3VBnYeup
         rUOxduXkyeyxJ9Ljoa3dPI3igQTFTY2zoIjg+RKc/lPB483GH1K3rq5kFv/LmyFrKVBO
         eNhjjeiCftfhGUx2Vzqz0LP0a8Vr3+fMVaZ4ABQ1Z/BjHep/L419uo4bPrQQNYoNmoN0
         QzaorcfpHxLiSivcbqKNgDpaKsj6WR/x59AaLeQRtY4T/3k3uxY3CX4VozijY9C+X6ak
         MRuA==
X-Forwarded-Encrypted: i=1; AJvYcCXGcNCWkmuK17yIqQJvz+o1+F4FJOFROLg80AU+blALqMwLwmrxIJuGYdRoMEJJpV0zIYPm9Cn3f8K11tAMSSdYHpw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwpShqXCqCVqJAx/RhDiOzEGeEJWdELorXX7RykxwSsLGbh+mq
	ouc0d+sO8QOYjfWlMRxRI5BGZM8uJyYuhGzUa78rjudLPjyQuwmJzB/2
X-Gm-Gg: AY/fxX6aeTfivFo5zqiCtwwQ7jI2z6yVShlY5o5denLr+fFsIgiJG+qmZEVCYTgQ48G
	lp4FUyiDXMpKWjqmpj7CMlGqwdHNsvLbVuxoNuAyAkZbRK1ukqaB6CitFPEgzdGV58qwHl8PZPQ
	ntnw34N3M2VwBztlbr5XKBQJqyUiLYmfoOBMWagXg3S44P6rzRdpl8HcBYabkj8fQ1fhgONGtk8
	PUj5dyYibv+yMmyndJ9VbjRkF/H8v6PwEZO9ZZ4AKyK0S5nS1WjrRZiJORGdMZkx0Cc1KHfLgu6
	/0evSrmL3CtvBPFEZthRo9JGOLpnI2PX8G7Lr9aL2hKLM9Ca5gvrcVwd+hbnLeNImkCzT973HVV
	N+ydUVFIOqVwrKIKfuk8HMNCoaIky8Mzn87+WLn7avmrBw4qekRR1Ku8q9TBw2cDUljTpR0kNfI
	8uC2C09V1v
X-Received: by 2002:a17:903:1b64:b0:2a1:243:94a8 with SMTP id d9443c01a7336-2a7177db0f2mr89032255ad.49.1768790268992;
        Sun, 18 Jan 2026 18:37:48 -0800 (PST)
Received: from 7940hx ([103.173.155.241])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a7190c9ee9sm77154645ad.22.2026.01.18.18.37.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jan 2026 18:37:48 -0800 (PST)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: andrii@kernel.org,
	ast@kernel.org
Cc: daniel@iogearbox.net,
	john.fastabend@gmail.com,
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
Subject: [PATCH bpf-next v3 1/2] bpf: support bpf_get_func_arg() for BPF_TRACE_RAW_TP
Date: Mon, 19 Jan 2026 10:37:31 +0800
Message-ID: <20260119023732.130642-2-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260119023732.130642-1-dongml2@chinatelecom.cn>
References: <20260119023732.130642-1-dongml2@chinatelecom.cn>
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
v3:
- remove unnecessary NULL checking for prog->aux->attach_func_proto

v2:
- for nr_args, skip first 'void *__data' argument in btf_trace_##name
  typedef
---
 kernel/bpf/verifier.c    | 32 ++++++++++++++++++++++++++++----
 kernel/trace/bpf_trace.c |  4 ++--
 2 files changed, 30 insertions(+), 6 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index faa1ecc1fe9d..4f52342573f0 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -23316,8 +23316,20 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
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
@@ -23369,8 +23381,20 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
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

