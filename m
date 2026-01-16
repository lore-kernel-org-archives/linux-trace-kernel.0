Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B975928641E
	for <linux-trace-kernel@vger.kernel.org>; Fri, 16 Jan 2026 07:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768547881; cv=none; b=iwMP+BexOYNpEuadIiE/KDT67ZrhNSSnVGL6HWJEP17LTGLFhoXfjJCk51AjKvJnTec8WmmaUJRI3dYCcLxWGiAGf7HAaa4ly6UOf+9ehjFZb4jhAVjgtt26DkXheHkzafIcW13RKHO+6lZGEtLQNcP5iFQczTDK1f2xCt9QJIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768547881; c=relaxed/simple;
	bh=sVKvb5Nz1A+WPx1wLx+juOJWf6PmzJcfp77DQOrJTzQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bSL+WGgWTrd/zqytXe1htxQEy4hcFz05npKlMLkK5x6nVqeAUxY1QPIYChdS3KxypaSz4lMp2jmdTKJiNqMMKCto5YlMOpqo9IQ+G9Q0ezQiHujx/4euTpgQWxYUZ6Kk9zGLcRh1cJ41AeaOEh4F6nh8LCKXWkYe02+G2+oJ/gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cFopeO5r; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cFopeO5r"
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-2a2ea96930cso11066675ad.2
        for <linux-trace-kernel@vger.kernel.org>; Thu, 15 Jan 2026 23:17:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768547879; x=1769152679; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/38jAZCyYx52GHr4cYx6xhDB60Qm+8nD9DL091nuyss=;
        b=cFopeO5rmtJxJ1mKdAJm/BefMHjqMme0PVR1hLLvDg0vWCgEE6+Jw+5mYNPgPe2bWt
         4itli1YwDfx61z5q3xa/9CghHDr+4Tbh8zgeaoKbcsym6nwUAF9OBM4d+1j2tsDCgjwb
         dmVgsw1zcg+pYb+/sYlhCGUjJ0XXC6/scU1z9aB1ng9ARLgpU18cErHyOBDA5D4Bovr6
         SmH/wb5m3FNmRaZXgSzQAyMEqrgIpGF72OpjJFBy1sRDjrZvEY92KnuFR4riB2l+rsN+
         132Tvkuh0n/K4G+lJEBFcRbCMK2nEe3Pfdx1RvsjK601r3rPHK+6eVvVLs+LyU7N19We
         ZpYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768547879; x=1769152679;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/38jAZCyYx52GHr4cYx6xhDB60Qm+8nD9DL091nuyss=;
        b=EZuK+oC6A+awgO3hEpLxqyaRmvsx/wQS5LiOQjekjSR6HF+hiqeXJAw0Qx1YWBKiD7
         lhP8tRDHBbE7AJcmFni1e3cGUb/5bH1XPcjGecjynFwANUSRpoiKYIZ6kqgmIn2aFfHB
         XzqPiycEkj4sKFEW32y3eX3pf8mbCz6MDd6E4SBV0ZUwKrtHXAOOYMAZSHV4TGDfbojt
         S7LVPe4oydvPkZdw95R6fsq5NpfU5gVVjsMcQ2Ywsft9KKxieA326aGWG7fOv0QygxVF
         UGk/nYdEBD2rKlCseFVvn1M0cNs+BGU8haJb7fapSfqXet2oTE7xl8oFlUgdygiU+dHG
         I5IA==
X-Forwarded-Encrypted: i=1; AJvYcCVc4gAI6aK2CkFbQAVXQoZK1dcXLpdMRApgDeO7KrxR266PhYzk3Fb5uR4hW+E6jfoImbUfrtjhtDpbQrpTewYAVR0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPcBZQW2MPYHuumr3s9nSjMVD5bGsQvQ6E4rbNKstnk2l8PQwM
	CeIKHBshMqseG8QLbKnyXaGK/C4XfLrPNF7T9yjKgYVeAycOqgIZEze2urIEEzXqub8=
X-Gm-Gg: AY/fxX6s1bl9XKGhC/nDTuww7nXPu6IRpHChYIuZqD3U1n2Ku3uzcmYXNExeDCYnbjJ
	AfsDfC/CtoRaC7Q6ugfQUq4UYgTe6wONuMgURvl5E0TzE8enxAYnU0i0TFN5SqqjzzpPYSGMlW2
	0Jb7PHbw7JM/VPyLww66Ti3PYHr9xwESTpsb2kdX0PZqGIKl5ypkoYs4kjM/nwGvzZjrZSZMGjg
	GisWg+/tz5M3YmMQSYAnXhvGE8eShM+BrfmHGpBBGuymFmBWziUU0hLOYQVBNip6ltOwFKNyrh1
	u9jeyEzhjMQPiUwSilvtP238IYNqHzdmHS75GVbOgHavJu2tem1WQBFqs/OwQMk01KitXfqOhDO
	dFMKeFbY6fz7FAjgySUXFO4etWc3cTwViVlPr990iAoF5OgIN07whDKb209KPpIBGwGjSQAgtof
	nFUQt7fkw=
X-Received: by 2002:a17:903:40cb:b0:2a0:faf1:782 with SMTP id d9443c01a7336-2a717519edbmr16762915ad.9.1768547879099;
        Thu, 15 Jan 2026 23:17:59 -0800 (PST)
Received: from 7940hx ([160.187.0.149])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a7190ce2ebsm12508275ad.32.2026.01.15.23.17.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 23:17:58 -0800 (PST)
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
Subject: [PATCH bpf-next v2 1/2] bpf: support bpf_get_func_arg() for BPF_TRACE_RAW_TP
Date: Fri, 16 Jan 2026 15:17:38 +0800
Message-ID: <20260116071739.121182-2-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260116071739.121182-1-dongml2@chinatelecom.cn>
References: <20260116071739.121182-1-dongml2@chinatelecom.cn>
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
v2:
- for nr_args, skip first 'void *__data' argument in btf_trace_##name
  typedef
---
 kernel/bpf/verifier.c    | 36 ++++++++++++++++++++++++++++++++----
 kernel/trace/bpf_trace.c |  4 ++--
 2 files changed, 34 insertions(+), 6 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index faa1ecc1fe9d..422d35c100ff 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -23316,8 +23316,22 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
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
+				/*
+				 * skip first 'void *__data' argument in btf_trace_##name
+				 * typedef
+				 */
+				nr_args = btf_type_vlen(prog->aux->attach_func_proto) - 1;
+				/* Save nr_args to reg0 */
+				insn_buf[0] = BPF_MOV64_IMM(BPF_REG_0, nr_args);
+			} else {
+				/* Load nr_args from ctx - 8 */
+				insn_buf[0] = BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, -8);
+			}
 			insn_buf[1] = BPF_JMP32_REG(BPF_JGE, BPF_REG_2, BPF_REG_0, 6);
 			insn_buf[2] = BPF_ALU64_IMM(BPF_LSH, BPF_REG_2, 3);
 			insn_buf[3] = BPF_ALU64_REG(BPF_ADD, BPF_REG_2, BPF_REG_1);
@@ -23369,8 +23383,22 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
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
+				/*
+				 * skip first 'void *__data' argument in btf_trace_##name
+				 * typedef
+				 */
+				nr_args = btf_type_vlen(prog->aux->attach_func_proto) - 1;
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

