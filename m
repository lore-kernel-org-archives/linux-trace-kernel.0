Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A692F619D
	for <linux-trace-kernel@vger.kernel.org>; Fri, 16 Jan 2026 07:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768547888; cv=none; b=fmUKltE/q1mRQhCTWPOqkn3lQm425b24BD3RLPRM1Uet/mFOg8MQ61UwXGSdNsZ5AC6E+DQqyYF/gWDUi3iz3+9rFm7plwdvleM6R4uMO+Z0Onnnv5gAuqDzutWv8Q/p2NqRbJybaEizddDN3jXcxTrQnRcw+WD/CixLAWSP8ZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768547888; c=relaxed/simple;
	bh=EaAxHhBihNbgSpMWs6VwmPwyGN3Y9pEdX7OYsgkOQdg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dRrDlkqEyiyaYDPXZNlYx8SRXO4rcqSkvowbw7FWiddAEukwXdg15IFAgSO/rRpox81zLZqYzsXOg1PadqBdxjVSFYHbPmIfExhkHo4Gow6BkHqQ83WuVqKwLuPjg3FTO3vgJqrCaBCeM3EyVvenfOVE6A/J9sUwA7BEc08HEM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nj/uzXTq; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nj/uzXTq"
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-2a081c163b0so10017095ad.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 15 Jan 2026 23:18:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768547886; x=1769152686; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8W6hsT0Cah8oIHuXixUZEynPv/ALwNuU4vKUiOQ3rA0=;
        b=nj/uzXTq4YLSFoRTfHyQM/TJhdgZeAjN96mraSn09sBGJWKGtN4GyvlautqfKlaXBQ
         +w6bXhVYa1E7/rewQ14DP1W1CcUR/w9FO96FDFyyC8tAuF1yc41z96wAwdrMIZlVSFaW
         9VWe1qLC7ticEVdPxC1PRMcWv/FeWOMZf1nK5OFJfkUHmUgZsis0kPsxgjGyWrvB3O9x
         50vbTbVsnM++rdQhOqa8MtIxyMbG4EhgdkRrhXgg5PwxFJciQkEPBX22wI21e32ekxBp
         se9lXDqcVpRzdUOifuSEGFfv4/Atv6Ufw+XJvd6JBQdO6eZnrqvsupjFA90wWuyCII45
         kdnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768547886; x=1769152686;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8W6hsT0Cah8oIHuXixUZEynPv/ALwNuU4vKUiOQ3rA0=;
        b=XyQqB9siwpd+PBtXy/OoDI+uNGkfDbOGOfxjQqOrWHKgwfCjOGrtZCht1P0cCUxf7o
         GTUQfRxgxbfYpFzvJQrQVykXl/HBC4FS7KIpDL0BQ1EDxqvRphyhNpXJJfZVX9QET48C
         uUTRKP3J4fXMZcD1mJuEqZAM/XUsSw3es0BvIXbtgTE9g08lL6HlvDIqXq468Q61947E
         JqsSwwQ7/Geum5xet2yhsGhOlr6hW+Ci+arTwZWrgaxyRrLNCaPM12vMC3jtPFBsU+SY
         NFPken14bTGWwDTI5ncScdRxf+oltCKmhd0LYIfXRftf2tSYNI/7/KCAZ02gY9Showuu
         SerQ==
X-Forwarded-Encrypted: i=1; AJvYcCU2tn3NJellMMmjDR3bnxZBwlE1UyOu9BjiPRJ/prA1aG3Pi8VeWfIyqNangHUNkexE+eCEetiIoijz4lJUjHeBV+k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJ5IHeORw2JJRj0MMJpFIlUE8hdTfqvlkeSvZDSAhnY68lhK9j
	Eh30tKRfje87ABlIHNOAUiemrIEeVZSpO0lp/cos1zi9BfdeZrIUYerH
X-Gm-Gg: AY/fxX7cs+SS5MaKg19TOzsNuUw3z/asKyIj4L3jyqKcl2antGYbscD6WTlEdBM5N2L
	jU64vZkIQOkBkpl1fNNZL4T4CHHy6FLGe6kxgOM/VJCBIqc+B5XDLq8BCKYU3Vi48Qt5cUX5aio
	UkeLjVl2H18lAwcipCUCogGg8y6KV5tUXtAtyDadaKk7Fy2550DotvQ6NCzuAq25qKdclzdiijj
	q4663RLAfVDHg+K8qI0WfjBS2MHg5SRGViBuJp1vMhVOCZHPVOf2L+kZUROHNx0boaenOegzLPH
	skC6W8+6+cVk2fN+Q5nBe3qwGPdEWbn68Osvhphr+eqqOWQ3InNCd4krf/1w7Iv+90FcGo1sdai
	UeAIi4r43wUfvha90C+0jdxVoSYD2DNQx69s+FtPvSO1ODZs65EieWiCev3nQwqUFFhILVo44it
	7j4Cbh/Nc=
X-Received: by 2002:a17:903:41c7:b0:297:f8d9:aad7 with SMTP id d9443c01a7336-2a7177dfcb2mr18715785ad.50.1768547886068;
        Thu, 15 Jan 2026 23:18:06 -0800 (PST)
Received: from 7940hx ([160.187.0.149])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a7190ce2ebsm12508275ad.32.2026.01.15.23.17.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 23:18:05 -0800 (PST)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: ast@kernel.org
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
	jolsa@kernel.org,
	mattbobrowski@google.com,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH bpf-next v2 2/2] selftests/bpf: test bpf_get_func_arg() for tp_btf
Date: Fri, 16 Jan 2026 15:17:39 +0800
Message-ID: <20260116071739.121182-3-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260116071739.121182-1-dongml2@chinatelecom.cn>
References: <20260116071739.121182-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Test bpf_get_func_arg() and bpf_get_func_arg_cnt() for tp_btf. The code
is most copied from test1 and test2.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 .../bpf/prog_tests/get_func_args_test.c       |  3 ++
 .../selftests/bpf/progs/get_func_args_test.c  | 45 +++++++++++++++++++
 .../bpf/test_kmods/bpf_testmod-events.h       | 10 +++++
 .../selftests/bpf/test_kmods/bpf_testmod.c    |  4 ++
 4 files changed, 62 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/get_func_args_test.c b/tools/testing/selftests/bpf/prog_tests/get_func_args_test.c
index 64a9c95d4acf..fadee95d3ae8 100644
--- a/tools/testing/selftests/bpf/prog_tests/get_func_args_test.c
+++ b/tools/testing/selftests/bpf/prog_tests/get_func_args_test.c
@@ -33,11 +33,14 @@ void test_get_func_args_test(void)
 
 	ASSERT_EQ(topts.retval >> 16, 1, "test_run");
 	ASSERT_EQ(topts.retval & 0xffff, 1234 + 29, "test_run");
+	ASSERT_OK(trigger_module_test_read(1), "trigger_read");
 
 	ASSERT_EQ(skel->bss->test1_result, 1, "test1_result");
 	ASSERT_EQ(skel->bss->test2_result, 1, "test2_result");
 	ASSERT_EQ(skel->bss->test3_result, 1, "test3_result");
 	ASSERT_EQ(skel->bss->test4_result, 1, "test4_result");
+	ASSERT_EQ(skel->bss->test5_result, 1, "test5_result");
+	ASSERT_EQ(skel->bss->test6_result, 1, "test6_result");
 
 cleanup:
 	get_func_args_test__destroy(skel);
diff --git a/tools/testing/selftests/bpf/progs/get_func_args_test.c b/tools/testing/selftests/bpf/progs/get_func_args_test.c
index e0f34a55e697..4b0dc233d498 100644
--- a/tools/testing/selftests/bpf/progs/get_func_args_test.c
+++ b/tools/testing/selftests/bpf/progs/get_func_args_test.c
@@ -121,3 +121,48 @@ int BPF_PROG(fexit_test, int _a, int *_b, int _ret)
 	test4_result &= err == 0 && ret == 1234;
 	return 0;
 }
+
+__u64 test5_result = 0;
+SEC("tp_btf/bpf_testmod_fentry_test1_tp")
+int BPF_PROG(tp_test1)
+{
+	__u64 cnt = bpf_get_func_arg_cnt(ctx);
+	__u64 a = 0, z = 0;
+	__s64 err;
+
+	test5_result = cnt == 1;
+
+	err = bpf_get_func_arg(ctx, 0, &a);
+	test5_result &= err == 0 && ((int) a == 1);
+	bpf_printk("cnt=%d a=%d\n", cnt, (int)a);
+
+	/* not valid argument */
+	err = bpf_get_func_arg(ctx, 1, &z);
+	test5_result &= err == -EINVAL;
+
+	return 0;
+}
+
+__u64 test6_result = 0;
+SEC("tp_btf/bpf_testmod_fentry_test2_tp")
+int BPF_PROG(tp_test2)
+{
+	__u64 cnt = bpf_get_func_arg_cnt(ctx);
+	__u64 a = 0, b = 0, z = 0;
+	__s64 err;
+
+	test6_result = cnt == 2;
+
+	/* valid arguments */
+	err = bpf_get_func_arg(ctx, 0, &a);
+	test6_result &= err == 0 && (int) a == 2;
+
+	err = bpf_get_func_arg(ctx, 1, &b);
+	test6_result &= err == 0 && b == 3;
+
+	/* not valid argument */
+	err = bpf_get_func_arg(ctx, 2, &z);
+	test6_result &= err == -EINVAL;
+
+	return 0;
+}
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod-events.h b/tools/testing/selftests/bpf/test_kmods/bpf_testmod-events.h
index aeef86b3da74..45a5e41f3a92 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod-events.h
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod-events.h
@@ -63,6 +63,16 @@ BPF_TESTMOD_DECLARE_TRACE(bpf_testmod_test_writable_bare,
 	sizeof(struct bpf_testmod_test_writable_ctx)
 );
 
+DECLARE_TRACE(bpf_testmod_fentry_test1,
+	TP_PROTO(int a),
+	TP_ARGS(a)
+);
+
+DECLARE_TRACE(bpf_testmod_fentry_test2,
+	TP_PROTO(int a, u64 b),
+	TP_ARGS(a, b)
+);
+
 #endif /* _BPF_TESTMOD_EVENTS_H */
 
 #undef TRACE_INCLUDE_PATH
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
index bc07ce9d5477..f3698746f033 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
@@ -396,11 +396,15 @@ __weak noinline struct file *bpf_testmod_return_ptr(int arg)
 
 noinline int bpf_testmod_fentry_test1(int a)
 {
+	trace_bpf_testmod_fentry_test1_tp(a);
+
 	return a + 1;
 }
 
 noinline int bpf_testmod_fentry_test2(int a, u64 b)
 {
+	trace_bpf_testmod_fentry_test2_tp(a, b);
+
 	return a + b;
 }
 
-- 
2.52.0

