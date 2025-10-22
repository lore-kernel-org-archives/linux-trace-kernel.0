Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D71DE2FD7D3
	for <linux-trace-kernel@vger.kernel.org>; Wed, 22 Oct 2025 08:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761120133; cv=none; b=Kxirclf9WfeRlkICMj9HRwUlSZOpDQxnTG8eXHmNsaCsX6ytmGPoBvscgDckYNmJhBZ3nt2OovGJI9U90871Jj/Zy7TwWrCopMeXYlbjfR3IssQTCrlFgL7soHdLGRfYUsvRjc9yhRcIB2ptPA5aAdBVVbsrN+BK3J4SGa5aftQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761120133; c=relaxed/simple;
	bh=KES1rqhhzVkWHCaQsx5xIA87TR29YUXJ/eVpvlSxQpY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YDykIhS7oOTMnFpMsY02XboQKPFA/3QR704mQrjSFzCqe+qrHF0BHsBDgRVXdkMBTNzob7W6h0dUfot0gFEg2SfUcYuccwHIpNDj+f8a4NmDbZG7+VZrAqwNsAW/vruPM5IiIXDF6Zz5kPQwLScjS4/+E9vv34XgsH4ynG59SvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LNpOxUlk; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LNpOxUlk"
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-290dc630a07so35525585ad.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 22 Oct 2025 01:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761120129; x=1761724929; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8IULEjah58/8/ttFr7hd4dbKkGYaqM5HUaRTvDTqwJA=;
        b=LNpOxUlkLx6W9UIs/CKAvDGW1SsciwZUL0sK46l9oxL3wTNyFT6Z1End3h5mTQ8TX1
         +7XeLsPXOXHed5O4WYtogL6Z5YB8aUJWEyna8m11RnxAD08qTbzXgDEHdwGTLj3Yrzuo
         vBjcJv1SZM5poDElEVyC3y4nACyuwfUGkeLWDaBWuDuDtG95BsKz4a6zCssp+tYn0r/I
         F0fK0VLZaTCWk9cWehJ8dFewGArLaiYZAmkTsJj1vc7GPTPwa3gftQE7MkdisIoVBY1U
         Um+7HWtIUeKbD1Ekhu/z0t/lc3vtKBlsqS2CnKIySGX9XKfoZ4caET6HuaOXQpnLJZGW
         1phg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761120129; x=1761724929;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8IULEjah58/8/ttFr7hd4dbKkGYaqM5HUaRTvDTqwJA=;
        b=bAexfUMGGss/1IcqsqPEAx/F80NY7++7FJqsFUkg8Xs19/dK0TqV20YaHrBLQ+bN9f
         YC/NjWNg+N6vhuZRj0fqm5bcCfeZl5hZzsTn2+40w45gFW9t/pfaF48uasnGHT25641o
         i69llLTm6YTXqNEgJyXOswhQJrPO37zzNf1faS8huuXP0KZC1pYfkq65TqyOoNm4Zv/o
         9swZjazmm1gow3+Bag14YmglveVC7nJvDX7DGS2CCb88BzeVx0OkMbhot37Sv8gIOb0i
         tIzXTTzBw2GEuLcgVZtqIHykCgWbdvNkoEuC7weHAxdkNBVAGNwALRMP4wG3ZlyMzzJz
         sGUA==
X-Forwarded-Encrypted: i=1; AJvYcCXGcFmFzDGi9LoyzxHFtJqurOORniUICttuUx0Ld9hLgZ1mys1k8t5sVunF0/ub/rp5CauoCdhE4FtFBbR80ykwFM0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdPe4JvXzxMWFKfBaz1JjPO66kt9gbwB1lDVLM+KrrLKAt46pr
	gehfv9kY36bISb/cOSiVbTv2yyAT2lTTg+rJPo3XcSozTYuZRNFbhXZY
X-Gm-Gg: ASbGnctjxPJ9UhleULW7Qpv+lsJ/pe86D3+XSTPZUQ3kq+YSaPnBLyLzUZtR1gIZEf7
	h3as9POUyt7MmlnzwZfQhFrriq7a6xcjW9iP+/YLJdKdUHRz5C7EHk63GkBwlAWlf1Mz/j/5GJ5
	mfqsJMAZ6d+jcyQ7E/CTAncTvwng2ER+oPMMGwVcOUWrCfctdTp12BkaEc9A2s5vqrLuwxUa/pk
	KsgGQ2mVn0vxkgQnnkvbpJyI3GCs6jRyfU/oLF6KlE8+lofC2m4pZjFV1G/hhUQKEn9cGqVlsuc
	aoaAMSvNLS58LOsGSbzJHkdU3La/h4Qmxmx3y1MkHjQ4Zb5vTRsjRSu0KB0xE8Oc+5igDdvSjDN
	MicdLtCWCXUba5A9hyK3IfZEBEt9GefLdoS6gJH7A71sURG+RRBJUCeBU9Krq9v6zCVKlDXU4rX
	zuRgaJoag=
X-Google-Smtp-Source: AGHT+IHUvFNEb8ueoRDJavJW321o3FS33gCYT8NQTFkfClnVpzJ7UDlFH8bs4uMSU13s5U8IClXzXw==
X-Received: by 2002:a17:903:244f:b0:261:e1c0:1c44 with SMTP id d9443c01a7336-290cc2f83a5mr263831745ad.40.1761120128951;
        Wed, 22 Oct 2025 01:02:08 -0700 (PDT)
Received: from 7950hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-292471d7e41sm131947785ad.57.2025.10.22.01.02.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 01:02:08 -0700 (PDT)
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
Subject: [PATCH bpf-next v2 00/10] bpf: tracing session supporting
Date: Wed, 22 Oct 2025 16:01:49 +0800
Message-ID: <20251022080159.553805-1-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.51.1.dirty
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sometimes, we need to hook both the entry and exit of a function with
TRACING. Therefore, we need define a FENTRY and a FEXIT for the target
function, which is not convenient.

Therefore, we add a tracing session support for TRACING. Generally
speaking, it's similar to kprobe session, which can hook both the entry
and exit of a function with a single BPF program. Meanwhile, it can also
control the execution of the fexit with the return value of the fentry.
Session cookie is also supported with the kfunc bpf_fsession_cookie().

The kfunc bpf_tracing_is_exit() and bpf_fsession_cookie() are both inlined
in the verifier.

We allow the usage of bpf_get_func_ret() to get the return value in the
fentry of the tracing session, as it will always get "0", which is safe
enough and is OK.

The while fsession stuff is arch related, so the -EOPNOTSUPP will be
returned if it is not supported yet by the arch. In this series, we only
support x86_64. And later, other arch will be implemented.

Changes since v1:
* session cookie support.
  In this version, session cookie is implemented, and the kfunc
  bpf_fsession_cookie() is added.

* restructure the layout of the stack.
  In this version, the session stuff that stored in the stack is changed,
  and we locate them after the return value to not break
  bpf_get_func_ip().

* testcase enhancement.
  Some nits in the testcase that suggested by Jiri is fixed. Meanwhile,
  the testcase for get_func_ip and session cookie is added too.

Menglong Dong (10):
  bpf: add tracing session support
  bpf: add kfunc bpf_tracing_is_exit for TRACE_SESSION
  bpf: add kfunc bpf_fsession_cookie for TRACING SESSION
  bpf,x86: add ret_off to invoke_bpf()
  bpf,x86: add tracing session supporting for x86_64
  libbpf: add support for tracing session
  selftests/bpf: test get_func_ip for fsession
  selftests/bpf: add testcases for tracing session
  selftests/bpf: add session cookie testcase for fsession
  selftests/bpf: add testcase for mixing fsession, fentry and fexit

 arch/arm64/net/bpf_jit_comp.c                 |   3 +
 arch/loongarch/net/bpf_jit.c                  |   3 +
 arch/powerpc/net/bpf_jit_comp.c               |   3 +
 arch/riscv/net/bpf_jit_comp64.c               |   3 +
 arch/s390/net/bpf_jit_comp.c                  |   3 +
 arch/x86/net/bpf_jit_comp.c                   | 214 ++++++++++++++++--
 include/linux/bpf.h                           |   2 +
 include/uapi/linux/bpf.h                      |   1 +
 kernel/bpf/btf.c                              |   2 +
 kernel/bpf/syscall.c                          |   2 +
 kernel/bpf/trampoline.c                       |   5 +-
 kernel/bpf/verifier.c                         |  45 +++-
 kernel/trace/bpf_trace.c                      |  59 ++++-
 net/bpf/test_run.c                            |   1 +
 net/core/bpf_sk_storage.c                     |   1 +
 tools/bpf/bpftool/common.c                    |   1 +
 tools/include/uapi/linux/bpf.h                |   1 +
 tools/lib/bpf/bpf.c                           |   2 +
 tools/lib/bpf/libbpf.c                        |   3 +
 .../selftests/bpf/prog_tests/fsession_test.c  | 161 +++++++++++++
 .../bpf/prog_tests/get_func_ip_test.c         |   2 +
 .../bpf/prog_tests/tracing_failure.c          |   2 +-
 .../selftests/bpf/progs/fsession_cookie.c     |  49 ++++
 .../selftests/bpf/progs/fsession_mixed.c      |  45 ++++
 .../selftests/bpf/progs/fsession_test.c       | 175 ++++++++++++++
 .../selftests/bpf/progs/get_func_ip_test.c    |  14 ++
 26 files changed, 776 insertions(+), 26 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/fsession_test.c
 create mode 100644 tools/testing/selftests/bpf/progs/fsession_cookie.c
 create mode 100644 tools/testing/selftests/bpf/progs/fsession_mixed.c
 create mode 100644 tools/testing/selftests/bpf/progs/fsession_test.c

-- 
2.51.1.dirty

