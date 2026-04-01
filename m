Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43BB147DD61
	for <linux-trace-kernel@vger.kernel.org>; Wed,  1 Apr 2026 16:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775060780; cv=none; b=Oro0jUh6TLpktsTBdV4W7T6E/ynkDOPk+hS9DCxXw+nG/khH9QIzw7gRPEHiFDE/yyy87N+GqnlUXlBupeIXu0kj+mUM0LLpCGA2ZsKysgsR5hFZ5yez667y0qqRFqk7eWtmJ3Dm/8wHBZZgWmvOR7zpL5RleokZynmGM6wYHGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775060780; c=relaxed/simple;
	bh=nu4MbcaGC1ScZASfjnysGtYFM0vwpEgtgUxJgHFyeFI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hR1jpI98QoR8ofKtzxC9mD4u0RP/oUqOBDH3W67aYoGSar3CMbmSTzrc1eTuHmaEefKfe/4R6LW8osdAUam1AIHYpEE2QNIyRRuG5pgLWdd9C2/sKgEAR08YiMI+MvUvYWjgMO62xfYTtq+wVdTaBCNXE4zEvaGHta0sHsNuwAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SJE5q6gT; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SJE5q6gT"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-35da8d037a5so1542898a91.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 01 Apr 2026 09:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775060771; x=1775665571; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=htPARiivWMAf+Z1l6rsulvqtlMFd2ueWojQoT0sqF7s=;
        b=SJE5q6gT9V8ia6m917MSHVo/XACG1RTe9ZQl8wRrDjwpyNlC0l41ns3lYxhQF32q1e
         1/5v4tMS4CZGtWNlLoEuX+vo0IFFR7RF2n3YIFJpMlArLz5Ayfgy0c263A3F1D5lzz41
         QDVKHncwpxqBx61Gz3LJPYfP6E4DbgYeoRdy25187AKKftVvS4S8AX6e8mh0OqBKKZFG
         NNOum24xZ8XKo5usax00nmJ1rAI3r0zDOSkFHNg6o6tP3T2x2APHUMKjlBqru7sONN+9
         pGcVJWFgFCNoHKQdWzz2Eqoz6zq1JB6fq/tD0IFN6sBm6Gbag4wZ22Sw1MdcFg5dYtCJ
         cMLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775060771; x=1775665571;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=htPARiivWMAf+Z1l6rsulvqtlMFd2ueWojQoT0sqF7s=;
        b=bjd2pzro6Vy+FG7T0L6+Jq3d1rsU4yOIPQD3aj3ZEDz8F3jLc8qRMaZ3AKHlXwxmYr
         Ja+/TCMa5J0Zj1rUhjIZhbXlArUloWv0HAzYTnuA+og0DTa1Qc+cxlkXJGjhlKznlnRY
         9k2TxZjKYbD/+9X+QOp2tyBT9qk+FUtGDjzbsy/cXQ50O7HmyJYWZmOZnW4h0b99K7wm
         v7DbNwooyVYpV8LIfiuSkCQf5pif9HzDl84OMByhCgpcbHMcRAas0ofJ90J2M74G13Eu
         58hOdY+YTrdTbe+JGx3NkaBBQYAvov9Y514PnvHGZpH0V0HM41dWHajsgTiGpBo7xMi8
         dxxw==
X-Forwarded-Encrypted: i=1; AJvYcCV0gkSwQMUsvpwWjwluIJ4AeNMz5xcztaBpzBum0Jr0SUBDYs0y6b3qM5lWcYy1w2GoI9ympTThfkbIHtCWVDDcvpU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw638JYxSBJuopZASYy7XyWE9SpfLaCdRx8w3VN03Ax7YgNhBdw
	f3/ARg67FAk8bwo6BwU0fga/d43P3mUw5dXaMUZozSZz6CNUV+Njts1H
X-Gm-Gg: ATEYQzx5goH5uk65OZ+5Y3XXSi6w2FO4ZbF/hYjfwcj3M7EgdpQOBjzNH4nxQB/9vpr
	U2Znw0jCaQh2YT/cE+yGBaO6qaNQVdH96RAHhpRVsxUHjN8FjUj7ilo8C7CqqLCNxip+rvrw5ll
	Zc8UYxiWZTgAzXyEJ83jjdmmgcY1+5BDjI9cCzIGvb2eSDdBcjhVvjOuixigxD5L3gSs8LfHn2R
	/cx8io8cmFn0fhQGhjT8ICbji5Y0AiGHS8gw3s9lhocc4pw4UVvdVdbfvWVAo+nWha33i7Ix8By
	myMaxDs3c3MWZtTfx1sMemVJJxn8S/kurqIUODc7wodRzcBpbNrLrW04Uay2NgplO0H+LMf8Ros
	vYa5GGH2XFLbCqOcWLxbEslRPsYipIPc7WP4PHPsdAEpFSmzMq7kraZDy4QbLQ9joggCxJbGudQ
	L/7Q0f5EYbGpYbSKvPMQtlhMXpKrwH9FSykZN3rNy9jt0Z5+N4VQi7sqwyFXWjplpMJck=
X-Received: by 2002:a17:90b:1350:b0:35c:b02:b5c1 with SMTP id 98e67ed59e1d1-35dc6e2d00dmr3948220a91.2.1775060770387;
        Wed, 01 Apr 2026 09:26:10 -0700 (PDT)
Received: from computer.goose-salary.ts.net ([2a09:bac5:40b2:a82::10c:22])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35dba546cccsm2338711a91.1.2026.04.01.09.26.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 09:26:09 -0700 (PDT)
From: Varun R Mallya <varunrmallya@gmail.com>
To: varunrmallya@gmail.com
Cc: andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	jolsa@kernel.org,
	kpsingh@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	martin.lau@linux.dev,
	mathieu.desnoyers@efficios.com,
	mattbobrowski@google.com,
	memxor@gmail.com,
	mhiramat@kernel.org,
	rostedt@goodmis.org,
	song@kernel.org,
	yonghong.song@linux.dev
Subject: [PATCH bpf v2] bpf: Reject sleepable kprobe_multi programs at attach time
Date: Wed,  1 Apr 2026 21:55:55 +0530
Message-ID: <20260401162555.426867-1-varunrmallya@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <ac0hLyMuPHiZfnVc@computer>
References: <ac0hLyMuPHiZfnVc@computer>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

kprobe.multi programs run in atomic/RCU context and cannot sleep.
However, bpf_kprobe_multi_link_attach() did not validate whether the
program being attached had the sleepable flag set, allowing sleepable
helpers such as bpf_copy_from_user() to be invoked from a non-sleepable
context.

This causes a "sleeping function called from invalid context" splat:

  BUG: sleeping function called from invalid context at ./include/linux/uaccess.h:169
  in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 1787, name: sudo
  preempt_count: 1, expected: 0
  RCU nest depth: 2, expected: 0

Fix this by rejecting sleepable programs early in
bpf_kprobe_multi_link_attach(), before any further processing.

Also add a selftest that tries to load a sleepable kprobe_multi program
and it needs to be rejected for the test to pass.

Fixes: 0dcac2725406 ("bpf: Add multi kprobe link")
Signed-off-by: Varun R Mallya <varunrmallya@gmail.com>
---
 kernel/trace/bpf_trace.c                      |  4 ++
 .../bpf/prog_tests/kprobe_multi_test.c        | 41 +++++++++++++++++++
 .../bpf/progs/kprobe_multi_sleepable.c        | 13 ++++++
 3 files changed, 58 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/kprobe_multi_sleepable.c

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 0b040a417442..af7079aa0f36 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -2752,6 +2752,10 @@ int bpf_kprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
 	if (!is_kprobe_multi(prog))
 		return -EINVAL;
 
+	/* kprobe_multi is not allowed to be sleepable. */
+	if (prog->sleepable)
+		return -EINVAL;
+
 	/* Writing to context is not allowed for kprobes. */
 	if (prog->aux->kprobe_write_ctx)
 		return -EINVAL;
diff --git a/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c b/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
index 78c974d4ea33..f02fec2b6fda 100644
--- a/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
+++ b/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
@@ -10,6 +10,7 @@
 #include "kprobe_multi_session_cookie.skel.h"
 #include "kprobe_multi_verifier.skel.h"
 #include "kprobe_write_ctx.skel.h"
+#include "kprobe_multi_sleepable.skel.h"
 #include "bpf/libbpf_internal.h"
 #include "bpf/hashmap.h"
 
@@ -633,6 +634,44 @@ static void test_attach_write_ctx(void)
 }
 #endif
 
+static void test_attach_multi_sleepable(void)
+{
+	struct kprobe_multi_sleepable *skel;
+	int err;
+
+	skel = kprobe_multi_sleepable__open();
+	if (!ASSERT_OK_PTR(skel, "kprobe_multi_sleepable__open"))
+		return;
+
+	err = bpf_program__set_flags(skel->progs.handle_kprobe_multi_sleepable,
+				     BPF_F_SLEEPABLE);
+	if (!ASSERT_OK(err, "bpf_program__set_flags"))
+		goto cleanup;
+
+	/* Load should succeed even with BPF_F_SLEEPABLE for KPROBE types */
+	err = kprobe_multi_sleepable__load(skel);
+	if (!ASSERT_OK(err, "kprobe_multi_sleepable__load"))
+		goto cleanup;
+
+	/* Attachment must fail for kprobe.multi + BPF_F_SLEEPABLE.
+	 * Also chosen a stable symbol to send into opts
+	 */
+	LIBBPF_OPTS(bpf_kprobe_multi_opts, opts);
+	const char *sym = "vfs_read";
+
+	opts.syms = &sym;
+	opts.cnt = 1;
+
+	skel->links.handle_kprobe_multi_sleepable =
+		bpf_program__attach_kprobe_multi_opts(skel->progs.handle_kprobe_multi_sleepable,
+						      NULL, &opts);
+	ASSERT_ERR_PTR(skel->links.handle_kprobe_multi_sleepable,
+		       "bpf_program__attach_kprobe_multi_opts");
+
+cleanup:
+	kprobe_multi_sleepable__destroy(skel);
+}
+
 void serial_test_kprobe_multi_bench_attach(void)
 {
 	if (test__start_subtest("kernel"))
@@ -676,5 +715,7 @@ void test_kprobe_multi_test(void)
 		test_unique_match();
 	if (test__start_subtest("attach_write_ctx"))
 		test_attach_write_ctx();
+	if (test__start_subtest("attach_multi_sleepable"))
+		test_attach_multi_sleepable();
 	RUN_TESTS(kprobe_multi_verifier);
 }
diff --git a/tools/testing/selftests/bpf/progs/kprobe_multi_sleepable.c b/tools/testing/selftests/bpf/progs/kprobe_multi_sleepable.c
new file mode 100644
index 000000000000..56973ad8779d
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/kprobe_multi_sleepable.c
@@ -0,0 +1,13 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+SEC("kprobe.multi")
+int handle_kprobe_multi_sleepable(struct pt_regs *ctx)
+{
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.53.0

