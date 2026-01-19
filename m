Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 364FF2459EA
	for <linux-trace-kernel@vger.kernel.org>; Mon, 19 Jan 2026 02:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768790277; cv=none; b=YffaHB/RSMty+AjENK26yOyima7+BlN64fQJ3j6E4fAQBoFucMMF1/NBfMVVG10PsejUhjKA1o8sG40Iy3O5KXdhwnv21kHDrzmydrDKLaTTyYe88RQGHss2ijoelQ3tfx05OG5GCtw84VVtuSdCZHl1ByOvJrVvOkbqK11imRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768790277; c=relaxed/simple;
	bh=kZiZh0VonzvzITLYzvii4c3vY29P/G7ZGQFYENdQFRI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lAVYLyN1upeEuYlp7aIkOrJ2FMGG49oZu1ChnomRxTvcB62GEm5boTzF5Oyw9GYIYAwfsMRsomxKLvpaS9vzscTjOjIZWEM1A5Bo6SlIKCnIcMnW7v32rwqR7jpUX6s2MdawvcQzQnszP2YAfXDFk4lmnzzoOxl5xyBT8eDb+mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PhIbTEk/; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PhIbTEk/"
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-2a09d981507so28164335ad.1
        for <linux-trace-kernel@vger.kernel.org>; Sun, 18 Jan 2026 18:37:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768790275; x=1769395075; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UxUe3zmQnPe+Di1h/wXJv+xTJZBq3RUkZe5dfyWfsD8=;
        b=PhIbTEk/ZFNkyY288W7whA2Og2xdC8yDLcHscFrVV1TAEYuYoCbzk4eX2K0Ud/iUUj
         A3MeBehh45bixl6ceJso8lIMBzxGUuHQdkJI6CUJMDhZK9hf5t8xF4DA4o9k6gKNjMNu
         oXmsu9v3zAobp6/+ppH9Gmty4SnCFNtuK/0sGbc4flXrspPGk2jYBOianXhyOMEw4mIH
         Ggk2H3ja3tml/EDO8WMKwNAeTkvyUajVs0i0kuATzKmwtFHB2Of4gwZy1UZtpy0Kr/mj
         Vw+uY7KW1m/+hO8EpvNzC+PzeTE3LU/gMCljKS+99f1ZQb+TY+Wlm5lu2pWrJ8warIeC
         0zQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768790275; x=1769395075;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UxUe3zmQnPe+Di1h/wXJv+xTJZBq3RUkZe5dfyWfsD8=;
        b=vCJ+HXeH1LdFpaxkVVwn338IpmMHp0T2+QaAx5d/y4r9w6XlmfO9hWiOe7OAi6m/MK
         kpNxC/ZkEb+9drkDN5CFYhxp9mTFmU2DlEP69Yhp89KykVMkTFY36xXp/47hLT1DRAgU
         wpOPBB11RkoTLo0RO2rLOh7kIFxgVPkyemierwOmUosu2wuf/tsi8RRyKI5AjhwmesGk
         i/nw8Irhun9MketDLHxeBu3saNmxb30WfODwOHkUaaNzAQnWFUxrlnjC6Ay3/rojSzqe
         cVTH7PlBeJS9sabkxth5+ucBQvs7Y9C2DbDiBYyT214BUtcxUJ0K9WAucNzAbcs4knxn
         ufjw==
X-Forwarded-Encrypted: i=1; AJvYcCW8nhovyTA3z1J0bUg5DpVXPz48aytcKEpotEffKQaTMeTBG6OsRL5SWw3kssj8caaahS8nrtdJAOz7HeLxOM7ciNM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBh2pJyKORMZNHWWbkIUK/3jj+J66tLGnxtLpvd/XR1P6yyX1A
	r0cmvpDB3lqjl4HeV926aahveCizWzLc6wbvwzp8nonCdVd7NLvsp5G0
X-Gm-Gg: AY/fxX6PD32SzQWS/scl5iyniBe452kNhegZ51c1dwcO4COvEvqgRxJ4vPHPZNefQE8
	+953YMBdUoH/UNc5Y54nRqqdpIh/fRcPfoMVU02eI8BRKqa1fQNbKc9FCagGvWCXAz2i3wW5jo3
	Jbpk7vSi28US/PiYN5NsNIQ8VknBDo2u+MOds87PTM5nWYjnirCAP2jqYiAl83W6yIBf0BJZf7g
	iz9WgiQ/eTTd0MLBT9iYaXq7uUCkX3+5ZeDzivPXTugcu36PIWPnRlWMbi1i+Cc5SyBuL6AH7Mv
	n4Yi8VdFHIhTbS0Fb9SieJY/rvKeUeyoTTXHCYPFttXJXfT6iiXL/I+44QJnZSOYlrb5rIDaeao
	dqo1W5QG8kCmBIPpLR1ASlGVr13z6cknEt5XMsm1aaW/i4gOwkIGBuX4lFKiLYOZ7Ko7hr1vARQ
	unuwagmj+2
X-Received: by 2002:a17:902:ec8b:b0:295:55fc:67a0 with SMTP id d9443c01a7336-2a700979c0emr139334475ad.2.1768790275428;
        Sun, 18 Jan 2026 18:37:55 -0800 (PST)
Received: from 7940hx ([103.173.155.241])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a7190c9ee9sm77154645ad.22.2026.01.18.18.37.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jan 2026 18:37:55 -0800 (PST)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: andrii@kernel.org,
	ast@kernel.org
Cc: daniel@iogearbox.net,
	john.fastabend@gmail.com,
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
Subject: [PATCH bpf-next v3 2/2] selftests/bpf: test bpf_get_func_arg() for tp_btf
Date: Mon, 19 Jan 2026 10:37:32 +0800
Message-ID: <20260119023732.130642-3-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260119023732.130642-1-dongml2@chinatelecom.cn>
References: <20260119023732.130642-1-dongml2@chinatelecom.cn>
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

