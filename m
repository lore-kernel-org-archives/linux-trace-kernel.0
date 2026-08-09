Received: from out-175.mta1.migadu.com (out-175.mta1.migadu.com [95.215.58.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C7A38F926
	for <linux-trace-kernel@vger.kernel.org>; Sun,  9 Aug 2026 15:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786287717; cv=none; b=BmJ1kquZs1KowZLJ+Sh42Ifctq6FZRGnF7DNjSiiDmbNHYFFTaR5laBZpOvC5msUuff8fh9skYH9LVbTPh+PrjlxLKQ4VTyWI9pjdldK0oJOWmFeE86dtCbWhyx++xS9rZEFPgYlkucFfuNKb5lR1ftXpNFtAHfl0qJ1W2gNXeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786287717; c=relaxed/simple;
	bh=3oNs8QSrFoe5bUDHUnLg5XCzSZ0JCxLnph4plr9mrKM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r4TS3oKnckOS94isGoc/VOYWQ1iHKR9ipsFeCvxXffAgvh8mtJ0oAJOg1V9TKIYytPMoXEXslYbHw8gqhHLWYMeb2ywYPU/+6wGeX32EVmqLX1Aj+n1S2TmnyToqDAP7lIv1YnoAQO7qQpTnco9phOqtdAGVVJwYsi4ewWOPHPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SZPA9Knj; arc=none smtp.client-ip=95.215.58.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SZPA9Knj"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786287711;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=KP+Yi6mHI4T84FcQS0INnfN/N5ZjzIUJJSjrPWRGYuE=;
	b=SZPA9KnjuC0GirlVYdSwgj8GrkTkmTpk3VBdRooUPPjP1FBTPFiMTxjJYOk9PxI8BgedlP
	kVrH4ZF1A/puOLuaTX04FJLlNQSgKIQfKWUepGh15GSLs3XginZx9qyxXErc6qMvTmbFX5
	Q6xttTrQN9dPtOeD9V9/+1dn97kp7r0=
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
	Quentin Monnet <qmo@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Leon Hwang <leon.hwang@linux.dev>,
	Mykyta Yatsenko <yatsenko@meta.com>,
	Avinash Duduskar <avinash.duduskar@gmail.com>,
	Anton Protopopov <a.s.protopopov@gmail.com>,
	Amery Hung <ameryhung@gmail.com>,
	Jordan Rife <jordan@jrife.io>,
	Rong Tao <rongtao@cestc.cn>,
	Eyal Birger <eyal.birger@gmail.com>,
	Pu Lehui <pulehui@huawei.com>,
	Jingguo Tan <tanjingguo@huawei.com>,
	Lin Ma <malin89@huawei.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next 00/13] bpf: Add tracing_multi link support for bpf progs
Date: Sun,  9 Aug 2026 23:00:58 +0800
Message-ID: <20260809150111.45000-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Similar to the tracing_multi link support for kernel functions [1], add
support for bpf progs.

When attaching to bpf progs, it must attaches to the target by text poke
way.

[1] https://lore.kernel.org/bpf/20260606123955.345967-1-jolsa@kernel.org/

Leon Hwang (13):
  bpf: Initialize ftrace_managed in bpf_trampoline_get
  bpf: Factor out update_fentry_multi helper
  bpf: Drop unnecessary ftrace_location() in update_fentry_multi()
  bpf: Add tracing_multi link support for bpf progs
  libbpf: Add tracing_multi link support for bpf progs
  bpf: Add tracing_multi link fdinfo support for bpf progs
  bpf: Add tracing_multi link info support for bpf progs
  selftests/bpf: Add tracing_multi bpf prog attach test
  selftests/bpf: Add tracing_multi bpf prog attach failure tests
  selftests/bpf: Add tracing_multi bpf prog cookie test
  selftests/bpf: Add tracing_multi bpf prog rollback test
  selftests/bpf: Add tracing_multi bpf prog link info test
  selftests/bpf: Test tailcall with fentry.multi

 include/linux/bpf.h                           |   3 +
 include/uapi/linux/bpf.h                      |   6 +-
 kernel/bpf/trampoline.c                       |  87 +++---
 kernel/bpf/verifier.c                         |  22 +-
 kernel/trace/bpf_trace.c                      | 212 ++++++++++++---
 tools/bpf/bpftool/link.c                      |  59 +++-
 tools/include/uapi/linux/bpf.h                |   6 +-
 tools/lib/bpf/bpf.c                           |   1 +
 tools/lib/bpf/bpf.h                           |   2 +
 tools/lib/bpf/libbpf.c                        |  39 ++-
 tools/lib/bpf/libbpf.h                        |   4 +-
 tools/lib/bpf/libbpf_internal.h               |   1 +
 .../selftests/bpf/prog_tests/fill_link_info.c | 170 ++++++++++--
 .../selftests/bpf/prog_tests/tailcalls.c      |  62 +++++
 .../selftests/bpf/prog_tests/tracing_multi.c  | 254 ++++++++++++++++++
 .../selftests/bpf/progs/tracing_multi_bpf.c   |  61 +++++
 16 files changed, 869 insertions(+), 120 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/tracing_multi_bpf.c

--
2.55.0
