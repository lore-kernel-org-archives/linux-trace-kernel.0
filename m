Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795617194;
	b=3V03K8Hjq8/nIaVR/YsNgZeM5N1y/ArLcRfZxfq6+mssP9UNiJSI38WinE/5coomCsL7
	 IIsuTpy79LqXnLXjoOzh299lo92/nZXiE9IMjXWfG3dfxeew9Pd7I0fUdOW/kFeF8//Rw
	 P12MGqPyIGVVrFx5m7XOdXE0P+2l/mgF3KlY3D+J4nrqkjIsQqNucWfU4ZwDNzNANUz4/
	 6FcZ/EtensdeItANcXeSwEWoXCl8+OiGF4ctB8BmFW2A776K3UVUgf+k4weiJkocf7s2w
	 2lEyAnYnVX/M69poRNdZi3s47muhxKRIZ4DvDxHc525yUpLJhjvV/F/Fg8cTT181J9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795617194;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=jhqnK9Ccmh8mSstnOmIF+Njmn3b/KS/9Xl+9w0xtSuI=;
	b=M0B8Ms4/CqkAme5eCL+OXNJrqXcUjqbypQJOyPUA6n88TkwMyK2/FaK4zaDlgyJBCeA/
	 DQfuXsWQ3vKNUISJNqMclLKsSAUuqBZpezjX5MnqE1tWT0vlRZk02SWvK5BPAQiAlq717
	 c+toSW/93t7gKGNDUVTm06BJREli/FWIs13rZ2NcUpwTkNg4KgDrdJl1PSy/K1y2ISyCp
	 3ok7z7fGyBgvokYYlL+IgFbZEAnMEgoeFlngPioyAA5ndmABl4geBlYrZGS1BZVP2fHNe
	 nQC1svKVxmHiF9BBLoXTm/oCVjLL/WcY/DhRhcW/gjip2Ai+/MdoP2LP/JNop24ShrA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b="xK/xnXqB";
	arc=none smtp.remote-ip=91.218.175.182
Received: from mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44464606A332
	for <linux-trace-kernel@vger.kernel.org>; Wed, 25 Nov 2026 14:33:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 44464606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=xK/xnXqB
X-Envelope-To: linux-trace-kernel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=ybK+ytYb/K1xG5uLFMNljDPRrGSwyg0hDB8H+Jw9Iis=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795617191; v=1; x=1796221991;
 b=xK/xnXqBskMPl1bKIegjTlInSyAigQX+Ya/VxGviKEomZQ9FuEYXjx81v/BxRTNJU7PhIi6N
 S5ZA3uYar9mCC4KaP7MwaD3WYyOGn9n8xr5iR3fjk/BdVqcR2Xz6NUWXQ7IbLP56Y/CfSgsTtxP
 JDExdDa04oNfU6FbLCmkH4lk=
X-Envelope-To: linux-trace-kernel@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id ea7f02afe93770ae;
	Wed, 25 Nov 2026 14:33:11 +0000
X-Mizu-Trace-ID: ea7f02afe93770ae
X-Migadu-Flow: FLOW_OUT
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	KP Singh <kpsingh@kernel.org>,
	Matt Bobrowski <matt@bobrowski.net>,
	Shuah Khan <shuah@kernel.org>,
	Leon Hwang <leon.hwang@linux.dev>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH bpf-next v4 6/6] selftests/bpf: Test tracing and cgroup link creation logs
Date: Wed, 25 Nov 2026 22:31:38 +0800
Message-ID: <20261125143138.47174-7-leon.hwang@linux.dev>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261125143138.47174-1-leon.hwang@linux.dev>
References: <20261125143138.47174-1-leon.hwang@linux.dev>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Check the errno, diagnostic text and reported log size for one failed
attachment each for tracing, tracing_multi, iter and cgroup links.

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 .../selftests/bpf/prog_tests/link_log.c       | 85 +++++++++++++++++++
 1 file changed, 85 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/link_log.c

diff --git a/tools/testing/selftests/bpf/prog_tests/link_log.c b/tools/testing/selftests/bpf/prog_tests/link_log.c
new file mode 100644
index 000000000000..8a05d6c48d9b
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/link_log.c
@@ -0,0 +1,85 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <test_progs.h>
+
+static const struct link_log_case {
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
+	  { .iter.len = sizeof(union bpf_iter_link_info) }, -EINVAL, "iter_info_len" },
+	{ "cgroup", BPF_PROG_TYPE_CGROUP_SKB, BPF_CGROUP_INET_EGRESS, NULL,
+	  { .cgroup.expected_revision = 2 }, -ESTALE, "revision" },
+};
+
+static void run_test(const struct link_log_case *test)
+{
+	const struct bpf_insn insns[] = {
+		BPF_MOV64_IMM(BPF_REG_0, 0),
+		BPF_EXIT_INSN(),
+	};
+	struct bpf_link_create_opts opts = test->opts;
+	int prog_fd, fd, btf_id, cg = -1;
+	LIBBPF_OPTS(bpf_prog_load_opts, load_opts,
+		    .expected_attach_type = test->attach_type,
+	);
+	char buf[128] = {};
+	LIBBPF_OPTS(bpf_log_opts, log_opts,
+		    .buf = buf,
+		    .size = sizeof(buf),
+		    .level = 1,
+	);
+
+	if (test->func) {
+		btf_id = libbpf_find_vmlinux_btf_id(test->func, test->attach_type);
+		if (!ASSERT_GT(btf_id, 0, "attach_btf_id"))
+			return;
+
+		load_opts.attach_btf_id = btf_id;
+	}
+
+	prog_fd = bpf_prog_load(test->type, NULL, "GPL", insns, ARRAY_SIZE(insns), &load_opts);
+	if (!ASSERT_OK_FD(prog_fd, "bpf_prog_load"))
+		return;
+
+	if (test->type == BPF_PROG_TYPE_CGROUP_SKB) {
+		cg = test__join_cgroup("/link_log");
+		if (!ASSERT_OK_FD(cg, "join_cgroup"))
+			goto out;
+	}
+
+	opts.sz = sizeof(opts);
+	opts.log_opts = &log_opts;
+	fd = bpf_link_create(prog_fd, cg < 0 ? 0 : cg, test->attach_type, &opts);
+	if (fd >= 0)
+		close(fd);
+
+	ASSERT_EQ(fd, test->err, "err");
+	ASSERT_HAS_SUBSTR(buf, test->msg, "log");
+	ASSERT_EQ(log_opts.true_size, strlen(buf) + 1, "true_size");
+
+	if (cg >= 0)
+		close(cg);
+out:
+	close(prog_fd);
+}
+
+void test_link_log(void)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(tests); i++)
+		if (test__start_subtest(tests[i].name))
+			run_test(&tests[i]);
+}
-- 
2.55.0

