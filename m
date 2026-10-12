Received: from mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F80C4AA3F8
	for <linux-trace-kernel@vger.kernel.org>; Mon, 12 Oct 2026 15:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791819903; cv=none; b=jgHDonXmoVYnPg7gGTjv4W4vsJqFjKmYdmMaJPwUcKHcAwGSqkyGJbpcyCQgLmMdBNLBizrggMYEpHc+Xz3J0GoF9pvJAU3MxkRuLifP1bcwV9YEWPE241UMyzjqLRppBSeO9ysryaiLcPZTaFG7rS6LxSPZxxL+D0AUaucMJK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791819903; c=relaxed/simple;
	bh=GF2y3cZLLKo3Rw4Rb6OFmd7jVWJ7z6UGsLgzVq2UMpQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pa0N5y07kWJejfZf+DeaXgrp2/Kv1ZVYMNLMZR3As5hRCOWpDlSwdIki6yqMH/dg3vUrXk+O1C8a+QFtvwtLn8F6AjuZq09GMOZ2pcdcH/preB/Rx2rDN0yh3ab+cVEYnV+J1n4W+6S06+h1R2DevtGR+k6RxF0+lCgX4wBtUGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=k96R6DGN; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="k96R6DGN"
X-Envelope-To: linux-trace-kernel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=GF2y3cZLLKo3Rw4Rb6OFmd7jVWJ7z6UGsLgzVq2UMpQ=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791819899; v=1; x=1792424699;
 b=k96R6DGNesctbty1JMjFQRvSFT4dy3eLgHXbKfbCBaIGk7Vxg1pN40FT9KneKRW0HBbSU3GN
 d6BTSt+y5f2Q4O2orWz8IThL6bCdPZ75z+RN0AsPbRYFI691a8vGkoAfZcDEgqVqwnREeFasA7w
 E9rJ0t2Ko3bkNArIQxeu7KNA=
X-Envelope-To: linux-trace-kernel@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 56d1af081940df69;
	Mon, 12 Oct 2026 15:44:58 +0000
X-Mizu-Trace-ID: 56d1af081940df69
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
	Quentin Monnet <qmo@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Leon Hwang <leon.hwang@linux.dev>,
	Mykyta Yatsenko <yatsenko@meta.com>,
	Avinash Duduskar <avinash.duduskar@gmail.com>,
	Anton Protopopov <a.s.protopopov@gmail.com>,
	Amery Hung <ameryhung@gmail.com>,
	Jordan Rife <jordan@jrife.io>,
	Rong Tao <rongtao@cestc.cn>,
	Eyal Birger <eyal.birger@gmail.com>,
	Pu Lehui <pulehui@huawei.com>,
	Jingguo Tan <tanjingguo@huawei.com>,
	Lin Ma <malin89@huawei.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next v2 17/21] selftests/bpf: Add tracing_multi bpf prog cookie test
Date: Mon, 12 Oct 2026 23:40:19 +0800
Message-ID: <20261012154024.29423-18-leon.hwang@linux.dev>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261012154024.29423-1-leon.hwang@linux.dev>
References: <20261012154024.29423-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Verify that the cookie also works for bpf prog targets of tracing_multi
link.

Assisted-by: Codex:gpt-5.5
Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 .../selftests/bpf/prog_tests/tracing_multi.c  | 21 +++++++++++++++++--
 .../selftests/bpf/progs/tracing_multi_bpf.c   | 13 ++++++++++--
 2 files changed, 30 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/tracing_multi.c b/tools/testing/selftests/bpf/prog_tests/tracing_multi.c
index d428b5e2600c..bcf933760bc5 100644
--- a/tools/testing/selftests/bpf/prog_tests/tracing_multi.c
+++ b/tools/testing/selftests/bpf/prog_tests/tracing_multi.c
@@ -1143,9 +1143,12 @@ static int run_bpf_target(struct bpf_program *prog, __u32 retval, const char *na
 	return 0;
 }
 
-static void test_link_api_bpf_prog(void)
+static void test_link_api_bpf_prog(bool test_cookies)
 {
 	const char *funcs[] = { "target_1", "target_2" };
+	__u64 fentry_cookies[] = { 0xfeed01, 0xfeed02 };
+	__u64 fexit_cookies[] = { 0xfeed11, 0xfeed12 };
+	__u64 fsession_cookies[] = { 0xfeed21, 0xfeed22 };
 	LIBBPF_OPTS(bpf_tracing_multi_opts, opts);
 	struct tracing_multi_bpf *skel = NULL;
 	int fds[ARRAY_SIZE(funcs)];
@@ -1158,27 +1161,39 @@ static void test_link_api_bpf_prog(void)
 	fds[0] = bpf_program__fd(skel->progs.target_1);
 	fds[1] = bpf_program__fd(skel->progs.target_2);
 
+	skel->bss->test_cookies = test_cookies;
+
 	opts.fds = fds;
 	opts.funcs = funcs;
 	opts.cnt = ARRAY_SIZE(fds);
 
+	opts.cookies = test_cookies ? fentry_cookies : NULL;
 	link = bpf_program__attach_tracing_multi(skel->progs.test_fentry, NULL, &opts);
 	if (!ASSERT_OK_PTR(link, "attach_fentry"))
 		goto cleanup;
 	skel->links.test_fentry = link;
 
+	opts.cookies = test_cookies ? fexit_cookies : NULL;
 	link = bpf_program__attach_tracing_multi(skel->progs.test_fexit, NULL, &opts);
 	if (!ASSERT_OK_PTR(link, "attach_fexit"))
 		goto cleanup;
 	skel->links.test_fexit = link;
 
+	opts.cookies = test_cookies ? fsession_cookies : NULL;
 	link = bpf_program__attach_tracing_multi(skel->progs.test_fsession, NULL, &opts);
 	if (!ASSERT_OK_PTR(link, "attach_fsession"))
 		goto cleanup;
 	skel->links.test_fsession = link;
 
+	skel->bss->fentry_cookie = fentry_cookies[0];
+	skel->bss->fexit_cookie = fexit_cookies[0];
+	skel->bss->fsession_cookie = fsession_cookies[0];
 	if (run_bpf_target(skel->progs.target_1, 1, "target_1"))
 		goto cleanup;
+
+	skel->bss->fentry_cookie = fentry_cookies[1];
+	skel->bss->fexit_cookie = fexit_cookies[1];
+	skel->bss->fsession_cookie = fsession_cookies[1];
 	if (run_bpf_target(skel->progs.target_2, 2, "target_2"))
 		goto cleanup;
 
@@ -1296,7 +1311,9 @@ static void test_attach_api_bpf_prog_fails(void)
 void test_tracing_multi_prog_test(void)
 {
 	if (test__start_subtest("link_api"))
-		test_link_api_bpf_prog();
+		test_link_api_bpf_prog(false);
 	if (test__start_subtest("attach_api_fails"))
 		test_attach_api_bpf_prog_fails();
+	if (test__start_subtest("cookies"))
+		test_link_api_bpf_prog(true);
 }
diff --git a/tools/testing/selftests/bpf/progs/tracing_multi_bpf.c b/tools/testing/selftests/bpf/progs/tracing_multi_bpf.c
index 3e02602558ad..651b5d86203f 100644
--- a/tools/testing/selftests/bpf/progs/tracing_multi_bpf.c
+++ b/tools/testing/selftests/bpf/progs/tracing_multi_bpf.c
@@ -5,6 +5,10 @@
 
 char _license[] SEC("license") = "GPL";
 
+bool test_cookies;
+__u64 fentry_cookie;
+__u64 fexit_cookie;
+__u64 fsession_cookie;
 __u64 test_result_fentry;
 __u64 test_result_fexit;
 __u64 test_result_fsession_entry;
@@ -29,20 +33,25 @@ int target_2(void *ctx)
 SEC("fentry.multi")
 int BPF_PROG(test_fentry)
 {
-	test_result_fentry++;
+	if (!test_cookies || bpf_get_attach_cookie(ctx) == fentry_cookie)
+		test_result_fentry++;
 	return 0;
 }
 
 SEC("fexit.multi")
 int BPF_PROG(test_fexit)
 {
-	test_result_fexit++;
+	if (!test_cookies || bpf_get_attach_cookie(ctx) == fexit_cookie)
+		test_result_fexit++;
 	return 0;
 }
 
 SEC("fsession.multi")
 int BPF_PROG(test_fsession)
 {
+	if (test_cookies && bpf_get_attach_cookie(ctx) != fsession_cookie)
+		return 0;
+
 	if (bpf_session_is_return(ctx))
 		test_result_fsession_exit++;
 	else
-- 
2.55.0

