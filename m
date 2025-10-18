Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0CFF2E765E
	for <linux-trace-kernel@vger.kernel.org>; Sat, 18 Oct 2025 14:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760797331; cv=none; b=Tstucs8i4vKSHkmPjLqPiSA+Bcpbi3hc7PrMVoISFn432eyOI3WIKUF84hPUSx8j9trIYHKWVNgL+dDCwMzJ5quYYgX7HRgt4kmGhCWEj2iwXymz8tacwQmxIiNhyhpAmQVT+EzCx4wDtqIuix0xYa5HdAUpcDKJlFqLZFAcpMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760797331; c=relaxed/simple;
	bh=kXsLBaOuiWzTxOYqwGnvvLF5/8s/zxozt6M4TBM1QdA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gdph4vU4HeL1t3bkVCN41XJNpJ9/Eek0iLnMkKnBltDFXGaT+NS8fo7RiT8xhJWLChEWpSyMzzw4pS1eMo0ajpAaAsZGeTrTHHkUzIZ7GhJgiYRUNABsmTSnNVGqBKKcKsVIn6ESKYoLx2QjZGbC13eWenYC0kSV+V+Qvx7g7xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C//25bkJ; arc=none smtp.client-ip=209.85.210.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C//25bkJ"
Received: by mail-pf1-f193.google.com with SMTP id d2e1a72fcca58-781206cce18so2984955b3a.0
        for <linux-trace-kernel@vger.kernel.org>; Sat, 18 Oct 2025 07:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760797327; x=1761402127; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2jT5zqdbDY8x74jTyYOhN+JPqZ1LIOOhcVlrRdTY1/4=;
        b=C//25bkJ6+qadg2daRdwmKMUMOCyEAV8lHInF2CBkYFk68VJy83Xp1JK4uNPevsRbx
         Shqaib9lLYCm0zPJId+DSQyoL4ayNMbQrDp0WiF/GD9iSpbuJk0aHuX+a0j1oSDEEO13
         EpIJfo7eLjBx9oIiXdMy0suMWX2QuObiAyv55P9pI0gSuv57bIhxXVf4kFRYU9UgHfgh
         q5xKDJW93EGdwqkiJqo/sRNF2yK20ei2PY6FVJnuHTKvBT9JmZjAfYwUXq9IddCGxD3p
         tB+qAYrrny+eSN7FKb05rm2jBEHY/YzJtgX1ryiLNS6RI2hF0q6J+G3HkZnomrux/Heh
         0JuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760797327; x=1761402127;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2jT5zqdbDY8x74jTyYOhN+JPqZ1LIOOhcVlrRdTY1/4=;
        b=DRDyoHF5bKQKbdiHkvGH3fziYkHyiHqwps4KIdhyKEqhmLd3Zg2sXgjycXL94Ptzte
         T9PkQSxsZjoAegjYccX4bYO/+wkELFrzM30zDK8v5VePnjy1jQoNvwxzz2a72tpzFh37
         /q+l4a7dgUeKGsRG+xjjxP2Lv4h6HmowM/lJ84jNmAW8Wg+eVkn0CUuGJFoeJoZxn7jU
         zS3GXdq/PtlLUrEQkcDK2qSKu6OAP4NQqmhR++XbCrCyJehRkkd8d3MceYfkQRUX0cIf
         emowF6Tnvz2spaUhWHu7dY0zBEyFSaRzNVXhShUy5z8C/aqHmLcJY4WqwxM9wOywoP1r
         rUlg==
X-Forwarded-Encrypted: i=1; AJvYcCW5MyvQb4bwXNqbQnAz5o69bUYIn48Bntkrqp5Y8pwvDhAbfpLgKwcX5VR1qUwIuF5GRlenD31gpy6XroW8Vg4QX+A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQmz2/gmo27gx3nFcOiB9onoo4Q9CN9xp52ZnGYh46YYa36FKW
	rUH3fqeg3LTMQONtjBPt/LsCWQZs6ftJfBlpzLuA44HAklYnuV8PysFX
X-Gm-Gg: ASbGncui6wqqQPfJJJfeNVQDiRksuIOCxO8DK9rlBz7Jd3z3cxRKsPRgIRi6+WaKdsI
	E3fKurhU4gVikidWNiAca3RMsb3r++PDDbJrlIBpbfHy0Hwn0B0osRDCrySyfgrYUtTleHnnpdE
	Ic5vIO+FFGQEcN/uk00rhMxJ3rn/BjbIDHJO5XiEbJT/LCWDzWF5eHdkBR0WoPBgVDx0R3zUDSV
	J9qF644sQygY/49Ko56Gmbeo+DkZ1TzxrO1cI/4W5F+sn7ATZYsEarr3MfXewyk24QeltUV5Sy5
	TqyD2mbuBAj/d8PPR6YXYEq3VmSEHiv9aX07hxLZ8iJENTsQF5dS578rAkH5owCC0ikTAHgCORl
	ADf6i4iCPYnbWCW6lal23VX15bhnH/S99VIr5+mk5OvxElkoiWHzh3wE3u7BWlAq9zC9Ayp1HFe
	gu5u1udVE9lw4=
X-Google-Smtp-Source: AGHT+IF8mZYG06kBMFtFukpoGor04JUZ4l0MlY/GtJi7DQKN6Uz0Qp4laos6d3KuLxChec3J3KhCrA==
X-Received: by 2002:a05:6a00:17a0:b0:78c:a3a6:a1bf with SMTP id d2e1a72fcca58-7a21f96567fmr8686639b3a.7.1760797326983;
        Sat, 18 Oct 2025 07:22:06 -0700 (PDT)
Received: from 7950hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a23010d818sm2913589b3a.53.2025.10.18.07.22.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Oct 2025 07:22:06 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: ast@kernel.org,
	jolsa@kernel.org
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
	mattbobrowski@google.com,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	leon.hwang@linux.dev,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH RFC bpf-next 5/5] selftests/bpf: add testcases for tracing session
Date: Sat, 18 Oct 2025 22:21:24 +0800
Message-ID: <20251018142124.783206-6-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251018142124.783206-1-dongml2@chinatelecom.cn>
References: <20251018142124.783206-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add testcases for BPF_TRACE_SESSION.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 .../selftests/bpf/prog_tests/fsession_test.c  | 136 +++++++++++++
 .../selftests/bpf/progs/fsession_test.c       | 178 ++++++++++++++++++
 2 files changed, 314 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/fsession_test.c
 create mode 100644 tools/testing/selftests/bpf/progs/fsession_test.c

diff --git a/tools/testing/selftests/bpf/prog_tests/fsession_test.c b/tools/testing/selftests/bpf/prog_tests/fsession_test.c
new file mode 100644
index 000000000000..e2913da57b38
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/fsession_test.c
@@ -0,0 +1,136 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2025 ChinaTelecom */
+#include <test_progs.h>
+#include "fsession_test.skel.h"
+
+static void test_fsession_basic(void)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, topts);
+	struct fsession_test *skel = NULL;
+	int err, prog_fd;
+
+	skel = fsession_test__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "fsession_test__open_and_load"))
+		goto cleanup;
+
+	err = fsession_test__attach(skel);
+	if (!ASSERT_OK(err, "fsession_attach"))
+		goto cleanup;
+
+	/* Trigger test function calls */
+	prog_fd = bpf_program__fd(skel->progs.test1);
+	err = bpf_prog_test_run_opts(prog_fd, &topts);
+	if (!ASSERT_OK(err, "test_run_opts err"))
+		return;
+	if (!ASSERT_OK(topts.retval, "test_run_opts retval"))
+		return;
+
+	/* Verify test1: both entry and exit are called */
+	ASSERT_EQ(skel->bss->test1_entry_called, 1, "test1_entry_called");
+	ASSERT_EQ(skel->bss->test1_exit_called, 1, "test1_exit_called");
+	ASSERT_EQ(skel->bss->test1_entry_result, 1, "test1_entry_result");
+	ASSERT_EQ(skel->bss->test1_exit_result, 1, "test1_exit_result");
+
+	/* Verify test2: entry is called but exit is blocked */
+	ASSERT_EQ(skel->bss->test2_entry_called, 1, "test2_entry_called");
+	ASSERT_EQ(skel->bss->test2_exit_called, 0, "test2_exit_not_called");
+	ASSERT_EQ(skel->bss->test2_entry_result, 1, "test2_entry_result");
+	ASSERT_EQ(skel->bss->test2_exit_result, 0, "test2_exit_result");
+
+	/* Verify test3: both entry and exit are called */
+	ASSERT_EQ(skel->bss->test3_entry_called, 1, "test3_entry_called");
+	ASSERT_EQ(skel->bss->test3_exit_called, 1, "test3_exit_called");
+	ASSERT_EQ(skel->bss->test3_entry_result, 1, "test3_entry_result");
+	ASSERT_EQ(skel->bss->test3_exit_result, 1, "test3_exit_result");
+
+	/* Verify test4: both entry and exit are called */
+	ASSERT_EQ(skel->bss->test4_entry_called, 1, "test4_entry_called");
+	ASSERT_EQ(skel->bss->test4_exit_called, 1, "test4_exit_called");
+	ASSERT_EQ(skel->bss->test4_entry_result, 1, "test4_entry_result");
+	ASSERT_EQ(skel->bss->test4_exit_result, 1, "test4_exit_result");
+
+	/* Verify test5: both entry and exit are called */
+	ASSERT_EQ(skel->bss->test5_entry_called, 1, "test5_entry_called");
+	ASSERT_EQ(skel->bss->test5_exit_called, 1, "test5_exit_called");
+	ASSERT_EQ(skel->bss->test5_entry_result, 1, "test5_entry_result");
+	ASSERT_EQ(skel->bss->test5_exit_result, 1, "test5_exit_result");
+
+	/* Verify test6: entry is called but exit is blocked */
+	ASSERT_EQ(skel->bss->test6_entry_called, 1, "test6_entry_called");
+	ASSERT_EQ(skel->bss->test6_exit_called, 0, "test6_exit_not_called");
+	ASSERT_EQ(skel->bss->test6_entry_result, 1, "test6_entry_result");
+	ASSERT_EQ(skel->bss->test6_exit_result, 0, "test6_exit_result");
+
+	/* Verify test7: entry is called but exit is blocked */
+	ASSERT_EQ(skel->bss->test7_entry_called, 1, "test7_entry_called");
+	ASSERT_EQ(skel->bss->test7_exit_called, 0, "test7_exit_not_called");
+	ASSERT_EQ(skel->bss->test7_entry_result, 1, "test7_entry_result");
+	ASSERT_EQ(skel->bss->test7_exit_result, 0, "test7_exit_result");
+
+cleanup:
+	fsession_test__destroy(skel);
+}
+
+static void test_fsession_reattach(void)
+{
+	struct fsession_test *skel = NULL;
+	int err, prog_fd;
+	LIBBPF_OPTS(bpf_test_run_opts, topts);
+
+	skel = fsession_test__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "fsession_test__open_and_load"))
+		goto cleanup;
+
+	/* First attach */
+	err = fsession_test__attach(skel);
+	if (!ASSERT_OK(err, "fsession_first_attach"))
+		goto cleanup;
+
+	/* Trigger test function calls */
+	prog_fd = bpf_program__fd(skel->progs.test1);
+	err = bpf_prog_test_run_opts(prog_fd, &topts);
+	if (!ASSERT_OK(err, "test_run_opts err"))
+		return;
+	if (!ASSERT_OK(topts.retval, "test_run_opts retval"))
+		return;
+
+	/* Verify first call */
+	ASSERT_EQ(skel->bss->test1_entry_called, 1, "test1_entry_first");
+	ASSERT_EQ(skel->bss->test1_exit_called, 1, "test1_exit_first");
+
+	/* Detach */
+	fsession_test__detach(skel);
+
+	/* Reset counters */
+	memset(skel->bss, 0, sizeof(*skel->bss));
+
+	/* Second attach */
+	err = fsession_test__attach(skel);
+	if (!ASSERT_OK(err, "fsession_second_attach"))
+		goto cleanup;
+
+	err = bpf_prog_test_run_opts(prog_fd, &topts);
+	if (!ASSERT_OK(err, "test_run_opts err"))
+		return;
+	if (!ASSERT_OK(topts.retval, "test_run_opts retval"))
+		return;
+
+	/* Verify second call */
+	ASSERT_EQ(skel->bss->test1_entry_called, 1, "test1_entry_second");
+	ASSERT_EQ(skel->bss->test1_exit_called, 1, "test1_exit_second");
+
+cleanup:
+	fsession_test__destroy(skel);
+}
+
+void test_fsession_test(void)
+{
+#if !defined(__x86_64__)
+	test__skip();
+	return;
+#endif
+	if (test__start_subtest("fsession_basic"))
+		test_fsession_basic();
+	if (test__start_subtest("fsession_reattach"))
+		test_fsession_reattach();
+}
diff --git a/tools/testing/selftests/bpf/progs/fsession_test.c b/tools/testing/selftests/bpf/progs/fsession_test.c
new file mode 100644
index 000000000000..cce2b32f7c2c
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/fsession_test.c
@@ -0,0 +1,178 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2025 ChinaTelecom */
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+char _license[] SEC("license") = "GPL";
+
+__u64 test1_entry_result = 0;
+__u64 test1_exit_result = 0;
+__u64 test1_entry_called = 0;
+__u64 test1_exit_called = 0;
+
+SEC("fsession/bpf_fentry_test1")
+int BPF_PROG(test1, int a)
+{
+	bool is_exit = bpf_tracing_is_exit(ctx);
+
+	if (!is_exit) {
+		/* This is entry */
+		test1_entry_called = 1;
+		test1_entry_result = a == 1;
+		return 0; /* Return 0 to allow exit to be called */
+	}
+
+	/* This is exit */
+	test1_exit_called = 1;
+	test1_exit_result = a == 1;
+	return 0;
+}
+
+__u64 test2_entry_result = 0;
+__u64 test2_exit_result = 0;
+__u64 test2_entry_called = 0;
+__u64 test2_exit_called = 0;
+
+SEC("fsession/bpf_fentry_test2")
+int BPF_PROG(test2, int a, __u64 b)
+{
+	bool is_exit = bpf_tracing_is_exit(ctx);
+
+	if (!is_exit) {
+		/* This is entry */
+		test2_entry_called = 1;
+		test2_entry_result = a == 2 && b == 3;
+		return 1; /* Return non-zero value to block exit call */
+	}
+
+	/* This is exit - should not be called due to blocking */
+	test2_exit_called = 1;
+	test2_exit_result = a == 2 && b == 3;
+	return 0;
+}
+
+__u64 test3_entry_result = 0;
+__u64 test3_exit_result = 0;
+__u64 test3_entry_called = 0;
+__u64 test3_exit_called = 0;
+
+SEC("fsession/bpf_fentry_test3")
+int BPF_PROG(test3, char a, int b, __u64 c)
+{
+	bool is_exit = bpf_tracing_is_exit(ctx);
+
+	if (!is_exit) {
+		/* This is entry */
+		test3_entry_called = 1;
+		test3_entry_result = a == 4 && b == 5 && c == 6;
+		return 0; /* Allow exit to be called */
+	}
+
+	/* This is exit */
+	test3_exit_called = 1;
+	test3_exit_result = a == 4 && b == 5 && c == 6;
+	return 0;
+}
+
+__u64 test4_entry_result = 0;
+__u64 test4_exit_result = 0;
+__u64 test4_entry_called = 0;
+__u64 test4_exit_called = 0;
+
+SEC("fsession/bpf_fentry_test4")
+int BPF_PROG(test4, void *a, char b, int c, __u64 d)
+{
+	bool is_exit = bpf_tracing_is_exit(ctx);
+
+	if (!is_exit) {
+		/* This is entry */
+		test4_entry_called = 1;
+		test4_entry_result = a == (void *)7 && b == 8 && c == 9 && d == 10;
+		return 0; /* Allow exit to be called */
+	}
+
+	/* This is exit */
+	test4_exit_called = 1;
+	test4_exit_result = a == (void *)7 && b == 8 && c == 9 && d == 10;
+	return 0;
+}
+
+__u64 test5_entry_result = 0;
+__u64 test5_exit_result = 0;
+__u64 test5_entry_called = 0;
+__u64 test5_exit_called = 0;
+
+SEC("fsession/bpf_fentry_test7")
+int BPF_PROG(test5, struct bpf_fentry_test_t *arg)
+{
+	bool is_exit = bpf_tracing_is_exit(ctx);
+
+	if (!is_exit) {
+		/* This is entry */
+		test5_entry_called = 1;
+		if (!arg)
+			test5_entry_result = 1;
+		return 0; /* Allow exit to be called */
+	}
+
+	/* This is exit */
+	test5_exit_called = 1;
+	if (!arg)
+		test5_exit_result = 1;
+	return 0;
+}
+
+__u64 test6_entry_result = 0;
+__u64 test6_exit_result = 0;
+__u64 test6_entry_called = 0;
+__u64 test6_exit_called = 0;
+
+SEC("fsession/bpf_fentry_test5")
+int BPF_PROG(test6, __u64 a, void *b, short c, int d, __u64 e)
+{
+	bool is_exit = bpf_tracing_is_exit(ctx);
+
+	if (!is_exit) {
+		/* This is entry */
+		test6_entry_called = 1;
+		test6_entry_result = a == 11 && b == (void *)12 && c == 13 && d == 14 &&
+			e == 15;
+		/* Decide whether to block exit call based on condition */
+		if (a == 11)
+			return 1; /* Block exit call */
+		return 0;
+	}
+
+	/* This is exit - should not be called due to blocking */
+	test6_exit_called = 1;
+	test6_exit_result = a == 11 && b == (void *)12 && c == 13 && d == 14 &&
+		e == 15;
+	return 0;
+}
+
+__u64 test7_entry_result = 0;
+__u64 test7_exit_result = 0;
+__u64 test7_entry_called = 0;
+__u64 test7_exit_called = 0;
+
+SEC("fsession/bpf_fentry_test6")
+int BPF_PROG(test7, __u64 a, void *b, short c, int d, void *e, __u64 f)
+{
+	bool is_exit = bpf_tracing_is_exit(ctx);
+
+	if (!is_exit) {
+		/* This is entry */
+		test7_entry_called = 1;
+		test7_entry_result = a == 16 && b == (void *)17 && c == 18 && d == 19 &&
+			e == (void *)20 && f == 21;
+		/* Return non-zero to block exit call */
+		return 1;
+	}
+
+	/* This is exit - should not be called due to blocking */
+	test7_exit_called = 1;
+	test7_exit_result = a == 16 && b == (void *)17 && c == 18 && d == 19 &&
+		e == (void *)20 && f == 21;
+	return 0;
+}
-- 
2.51.0

