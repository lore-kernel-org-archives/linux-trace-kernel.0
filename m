Received: from mail-yx1-f74.google.com (mail-yx1-f74.google.com [74.125.224.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D32263570B8
	for <linux-trace-kernel@vger.kernel.org>; Tue, 28 Oct 2025 21:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761686740; cv=none; b=Q1WuiHesbF1zl4PGmlmFClnxEuAxEVmbGKAxJYC0k2z9bDwZGlHK6KN3h1ccHchRmtUAGMhKi9CFViB+G6/dC2jAEEPMwI9jq1j+lzufU6mLf4kkiOUD7b7EcvT8Oje2NXi865OkIzvR6jyhJ4/FTIwYuPKCwQdNACkXS1TRSe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761686740; c=relaxed/simple;
	bh=VONa5+qGmceUz/WA5Ut4vRFxC2i/SKI2Ca9kKEHzbt8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=JJZQ5o3YqGzTRniQyDoJr5Upnjk8SKLMoYGzMI1Yq6bmpkPxHrMOsPGUhtOsMbEiMwVHjCogePhpw1l2WTu7R1rgeIKms+5kCNq9J8Mdh0IWGZ1ssjZ8T9p7fbOYOX7TwJ6yEeTc6J7M4ZdvulAfVHCSPrwCAZJWRJ+1Q5xfjCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kaleshsingh.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sRldQMR9; arc=none smtp.client-ip=74.125.224.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kaleshsingh.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sRldQMR9"
Received: by mail-yx1-f74.google.com with SMTP id 956f58d0204a3-60fb0c64421so7869574d50.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 28 Oct 2025 14:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761686738; x=1762291538; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=U4p6kxOlNOG31wIDXmwy414BSQw9sWas+789Bv9fSts=;
        b=sRldQMR9bGFZcTGpGR/kF50apQxspOQb9yLQuOgNfr+ScULM/dVFL7Q0WMYyjjW0Zm
         djz2EpBg6SFifB+PTE4YWtAMQ5rNIh17w6gmIMidgJcSGWeUjUvOhBPigRu+bBP+pkq+
         mdQeP0r1Z5nYZLx1EFYE2dIKFGduIeOxkEPc2cD72LAhZ5GdG3+7rBIullPFAEyBcZWp
         fPBMF54Sp6JUS9P3oAbQDLzhTE3CaEe0piX1Yx4WuHSbcUtYf3DKfei+nGq7A7Qp/J6l
         6ZDCjOS2Gm9DqDPYn//KQsGqT73IKp1iycZIXI8vwcmAU85wuy/HjUY+CNmp3aJLCQE/
         9dOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761686738; x=1762291538;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U4p6kxOlNOG31wIDXmwy414BSQw9sWas+789Bv9fSts=;
        b=sj8PMoF/EqYXArscdlZaPdep3bUx9QLrg8SV7bmW6AGJTp0VaPfU/KRGCQ8aRxAdcd
         uN7YduRNboOZzBCnkBFI3pYJJvpbkbeehw5fP8Li203I/X8SwuHW6k9obpcQW1NJcH6O
         wIuko9Md/GG7pvjncPu7K/JwK1cImKXuLldBdMi92V1WVnjWx1DFM6vjkMGQFVErzz3e
         gdFyR0yjrJyad6yAhWAiAyemyof+tYoFk9THIaByEqcPU72TlSZ1KPJ4Ae5fphXJ4y/A
         E96mLioEgTlFcOsG1q6loxwnzEUPhOzDh4r1xDTLRLSrWAaTnJAuqAmKDYAQXHSXmKZm
         zHbA==
X-Forwarded-Encrypted: i=1; AJvYcCUgMUIOJOWRttd0vxhmNQEpXRAtabjAQ5S2Vo7303AZpQ6DPajvA3b9MigXQPRuOOZg6+83iiRqBEgS3thixde3bcc=@vger.kernel.org
X-Gm-Message-State: AOJu0YybzgptIYdKgqroPMqIRfkwGsCdFJ9nuDYYrwgOD17ZvCE8R60s
	qvQk2pG4ZxRCOBb22Zofcz8BCPUPZpZa70wMmoueDrDNTKhBeLfRtiVExd91S7NV/IOqNKSykO+
	9fVCCipHDHjBB/FvITTXR9lxDDw==
X-Google-Smtp-Source: AGHT+IGJWNdmzr+80PlpfT/LLo3Pibom+vpVqtRUcL1zZ6uSsgkD1esTGCr9/87u9nvyfQFqt6WKW0iDTdv7HmQAjw==
X-Received: from yxli18.prod.google.com ([2002:a53:c0d2:0:b0:63f:2d9a:6543])
 (user=kaleshsingh job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:690e:38c:b0:63e:1de4:7fc0 with SMTP id 956f58d0204a3-63f76df7854mr600821d50.66.1761686737742;
 Tue, 28 Oct 2025 14:25:37 -0700 (PDT)
Date: Tue, 28 Oct 2025 14:24:31 -0700
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.1.851.g4ebd6896fd-goog
Message-ID: <20251028212528.681081-1-kaleshsingh@google.com>
Subject: [PATCH v4 0/5] mm: Refactor and improve VMA count limit code
From: Kalesh Singh <kaleshsingh@google.com>
To: akpm@linux-foundation.org, minchan@kernel.org, lorenzo.stoakes@oracle.com, 
	david@redhat.com, Liam.Howlett@oracle.com, rppt@kernel.org, pfalcato@suse.de
Cc: rostedt@goodmis.org, hughd@google.com, kernel-team@android.com, 
	android-mm@google.com, Kalesh Singh <kaleshsingh@google.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Kees Cook <kees@kernel.org>, Vlastimil Babka <vbabka@suse.cz>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Jann Horn <jannh@google.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Ben Segall <bsegall@google.com>, 
	Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi all,

This series refactors the VMA count limit code to improve clarity,
test coverage, and observability.

The VMA count limit, controlled by sysctl_max_map_count, is a safeguard
that prevents a single process from consuming excessive kernel memory
by creating too many memory mappings.

A major change since v3 is the first patch in the series which instead of 
attempting to fix overshooting the limit now documents that this is the
intended behavior. As Hugh pointed out, the lenient check (>) in do_mmap()
and do_brk_flags() is intentional to allow for potential VMA merges or
expansions when the process is at the sysctl_max_map_count limit. 
The consensus is that this historical behavior is correct but non-obvious.

This series now focuses on making that behavior clear and the surrounding
code more robust. Based on feedback from Lorenzo and David, this series
retains the helper function and the rename of map_count.

The refined v4 series is now structured as follows:

1.  Documents the lenient VMA count checks with comments to clarify
    their purpose.

2.  Adds a comprehensive selftest to codify the expected behavior at the
    limit, including the lenient mmap case.

3.  Introduces max_vma_count() to abstract the max map count sysctl,
    making the sysctl static and converting all callers to use the new
    helper.

4.  Renames mm_struct->map_count to the more explicit vma_count for
    better code clarity.

5.  Adds a tracepoint for observability when a process fails to
    allocate a VMA due to the count limit.

Tested on x86_64 and arm64:

 1. Build test:
      allyesconfig for rename

 2. Selftests:
      cd tools/testing/selftests/mm && \
          make && \
          ./run_vmtests.sh -t max_vma_count

 3. vma tests:
      cd tools/testing/vma && \
          make && \
          ./vma

Link to v3:
https://lore.kernel.org/r/20251013235259.589015-1-kaleshsingh@google.com/

Thanks to everyone for the valuable discussion on previous revisions.

-- Kalesh

Kalesh Singh (5):
  mm: Document lenient map_count checks
  mm/selftests: add max_vma_count tests
  mm: Introduce max_vma_count() to abstract the max map count sysctl
  mm: rename mm_struct::map_count to vma_count
  mm/tracing: introduce trace_mm_insufficient_vma_slots event

 MAINTAINERS                                   |   2 +
 fs/binfmt_elf.c                               |   2 +-
 fs/coredump.c                                 |   2 +-
 include/linux/mm.h                            |   2 -
 include/linux/mm_types.h                      |   2 +-
 include/trace/events/vma.h                    |  32 +
 kernel/fork.c                                 |   2 +-
 mm/debug.c                                    |   2 +-
 mm/internal.h                                 |   3 +
 mm/mmap.c                                     |  25 +-
 mm/mremap.c                                   |  13 +-
 mm/nommu.c                                    |   8 +-
 mm/util.c                                     |   1 -
 mm/vma.c                                      |  42 +-
 mm/vma_internal.h                             |   2 +
 tools/testing/selftests/mm/.gitignore         |   1 +
 tools/testing/selftests/mm/Makefile           |   1 +
 .../selftests/mm/max_vma_count_tests.c        | 716 ++++++++++++++++++
 tools/testing/selftests/mm/run_vmtests.sh     |   5 +
 tools/testing/vma/vma.c                       |  32 +-
 tools/testing/vma/vma_internal.h              |  13 +-
 21 files changed, 856 insertions(+), 52 deletions(-)
 create mode 100644 include/trace/events/vma.h
 create mode 100644 tools/testing/selftests/mm/max_vma_count_tests.c


base-commit: b227c04932039bccc21a0a89cd6df50fa57e4716
-- 
2.51.1.851.g4ebd6896fd-goog

