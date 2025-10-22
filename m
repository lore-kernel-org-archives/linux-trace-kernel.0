Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD59530147E
	for <linux-trace-kernel@vger.kernel.org>; Wed, 22 Oct 2025 08:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761120170; cv=none; b=LYj6bV9iqpRcZGmVgcd3MboAUfLNi4IJmZ23cLn1uBkgM6TU935ylAEjGqFAnzx1CtHLwClE1QEWl7xVibc0xyU6lC0GKvXZKIbL+t1MTAl3MYpHUWlR+WWLIWgpIIuRH+3bjQaoXCJKc1JQlsYCG9+4Vwk21OIUmX+yhk6XUdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761120170; c=relaxed/simple;
	bh=rQf7cIrqXhFpdtblFtlpnVlrPiULOyK/btzySltR7Hs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PMzg0DtxatY0SsWfAJKm3b/yGzYiCdRx83aZipRb3p5g8r8PVZVOqHSReIBrCSHYnTNTwXlJoSC12P1m0RTrMJXjE1aRO7L0N+F2yf9i+M7AHtmz8+dw9QiLb/F4NNVWmnD4cbjqo8b/HFBVUZqUdaXLmDTDPSyLfrhO1YNdmIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V1mVyeCK; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V1mVyeCK"
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-292322d10feso6418075ad.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 22 Oct 2025 01:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761120168; x=1761724968; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6+bk3eU07EvQuVpjQM0cAE/sVqM0p3Ty+ZMGLS++KRY=;
        b=V1mVyeCKE+Q9LEaLKeIrx72B+GuhCR9jVF/hn52WBMOjS6j+Yt7zj05DiUAuv2M+HQ
         jCJohRUmL/Yy3qItpLMwb7w5Ca/evKBh5ZprHUVSZELj5EKK7nBVnYrO0Dpf/dlTQYvE
         aix3FA+DKj83vM/LAV5njgNFN561B1XAOW4/fGU28NvbUj9UFB6aqegXTD/teeG7oPhN
         0eki1RCmJpgBdd8dKN+tDHMT8rI0oP+YgQZyrwtD7u8sibBGTaLFtDO74ht+SySDHnbl
         YWdAbO9N7oQKecjb6E7UA2xkvyW+1wMhqCoo0JokDwDNobfKT2xniYZZJ9W9W9rAlUrx
         vnFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761120168; x=1761724968;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6+bk3eU07EvQuVpjQM0cAE/sVqM0p3Ty+ZMGLS++KRY=;
        b=gi1+3EP6sXgloBL8Lnaenyis5WVx8djqGmi3nGC19n1zFGTbn8YfV7qsJnRLvTMFo5
         ta5SDsZw4p0oAdPgCOT9OOCUFvPj2rTf3k0+HY+Ht/emr5f8E35CdVYorO7VRPdP7K45
         Lkrnywh27mawcYEFy6q99zSX9jKGOJuy3jWv1QyUJAvKdtnEnk5uDvil3Y2HxLka95WO
         VG9hF9Aq68R+/x2AJRprD095Ayc+n89IDLHeTph48mYJ3GOl8xrP8Oy+G7FqpQ5A4j9p
         SENLm55XV4HJv5kO13fxrpYuSiIfilNOGcPwpqcd38Fsrxj5qcMA/fDIkdebkGOgKFeT
         lQVw==
X-Forwarded-Encrypted: i=1; AJvYcCV5U0fstx1OAAV2DD2eNUSPYjIrOlU5QBTjmuZpvZ/iZsA7PY57+32HYVAQYGExhnLOFy1IDMwYAQlL+nzmjek4ph8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFvrS5O7OH+bcGzxNuvN1e/Ik+lyEsmKxTDLS+gOhelImuy44o
	Nkdfe1Oo3BOL9D/YZbW69abb1RnvUsLq5HQlMNfAMISUElax505A4aCS
X-Gm-Gg: ASbGncv33s3uI/OavpmVYj55vjIK9t+Bh8HNuocazibSWkwBHem0e7YFHtoiEjk0hAa
	uMs22EF8J4PLYEPuSFy3CLXV95mMWCSgL5OPM7HLlOFkL+65P5j9ZPL9Y7fpvfgo3wXvkaYo7EB
	fER8j9guVvJKtZrkzb/nzBHsJMJybGWmSrETj+8UnOJhYof4YPueiTPEBJM+q92fk1oT9dFpg/l
	zABtaoqt2/yqs8bbyl7rJ4XUUeE+XEVBZ3vZf65sdAuAM/vO9mmQ7WoCocNe0RSbdgBLazJhaXP
	vkMMovE2gwxFHwOvYbHtprR2QH0WH1i3utlK5P9rT6Yz4A8Ihq6Gld4L5S/0nTt32ZUwpgsUiUY
	Zg9Kehlt/c+87x4bXXvdXEFrKq5blW//aW/ErvF6hDmsFrW9k6k/WhRgSPaTD/LsCBKcdiyGzOl
	sya28S23o=
X-Google-Smtp-Source: AGHT+IHZbqWhKjaHa1YFzTTsX97Y9CCMc06jcvSVZQudwp5xfmvGDzbBnbpMm0kvVeibqCwk1ty0Xw==
X-Received: by 2002:a17:902:dacf:b0:271:fa2d:534c with SMTP id d9443c01a7336-292ffc32da1mr32740295ad.22.1761120168058;
        Wed, 22 Oct 2025 01:02:48 -0700 (PDT)
Received: from 7950hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-292471d7e41sm131947785ad.57.2025.10.22.01.02.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 01:02:47 -0700 (PDT)
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
Subject: [PATCH bpf-next v2 07/10] selftests/bpf: test get_func_ip for fsession
Date: Wed, 22 Oct 2025 16:01:56 +0800
Message-ID: <20251022080159.553805-8-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.51.1.dirty
In-Reply-To: <20251022080159.553805-1-dongml2@chinatelecom.cn>
References: <20251022080159.553805-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As the layout of the stack changed for fsession, we'd better test
bpf_get_func_ip() for it.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 .../selftests/bpf/prog_tests/get_func_ip_test.c    |  2 ++
 .../testing/selftests/bpf/progs/get_func_ip_test.c | 14 ++++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/get_func_ip_test.c b/tools/testing/selftests/bpf/prog_tests/get_func_ip_test.c
index c40242dfa8fb..a9078a1dbb07 100644
--- a/tools/testing/selftests/bpf/prog_tests/get_func_ip_test.c
+++ b/tools/testing/selftests/bpf/prog_tests/get_func_ip_test.c
@@ -46,6 +46,8 @@ static void test_function_entry(void)
 	ASSERT_EQ(skel->bss->test5_result, 1, "test5_result");
 	ASSERT_EQ(skel->bss->test7_result, 1, "test7_result");
 	ASSERT_EQ(skel->bss->test8_result, 1, "test8_result");
+	ASSERT_EQ(skel->bss->test9_result1, 1, "test9_result1");
+	ASSERT_EQ(skel->bss->test9_result2, 1, "test9_result2");
 
 cleanup:
 	get_func_ip_test__destroy(skel);
diff --git a/tools/testing/selftests/bpf/progs/get_func_ip_test.c b/tools/testing/selftests/bpf/progs/get_func_ip_test.c
index 2011cacdeb18..9acb79fc7537 100644
--- a/tools/testing/selftests/bpf/progs/get_func_ip_test.c
+++ b/tools/testing/selftests/bpf/progs/get_func_ip_test.c
@@ -103,3 +103,17 @@ int BPF_URETPROBE(test8, int ret)
 	test8_result = (const void *) addr == (const void *) uprobe_trigger;
 	return 0;
 }
+
+__u64 test9_result1 = 0;
+__u64 test9_result2 = 0;
+SEC("fsession/bpf_fentry_test1")
+int BPF_PROG(test9, int a)
+{
+	__u64 addr = bpf_get_func_ip(ctx);
+
+	if (bpf_tracing_is_exit(ctx))
+		test9_result1 = (const void *) addr == &bpf_fentry_test1;
+	else
+		test9_result2 = (const void *) addr == &bpf_fentry_test1;
+	return 0;
+}
-- 
2.51.1.dirty

