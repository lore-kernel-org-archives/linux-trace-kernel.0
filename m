Received: from mail-pg1-f194.google.com (mail-pg1-f194.google.com [209.85.215.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F01443019A4
	for <linux-trace-kernel@vger.kernel.org>; Wed, 22 Oct 2025 08:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761120391; cv=none; b=hIV5FokEYn1xYvKBudgFSx6dgoJfwMnIuYuZKPkYnORT6nYog+3ehlJTGX8GhqcBny/9Z4+teIaleWlT8pGXyIOvuzR16DlZ2JWCb/fKjRCcpSHAqNzybI/fpImYq1lKu2owWUpcZcTOSuHv0619OaDNdg75cvVSacGhMYLzDhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761120391; c=relaxed/simple;
	bh=B0JQqDRKxWcBxPXaAw62FhVtQnrslzaQ3xhWOIHDjmg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tv3HLsZivG/UCj3ufb4+aU1Hdol2YPBMckCyumdtnw9pmwX1RhfOBsr2+dsHm/VI6Kfh4fSzoSPCaiV58ylbEfM3La8s6or4qSuk2RzcLeJDOvrSeymccIbgiFJmsL0Irkv/UWXmEtekuwpEZnY1VQSJ3rF/vjS+zLUuyeqbywg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=js39pTVm; arc=none smtp.client-ip=209.85.215.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="js39pTVm"
Received: by mail-pg1-f194.google.com with SMTP id 41be03b00d2f7-b58445361e8so613534a12.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 22 Oct 2025 01:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761120388; x=1761725188; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xHIaGixaxA7xmdcTs4um3PPNmbROplwQ3SgulV73VAE=;
        b=js39pTVmKBh0qrcGsb2uVbZOU/bbZb6vfUA0qpj+BbIRHuxajjaHRHpln1TpKg3cl5
         zjj86un+TfkwWfHID5cPx0407dYwhIDBtoqSl7xmDn1BBDnU4rsEWVaCJgtJvmJusZu1
         0zLVzLF9OmMjWkAh+lC/8He3mUFbMT02Lq2FOqdA6fui2YtNYcv6rt3tMeIGs0tYJHGo
         knga6Z9KQMlf1GT4JZp+PTMYK1U1e+n+KAofuyYPSAaFe22z0FZfyZNpYH3Kknilh6J2
         kb0hTTN/APQhbDtftG2u63OkN1bRCb3EJcdPFb+zm/mhcWdz+3h5NW7JHgc/GSnoLy74
         O0sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761120388; x=1761725188;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xHIaGixaxA7xmdcTs4um3PPNmbROplwQ3SgulV73VAE=;
        b=g2X7JDl6LdpAn27C18fDjlQJyc1LM2w9YPJ1zzhTJmH+BJJu2ZCYhkFkZHR2g4RMGN
         GHeIcUz9FQbfkqnhz+eJfcVpasVnca/25JuzUIrCoifnX/LWzjDlFF5IuATgxVoBABpt
         esxPsRIUM1OmoAEO3YrfQkPfa5RRctkkiA9V3lBhxty7lssiow3i8wxYiLKi0odyNzA6
         VVvxb9e5gNsLXzXLc38eX6dhDGFMsUw3mt25Jv1A1L+SS4W/3oHrrgTOxEC176P1ktr9
         rqUJHGLlYsAmwe46TL8zfWPN8DzGtrAD1gATp57TprhIBoYaFt6t2HArhaURF5QDhbLh
         rsJg==
X-Forwarded-Encrypted: i=1; AJvYcCWvUod6v5KXwOGU9yifvyfxY94Qo2o+3pPAIY395IZryOrA0CIys+tpI1qatfcoPB8oyYM8lPFG+uHcY1yScWvyoSI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYw+pWBSRYN5tBc8kVDNyqG0S6c3USQNPkQyYZOPzBfdAQ4k0D
	cprw7zx/5YYwB9PjQOG6z3XlVEpW6pT/AK/WOiUPGlL0/Tnr0Or6nYUw
X-Gm-Gg: ASbGncsuXYE3eEVD25veJw61YY2Ad8oaKPRQd0zZ7ACs2+BoWkEYgmX6WnpXbZ/yAww
	iu58OFFktt9Tqi4YvgY35yY23QU8VJ34pX4lIey24UmGBkfs4+X/vuEwtEa8V7oqhLzg/SiRq5Z
	RJ4x2e2gzszpeTHPupcpWlglrMtBSJFE65f0Ak1ynaQ4Zw0WeibCP9Fl9Np+2uG/lAiCGzOl19j
	mvEhIIHLqEyaZNiBakzlXO3O8gki+H0/OZAiEb8RUWHzbV9G2vDkDZh3YgAf8zJt1PZbROhFQ2e
	+eziq/ISufUzg498jgRt8l9p+HHKz+cO4/XZB7uUuWSQJlnUj3l/he29i48hk8lOGvaq4rOhpum
	usxObhd0qI4KS2du5YPJIerlv0hI3ZHeaqW+IJsiMjzr3uz0zbq/QqX09B6n66XOta1+CeKvasi
	FNtxGkdGs=
X-Google-Smtp-Source: AGHT+IERyb93JkjscfYhmv50eNGlTcSbffWgXk4M3VQqoMdjpjdztgQz3+2IY6J0m01vh+DMSEmNnA==
X-Received: by 2002:a17:90b:48cf:b0:327:53f0:6368 with SMTP id 98e67ed59e1d1-33e21ec327bmr3586322a91.2.1761120388000;
        Wed, 22 Oct 2025 01:06:28 -0700 (PDT)
Received: from 7950hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33e223c7fb5sm1805330a91.2.2025.10.22.01.06.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 01:06:27 -0700 (PDT)
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
Subject: [PATCH bpf-next v2 09/10] selftests/bpf: add session cookie testcase for fsession
Date: Wed, 22 Oct 2025 16:06:12 +0800
Message-ID: <20251022080613.555463-2-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.51.1.dirty
In-Reply-To: <20251022080613.555463-1-dongml2@chinatelecom.cn>
References: <20251022080613.555463-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Test the session cookie for fsession. Multiple fsession BPF progs is
attached to bpf_fentry_test1() and session cookie is read and write in
this testcase.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 .../selftests/bpf/prog_tests/fsession_test.c  | 34 +++++++++++++
 .../selftests/bpf/progs/fsession_cookie.c     | 49 +++++++++++++++++++
 2 files changed, 83 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/fsession_cookie.c

diff --git a/tools/testing/selftests/bpf/prog_tests/fsession_test.c b/tools/testing/selftests/bpf/prog_tests/fsession_test.c
index d70bdb683691..549b6fdd6167 100644
--- a/tools/testing/selftests/bpf/prog_tests/fsession_test.c
+++ b/tools/testing/selftests/bpf/prog_tests/fsession_test.c
@@ -2,6 +2,7 @@
 /* Copyright (c) 2025 ChinaTelecom */
 #include <test_progs.h>
 #include "fsession_test.skel.h"
+#include "fsession_cookie.skel.h"
 
 static int check_result(struct fsession_test *skel)
 {
@@ -82,6 +83,37 @@ static void test_fsession_reattach(void)
 	fsession_test__destroy(skel);
 }
 
+static void test_fsession_cookie(void)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, topts);
+	struct fsession_cookie *skel = NULL;
+	int err, prog_fd;
+
+	skel = fsession_cookie__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "fsession_cookie__open_and_load"))
+		goto cleanup;
+
+	err = fsession_cookie__attach(skel);
+	if (!ASSERT_OK(err, "fsession_cookie_attach"))
+		goto cleanup;
+
+	/* Trigger target once */
+	prog_fd = bpf_program__fd(skel->progs.test1);
+	err = bpf_prog_test_run_opts(prog_fd, &topts);
+	if (!ASSERT_OK(err, "test_run_opts err"))
+		goto cleanup;
+	if (!ASSERT_OK(topts.retval, "test_run_opts retval"))
+		goto cleanup;
+
+	for (int i = 0; i < sizeof(*skel->bss) / sizeof(__u64); i++) {
+		if (!ASSERT_EQ(((__u64 *)skel->bss)[i], 1, "test_result"))
+			goto cleanup;
+	}
+
+cleanup:
+	fsession_cookie__destroy(skel);
+}
+
 void test_fsession_test(void)
 {
 #if !defined(__x86_64__)
@@ -92,4 +124,6 @@ void test_fsession_test(void)
 		test_fsession_basic();
 	if (test__start_subtest("fsession_reattach"))
 		test_fsession_reattach();
+	if (test__start_subtest("fsession_cookie"))
+		test_fsession_cookie();
 }
diff --git a/tools/testing/selftests/bpf/progs/fsession_cookie.c b/tools/testing/selftests/bpf/progs/fsession_cookie.c
new file mode 100644
index 000000000000..93a120fb62e2
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/fsession_cookie.c
@@ -0,0 +1,49 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2025 ChinaTelecom */
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+char _license[] SEC("license") = "GPL";
+
+__u64 test1_entry_ok = 0;
+__u64 test1_exit_ok = 0;
+
+SEC("fsession/bpf_fentry_test1")
+int BPF_PROG(test1, int a)
+{
+	__u64 *cookie = bpf_fsession_cookie(ctx);
+
+	if (!bpf_tracing_is_exit(ctx)) {
+		if (cookie) {
+			*cookie = 0xAAAABBBBCCCCDDDDull;
+			test1_entry_ok = *cookie == 0xAAAABBBBCCCCDDDDull;
+		}
+		return 0;
+	}
+
+	if (cookie)
+		test1_exit_ok = *cookie == 0xAAAABBBBCCCCDDDDull;
+	return 0;
+}
+
+__u64 test2_entry_ok = 0;
+__u64 test2_exit_ok = 0;
+
+SEC("fsession/bpf_fentry_test1")
+int BPF_PROG(test2, int a)
+{
+	__u64 *cookie = bpf_fsession_cookie(ctx);
+
+	if (!bpf_tracing_is_exit(ctx)) {
+		if (cookie) {
+			*cookie = 0x1111222233334444ull;
+			test2_entry_ok = *cookie == 0x1111222233334444ull;
+		}
+		return 0;
+	}
+
+	if (cookie)
+		test2_exit_ok = *cookie == 0x1111222233334444ull;
+	return 0;
+}
-- 
2.51.1.dirty

