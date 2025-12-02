Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25D32302CB0
	for <linux-trace-kernel@vger.kernel.org>; Tue,  2 Dec 2025 07:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764662100; cv=none; b=q7uYAQFxeCENT0qwexuivpGxcl3WhS4b3iP18T9R/UoXnD8IKja730bic8uCaQFd3vJ9XhBkDbrnKw3OpAWH9SsyV1ScKRXqEXWXsD89teGBuDpr2PyKwz26IR98Lpch2VPZJUjxt02NsgfC4X37F0Ism7VcUoX+FG6BpgQmXgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764662100; c=relaxed/simple;
	bh=kyTtfVPyqo4WaueoH4x+WDK8bxFY3WrcN67Pgl/mPRM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=g+HJ2CRUuamkylBesPPyYk8h4hiohW4elZrDcXidw50J9x7ASrh96XW6yFbxKCvy+37uN8chGYq/k11HdEfOeRSr3JgbB+qvbXnbBpMya5qZqrx9mwxpp7lLreuSrrucWSXYLPzkx6RP6PLjXJzNDdeIuBDctt4uqXoh9pgBb9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NbOpdHIP; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NbOpdHIP"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-78a6c7ac38fso54247927b3.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 01 Dec 2025 23:54:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764662098; x=1765266898; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9HL+1MzYvl7+tplIAo6lCWeY0ZFqhV9UOUFQuiT16Mg=;
        b=NbOpdHIPyIVWkk1MQb865Ga0I3083/OWeiKX0wE0wVdwBzAet5UvLc159SDOhrhmxq
         gyf+nKdAN5p2BTj40OLomddqjJ9XuE1yDewTD5SCWsEmxKh65p0lME+yhaG7p/oyPD/D
         uVYJW0OfyST3SOnyXEnbPuUkGbajoawwToCG+nX0encEqAZr3qFj9DRqaUmzxjekvNdj
         A8NlE11nHEXgN2BwtpRDLDei5Pzp6ZlCevfJsWFw1Zki4NTKtuoqFDNrTDHr077SBjEa
         fIWXZhAWVt+3X8rG+mAsNrheQYNcDMjLomDoJiJfyrl0316sYISRlQAEscglsqvY8pZX
         SwZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764662098; x=1765266898;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9HL+1MzYvl7+tplIAo6lCWeY0ZFqhV9UOUFQuiT16Mg=;
        b=LN5tSvz6WZI22wlx4qEx0y+abH1L51uzad5LbiQuHHo1xkECrhvw3mDZZLiqIgwfd2
         nmlJ1v8bs3S5JQe9tkbjJxhPpicAvTJ5abprnKFKUIlAjH46S0N6yqaw3nJp8B4xvRKy
         g7VhJgrC6IgSG8GgcyALycYrxfhL1VvKW6Bcq18cy0sseAD+uW04GUIvbWJoJWOcvWsw
         DZCrT2lHpjPXUkkmKaqcCSAiXgPcL6fz5pNfRtq+J6u3oq+TfpWmhdvAa6lKxFWmOLxU
         RcEuYkDKF0s6EGKDof+nDkfAb+91G2SlQw8FHsQSweUmvNYwCiH4FqehFaGUx1jtFlvM
         l1UA==
X-Forwarded-Encrypted: i=1; AJvYcCXSGAMdWweqNfBDkbAKO2s7oZyQGP34YqiIEuEabNdTcj0GuDXm6FTgKNhhX7kRpMnQT8BFIO1sk4Wjmfgk8zqiSTs=@vger.kernel.org
X-Gm-Message-State: AOJu0YylqarMiCiyl7eGhqXPyzwfuF28VCKH/teVZyfEZezJyZqmpdJl
	1TJ8rSykISXc3aMBWy/F9REtFMjjl86/KRpfitH9ajQ6JVy2rqUoxNeW
X-Gm-Gg: ASbGncuR5DBldq3SjWJNpsfDKJLV6hMZyscGIjoLK/owpk+fsLIg7Uqk1E4PGLms/9Y
	Y5XAdSvwfG0+Z4BuP/49kN1n47Ezr6DOiCLWukw0wPzYZkxkYmE4UgHmdvlxvSRlGFIbFXEggt4
	vaW4kp8TyNWuVhZifXKPSCLc9ErjeDP8Kfq2eKbb2KUNSSugfORdm8zRnKBe5ck00FkO1EFD19e
	K3KpL/ELk3GUTOApKjM9ZOX5y29WdTeSK9Aa1HbzzZWiavQ/LyNAN7XclcQ2G1lxb7yDljiV+u0
	6uKgtGKGeJwwOHtV4hbCBVjJIi/ZpBEYZp6gewXQYVgwYm9v6ojyYxuej2GcWfYcJBY8hBmDhyZ
	90uqe8cG3/NMDfoe5CwUGyC6FmsWpKuqinYGPpaaHFcZ8HZrK98GX3ca5J61ahdhM1TABRzmcqM
	1/K30jkKETTsZmSIj/uqnSqZpEphupbESEtY8j60ohs6G54MAEKh4=
X-Google-Smtp-Source: AGHT+IHYFszBo6ArLl+E3lTGk8xWpJ8CaGWtpce3cqenGwdU5nNL0vqJKRlijuCx3cW1rCiiTx5D2w==
X-Received: by 2002:a05:690e:120c:b0:643:1961:c600 with SMTP id 956f58d0204a3-6431961c686mr29024639d50.2.1764662098134;
        Mon, 01 Dec 2025 23:54:58 -0800 (PST)
Received: from localhost.localdomain (45.62.117.175.16clouds.com. [45.62.117.175])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6433c050d98sm6008225d50.2.2025.12.01.23.54.53
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 01 Dec 2025 23:54:57 -0800 (PST)
From: Shuran Liu <electronlsr@gmail.com>
To: song@kernel.org,
	mattbobrowski@google.com,
	bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	electronlsr@gmail.com
Subject: [PATCH bpf v2 0/2] bpf: fix bpf_d_path() helper prototype
Date: Tue,  2 Dec 2025 15:54:39 +0800
Message-ID: <20251202075441.1409-1-electronlsr@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

this series fixes a verifier regression for bpf_d_path() introduced by
commit 37cce22dbd51 ("bpf: verifier: Refactor helper access type
tracking") and adds a small selftest to exercise the helper from an
LSM program.

Commit 37cce22dbd51 started distinguishing read vs write accesses
performed by helpers. bpf_d_path()'s buffer argument was left as
ARG_PTR_TO_MEM without MEM_WRITE, so the verifier could incorrectly
assume that the buffer contents are unchanged across the helper call
and base its optimizations on this wrong assumption.

In practice this showed up as a misbehaving LSM BPF program that calls
bpf_d_path() and then does a simple prefix comparison on the returned
path: the program would sometimes take the "mismatch" branch even
though both bytes being compared were actually equal.

Patch 1 fixes bpf_d_path()'s helper prototype by marking the buffer
argument as ARG_PTR_TO_MEM | MEM_WRITE, so that the verifier correctly
models the write to the caller-provided buffer.

Patch 2 adds a regression test that exercises bpf_d_path() from an LSM
program attached to bprm_check_security. The test verifies that pathname
prefix comparisons behave correctly with the fix applied.

Changes in v2:
- Merge the new test into the existing d_path selftest rather than
creating new files.
- Add PID filtering in the LSM program to avoid nondeterministic failures
due to unrelated processes triggering bprm_check_security.
- Synchronize child execution using a pipe to ensure deterministic
updates to the PID.

Thanks,
Shuran Liu

Shuran Liu (2):
  bpf: mark bpf_d_path() buffer as writeable
  selftests/bpf: fix and consolidate d_path LSM regression test

 kernel/trace/bpf_trace.c                      |  2 +-
 .../testing/selftests/bpf/prog_tests/d_path.c | 64 +++++++++++++++++++
 .../testing/selftests/bpf/progs/test_d_path.c | 33 ++++++++++
 3 files changed, 98 insertions(+), 1 deletion(-)

-- 
2.52.0

