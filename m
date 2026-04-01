Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC70C33E374
	for <linux-trace-kernel@vger.kernel.org>; Wed,  1 Apr 2026 19:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775070707; cv=none; b=uCeEobZbwCEyyATlKZlgrW7PQcwi/bt4Y4a5OEHnuHsTqsDbrfaMKcneFAdDiX6yOtGo7ZnYjLcqlXbJRCHH/I3ipwIC1Qpfm+iuzDhZRDoSoYsaoePZ//QzFAsFqWb8Atwhb4Hr1zaF8yLggoD9PRkEp/82UvZTh4ALa7i1tPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775070707; c=relaxed/simple;
	bh=zreID7VlKz3sOwx4c4xLYDTLtsQVmx5niiZjOton9/g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mgm6UQSWtx5t5iZU0GlYVfeJI52r6m2lehs4ajEhPFcaAhlhcS9csATEf5bPHU+SK1FhvLE709qknzSSaYG5mszXuSzo2r/dSzzM1msvEgp9hWqLqlRoUgU+VFUPobAPcd5tUvaFkVAvzim6Sd3M9o8IQ+LPnJhU7UuI02aqZHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kOLa6wA/; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kOLa6wA/"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2adff872068so254805ad.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 01 Apr 2026 12:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775070704; x=1775675504; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hq94V4VxVCzdIEnjJH0P1icIANAAhuTjvKKe0p+pHxU=;
        b=kOLa6wA/yheVe+rFDI+qOwktORz76Tgv3Um/kyZ5lwsCdYuXIukYGnLO3vDqLemS86
         KZ4raew0UrTcR4/DSNZUCbCcPl4WRN7ymlVQA+dJnOoMxh1vMihgapgB7P5u3qbIKRQA
         VLIhUvEo9utpMPvCHcKfK16EvD55dRRcEr8Djc+rUh4GAxCizBF0a8s9iddLrwRQop2w
         YtsD3N2SPPFIUqxM459anghfEViaq2PRbXcfwtLr63Rz+kFwzK9hZoI2HFB3GFThCJNN
         dg+vH7GxUJDESZer5JmZPuHULPkOR7vXrMOFZebd1WY4nNZLTrG4+q7xUuQNkeIshVtT
         Uujw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775070704; x=1775675504;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hq94V4VxVCzdIEnjJH0P1icIANAAhuTjvKKe0p+pHxU=;
        b=nBJUgED7aukjFOqFXhO4Cy1WYuqR9ELGA8K4VqTOSIVeB5nPU04jHyQCwp1VCDNH2R
         jIRlwJ7xa5yW2wpxOLH4Pr5LidoJDPpD4soVDPpKHpapLMZ2LqLiQCOzdm2Mu3RbUUpR
         QnC1VMwt4V4n8aCQmkwPsChu1EASpIxgnS4j/9CxvFMaOAK43qMxCCNCo1K9bs4D0oSE
         Me2ujtgenboTqtiktMeai7VDZA733GL7Cf4XIBANSn14os9AyErIc8rAVNtGOr873OO9
         4Jigl/Q1bXamD65IeQK7Ei6tFWhUjw4HPwv/CEavmNDlvjTAu1+OKG/2V2QF35nVN9jb
         PkfQ==
X-Forwarded-Encrypted: i=1; AJvYcCVyMJ9dGZiaUjy9C5BQ3xUB2IZffbgBT3Cgsw0WyZCccc9ixXxH0sAJ+U+K6aHdBxtbjKkYdPXFq7zBgHpHfo06Pmo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCxMKlkmi6BgNA5xoJtU5JKvkIhRLPcYDKE6Bc0unvNL90/341
	OAW+U4eZvmVD4OXRm/eLxJGOdFCUYrXztKPQF4f6VP7FwSbTM9OPBXsQ
X-Gm-Gg: ATEYQzzpIZLWupAMDtlBXvVyrgP83KvMPgHJCuCHF1Wvisp1HWTjcrlx/K10xh5RO3h
	enLUBz35u8bt3oH5nyMONi0wxQtFTlAw7/4AsSPjB8Yw6/Txghi5r6n9ZgdgBs1JLP1kM6Dj7cN
	+QSE9lk1gHKeQc2aFljFcXVWxkejMli1OEgDubaX06yULl6j3a7XDXdVQLBXurtvxTNqlcSBsfc
	X3yJITEfZLW06j9402L8Vn7raHKAGALSqNGuhn5xS+PprPpIgGv9D2bVwbE9Vw/4tTi8niGn+pb
	d1rqtBQNAA78apwQQsc7sCDA6uvUIHzLmX2+sqS2YN7z2loZZkJMTZA+xz6LcIPoskSElfMwGYn
	cXUjKpQdbG1Aq5BMlnrro6tuYHEH5FUeeLg7PqKIh5egwiIgbYYquGHvUNKwrK0QDNMmCaBQVF2
	/078+wHaFUJ4P+Z0ZNNeni5wyx5hu/S68HKnkw6LuzcWdOyIEx+owP+LTuvLt3J8rhBVAj
X-Received: by 2002:a17:903:2acb:b0:2b0:6ce3:8f7 with SMTP id d9443c01a7336-2b269cee743mr46533815ad.43.1775070704223;
        Wed, 01 Apr 2026 12:11:44 -0700 (PDT)
Received: from computer.goose-salary.ts.net ([2a09:bac5:40b2:1a96::2a6:7a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b27477c54bsm6805875ad.27.2026.04.01.12.11.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 12:11:43 -0700 (PDT)
From: Varun R Mallya <varunrmallya@gmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	memxor@gmail.com,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	varunrmallya@gmail.com
Subject: [PATCH bpf v3 2/2] selftests/bpf: Add test to ensure kprobe_multi is not sleepable
Date: Thu,  2 Apr 2026 00:41:26 +0530
Message-ID: <20260401191126.440683-2-varunrmallya@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260401191126.440683-1-varunrmallya@gmail.com>
References: <20260401191126.440683-1-varunrmallya@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a selftest to ensure that kprobe_multi programs cannot be attached
using the BPF_F_SLEEPABLE flag. This test succeeds when the kernel
rejects attachment of kprobe_multi when the BPF_F_SLEEPABLE flag is set.

Signed-off-by: Varun R Mallya <varunrmallya@gmail.com>
---
 .../bpf/prog_tests/kprobe_multi_test.c        | 41 +++++++++++++++++++
 .../bpf/progs/kprobe_multi_sleepable.c        | 13 ++++++
 2 files changed, 54 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/kprobe_multi_sleepable.c

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

