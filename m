Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E8732E12B
	for <linux-trace-kernel@vger.kernel.org>; Tue, 18 Nov 2025 12:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763469413; cv=none; b=VDa811OC6RghdQS4CM6rjKUqo1fp30qT/qmnY8ck1Z/+W3Ci/+qiqOJA1wBEIJmSyXCo8ax1xszmzuzTf0lU4xUkBmuNHuE8rqLT80wNCIilqyVcZ6bEIXbSg30X26eMYrl50ECsyOnr0z215g/YmGThedVVmPg/AQzC73ygKT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763469413; c=relaxed/simple;
	bh=7giUa1zm7WNduNPmlFlBni+p5300Qo8/anEWmLfFLhc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MJR2qc8QWwpDT8VJRfZNy4a5dO4gPxW16/P/hD4bM0Y6qqo88gdbjQJprnaq3MbHGV+iBqeL3jj+3Tv9psQYbkLFCZZLnlZRe21Jommp8KzN89qHCNkEwjGUIlc7cMv821deltiCqu2WdegkOYXRnm6G571ojck3LqCQlOed0vM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nkZdLIJv; arc=none smtp.client-ip=209.85.210.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nkZdLIJv"
Received: by mail-pf1-f193.google.com with SMTP id d2e1a72fcca58-7aa9be9f03aso4749241b3a.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 18 Nov 2025 04:36:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763469410; x=1764074210; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1LM23e0L0ml5CO7atXlhcS6iRDTOr1crRAlI1mbA3v8=;
        b=nkZdLIJvl2p7lRrMnzEL4b9/hX3LQl4E7Iz/f/32n+m7z9BHIwDw/oB/cQWkTfojvP
         MJUVumpniNPqraMcoVD2/9hiOVJlFoZZIDf03mcq8hx7bjVXWWHjFTyLBTAazCF7tk3+
         a/d2D/JgQ4C2oE8KfGQFM3x1MSCUSMKnkRFTBGwWAL7fKSuo+VrVzr56FVKjnj/7RmNW
         Wdp5nREiFUqs4i5/3DovfClDdiVPV5z0piYVedy+Pd/EZ8AWmzpJ3cEjgfcn61yn4mmE
         /c9BkaI3UsrJoxHZ60/9JvrzOa8EFrO90apNfr4S83ZdjwU830/G1wqVD8Ufc2D+D6n1
         7JaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763469410; x=1764074210;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1LM23e0L0ml5CO7atXlhcS6iRDTOr1crRAlI1mbA3v8=;
        b=UgWkdGfy0EgN6W66iNMHqAIwh+/ZnJauHJ7qpelg3wNLm9oMLR8VH+wVCG3OqEVOT9
         6IJPty0sqIxj1RXonk8Qt7L6HQBZJPbvLMfdrX4ZIOYFEedGgpitQ5/0TwY9E4p0csvo
         hbMmSIfXN/XyelNFbywYcYyRl4WilOPy8+XKLjbZna6ujTb26amogyRqnEu5mg3gq/+e
         UHs/Rv6ynncBBbjZ8RH+QeaV3GxBYghGptQuOaH/WML5EGjFRasWbfta8x/mIfMToNtW
         AuZoQm0l8kDdAxj+5bts1Dt9PznIZBehY1jdxk/IAl/Hx2fcvMtxUaveAhd0kp1Q1Ece
         nA2A==
X-Forwarded-Encrypted: i=1; AJvYcCVDEGwkEQ9uKwGeLtiNc4A3UKME1/sQM/2A4yqmscVRqnvO9uoCvFpMwXBIxJCTaFxXSisBkHbzYvrCWkjMxmSps0k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1nI1dWiNvBPiDonOyOfMzKq/I0Q0weClkS03SZHbCiS1VQVEu
	w4N/IgtirACh5rhzT3/fREMNNyabgjxLmhnWKJNaCAd+ouInJWXqdB3v
X-Gm-Gg: ASbGnct03e2bVy5I/l+PIri1/i3b98YUajdhXi939DWRguByicHL7ar2QnaUFNdOdT0
	75YMpadRw4d2pKuRkZfq/sMNHwGJILs14pTqMET8MEijPb6x5DK2SOHEiZwdSW+gk/ukJ0LXHC+
	lSWvjSSm3KLAHdxQ532SckcmuRoyiR9vc7DZZCJa3GAXs7qdMNWYPHPx/cYkABMtZCvy5Jm9jSN
	MXLTIKf+isNszkE3l+62wxiMH0BgPH6SyLI5xsU0B60kflK67GUbzL2P9cH1eHEu4KNVQjufR8R
	fMmCOc7gzRf/mkDrcV/kvEskzYR9NPTtHAnBc7RKJuZx6t6ERWweG7nGyV1gyZx9AE0z5Zx5SdT
	RatE6GTr6PpFo27db3E3zSkUFFR2KlxNBE95BsDOKfxLgz+j1TBW/XVpB8W/0vvzFwSMomq1g4x
	mava79gkDJCzSMW4azZ8MeUg==
X-Google-Smtp-Source: AGHT+IETM5S8hWOszOBnIm3XxEqQG5D1jgh7M8aLGbxLIl4ecWp5cqe9a7kHieHLebE41E16oQqGlw==
X-Received: by 2002:a05:6a00:18a2:b0:7aa:ac12:2c2e with SMTP id d2e1a72fcca58-7ba3c6658admr20491229b3a.25.1763469409695;
        Tue, 18 Nov 2025 04:36:49 -0800 (PST)
Received: from 7950hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b92772e7f2sm16331496b3a.57.2025.11.18.04.36.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 04:36:49 -0800 (PST)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: ast@kernel.org,
	rostedt@goodmis.org
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
	mhiramat@kernel.org,
	mark.rutland@arm.com,
	mathieu.desnoyers@efficios.com,
	jiang.biao@linux.dev,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH bpf-next v3 0/6] bpf trampoline support "jmp" mode
Date: Tue, 18 Nov 2025 20:36:28 +0800
Message-ID: <20251118123639.688444-1-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

For now, the bpf trampoline is called by the "call" instruction. However,
it break the RSB and introduce extra overhead in x86_64 arch.

For example, we hook the function "foo" with fexit, the call and return
logic will be like this:
  call foo -> call trampoline -> call foo-body ->
  return foo-body -> return foo

As we can see above, there are 3 call, but 2 return, which break the RSB
balance. We can pseudo a "return" here, but it's not the best choice,
as it will still cause once RSB miss:
  call foo -> call trampoline -> call foo-body ->
  return foo-body -> return dummy -> return foo

The "return dummy" doesn't pair the "call trampoline", which can also
cause the RSB miss.

Therefore, we introduce the "jmp" mode for bpf trampoline, as advised by
Alexei in [1]. And the logic will become this:
  call foo -> jmp trampoline -> call foo-body ->
  return foo-body -> return foo

As we can see above, the RSB is totally balanced after this series.

In this series, we introduce the FTRACE_OPS_FL_JMP for ftrace to make it
use the "jmp" instruction instead of "call".

And we also do some adjustment to bpf_arch_text_poke() to allow us specify
the old and new poke_type.

For the BPF_TRAMP_F_SHARE_IPMODIFY case, we will fallback to the "call"
mode, as it need to get the function address from the stack, which is not
supported in "jmp" mode.

Before this series, we have the following performance with the bpf
benchmark:

  $ cd tools/testing/selftests/bpf
  $ ./benchs/run_bench_trigger.sh
  usermode-count :  890.171 ± 1.522M/s
  kernel-count   :  409.184 ± 0.330M/s
  syscall-count  :   26.792 ± 0.010M/s
  fentry         :  171.242 ± 0.322M/s
  fexit          :   80.544 ± 0.045M/s
  fmodret        :   78.301 ± 0.065M/s
  rawtp          :  192.906 ± 0.900M/s
  tp             :   81.883 ± 0.209M/s
  kprobe         :   52.029 ± 0.113M/s
  kprobe-multi   :   62.237 ± 0.060M/s
  kprobe-multi-all:    4.761 ± 0.014M/s
  kretprobe      :   23.779 ± 0.046M/s
  kretprobe-multi:   29.134 ± 0.012M/s
  kretprobe-multi-all:    3.822 ± 0.003M/

And after this series, we have the following performance:

  usermode-count :  890.443 ± 0.307M/s
  kernel-count   :  416.139 ± 0.055M/s
  syscall-count  :   31.037 ± 0.813M/s
  fentry         :  169.549 ± 0.519M/s
  fexit          :  136.540 ± 0.518M/s
  fmodret        :  159.248 ± 0.188M/s
  rawtp          :  194.475 ± 0.144M/s
  tp             :   84.505 ± 0.041M/s
  kprobe         :   59.951 ± 0.071M/s
  kprobe-multi   :   63.153 ± 0.177M/s
  kprobe-multi-all:    4.699 ± 0.012M/s
  kretprobe      :   23.740 ± 0.015M/s
  kretprobe-multi:   29.301 ± 0.022M/s
  kretprobe-multi-all:    3.869 ± 0.005M/s

As we can see above, the performance of fexit increase from 80.544M/s to
136.540M/s, and the "fmodret" increase from 78.301M/s to 159.248M/s.

Link: https://lore.kernel.org/bpf/20251117034906.32036-1-dongml2@chinatelecom.cn/
Changes since v2:
* reject if the addr is already "jmp" in register_ftrace_direct() and
  __modify_ftrace_direct() in the 1st patch.
* fix compile error in powerpc in the 5th patch.
* changes in the 6th patch:
  - fix the compile error by wrapping the write to tr->fops->flags with
    CONFIG_DYNAMIC_FTRACE_WITH_JMP
  - reset BPF_TRAMP_F_SKIP_FRAME when the second try of modify_fentry in
    bpf_trampoline_update()

Link: https://lore.kernel.org/bpf/20251114092450.172024-1-dongml2@chinatelecom.cn/
Changes since v1:
* change the bool parameter that we add to save_args() to "u32 flags"
* rename bpf_trampoline_need_jmp() to bpf_trampoline_use_jmp()
* add new function parameter to bpf_arch_text_poke instead of introduce
  bpf_arch_text_poke_type()
* rename bpf_text_poke to bpf_trampoline_update_fentry
* remove the BPF_TRAMP_F_JMPED and check the current mode with the origin
  flags instead.

Link: https://lore.kernel.org/bpf/CAADnVQLX54sVi1oaHrkSiLqjJaJdm3TQjoVrgU-LZimK6iDcSA@mail.gmail.com/[1]
Menglong Dong (6):
  ftrace: introduce FTRACE_OPS_FL_JMP
  x86/ftrace: implement DYNAMIC_FTRACE_WITH_JMP
  bpf: fix the usage of BPF_TRAMP_F_SKIP_FRAME
  bpf,x86: adjust the "jmp" mode for bpf trampoline
  bpf: specify the old and new poke_type for bpf_arch_text_poke
  bpf: implement "jmp" mode for trampoline

 arch/arm64/net/bpf_jit_comp.c   | 14 +++---
 arch/loongarch/net/bpf_jit.c    |  9 ++--
 arch/powerpc/net/bpf_jit_comp.c | 10 +++--
 arch/riscv/net/bpf_jit_comp64.c | 11 +++--
 arch/s390/net/bpf_jit_comp.c    |  7 +--
 arch/x86/Kconfig                |  1 +
 arch/x86/kernel/ftrace.c        |  7 ++-
 arch/x86/kernel/ftrace_64.S     | 12 +++++-
 arch/x86/net/bpf_jit_comp.c     | 55 ++++++++++++++----------
 include/linux/bpf.h             | 18 +++++++-
 include/linux/ftrace.h          | 33 ++++++++++++++
 kernel/bpf/core.c               |  5 ++-
 kernel/bpf/trampoline.c         | 76 ++++++++++++++++++++++++++-------
 kernel/trace/Kconfig            | 12 ++++++
 kernel/trace/ftrace.c           | 14 +++++-
 15 files changed, 219 insertions(+), 65 deletions(-)

-- 
2.51.2

