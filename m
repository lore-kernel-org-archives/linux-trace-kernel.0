Received: from mta1.migadu.com (out-82.mta1.migadu.com [95.215.58.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B47B2E7390
	for <linux-trace-kernel@vger.kernel.org>; Mon, 12 Oct 2026 15:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.82
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791819930; cv=none; b=iXgiyw2gG6cT9L0/QwHg7btunWt5l9xCwL4cHplwAw+xms+0HCj6m37oIX6/kQ9tAR6mM0q2unaaP+UKN7pVdr17ahpx4WuDAvQX/oCP1DJMPdc7nvqUnrQ4+bykonaaycdD5QF5qu6ucGjE6pJEYJWek8o/tmnIbSFUft4LWTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791819930; c=relaxed/simple;
	bh=ZNknDVT+PW4jJ1q4FIosutbkmH96w3Q1cdmfa9WAwTw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pdtev54o7cnWHN0xUnxpT+V1qeIL5lLWvkG0/LFdEA6i1kmsU2jJ9qSX0Ld1OwjBf4VbjqRR9+eG5R4wi4BsgW+RWI9wOGm1VybZhwpLr4vAtk6xjGX9+CCyXtKJ45RnqRvBG56yKTUc4L4frV7yFvlbxgFEOn7HvV6lAOPjvSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uoQVy3mT; arc=none smtp.client-ip=95.215.58.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uoQVy3mT"
X-Envelope-To: linux-trace-kernel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=ZNknDVT+PW4jJ1q4FIosutbkmH96w3Q1cdmfa9WAwTw=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791819927; v=1; x=1792424727;
 b=uoQVy3mT8BYKyffUHXU886ltymW0+4FPtDiJmLdAiC56PPVSfJBHdaYrdtTln2w9LOq1n0WE
 U+jmHO+eyOLUsrHq07s0NS1sDk/ZJ4i1vs4PLHNw5pO7Fjb7f+DUs1sRaLSMlVwDVGZ4h8C727K
 6PVRwfUxywyFa4qWBDBnJ9pk=
X-Envelope-To: linux-trace-kernel@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id fcd304c2a6652fcb;
	Mon, 12 Oct 2026 15:45:19 +0000
X-Mizu-Trace-ID: fcd304c2a6652fcb
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
Subject: [PATCH bpf-next v2 19/21] selftests/bpf: Add tracing_multi bpf prog link info test
Date: Mon, 12 Oct 2026 23:40:21 +0800
Message-ID: <20261012154024.29423-20-leon.hwang@linux.dev>
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

Verify the link info works well for bpf prog targets of tracing_multi link.

Assisted-by: Codex:gpt-5.5
Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 .../selftests/bpf/prog_tests/fill_link_info.c | 169 ++++++++++++++++--
 1 file changed, 151 insertions(+), 18 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/fill_link_info.c b/tools/testing/selftests/bpf/prog_tests/fill_link_info.c
index 0918321c8e63..422e94f13409 100644
--- a/tools/testing/selftests/bpf/prog_tests/fill_link_info.c
+++ b/tools/testing/selftests/bpf/prog_tests/fill_link_info.c
@@ -3,11 +3,13 @@
 
 #include <string.h>
 #include <linux/bpf.h>
+#include <linux/kallsyms.h>
 #include <linux/limits.h>
 #include <bpf/btf.h>
 #include <test_progs.h>
 #include "trace_helpers.h"
 #include "test_fill_link_info.skel.h"
+#include "tracing_multi_bpf.skel.h"
 #include "bpf/libbpf_internal.h"
 
 #define TP_CAT "sched"
@@ -39,8 +41,19 @@ struct tmulti_target {
 	__u64 addr;
 	__u64 cookie;
 	__u32 id;
+	__u32 func_btf_id;
 };
 
+static const char *tmulti_bpf_funcs[] = {
+	"target_1",
+	"target_2",
+};
+
+static __u64 tmulti_bpf_fentry_cookies[] = { 0xfeed01, 0xfeed02 };
+static __u64 tmulti_bpf_fexit_cookies[] = { 0xfeed11, 0xfeed12 };
+static __u64 tmulti_bpf_fsession_cookies[] = { 0xfeed21, 0xfeed22 };
+#define TRACING_MULTI_BPF_CNT ARRAY_SIZE(tmulti_bpf_funcs)
+
 #define UPROBE_FILE "/proc/self/exe"
 static ssize_t uprobe_offset;
 /* uprobe attach point */
@@ -421,14 +434,28 @@ static int tmulti_target_cmp(const void *a, const void *b)
 	return (ta->id > tb->id) - (ta->id < tb->id);
 }
 
+static int setup_tmulti_btf_obj_id(const struct bpf_program *prog, __u32 *btf_obj_id)
+{
+	struct bpf_prog_info prog_info = {};
+	__u32 len = sizeof(prog_info);
+	int err;
+
+	err = bpf_prog_get_info_by_fd(bpf_program__fd(prog), &prog_info, &len);
+	if (!ASSERT_OK(err, "bpf_prog_get_info_by_fd"))
+		return -1;
+	if (!ASSERT_GT(prog_info.attach_btf_obj_id, 0, "attach_btf_obj_id"))
+		return -1;
+
+	*btf_obj_id = prog_info.attach_btf_obj_id;
+	return 0;
+}
+
 static int setup_tmulti_targets(const struct bpf_program *prog,
 				struct tmulti_target *targets,
 				__u32 *btf_obj_id)
 {
-	struct bpf_prog_info prog_info;
-	__u32 len = sizeof(prog_info);
 	struct btf *btf;
-	int err, i;
+	int i;
 	__s32 id;
 
 	btf = btf__load_vmlinux_btf();
@@ -446,13 +473,8 @@ static int setup_tmulti_targets(const struct bpf_program *prog,
 		targets[i].id = id;
 	}
 
-	memset(&prog_info, 0, len);
-	err = bpf_prog_get_info_by_fd(bpf_program__fd(prog), &prog_info, &len);
-	if (!ASSERT_OK(err, "bpf_prog_get_info_by_fd"))
-		goto error;
-	if (!ASSERT_GT(prog_info.attach_btf_obj_id, 0, "attach_btf_obj_id"))
+	if (setup_tmulti_btf_obj_id(prog, btf_obj_id))
 		goto error;
-	*btf_obj_id = prog_info.attach_btf_obj_id;
 
 	/*
 	 * The kernel tracing multi attach sorts ids. We sort as well,
@@ -467,13 +489,49 @@ static int setup_tmulti_targets(const struct bpf_program *prog,
 	return -1;
 }
 
+static int setup_tmulti_bpf_prog_targets(const struct bpf_program *prog, int token_fd,
+					 const __u64 *cookies,
+					 const struct bpf_program * const *target_progs,
+					 struct tmulti_target *targets,
+					 __u32 *btf_obj_id)
+{
+	struct bpf_prog_info prog_info = {};
+	__u32 len = sizeof(prog_info), func_btf_id;
+	int err, i, prog_fd;
+
+	for (i = 0; i < TRACING_MULTI_BPF_CNT; i++) {
+		memset(&prog_info, 0, sizeof(prog_info));
+		len = sizeof(prog_info);
+		prog_info.jited_ksyms = ptr_to_u64(&targets[i].addr);
+		prog_info.nr_jited_ksyms = 1;
+		prog_fd = bpf_program__fd(target_progs[i]);
+		err = bpf_prog_get_info_by_fd(prog_fd, &prog_info, &len);
+		if (!ASSERT_OK(err, "bpf_prog_get_info_by_fd"))
+			return -1;
+
+		func_btf_id = libbpf_find_prog_btf_id(tmulti_bpf_funcs[i], prog_fd, token_fd);
+		if (!ASSERT_GT(func_btf_id, 0, "libbpf_find_prog_btf_id"))
+			return -1;
+
+		targets[i].cookie = cookies[i];
+		targets[i].id = prog_info.id;
+		targets[i].func_btf_id = func_btf_id;
+	}
+
+	qsort(targets, TRACING_MULTI_BPF_CNT, sizeof(targets[0]), tmulti_target_cmp);
+	return setup_tmulti_btf_obj_id(prog, btf_obj_id);
+}
+
 static int verify_tracing_multi_link_info(int fd, const struct bpf_program *prog,
 					  const struct tmulti_target *targets,
-					  __u32 btf_obj_id, bool has_cookies)
+					  __u32 btf_obj_id, __u32 count,
+					  bool has_cookies, bool tgt_progs)
 {
+#define TMULTI_CNT (TRACING_MULTI_CNT > TRACING_MULTI_BPF_CNT ? \
+		    TRACING_MULTI_CNT : TRACING_MULTI_BPF_CNT)
 	enum bpf_attach_type attach_type = bpf_program__expected_attach_type(prog);
-	__u64 addrs[TRACING_MULTI_CNT], cookies[TRACING_MULTI_CNT];
-	__u32 ids[TRACING_MULTI_CNT];
+	__u64 addrs[TMULTI_CNT], cookies[TMULTI_CNT];
+	__u32 ids[TMULTI_CNT], fids[TMULTI_CNT];
 	struct bpf_link_info info;
 	__u32 len = sizeof(info);
 	int err, i;
@@ -487,16 +545,21 @@ static int verify_tracing_multi_link_info(int fd, const struct bpf_program *prog
 		return -1;
 
 	ASSERT_EQ(info.tracing_multi.attach_type, attach_type, "info.tracing_multi.attach_type");
-	ASSERT_EQ(info.tracing_multi.count, TRACING_MULTI_CNT, "info.tracing_multi.count");
+	ASSERT_EQ(info.tracing_multi.count, count, "info.tracing_multi.count");
+	if (tgt_progs)
+		ASSERT_TRUE(info.tracing_multi.flags & BPF_F_TRACING_MULTI_TGT_PROGS,
+			    "info.tracing_multi.flags");
 
 	memset(ids, 0, sizeof(ids));
+	memset(fids, 0, sizeof(fids));
 	memset(cookies, 0, sizeof(cookies));
 	memset(addrs, 0, sizeof(addrs));
 
 	info.tracing_multi.ids = ptr_to_u64(ids);
 	info.tracing_multi.addrs = ptr_to_u64(addrs);
 	info.tracing_multi.cookies = has_cookies ? ptr_to_u64(cookies) : 0;
-	info.tracing_multi.count = TRACING_MULTI_CNT;
+	info.tracing_multi.func_btf_ids = tgt_progs ? ptr_to_u64(fids) : 0;
+	info.tracing_multi.count = count;
 
 	err = bpf_link_get_info_by_fd(fd, &info, &len);
 	if (!ASSERT_OK(err, "bpf_link_get_info_by_fd"))
@@ -506,14 +569,20 @@ static int verify_tracing_multi_link_info(int fd, const struct bpf_program *prog
 		return -1;
 
 	ASSERT_EQ(info.tracing_multi.attach_type, attach_type, "info.tracing_multi.attach_type");
-	ASSERT_EQ(info.tracing_multi.count, TRACING_MULTI_CNT, "info.tracing_multi.count");
+	ASSERT_EQ(info.tracing_multi.count, count, "info.tracing_multi.count");
 	ASSERT_EQ(info.tracing_multi.btf_obj_id, btf_obj_id, "tracing_multi.btf_obj_id");
+	if (tgt_progs)
+		ASSERT_TRUE(info.tracing_multi.flags & BPF_F_TRACING_MULTI_TGT_PROGS,
+			    "info.tracing_multi.flags");
 
-	for (i = 0; i < TRACING_MULTI_CNT; i++) {
+	for (i = 0; i < count; i++) {
 		ASSERT_EQ(ids[i], targets[i].id, "tracing_multi.ids");
 		ASSERT_EQ(cookies[i], has_cookies ? targets[i].cookie : 0, "tracing_multi.cookies");
 
-		if (targets[i].addr) {
+		if (tgt_progs) {
+			ASSERT_EQ(addrs[i], targets[i].addr, "tracing_multi.addrs");
+			ASSERT_EQ(fids[i], targets[i].func_btf_id, "tracing_multi.func_btf_ids");
+		} else if (targets[i].addr) {
 			struct ksym *ksym;
 
 			if (!ASSERT_NEQ(addrs[i], 0, "tracing_multi.addrs"))
@@ -624,13 +693,73 @@ static void test_tracing_multi_fill_link_info(struct test_fill_link_info *skel,
 		verify_tracing_multi_invalid_user_buffer(link_fd, targets);
 	} else {
 		err = verify_tracing_multi_link_info(link_fd, skel->progs.tmulti_run,
-						     targets, btf_obj_id, has_cookies);
+						     targets, btf_obj_id, TRACING_MULTI_CNT,
+						     has_cookies, false);
 		ASSERT_OK(err, "verify_tracing_multi_link_info");
 	}
 
 	bpf_link__destroy(link);
 }
 
+static void test_tracing_multi_bpf_fill_link_info_one(struct tracing_multi_bpf *skel,
+						      struct bpf_program *prog,
+						      __u64 *cookies,
+						      bool has_cookies)
+{
+	LIBBPF_OPTS(bpf_tracing_multi_opts, opts);
+	const struct bpf_program *target_progs[] = {
+		skel->progs.target_1,
+		skel->progs.target_2,
+	};
+	struct tmulti_target targets[TRACING_MULTI_BPF_CNT] = {};
+	int fds[TRACING_MULTI_BPF_CNT], token_fd, err, i;
+	struct bpf_link *link;
+	__u32 btf_obj_id;
+
+	token_fd = bpf_object__token_fd(skel->obj);
+	token_fd = token_fd < 0 ? 0 : token_fd;
+
+	if (setup_tmulti_bpf_prog_targets(prog, token_fd, cookies, target_progs, targets,
+					  &btf_obj_id))
+		return;
+
+	for (i = 0; i < TRACING_MULTI_BPF_CNT; i++)
+		fds[i] = bpf_program__fd(target_progs[i]);
+
+	opts.fds = fds;
+	opts.funcs = tmulti_bpf_funcs;
+	opts.cnt = ARRAY_SIZE(fds);
+	opts.cookies = has_cookies ? cookies : NULL;
+
+	link = bpf_program__attach_tracing_multi(prog, NULL, &opts);
+	if (!ASSERT_OK_PTR(link, "bpf_program__attach_tracing_multi"))
+		return;
+
+	err = verify_tracing_multi_link_info(bpf_link__fd(link), prog, targets, btf_obj_id,
+					     TRACING_MULTI_BPF_CNT, has_cookies, true);
+	ASSERT_OK(err, "verify_tracing_multi_link_info");
+
+	bpf_link__destroy(link);
+}
+
+static void test_tracing_multi_bpf_fill_link_info(bool has_cookies)
+{
+	struct tracing_multi_bpf *skel;
+
+	skel = tracing_multi_bpf__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "tracing_multi_bpf__open_and_load"))
+		return;
+
+	test_tracing_multi_bpf_fill_link_info_one(skel, skel->progs.test_fentry,
+						  tmulti_bpf_fentry_cookies, has_cookies);
+	test_tracing_multi_bpf_fill_link_info_one(skel, skel->progs.test_fexit,
+						  tmulti_bpf_fexit_cookies, has_cookies);
+	test_tracing_multi_bpf_fill_link_info_one(skel, skel->progs.test_fsession,
+						  tmulti_bpf_fsession_cookies, has_cookies);
+
+	tracing_multi_bpf__destroy(skel);
+}
+
 #define SEC(name) __attribute__((section(name), used))
 
 static short uprobe_link_info_sema_1 SEC(".probes");
@@ -879,6 +1008,10 @@ void test_fill_link_info(void)
 		test_tracing_multi_fill_link_info(skel, false, false);
 		test_tracing_multi_fill_link_info(skel, true, false);
 	}
+	if (test__start_subtest("tracing_multi_bpf_link_info")) {
+		test_tracing_multi_bpf_fill_link_info(false);
+		test_tracing_multi_bpf_fill_link_info(true);
+	}
 	if (test__start_subtest("tracing_multi_invalid_ubuff"))
 		test_tracing_multi_fill_link_info(skel, true, true);
 
-- 
2.55.0

