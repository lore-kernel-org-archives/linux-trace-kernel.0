Received: from mail-pj1-f66.google.com (mail-pj1-f66.google.com [209.85.216.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5819C2FD7CE
	for <linux-trace-kernel@vger.kernel.org>; Wed, 22 Oct 2025 08:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761120385; cv=none; b=niuK/7xtyy+F5T479u/nlxCvVt+eiVblCYRrBI5gZ/qm5625hRbdMPchp2dm0Cki/J17lbTgCqMGfhcVrA+Sayd0cldmqpfZvMoI2JC7ZFjCutucU1OtO1XmJh8MXcT4K9DaHoWp9TbxaiQKdYDZoXwpchrR/Pcq1sUzhEqzYII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761120385; c=relaxed/simple;
	bh=11h9/7cLSx4w9Nlnk3G5SzB3wO2oo6urxq94rUmhgIo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m3Cl+SAq1V1V4CI89wB59+paYrh6frub8YBpEMy3vjaXeota5jl25g7q1wkQabGS23K0ZfEN5pNfKJO5AI37udzmKONoxzmWQWxZuvvQtO5tdGWeWUcwg4iEPzn9NIEQiyIpIeIQG7DRfwBMMxjcv6g4WRkqicxcDBT71AFu4WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OT+7p63A; arc=none smtp.client-ip=209.85.216.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OT+7p63A"
Received: by mail-pj1-f66.google.com with SMTP id 98e67ed59e1d1-33bda2306c5so5256441a91.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 22 Oct 2025 01:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761120382; x=1761725182; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7pd1xamI1Z87Z/xGHN+zpZ0EaiU7Q5JCHed+8W4tHa8=;
        b=OT+7p63A8dISxStTvo9VrMpayqSkKAjaP1vSYqkVnPTCZd63OD5So4W/qdMytcc5JV
         RPpef6kzJf3PsKWDy9CssdnYD1lko9oVffl0irluGLkB0WMoV96K1KMdPX6eYFOpE79R
         uIH+zEh1XQyeWsEIfm1gL4VaQM8FtzNgrMQ7zKLOl7X6d9LIJnk9fSYnf7Vs+mvgGni8
         zx8S8jiIkzlOX7r5Tao4NET6l/ob2SvDodsizlT/EadDIgxFdsjkOmgjJVzsRvoEMe/r
         U7efk7mq6X2fY9bMIN0Sposqgmqt2irN65wIqCQmH8KeYwnZsAAJunp4qHwHwb5bbpiO
         nwAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761120382; x=1761725182;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7pd1xamI1Z87Z/xGHN+zpZ0EaiU7Q5JCHed+8W4tHa8=;
        b=LKtqvdmadxGZThZHsAJXcT0hTjRc9omd4Us0OEnPvKFCr2MS/chJztVU5Yyfv6Is6a
         f+TMol6ml7G9ZYpxH+2VRbzdjEFDlzMCriGxLz/jdj+vjafc7xYByP3NlAC2Dv1yGqoG
         7dxOtnVuZph6VZ6cmrgPPlwcP+hIJ7+HRPOBbE7zxVJIMDhJTe42Wj6tGID1UtJbNr5h
         8iqIPuRMbIY06s5qf5Gj+As4dxO1RprJPJ0mS8u9KUPeKOzudhZMgdaLY4z3L+p6noKU
         X9XvP62O7K/3RVjPZjdKVCz4w8zt862N6ubhHof/k7Pv8a3rnR2OIISWn3DXITVcnnXe
         Gq1A==
X-Forwarded-Encrypted: i=1; AJvYcCW716IEFlnhaIKujj0bY5MKoPpF+fFFCIsofb42KVz6vC9jfogvDuEX0aZ1cW+EXqmJT3KG8TE9DLvx+0b5KYA45hU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbiAkyA7zQ2dmCBeObGxVbsxZ3rI/ftGxaBDE80e6DXhNRFoAY
	oaEo3XI1GMeyYCfvkO66xUZ+xv21itE5CFJU11kXdWqlA6uAv+WiBTT+
X-Gm-Gg: ASbGncsUOMB+5DjDCgxuqh69eAXmsIgwU8CU+TiY/jNeGQHyUGU3EG3wuiHJr39LGeP
	thnPsanJdPLSGx5NhoGKyp2BEwI2DpYUqJLQwMfdDpl7AtHX3d5NF8Lr3vKzgbgqwaNVIy5Nj8P
	eEECdYog2m5Hx9zvMkjckyalSImD1k3mgKpaK8wwwavRbZFK9HdD6epcVuGvviAM0LctAwHITgr
	4MEFfdefdU3b12jnTdQW2Swl5Xj7uA1PF/aEtZ+MYrb6sy2kAC8Mxr93Ik7p2t0cSlgi9g4tG2d
	DUOPQonRkk+weG0k2wDNF98EcHot6uM2JyqohWjYXH/IkZbTeZXKawO1DiRszzNs33eXzmrp210
	7SAZO9/5VP1sX25Lmr+xAm0t/ZIwpC8lQhFyiX2fY5rH/q7NhBQT4VHio1M6iB52reW2Q4zQ5nd
	lYP6Art0I=
X-Google-Smtp-Source: AGHT+IE70+TREWXzMJPqDOGvy7TIW4dMzKInSqb2lFkSA22INPn9248XY9+0iTdOyzuydSqJYdoiQQ==
X-Received: by 2002:a17:90b:3942:b0:336:b60f:3936 with SMTP id 98e67ed59e1d1-33bcf87ab20mr29204108a91.12.1761120382423;
        Wed, 22 Oct 2025 01:06:22 -0700 (PDT)
Received: from 7950hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33e223c7fb5sm1805330a91.2.2025.10.22.01.06.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 01:06:21 -0700 (PDT)
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
	jiang.biao@linux.dev,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH bpf-next v2 08/10] selftests/bpf: add testcases for tracing session
Date: Wed, 22 Oct 2025 16:06:11 +0800
Message-ID: <20251022080613.555463-1-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.51.1.dirty
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
 .../selftests/bpf/prog_tests/fsession_test.c  |  95 ++++++++++
 .../selftests/bpf/progs/fsession_test.c       | 175 ++++++++++++++++++
 2 files changed, 270 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/fsession_test.c
 create mode 100644 tools/testing/selftests/bpf/progs/fsession_test.c

diff --git a/tools/testing/selftests/bpf/prog_tests/fsession_test.c b/tools/testing/selftests/bpf/prog_tests/fsession_test.c
new file mode 100644
index 000000000000..d70bdb683691
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/fsession_test.c
@@ -0,0 +1,95 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2025 ChinaTelecom */
+#include <test_progs.h>
+#include "fsession_test.skel.h"
+
+static int check_result(struct fsession_test *skel)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, topts);
+	int err, prog_fd;
+
+	/* Trigger test function calls */
+	prog_fd = bpf_program__fd(skel->progs.test1);
+	err = bpf_prog_test_run_opts(prog_fd, &topts);
+	if (!ASSERT_OK(err, "test_run_opts err"))
+		return err;
+	if (!ASSERT_OK(topts.retval, "test_run_opts retval"))
+		return topts.retval;
+
+	for (int i = 0; i < sizeof(*skel->bss) / sizeof(__u64); i++) {
+		if (!ASSERT_EQ(((__u64 *)skel->bss)[i], 1, "test_result"))
+			return -EINVAL;
+	}
+
+	/* some fields go to the "data" sections, not "bss" */
+	for (int i = 0; i < sizeof(*skel->data) / sizeof(__u64); i++) {
+		if (!ASSERT_EQ(((__u64 *)skel->data)[i], 1, "test_result"))
+			return -EINVAL;
+	}
+	return 0;
+}
+
+static void test_fsession_basic(void)
+{
+	struct fsession_test *skel = NULL;
+	int err;
+
+	skel = fsession_test__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "fsession_test__open_and_load"))
+		goto cleanup;
+
+	err = fsession_test__attach(skel);
+	if (!ASSERT_OK(err, "fsession_attach"))
+		goto cleanup;
+
+	check_result(skel);
+cleanup:
+	fsession_test__destroy(skel);
+}
+
+static void test_fsession_reattach(void)
+{
+	struct fsession_test *skel = NULL;
+	int err;
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
+	if (check_result(skel))
+		goto cleanup;
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
+	if (check_result(skel))
+		goto cleanup;
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
index 000000000000..3a756272374d
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/fsession_test.c
@@ -0,0 +1,175 @@
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
+
+SEC("fsession/bpf_fentry_test1")
+int BPF_PROG(test1, int a, int ret)
+{
+	bool is_exit = bpf_tracing_is_exit(ctx);
+
+	if (!is_exit) {
+		/* This is entry */
+		test1_entry_result = a == 1 && ret == 0;
+		/* Return 0 to allow exit to be called */
+		return 0;
+	}
+
+	/* This is exit */
+	test1_exit_result = a == 1 && ret == 2;
+	return 0;
+}
+
+__u64 test2_entry_result = 0;
+__u64 test2_exit_result = 1;
+
+SEC("fsession/bpf_fentry_test2")
+int BPF_PROG(test2, int a, __u64 b, int ret)
+{
+	bool is_exit = bpf_tracing_is_exit(ctx);
+
+	if (!is_exit) {
+		/* This is entry */
+		test2_entry_result = a == 2 && b == 3 && ret == 0;
+		/* Return non-zero value to block exit call */
+		return 1;
+	}
+
+	/* This is exit - should not be called due to blocking */
+	test2_exit_result = 0;
+	return 0;
+}
+
+__u64 test3_entry_result = 0;
+__u64 test3_exit_result = 0;
+
+SEC("fsession/bpf_fentry_test3")
+int BPF_PROG(test3, char a, int b, __u64 c, int ret)
+{
+	bool is_exit = bpf_tracing_is_exit(ctx);
+
+	if (!is_exit) {
+		test3_entry_result = a == 4 && b == 5 && c == 6 && ret == 0;
+		return 0;
+	}
+
+	test3_exit_result = a == 4 && b == 5 && c == 6 && ret == 15;
+	return 0;
+}
+
+__u64 test4_entry_result = 0;
+__u64 test4_exit_result = 0;
+
+SEC("fsession/bpf_fentry_test4")
+int BPF_PROG(test4, void *a, char b, int c, __u64 d, int ret)
+{
+	bool is_exit = bpf_tracing_is_exit(ctx);
+
+	if (!is_exit) {
+		test4_entry_result = a == (void *)7 && b == 8 && c == 9 && d == 10 && ret == 0;
+		return 0;
+	}
+
+	test4_exit_result = a == (void *)7 && b == 8 && c == 9 && d == 10 && ret == 34;
+	return 0;
+}
+
+__u64 test5_entry_result = 0;
+__u64 test5_exit_result = 0;
+
+SEC("fsession/bpf_fentry_test5")
+int BPF_PROG(test5, __u64 a, void *b, short c, int d, __u64 e, int ret)
+{
+	bool is_exit = bpf_tracing_is_exit(ctx);
+
+	if (!is_exit) {
+		test5_entry_result = a == 11 && b == (void *)12 && c == 13 && d == 14 &&
+			e == 15 && ret == 0;
+		return 0;
+	}
+
+	test5_exit_result = a == 11 && b == (void *)12 && c == 13 && d == 14 &&
+		e == 15 && ret == 65;
+	return 0;
+}
+
+__u64 test6_entry_result = 0;
+__u64 test6_exit_result = 1;
+
+SEC("fsession/bpf_fentry_test6")
+int BPF_PROG(test6, __u64 a, void *b, short c, int d, void *e, __u64 f, int ret)
+{
+	bool is_exit = bpf_tracing_is_exit(ctx);
+
+	if (!is_exit) {
+		test6_entry_result = a == 16 && b == (void *)17 && c == 18 && d == 19 &&
+			e == (void *)20 && f == 21 && ret == 0;
+		return 1;
+	}
+
+	test6_exit_result = 0;
+	return 0;
+}
+
+__u64 test7_entry_result = 0;
+__u64 test7_exit_result = 0;
+
+SEC("fsession/bpf_fentry_test7")
+int BPF_PROG(test7, struct bpf_fentry_test_t *arg, int ret)
+{
+	bool is_exit = bpf_tracing_is_exit(ctx);
+
+	if (!is_exit) {
+		if (!arg)
+			test7_entry_result = ret == 0;
+		return 0;
+	}
+
+	if (!arg)
+		test7_exit_result = 1;
+	return 0;
+}
+
+__u64 test8_entry_result = 0;
+__u64 test8_exit_result = 1;
+/*
+ * test1, test8 and test9 hook the same target to verify the "ret" is always
+ * 0 in the entry.
+ */
+SEC("fsession/bpf_fentry_test1")
+int BPF_PROG(test8, int a, int ret)
+{
+	bool is_exit = bpf_tracing_is_exit(ctx);
+
+	if (!is_exit) {
+		test8_entry_result = a == 1 && ret == 0;
+		return -21;
+	}
+
+	/* This is exit */
+	test8_exit_result = 0;
+	return 0;
+}
+
+__u64 test9_entry_result = 0;
+__u64 test9_exit_result = 1;
+
+SEC("fsession/bpf_fentry_test1")
+int BPF_PROG(test9, int a, int ret)
+{
+	bool is_exit = bpf_tracing_is_exit(ctx);
+
+	if (!is_exit) {
+		test9_entry_result = a == 1 && ret == 0;
+		return -22;
+	}
+
+	test9_exit_result = 0;
+	return 0;
+}
-- 
2.51.1.dirty

