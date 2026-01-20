Received: from mail-pg1-f195.google.com (mail-pg1-f195.google.com [209.85.215.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB423A782A
	for <linux-trace-kernel@vger.kernel.org>; Tue, 20 Jan 2026 07:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768894277; cv=none; b=Bb4ANr9IFzoBewKJbyjLn9w0R1RIIFsKPW5eL0S3kGfGBAl+TuCqlQfLmv4xnC6psxUCxOerNXCxcjCK4v5DrMCZ80yI7CJ+GPKuq+WcoGWLPGDTydu7ZHLRwCT1hQsd5/K6dxzZ41Yuy+Wafaee5RuSRLqj2WwG4ZAUZM5VV3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768894277; c=relaxed/simple;
	bh=kZiZh0VonzvzITLYzvii4c3vY29P/G7ZGQFYENdQFRI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kEP3VfLZk79oQdcScw85xLvf+KO1nYMsmavd7CdepTJfZEGVxPJsuV3wH5xs8JstzSEfVQMuIu8+Zc8r1u3/yOBd8oNHKXTUyOlEtFCVwCJ8L9x5E1CeTyXRRQNs+Suy4Cen3gr9UGbqvayt4AIL+XE3BDEa9MoaZscqaXVr+14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lujhPUPm; arc=none smtp.client-ip=209.85.215.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lujhPUPm"
Received: by mail-pg1-f195.google.com with SMTP id 41be03b00d2f7-bc09b3d3afeso1884070a12.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 19 Jan 2026 23:31:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768894275; x=1769499075; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UxUe3zmQnPe+Di1h/wXJv+xTJZBq3RUkZe5dfyWfsD8=;
        b=lujhPUPmoO5KBJzWj04R73Gzom9CH9yyg2bTGrtHQoKUjI8hyKPMo38yIXAjFeZ7Dr
         hhyEMo+PEU7GdBYwRvgXpBbTc7T3HfifCxeh/i23JruBoTdXx/y4RpSBwOHc8h/f+A0L
         HJ9F16wH7Y1QuyNnCoun8dzk//Mk76qe8NIP90uFVcMMkSmxyPLP4SZLueubq2/02+dp
         vLd2w4NJL9BRnguImXvsafN8oMamL9Pmr5WvWMjR31r4f8mTvsOty6aHNSxEwNrtCEkm
         LkUXGQLZQY4w7YO7H+hNs8p5hxmNsDo29F2tfR0+WXPRhvtakb7Y9El1ptU6s5Y2qntQ
         BrDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768894275; x=1769499075;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UxUe3zmQnPe+Di1h/wXJv+xTJZBq3RUkZe5dfyWfsD8=;
        b=SvMlgkgF30B9Ffq8Yvd9HeeoGS/yNfTFdqcC4m+eQuLkoe9o7gUGwAb04hVgLb7R8t
         UNegRdcNhqH5YUfq0U2cGgwCXFlfh99Umf2mv3kiWjBfrzChi/X1TDoKk5bXkbHhHY3T
         Dj1Dm0JChdW5bBHhtJcV+SP1kykQNxusB2P7b+Z2raXdwgoEyC2B8FGj+UnIxmaf/ZGR
         LCabOLs6Cz3ozxCDm3hduKkaacPVF6Ch59UaSiD+W6u0Z6AaTUjeWCSbLDt3KJ9crPsz
         JyhgFdD68zfE6rLqomuVrAgvmmpTn/1OpXSBd4eUYWtioSWurbQLWUC6HctBmF63tg9T
         CpJA==
X-Forwarded-Encrypted: i=1; AJvYcCXN3StpzLGPF3E2svQzthPABtQqaXNDXJoJKP7ZRCjy1P9R6xSr9BiuPOkUMoWJRINSJtaa/Wy4ayyqQl8QompRbFc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5Pn8E0pew46grr/JPPdCJykdSWO50TDI/HBm53J3t9ktp9qg3
	+Eyvfx4514JZ41sUTHMixlxGqEWrrJBFncAuc0iEwcMKvHJn5EdoalZB
X-Gm-Gg: AY/fxX4C/u2nC04aoXr1eZ9h82OOF+1UZh3Y2gFCPDCGtW7HS1K+s+wFcrk4CQUa4o9
	wkTx9mhbvEVou2+dGNesmNfZivj9x92hxBmExHu+l6kytU3HLM2ugVpVyYTFvZbocwWtBm/1wu4
	mZXghTwo/ffEgsbLiDO2JHTWOrxetyHh0zIQq0AciWP5dx7pcjZvWmej/+h7U+46qAfvIoj9IR5
	1JBMx+IFyvsWL1rls/wh3m4CKbUvlbeRsbQiRDXhfWKhyQYdpEmSGBkSsH9kMzzaJyjv2FtELpy
	A+QWkDMuEYYg7J2uJhIZxszKzAVZjrtWB/cWOoTZVtEVvmwbwz33usVdpwAGkIjo/8iEsBQuQ1B
	exLTN52r5wU2RBd3yp8HR0238nODN2SYZhLXnFITM3YWFYu005oQo5HfqrcO2xMSACyQ9eE2usc
	ARh8XYuqYr
X-Received: by 2002:a05:6a20:12c6:b0:38d:e6f8:fd8c with SMTP id adf61e73a8af0-38e00d7a500mr10849339637.67.1768894275097;
        Mon, 19 Jan 2026 23:31:15 -0800 (PST)
Received: from 7950hx ([103.173.155.241])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c5edf2363e5sm10822395a12.4.2026.01.19.23.31.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 23:31:14 -0800 (PST)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: ast@kernel.org,
	andrii@kernel.org,
	yonghong.song@linux.dev
Cc: daniel@iogearbox.net,
	john.fastabend@gmail.com,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
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
Subject: [PATCH bpf-next v4 2/2] selftests/bpf: test bpf_get_func_arg() for tp_btf
Date: Tue, 20 Jan 2026 15:30:46 +0800
Message-ID: <20260120073046.324342-3-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260120073046.324342-1-dongml2@chinatelecom.cn>
References: <20260120073046.324342-1-dongml2@chinatelecom.cn>
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
 .../selftests/bpf/progs/get_func_args_test.c  | 44 +++++++++++++++++++
 .../bpf/test_kmods/bpf_testmod-events.h       | 10 +++++
 .../selftests/bpf/test_kmods/bpf_testmod.c    |  4 ++
 4 files changed, 61 insertions(+)

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
index e0f34a55e697..5b7233afef05 100644
--- a/tools/testing/selftests/bpf/progs/get_func_args_test.c
+++ b/tools/testing/selftests/bpf/progs/get_func_args_test.c
@@ -121,3 +121,47 @@ int BPF_PROG(fexit_test, int _a, int *_b, int _ret)
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

