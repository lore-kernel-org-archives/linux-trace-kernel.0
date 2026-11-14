Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.244
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794668787;
	b=NgOOW1FVA0sjV/az4yMCD/eCK7zyGAz0J9evo0ZPSgoUOXm4EzyTFXFKLmgFN2YA07nA
	 FI8As0lydh9s5Mx9r4DD8jLCh8fxJHjHsA/HqrzOSPTiI4LI69mxEEASXTiN+sAVVxSMf
	 lB7gte2zShyKWmEYysUH6WQdpUM2ETqXYp+/quEyaSJWGZDraQVkiJK/6oPzQIPVMxkgx
	 aVJJOw+4NzKbX92ldM/OCUNDF4kpUf4hiLE6jtM0Nze8T/TjLFjx7XdnlSNQ6ENFujjft
	 apW6m1CV25S7MKNkPfy9JAe5vmDArjBFcXQU13iE+LjoACPpv5yFYIl++mnNUpT74gg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794668787;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=GqVfe+gMMe0HOFEnoFcjKGVxfj+tUTB2vMVxeIhcZK8=;
	b=NiAhyd74uYW+j9WimV7SJPO8QSrSgmLnNUEAwaMWB1NgksCCwXsYp2PEdG1kYjWnNjR/
	 dVpslG0n3EV0/4u9qXJdPNtTuQs1WydzuJSXNfH5UYndE3Q8V0X7z76fwbhyUPtGeQbjn
	 856S4h4zhBALjivTZ6mdC5CUr9rlybaz6RrQxFlmkAUiMn0NVlptATDuodoFXWhQ/o+7+
	 oEadhJVFnAomydH1qHTiATZAEemQmfMCSAJPH4t2UHja/Tu92KNVl/qowP/9qGFKZt6Y5
	 06kyqQDmrR2DCSjQn0HqnjIWVg8OiZKnpbaCyihzdrXN5tQdEXusxoawcO1N3yMBSUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b="ab/7ZlsT";
	arc=none smtp.remote-ip=91.218.175.244
Received: from mta0.migadu.com (out-244.mta0.migadu.com [91.218.175.244])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9B97606A327
	for <linux-trace-kernel@vger.kernel.org>; Sat, 14 Nov 2026 15:06:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A9B97606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=ab/7ZlsT
X-Envelope-To: linux-trace-kernel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=3EHbdy83rCpwpfT1fsnCR8rbfvn0CmloPXzAcMGse/I=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794668783; v=1; x=1795273583;
 b=ab/7ZlsTtiVY3VB3DcqUDjUiGrLBdgSEEQTEZoaETB8zKE925WeOA9gI0qnKv+BmMt2NIJ94
 /zeKbLuHocWwAOSZ0BQJB9CMzTwIpURnaKXhos6P0mWtRfB7IbU069drQAeJeZV1UDLqQG8BKpw
 bb9atwlvvcbLVQymyyWrYjb0=
X-Envelope-To: linux-trace-kernel@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 5012754fb9425d27;
	Sat, 14 Nov 2026 15:06:23 +0000
X-Mizu-Trace-ID: 5012754fb9425d27
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
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	KP Singh <kpsingh@kernel.org>,
	Matt Bobrowski <matt@bobrowski.net>,
	Shuah Khan <shuah@kernel.org>,
	Leon Hwang <leon.hwang@linux.dev>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH bpf-next v2 0/9] bpf: Add log support for tracing link_create
Date: Sat, 14 Nov 2026 23:06:01 +0800
Message-ID: <20261114150610.84507-1-leon.hwang@linux.dev>
X-Mailer: git-send-email 2.55.0
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I'm planning to add syscall common attrs support for LINK_CREATE cmd.

This is the second series for the plan, that adds syscall common attrs
support for LINK_CREATE of tracing prog and cgroup prog.

BTW, address Andrii's review [1] in patch 5:
1. Change if (!OPTS_ZEROED(opts, iter_info_len)) to if
   (!OPTS_ZEROED(opts, log_opts)).
2. Add comment to iter_info and iter_info_len that they are
   deprecated, and use iter.info and iter.len instead.

Links:
[1] https://lore.kernel.org/bpf/CAEf4BzbW4zwL-9j8e2B6KNXVNwsfWyMSAo_RsGCqv-nu_yGhTg@mail.gmail.com/

Changes:
v1 -> v2:
* Add log_opts support for bpf_program__attach_iter() API in libbpf.
* Add test to verify the log for freplace max_ctx_offset case.
* Update a subtest to verify the log_opts in bpf_program__attach_iter()
  API.
* Add log for freplace max_ctx_offset case. (bot+bpf-ci)
* Drop unnecessary bpf_verifier.h include. (bot+bpf-ci)
* Change log to "Invalid tracing attach_type.\n" when the link
  attach_type is not prog->expected_attach_type. (bot+bpf-ci)
* Change BPF_XDP to BPF_TRACE_FEXIT in tracing link_create test.
  (bot+bpf-ci)
* Drop dead iter.len check in libbpf. (bot+bpf-ci, Sashiko)
* Add OPTS_ZEROED(opts, iter) check. (bot+bpf-ci, Sashiko)
* Swap log positions of iter_info and iter_info_len. (Sashiko)
* Update bpf_program__attach_iter() to use iter.info and iter.len.
  (Sashiko)
* v1: https://lore.kernel.org/bpf/20261109140816.5196-1-leon.hwang@linux.dev/

Leon Hwang (9):
  bpf: Add log support for tracing link_create
  bpf: Add log support for tracing_multi link_create
  bpf: Add log support for iter link_create
  bpf: Add log support for cgroup prog link_create
  libbpf: Add log_opts support for BPF_TRACE_ITER
  selftests/bpf: Verify tracing link_create logs
  selftests/bpf: Verify tracing_multi link_create logs
  selftests/bpf: Verify iter link_create logs
  selftests/bpf: Verify cgroup prog link_create logs

 include/linux/bpf-cgroup.h                    |   6 +-
 include/linux/bpf.h                           |   3 +-
 include/linux/trace_events.h                  |   7 +-
 kernel/bpf/bpf_iter.c                         |  27 +-
 kernel/bpf/cgroup.c                           |  76 +++-
 kernel/bpf/syscall.c                          |  29 +-
 kernel/trace/bpf_trace.c                      |  26 +-
 tools/lib/bpf/bpf.c                           |  23 +-
 tools/lib/bpf/bpf.h                           |   8 +
 tools/lib/bpf/libbpf.c                        |   5 +-
 tools/lib/bpf/libbpf.h                        |   3 +-
 .../selftests/bpf/prog_tests/cgroup_link.c    | 324 +++++++++++++
 .../selftests/bpf/prog_tests/iter_link.c      | 156 +++++++
 .../selftests/bpf/prog_tests/tracing_link.c   | 429 ++++++++++++++++++
 .../selftests/bpf/progs/tracing_link_ctx.c    |  17 +
 15 files changed, 1083 insertions(+), 56 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/iter_link.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/tracing_link.c
 create mode 100644 tools/testing/selftests/bpf/progs/tracing_link_ctx.c

--
2.55.0
