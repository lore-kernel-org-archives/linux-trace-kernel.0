Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795479172;
	b=mcDOzwLndKMBsxe5ygDbXtc8PkPHMPWbHVFLPkgwlQ4cWpcveqc5KILKepFZSYj+2wMR
	 HdLUEJmh6olAPTEVmgdLv2gNXOESmE8sd33/ngqZ2FuTcEGTRTikBocG3Fi9OwjxzA6pG
	 TfERO9C09alNYbnd30koY9ndkr+7s+LJycHhcUpg0Jr6KdrGhXFmsYyCGJQncl3di7FqV
	 uYfmNSNu4LsUsH5uayOoQ1UGARAg0oCD6k6OamKH1udTHVgZwjzsn4G+I1pq7B12kOPdq
	 Asrl/h7lUk1e29iam2j7hamQUZ+6yBLgGERlA+gEKLMQERc2Y6uE73sBiS9aQQWfc0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795479172;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:From:To:Cc:Subject:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=7bDIHXXIM4LNEtaYASA3zw1NmzIi1pMS/QPwvnMhMAg=;
	b=EcS/PveQkOx3B99PXm+uIYcU1g1hPfMBPIQK7jprXMRanXFjnIesGTA4yO1J3UIV+574
	 Gj5/XyB3GUJSswR+CfSgerdAqVb/aiRCVXAO0sAuX+fxpYXGmaEl4BW4sIjTC2FfeVu55
	 jOmd94ngSRxrh9mLkASxkfp7jTd3kYMMv1EHzkccOVqB5oBq7DSk6aRtj1qwswBIhq2GD
	 W/IoKtnY0qYS1bPw1o/d7UkGPNl1qHQ0xEWxHGTIZCAAWA9j0W6he795Pqsh1RWjcf4MQ
	 4Ynq4frvXAdArLReZpzxDsPa+2srGTCcGf8EJ/H3aFOf7PecDsxew3wWr+vkJyFHGGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EvzGf6z3;
	arc=none smtp.remote-ip=209.85.210.177
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72DD4606A327
	for <linux-trace-kernel@vger.kernel.org>; Tue, 24 Nov 2026 00:12:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 72DD4606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EvzGf6z3
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-8b67f25e6e1so1866531b3a.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 23 Nov 2026 16:12:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795479171; x=1796083971; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :subject:cc:to:from:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7bDIHXXIM4LNEtaYASA3zw1NmzIi1pMS/QPwvnMhMAg=;
        b=EvzGf6z3rhg+QVwRCNjiqtCEZQCgcOG6ShYMP0kcI8BIeTc+i+i1MBX1jcLv86gWPK
         nyHsqBHq/6w7+m9DsSBPB+vW2wMewdPpAMBY2hX/Uls7uEq7FEl0qbsUwWhAxBAwrC+W
         +S5cCZa8peiG/UWSsGfsCamGsA2WW+N0Ng8wgEG/f8tHfVjaETAJGRpi4zoOJVmSk2Fk
         yMKdj6HtQbbkDpc8+pkb4cP7A8uDYL+GEkEZIYMBDAuTLKWDOZC5Yh+kvlrf0QrZ3MgU
         xHDFWEv+uQAg/q+KqS+6yXIIvnoFUGR0Y1VT7IFBmxqe7g1OrYn/zB5z2DbJlOn0IIOF
         B+dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795479171; x=1796083971;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :subject:cc:to:from:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7bDIHXXIM4LNEtaYASA3zw1NmzIi1pMS/QPwvnMhMAg=;
        b=D+enjGn0GBIeLB6JA3VHv9xqOm0qjqYLuSdlM/hoKI1PLkVQFmtOoAu5LKt/iPhWIX
         LRYGh0bx60rFCu893MjspMZjX3NF2ilRYCVi3WauOQVyyKOnqUGSz8rlyp29H9mUH1gU
         WSKHnNE4R5aBqq0uibZETSC+40TfmLqkAsXFKKfTF1ZUdh9TGY7blrP3JJyH83HXkOK6
         K6WQybDS6hFPYBsaCKBgLKkuk9z2SpXMwNaZs0VJ6p2qur3Fianluw/KFP0Tr1KGUuDT
         DFDKGBbzGSrcMGqoMZyyLVWAoNnHz5skgDd1wolbFIHMW2HtESNZIJFpRldYDI720hXa
         w/fQ==
X-Forwarded-Encrypted: i=1; AL+hErFzdSX+bIf84U7PQPVoIyQcJC/sGdxjI7dDMkKZJ5MwftOlWmtYnf9VzlwXEdhh7h8omV/eKGtPx6C3IpJq3+RA17Q=@vger.kernel.org
X-Gm-Message-State: APuU4Z/UbuKcY1EcioXHfXYGwz7TRU9ecYN7oAGgksqAS3+IrDey8PCs
	bpclL+vvqD57PHePjxYy/GbWivdy9Vq6kt2uEuaVAVtzhqGpRa6pAsQ+
X-Gm-Gg: AZFdTZd/NKJUhDPlxQBBB5QOj9F33A5C/wpHrG3tXRt9l3vc17Ee/aJ5yBMpjUk2F1c
	zojzXfPDhOPooRXZLVFJ4TOh9XbEjuflpp7RET8oAIEpp+wODahgbzTEpi50pfgcGIMC14kDdat
	8XdquumqfOf1dUCQChTssoEMxZFDKIsVVjeI0KD8eoOEQlHs2qR9q+5rK8vCx2co5VUxWlTilcq
	tFCo6ZIZV+zuiCirKaxvhh+Ywpkza4hXqVf2NzjEGSgvqE+dqUMUB/6r8EmFMvZrkgBMAWJ/GJJ
	xXiyG5nGLZTIpawo3u2Ifb26E8l2ll84MYGkGO9y+8o2j6L6IKFRTs02qtdoUhtL0bqTJiOkKFJ
	uEtK5RmWdkSAFz2Lz3cBsSwQObcZg4uO0o2els6vFTK9i+fTOE2TJB52+tNdut9lUmUYpJ8W4V1
	uGAPA3PHCkqfxZMh4nHn94wyRnlPufQcIvIcfq89g6fxpqiH3Vppv+VMFnzBTprTfXYPUY0Gf9H
	NrIS6boeQczydHNBESdKjzxIDEuyfBaeg+FYXfwfZTdzoQlX48xj+3Z/bGYIBWei40lIC0bYA8a
	rsyqx7W85nVkKVEnS+d7EmE8xSajPDYc/DPRvl3hC2FamvO2ggYn8pSrWNqON9aa9XObya1I+om
	ZdkGFAWmw5s6BogcjWMcd5GRPShkeNLajwQ==
X-Received: by 2002:a05:6a00:368b:b0:89e:b12e:7eda with SMTP id d2e1a72fcca58-8c8792c36afmr11522943b3a.7.1795479170548;
        Mon, 23 Nov 2026 16:12:50 -0800 (PST)
Received: from localhost ([153.61.198.243])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c873b278f0sm6298093b3a.51.2026.11.23.16.12.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Nov 2026 16:12:50 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Tue, 24 Nov 2026 00:12:47 +0000
Message-Id: <DN308UHY5QHQ.8CJOFGAHVVTR@gmail.com>
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Leon Hwang" <leon.hwang@linux.dev>, <bpf@vger.kernel.org>
Cc: "Daniel Borkmann" <daniel@iogearbox.net>, "John Fastabend"
 <john.fastabend@gmail.com>, "Andrii Nakryiko" <andrii@kernel.org>, "Eduard
 Zingerman" <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>, "Martin KaFai Lau" <martin.lau@linux.dev>, "Song Liu"
 <song@kernel.org>, "Yonghong Song" <yonghong.song@linux.dev>, "Jiri Olsa"
 <jolsa@kernel.org>, "Emil Tsalapatis" <emil@etsalapatis.com>, "Ihor
 Solodrai" <ihor.solodrai@linux.dev>, "Steven Rostedt"
 <rostedt@goodmis.org>, "Masami Hiramatsu" <mhiramat@kernel.org>, "Mathieu
 Desnoyers" <mathieu.desnoyers@efficios.com>, "KP Singh"
 <kpsingh@kernel.org>, "Matt Bobrowski" <matt@bobrowski.net>, "Shuah Khan"
 <shuah@kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-trace-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 <netdev@vger.kernel.org>
Subject: Re: [PATCH bpf-next v3 0/9] bpf: Add log support for tracing
 link_create
In-Reply-To: <20261123152743.19629-1-leon.hwang@linux.dev>
References: <20261123152743.19629-1-leon.hwang@linux.dev>
Content-Transfer-Encoding: 8bit
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Mon, Nov 23, 2026 at 07:27 AM Leon Hwang <leon.hwang@linux.dev> wrote:
>  .../selftests/bpf/prog_tests/cgroup_link.c    | 324 ++++++++
>  .../selftests/bpf/prog_tests/iter_link.c      | 156 ++++
>  .../selftests/bpf/prog_tests/tracing_link.c   | 741 ++++++++++++++++++
>  .../selftests/bpf/progs/tracing_link_ctx.c    |  17 +
>  .../selftests/bpf/progs/tracing_link_multi.c  |  36 +
>  .../selftests/bpf/test_kmods/bpf_testmod.c    |   5 +

1279 lines of selftests for log messages ?
This is way too much.

pw-bot: cr

One row per attach path is enough. It checks that the log gets there.
The base kernel leaves the log empty, so all four rows fail on it.
Something like this:

diff --git a/tools/testing/selftests/bpf/prog_tests/link_log.c b/tools/testing/selftests/bpf/prog_tests/link_log.c
new file mode 100644
index 0000000..4f7e71a
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/link_log.c
@@ -0,0 +1,72 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <test_progs.h>
+
+/* One row per attach path. It checks that the log gets there. */
+static const struct {
+	const char *name;
+	enum bpf_prog_type type;
+	enum bpf_attach_type attach_type;
+	const char *func;
+	struct bpf_link_create_opts opts;
+	int err;
+	const char *msg;
+} tests[] = {
+	{ "tracing", BPF_PROG_TYPE_TRACING, BPF_TRACE_FENTRY, "bpf_fentry_test1",
+	  { .target_btf_id = 1 }, -EINVAL, "target_btf_id" },
+#ifdef __x86_64__
+	{ "tracing_multi", BPF_PROG_TYPE_TRACING, BPF_TRACE_FENTRY_MULTI, NULL,
+	  { .tracing_multi = { .ids = (const __u32[]){ ~0U }, .cnt = 1 } },
+	  -EINVAL, "4294967295" },
+#endif
+	{ "iter", BPF_PROG_TYPE_TRACING, BPF_TRACE_ITER, "bpf_map",
+	  { .iter.len = 4 }, -EINVAL, "iter_info_len" },
+	{ "cgroup", BPF_PROG_TYPE_CGROUP_SKB, BPF_CGROUP_INET_EGRESS, NULL,
+	  { .cgroup.expected_revision = 2 }, -ESTALE, "revision" },
+};
+
+static void run_test(int i, int cg)
+{
+	const struct bpf_insn insns[] = {
+		BPF_MOV64_IMM(BPF_REG_0, 0),
+		BPF_EXIT_INSN(),
+	};
+	struct bpf_link_create_opts opts = tests[i].opts;
+	char buf[128] = {};
+	LIBBPF_OPTS(bpf_log_opts, log_opts, .buf = buf, .size = sizeof(buf), .level = 1);
+	LIBBPF_OPTS(bpf_prog_load_opts, load_opts,
+		    .expected_attach_type = tests[i].attach_type);
+	int prog_fd, fd;
+
+	if (tests[i].func)
+		load_opts.attach_btf_id =
+			libbpf_find_vmlinux_btf_id(tests[i].func, tests[i].attach_type);
+	prog_fd = bpf_prog_load(tests[i].type, NULL, "GPL", insns, ARRAY_SIZE(insns),
+				&load_opts);
+	if (!ASSERT_OK_FD(prog_fd, "bpf_prog_load"))
+		return;
+
+	opts.sz = sizeof(opts);
+	opts.log_opts = &log_opts;
+	fd = bpf_link_create(prog_fd, tests[i].type == BPF_PROG_TYPE_CGROUP_SKB ? cg : 0,
+			     tests[i].attach_type, &opts);
+	if (fd >= 0)
+		close(fd);
+	ASSERT_EQ(fd, tests[i].err, "err");
+	ASSERT_HAS_SUBSTR(buf, tests[i].msg, "log");
+	ASSERT_EQ(log_opts.true_size, strlen(buf) + 1, "true_size");
+	close(prog_fd);
+}
+
+void test_link_log(void)
+{
+	int i, cg;
+
+	cg = test__join_cgroup("/link_log");
+	if (!ASSERT_OK_FD(cg, "join_cgroup"))
+		return;
+
+	for (i = 0; i < ARRAY_SIZE(tests); i++)
+		if (test__start_subtest(tests[i].name))
+			run_test(i, cg);
+	close(cg);
+}
