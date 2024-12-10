Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 891A819C546
	for <linux-trace-kernel@vger.kernel.org>; Tue, 10 Dec 2024 15:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733844871; cv=none; b=I0/k1M/bMP/98z7wqcr2YGeLEf8n1eR0rRG0AvhBfgIAeV1U69bd3NMM1weXrNaHuNS5C9gglse7uvWV4kipn7dwuYTuvQZkZJyKY6KTpEIfETsKIOBGBYQZapGzX/FeplC3UoblmRkIAdeKeGLlC9hQ7S6MAUT0GfT8rhVXcLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733844871; c=relaxed/simple;
	bh=D4EPrZ1KlCJrj+YiSAnr4IIWbtdz8oQu+zYxqHKFgUs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=QEJbNf1tXN9lvNEWAWyvsARf3w5yOqC0SOT/C6MexQB71sJ5PL6qTWxu61/33MZiFisf1P6qCgDTfx98gjbdu72PVi+W25h+AEOImVCX/VNQvUilaCc7e5DVmgeBN85ERSIiRnusSf+3iZWOuib2440I0ujYxVBmOEweVByzuhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=O02w0W70; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O02w0W70"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-434e5e71a08so46355e9.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 10 Dec 2024 07:34:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733844868; x=1734449668; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=e7oKn8SfeOYu43ner6bNalQq2+eOUuwHIvOMLrZ7fjg=;
        b=O02w0W70FuVOT8i4NVJ0fKUczVrmKJQpgCfMRM5BnF/MDkuupXA4XnaZLCvPhaV/Gm
         FbvaoLdsmjpdvwMqpbBH4G9tjhE8TojAHseHTLBXb1ojKVo3NkBH9ZiGayPlQ4h7E9WA
         N3Nh9wNgL/pg3GgOWf0bQKW+ilDEZMcnljzLAgoMcIMVzPnfFvLaZm0ke/8hkaCJGU+p
         jB9oJLSQarLtg2+zLwP4jImxbXmwpDoDzDIpIeLcBNRReMBUmuTjqzW4l0hqqUE4hpMB
         FruaV8A4NzcbFMm1nOQJp8QRll59jp76rmu1sMVqnR+mofaCfaQTXR0dOJiiOdzVw9jw
         bn6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733844868; x=1734449668;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e7oKn8SfeOYu43ner6bNalQq2+eOUuwHIvOMLrZ7fjg=;
        b=TrfMwl1MYIc+Lv33AuoHKmVuykT3PF+lHbZi+tWZZCSomDEQIK/MdW0Zr1PvXd6QwN
         JiYVB553gNgbIjYFVIhZxuPzIiSeKs/qXbWWXzDmytX0HznrDnwpIlBr9E3TPBs6Aqf2
         62l8pd0Qu+ZqcDejZ4cu4tGUFuWv0UTO6QVeqGSiKn43dC/Mm8AskC+HWl+TLBDFOFHW
         WP9m76+tvTMlnW4iB4WZEcXtGbgxy/3A+nnORtUECPKXgQEXT0MRmwH0F5jMDce0xu9P
         tUNmsW5DHxOHR2lHxsSOm7vQhveUjzvthZfGYDOgyVmIjz6ihoogk5ImeX23FEUdOEAU
         RYHw==
X-Forwarded-Encrypted: i=1; AJvYcCXllcGTXxsSNz47eFWLxxmk1+aX7j8msWWjvuIRXpaoEccDn5gylJefclucHfhvr7OBLwPUCOn3Xs2ljwWv6J9dVRc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxbjsrm8OSy2Lh6AmJxucEOnt2BXR5ax9/b2DsWofYA0jvbjFO2
	NGmP7B8nyHTgfUbABUR6POuSUlGxAVVM83Y3gu20d0FgXnu/vLs0zuy2bJtIhg==
X-Gm-Gg: ASbGnctuEerJdbZS6yPtiKk7xodwnQOZBHkJt07MGd/AXL8JxdvQV0pmcHc+z099+kL
	GsGqqWg+fBxTfAo1REzvNNbl9DA9sHFLBWiDVG1BY6DO7yNAKhUxZmQzbRafYMnb0uHEwyL64Cg
	MewSgcsKfTbvPCA9KMhNfEp0x/a/TtaGw09CT8vPU6ZfBvuuY+6QmVHKyhBeAjGa+rwqHfiaWJB
	00dFW5A9hppzWu0Rohds8qu5kGRDAzChhRQ0aCTtp4=
X-Google-Smtp-Source: AGHT+IEBipaGZmUxyH+9ZM7xyHO/CFA1s88GF5PM0VfgA8u/bXFdvNqD/XiKoIz1xDNwuIeIsZQPCA==
X-Received: by 2002:a05:600c:4907:b0:434:f7fc:1b18 with SMTP id 5b1f17b1804b1-435028ac13amr1382405e9.4.1733844867378;
        Tue, 10 Dec 2024 07:34:27 -0800 (PST)
Received: from localhost ([2a00:79e0:9d:4:deb9:87dc:18b2:3f1c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434f5774454sm87113235e9.13.2024.12.10.07.34.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 07:34:26 -0800 (PST)
From: Jann Horn <jannh@google.com>
Date: Tue, 10 Dec 2024 16:34:18 +0100
Subject: [PATCH bpf v3] bpf: Fix theoretical prog_array UAF in
 __uprobe_perf_func()
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241210-bpf-fix-uprobe-uaf-v3-1-ce50ae2a2f0f@google.com>
X-B4-Tracking: v=1; b=H4sIAHlfWGcC/4XNTQ7CIBAF4Ks0rB1TptAfV97DuAA6tCQqDViia
 Xp3CTs3unwzb77ZWKTgKLJTtbFAyUXnHzk0h4qZWT0mAjfmzLBGwbFuQS8WrHvBugSvCVZlQTb
 jgL1Wuhlrlg+XQLlR0AvLfXbNw9nFpw/v8ijxsvplJg4c2r4dTK94h7I/T95PNzoafy9ewv8GZ
 kOYThopLAkUX8a+7x+UKE0C/gAAAA==
X-Change-ID: 20241206-bpf-fix-uprobe-uaf-53d928bab3d0
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Delyan Kratunov <delyank@fb.com>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, Jann Horn <jannh@google.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733844863; l=3983;
 i=jannh@google.com; s=20240730; h=from:subject:message-id;
 bh=D4EPrZ1KlCJrj+YiSAnr4IIWbtdz8oQu+zYxqHKFgUs=;
 b=YSLxoLODDEklujQg5BUuocln7Wu7g1Q2qyVqqEYI8R/sFpAgizW5+17PAauI5LlhDHyYaXmsw
 W8+IwulIzpyBm+Hc1bCaKBP5vLFPL2W1EMagiEREaBmtwnXRUzi2N/n
X-Developer-Key: i=jannh@google.com; a=ed25519;
 pk=AljNtGOzXeF6khBXDJVVvwSEkVDGnnZZYqfWhP1V+C8=

Currently, the pointer stored in call->prog_array is loaded in
__uprobe_perf_func(), with no RCU annotation and no immediately visible
RCU protection, so it looks as if the loaded pointer can immediately be
dangling.
Later, bpf_prog_run_array_uprobe() starts a RCU-trace read-side critical
section, but this is too late. It then uses rcu_dereference_check(), but
this use of rcu_dereference_check() does not actually dereference anything.

Fix it by aligning the semantics to bpf_prog_run_array(): Let the caller
provide rcu_read_lock_trace() protection and then load call->prog_array
with rcu_dereference_check().

This issue seems to be theoretical: I don't know of any way to reach this
code without having handle_swbp() further up the stack, which is already
holding a rcu_read_lock_trace() lock, so where we take
rcu_read_lock_trace() in __uprobe_perf_func()/bpf_prog_run_array_uprobe()
doesn't actually have any effect.

Fixes: 8c7dcb84e3b7 ("bpf: implement sleepable uprobes by chaining gps")
Suggested-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Jann Horn <jannh@google.com>
---
Changes in v3:
- align semantics with bpf_prog_run_array()
- correct commit message: the issue is theoretical
- remove stable CC
- Link to v2: https://lore.kernel.org/r/20241206-bpf-fix-uprobe-uaf-v2-1-4c75c54fe424@google.com

Changes in v2:
- remove diff chunk in patch notes that confuses git
- Link to v1: https://lore.kernel.org/r/20241206-bpf-fix-uprobe-uaf-v1-1-6869c8a17258@google.com
---
 include/linux/bpf.h         | 11 +++--------
 kernel/trace/trace_uprobe.c |  6 +++++-
 2 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index eaee2a819f4c150a34a7b1075584711609682e4c..7fe5cf181511d543b1b100028db94ebb2a44da5d 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2193,26 +2193,22 @@ bpf_prog_run_array(const struct bpf_prog_array *array,
  * rcu-protected dynamically sized maps.
  */
 static __always_inline u32
-bpf_prog_run_array_uprobe(const struct bpf_prog_array __rcu *array_rcu,
+bpf_prog_run_array_uprobe(const struct bpf_prog_array *array,
 			  const void *ctx, bpf_prog_run_fn run_prog)
 {
 	const struct bpf_prog_array_item *item;
 	const struct bpf_prog *prog;
-	const struct bpf_prog_array *array;
 	struct bpf_run_ctx *old_run_ctx;
 	struct bpf_trace_run_ctx run_ctx;
 	u32 ret = 1;
 
 	might_fault();
+	RCU_LOCKDEP_WARN(!rcu_read_lock_trace_held(), "no rcu lock held");
 
-	rcu_read_lock_trace();
 	migrate_disable();
 
 	run_ctx.is_uprobe = true;
 
-	array = rcu_dereference_check(array_rcu, rcu_read_lock_trace_held());
-	if (unlikely(!array))
-		goto out;
 	old_run_ctx = bpf_set_run_ctx(&run_ctx.run_ctx);
 	item = &array->items[0];
 	while ((prog = READ_ONCE(item->prog))) {
@@ -2227,9 +2223,8 @@ bpf_prog_run_array_uprobe(const struct bpf_prog_array __rcu *array_rcu,
 			rcu_read_unlock();
 	}
 	bpf_reset_run_ctx(old_run_ctx);
-out:
+
 	migrate_enable();
-	rcu_read_unlock_trace();
 	return ret;
 }
 
diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index fed382b7881b82ee3c334ea77860cce77581a74d..4875e7f5de3db249af34c539c079fbedd38f4107 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -1402,9 +1402,13 @@ static void __uprobe_perf_func(struct trace_uprobe *tu,
 
 #ifdef CONFIG_BPF_EVENTS
 	if (bpf_prog_array_valid(call)) {
+		const struct bpf_prog_array *array;
 		u32 ret;
 
-		ret = bpf_prog_run_array_uprobe(call->prog_array, regs, bpf_prog_run);
+		rcu_read_lock_trace();
+		array = rcu_dereference_check(call->prog_array, rcu_read_lock_trace_held());
+		ret = bpf_prog_run_array_uprobe(array, regs, bpf_prog_run);
+		rcu_read_unlock_trace();
 		if (!ret)
 			return;
 	}

---
base-commit: 509df676c2d79c985ec2eaa3e3a3bbe557645861
change-id: 20241206-bpf-fix-uprobe-uaf-53d928bab3d0

-- 
Jann Horn <jannh@google.com>

