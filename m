Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4CFE3D4111
	for <linux-trace-kernel@vger.kernel.org>; Wed, 21 Jan 2026 04:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768970656; cv=none; b=E2ijMp2iw2ZlMCwun8Jlm7ZGk+f5QjyGd4Do9IKzFo9zM9pwPltoUwG0OXin5K6ZQ3uqIg1TGwpelKvfZirj4xFid+uPtHCroyv6phSKuGAjo1fhTCIZbn8JY0cAaNgXNDnZ9JsXdQ9Y2J3dai8q8ADktcvA40tVknTsp9QdDIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768970656; c=relaxed/simple;
	bh=UfYDPQ2tt5i71JPKk8CRqW3s2Ee+lt+6xD8TDc9dg4M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EK8RzlZ73v0yQQElHy8yCgXy/zFiI7VIkyRUw2ZK96Nzd3gN/8IdSr4k5fhKV2d4TuUaVUJWiD3vRKkHpGLOjtXnUZkp6wZbpZSWrl6SPFpEXBd3jTiWxvIZgiJb0BXHp0wJCtPuZS44b3+iLAQrCzADby+/DRH7svG/s6MjlBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dMyPL7C/; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dMyPL7C/"
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-2a7a9b8ed69so1484605ad.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 20 Jan 2026 20:44:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768970653; x=1769575453; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7UsM01zHjyrzsQENBFnIHRhI5E1hZndtJZVUReoZ1o0=;
        b=dMyPL7C/SnBwDGK8QJeGOsTaNTxKNUDc6AOJSCjp/oo7hQBowcxwd3a9mHCB6RPUfh
         GawXok6UbDJ4pcpwtZazTfstqR/nwL3bRNLRBbIlS587dQyIn1oWDhyoO6joAu/+c/oo
         IjjpID2g/UMl26Rcet4ZJxoR5xF2mwjNPYOlIKTygdEeWdDkygEdHun8w+V6j4DPnGI/
         obJ202gxf6JSmDI/h1oZVhB0CrugZMUdNVoITbW6/9pUpaPDgLngBsHPJcebyf/0Zgf0
         ALzbARls9JA37Z2iA9uXq6YhJO21TN2EsvpewtCuzlPGVpir9J6qDudSZmbvY8oMR8nR
         WzLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768970653; x=1769575453;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7UsM01zHjyrzsQENBFnIHRhI5E1hZndtJZVUReoZ1o0=;
        b=h9dl5CWzaz2u6Z6slL/OFgqCkutV6UTC2rd/o7PPSNS9Ocyv3Nqg4O3f6YssdpZwPZ
         APhmwCU1P0LqhXqrzEXzCuZz6dbXvO4feDyMQYigStBEX4dfmFszS1rOcM8s2Y1FTqF+
         y9KzAdKmblhliFL4yEyBowPabXImZU+380MyUkkHqoYoGG6zUmpQnz4PK0HOj3S76nkQ
         3ohdKylHk7vxs81l1I7RWSAS/UGgqATgEE1cahimZHPprDS4w6BvltEIAzwsGk3Ivh4c
         VH2QYnDhs0vZoyyE4tZpOICzYqi01HFE7gBk6ihUhBsofACUWwoALJxGyrGWwEsEnAmb
         uB8Q==
X-Forwarded-Encrypted: i=1; AJvYcCWuZLd5EB8jBr0PZqqqFHr96Fn/GOuNXU80wgvcoGuTzMwXJK1FXsBnamQk2LHAaLNdu1PNekoL98BVdvOadDIK5rk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvRIiXDWePxcva38YPJvpJqVpOF8PiLeJHPfCivsyOmu76BX3V
	DB9/4X2ct2HkUKsJl+du0Uy+ugwTNOG5W6YkPbKHxk74i6hQMr4+WGrW
X-Gm-Gg: AZuq6aLmMQGJsn1uos393Bjm2zePuRKza+tBpMSDl/ekVrJ/2VvrMRTeHwOynmdYJ51
	4GnEhlW5E943obz3z1UQ/CRa0V9NkW66ilU/AT+XMSQHnfhyvgK4YbtVEBSS5d0jUHj4u9Tjra4
	apOy0m67fNenrdQ/vQT9w+bxiqVjQ+gbGkyHUOsx8ZfeiBo1W2OcujSmYuCp4t9/haIdMrTE/N5
	G5uTon+trT8g6EzwsC6gfO1Wdzby/tK8JP0U9H98qXkuFyQPGLzo3NDekI8DzgtUiGPM+a2HYF9
	93JE1IMz9qjSFfFRPn2fbDJSPsV8ln5Se5yRXOA2nwA8WYli64+WVE51CGkFPE8Vb+aKBAHaujU
	4iX9URyMhfHRJKumy9oFla2izxYOFlRL199YkDRgGFXXEOydOBqZabjRJduqkp1Q+B+fjGh66Kt
	DP8LkvwTrqHUsnW2c39cY=
X-Received: by 2002:a17:902:fc85:b0:2a1:deb:c46c with SMTP id d9443c01a7336-2a76b055c47mr40973005ad.44.1768970652999;
        Tue, 20 Jan 2026 20:44:12 -0800 (PST)
Received: from 7940hx ([103.173.155.241])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a7193dedacsm139754815ad.58.2026.01.20.20.44.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 20:44:12 -0800 (PST)
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
Subject: [PATCH bpf-next v5 2/2] selftests/bpf: test bpf_get_func_arg() for tp_btf
Date: Wed, 21 Jan 2026 12:43:48 +0800
Message-ID: <20260121044348.113201-3-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260121044348.113201-1-dongml2@chinatelecom.cn>
References: <20260121044348.113201-1-dongml2@chinatelecom.cn>
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
Acked-by: Yonghong Song <yonghong.song@linux.dev>
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

