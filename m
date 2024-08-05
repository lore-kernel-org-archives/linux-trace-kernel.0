Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62CB113C66A
	for <linux-trace-kernel@vger.kernel.org>; Mon,  5 Aug 2024 17:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722879216; cv=none; b=NHh5m4YqayxIvi1TjvC+OgxLz/RoAgftxzG1Nu2NVemD7sJgEXKCklINnSpb1S11yq/FvrW4N48e46IiJAX48gWmytlj1E8fFcnIsMjAzq7T31FKItSW/InPW1f5Pr7z9tXxZrbNaX5mwMq8Mu7f8+GBktcGeHweoUogLYjFTqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722879216; c=relaxed/simple;
	bh=J1tnYntwg50fTpjA0mrAEwd6kGMrYyjO+qV+J0d5bL0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=IBg6tBN8lBN30nwulC0EKWBNZxdIp5yRiNgCh4XqRLH+BghhSwfGROuinIhIxr4fZ6f4QhErEJdkCoFApbnTUmPd91J0yAhUuGGyK/7jwYfYdvqF46UncEhRoouu7TsNd/eoHpeRZXK/Dmv5yZzsYuUsdrtj2NT/IEw4huwShvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YBa2cFxu; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YBa2cFxu"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-68dcbd6135dso60702677b3.3
        for <linux-trace-kernel@vger.kernel.org>; Mon, 05 Aug 2024 10:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722879212; x=1723484012; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XFsKcyry/RGvnDXDztV7J/rjOs8FjUssMxjCbt3gJjw=;
        b=YBa2cFxu3cmHFfg4FFJdLltmdztYWxC32QSkjkRLzUTUGXYPVzM9LRaBHgNCEZ8WjJ
         wX7lZox+Smwc/7qVE7qTDagBpcSsORsgOag/KI0BZ87uQdyBtxBNz3ANiEAD1Q/m514v
         G8kjJ9GzeoOMraLPENE38i9b/r9E8UXnkbVDWWuGG6JoauSUF7Z/sU7JMz0FP3bt+eAt
         0+cjcVNy79GIyLu24iE9GLq2tRBJIZGxcoBhtO7ePREVCVolN9pk/5MGoGvhZfxSb3Ef
         QMpyEgutJupGx8cCLBfnAYNMVvMNLxRoPAhCXfhR8+A1T8tAfEpuTFtbgCkj1Do8wiap
         Dj5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722879212; x=1723484012;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XFsKcyry/RGvnDXDztV7J/rjOs8FjUssMxjCbt3gJjw=;
        b=BvzgzbFX8fFPvLx/e2auvlGHmg95iUF8yVm0Qy02pJmKvr/kowEU3E83JIXPmoHAQl
         JxeSIPU4b8buJTcQ2X/mkNRp5QLEI/p2MGRMYSgitRwLwr0+0Lg/nSdRCmxRae12pHSQ
         mmIcCLmxofnrHITHJKBc7/tMgFKuXBlKrT7kH59KFI1iKqDm6gmZND6rcwU0DvJRLkdY
         /voziIbkl5MZKO8dJP4xW6MEmUwhPozUyt1uoOq7KnlU8auNQ0vwpV18GKEPA/+TUdOQ
         vCFFeDrZRBuShuGWkDBlLohi74QOyupZIbnD2fY5MbdRrckmjKtfXyWBZvL+b+tqpe7l
         s3pw==
X-Forwarded-Encrypted: i=1; AJvYcCUm9fH4e2XZ8FVp8CtKZKoHbZpuGySotjqiS3ECXFw6Chej+pJDkM6r+n0Nso8g1rHNCo6SjybAbhscEpAjC0qBXzW+vZmC9jnXdK9Lo/a3QrIj
X-Gm-Message-State: AOJu0YxeokNI3C5876DHMzLLl342QcKZhkyTv1vIuR0Wfy1FTs/yJNQA
	7rFrM7B1zF0sG3txHbFngoh4yFO3cIFQ+6qvENZxJJvkE/0fOlmh+gvyqlVo6KDgQ8ONfs0nnQr
	04ArOevtOhDlhQr8ggg==
X-Google-Smtp-Source: AGHT+IFZlxJNmQzbt9N82rYot7byBSPmj3iU12CQIJ/Po6Ln73cDVxthhXbSBDiWXirkdAWQL+ODuSEp2kVxxz5a
X-Received: from vdonnefort.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:2eea])
 (user=vdonnefort job=sendgmr) by 2002:a05:690c:7107:b0:673:b39a:92ea with
 SMTP id 00721157ae682-68963233905mr4252017b3.7.1722879212424; Mon, 05 Aug
 2024 10:33:32 -0700 (PDT)
Date: Mon,  5 Aug 2024 18:32:23 +0100
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.rc2.264.g509ed76dc8-goog
Message-ID: <20240805173234.3542917-1-vdonnefort@google.com>
Subject: [RFC PATCH 00/11] Tracefs support for pKVM
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, 
	linux-trace-kernel@vger.kernel.org, maz@kernel.org, oliver.upton@linux.dev
Cc: kvmarm@lists.linux.dev, will@kernel.org, qperret@google.com, 
	kernel-team@android.com, Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

The growing set of features supported by the hypervisor in protected
mode necessitates debugging and profiling tools. Tracefs is the
ideal candidate for this task:

  * It is simple to use and to script.

  * It is supported by various tools, from the trace-cmd CLI to the
    Android web-based perfetto.

  * The ring-buffer, where are stored trace events consists of linked
    pages, making it an ideal structure for sharing between kernel and
    hypervisor.

This series introduces a method to create events and to generate them
from the hypervisor (hyp_enter/hyp_exit given as an example) as well as
a Tracefs user-space interface to read them.

A presentation was given on this matter during the tracing summit in
2022. [1]

1. ring-buffer
--------------

To setup the per-cpu ring-buffers, a new interface is created:

  ring_buffer_writer:	Describes what the kernel needs to know about the
			writer, that is, the set of pages forming the
			ring-buffer and a callback for the reader/head
			swapping (enables consuming read)

  ring_buffer_reader():	Creates a read-only ring-buffer from a
			ring_buffer_writer.

To keep the internals of `struct ring_buffer` in sync with the writer,
the meta-page is used. It was originally introduced to enable user-space
mapping of the ring-buffer [1]. In this case, the kernel is not the
producer anymore but the reader. The function to read that meta-page is:

  ring_buffer_poll_writer():
			Update `struct ring_buffer` based on the writer
			meta-page. Wake-up readers if necessary.

The kernel has to poll the meta-page to be notified of newly written
events.

2. Tracefs interface
--------------------

The interface is a hyp/ folder at the root of the tracefs mount point.
This folder is like an instance and you'll find there a subset of the
regular Tracefs user-space interface:

  hyp/
     buffer_size_kb
     trace_pipe
     trace_pipe_raw
     trace
     per_cpu/
             cpuX/
                 trace_pipe
                 trace_pipe_raw
     events/
            hyp/
                hyp_enter/
                          enable
                          id

Behind the scenes, kvm/hyp_trace.c must rebuild the tracing hierarchy
without relying on kernel/trace/trace.c. This is due to fundamental
differences:

  * Hypervisor tracing doesn't support trace_array's system-specific
    features (snapshots, tracers, etc.).

  * Logged event formats differ (e.g., no PID in hypervisor
    events).

  * Buffer operations require specific hypervisor interactions.

3. Events
---------

In the hypervisor, "hyp events" can be generated with trace_<event_name>
in a similar fashion to what the kernel does. They're also created with
similar macros than the kernel (see kvm_hypevents.h)

HYP_EVENT("foboar",
	HE_PROTO(void),
	HE_STRUCT(),
	HE_ASSIGN(),
	HE_PRINTK(" ")
)

Despite the apparent similarities with TRACE_EVENT(), those macros
internally differs: they must be used in parallel between the hypervisor
(for the writing part) and the kernel (for the reading part) which makes
it difficult to share anything with their kernel counterpart.

Also, events directory isn't using eventfs.

4. Few limitations:
-------------------

Non consuming reading of the buffer isn't supported (i.e. cat trace) due
to the lack of support in the ring-buffer meta-page.

Tracing must be stopped for the buffer to be reset. i.e. (echo 0 >
tracing_on; echo 0 > trace)

[1] https://tracingsummit.org/ts/2022/hypervisortracing/
[2] https://lore.kernel.org/all/20240510140435.3550353-1-vdonnefort@google.com/

Vincent Donnefort (11):
  ring-buffer: Check for empty ring-buffer with rb_num_of_entries()
  ring-buffer: Introducing ring-buffer writer
  ring-buffer: Expose buffer_data_page material
  timekeeping: Export the boot clock in snapshots
  KVM: arm64: Support unaligned fixmap in the nVHE hyp
  KVM: arm64: Add clock support in the nVHE hyp
  KVM: arm64: Add tracing support for the pKVM hyp
  KVM: arm64: Add hyp tracing to tracefs
  KVM: arm64: Add raw interface for hyp tracefs
  KVM: arm64: Add support for hyp events
  KVM: arm64: Add kselftest for tracefs hyp tracefs

 arch/arm64/include/asm/kvm_asm.h              |   6 +
 arch/arm64/include/asm/kvm_define_hypevents.h |  60 ++
 arch/arm64/include/asm/kvm_hyp.h              |   6 +
 arch/arm64/include/asm/kvm_hypevents.h        |  41 +
 arch/arm64/include/asm/kvm_hypevents_defs.h   |  41 +
 arch/arm64/include/asm/kvm_hyptrace.h         |  38 +
 arch/arm64/kernel/image-vars.h                |   4 +
 arch/arm64/kernel/vmlinux.lds.S               |  18 +
 arch/arm64/kvm/Kconfig                        |   9 +
 arch/arm64/kvm/Makefile                       |   2 +
 arch/arm64/kvm/arm.c                          |   6 +
 arch/arm64/kvm/hyp/hyp-constants.c            |   4 +
 arch/arm64/kvm/hyp/include/nvhe/arm-smccc.h   |  13 +
 arch/arm64/kvm/hyp/include/nvhe/clock.h       |  15 +
 .../kvm/hyp/include/nvhe/define_events.h      |  21 +
 arch/arm64/kvm/hyp/include/nvhe/trace.h       |  55 ++
 arch/arm64/kvm/hyp/nvhe/Makefile              |   1 +
 arch/arm64/kvm/hyp/nvhe/clock.c               |  42 +
 arch/arm64/kvm/hyp/nvhe/events.c              |  35 +
 arch/arm64/kvm/hyp/nvhe/ffa.c                 |   2 +-
 arch/arm64/kvm/hyp/nvhe/hyp-main.c            |  64 ++
 arch/arm64/kvm/hyp/nvhe/hyp.lds.S             |   4 +
 arch/arm64/kvm/hyp/nvhe/mm.c                  |   2 +-
 arch/arm64/kvm/hyp/nvhe/psci-relay.c          |  14 +-
 arch/arm64/kvm/hyp/nvhe/switch.c              |   5 +-
 arch/arm64/kvm/hyp/nvhe/trace.c               | 594 ++++++++++++
 arch/arm64/kvm/hyp_events.c                   | 164 ++++
 arch/arm64/kvm/hyp_trace.c                    | 854 ++++++++++++++++++
 arch/arm64/kvm/hyp_trace.h                    |  15 +
 include/linux/ring_buffer.h                   | 124 ++-
 include/linux/timekeeping.h                   |   6 +
 kernel/time/timekeeping.c                     |   9 +
 kernel/trace/ring_buffer.c                    | 244 +++--
 tools/testing/selftests/hyp-trace/Makefile    |   6 +
 tools/testing/selftests/hyp-trace/config      |   4 +
 .../selftests/hyp-trace/hyp-trace-test        | 161 ++++
 36 files changed, 2591 insertions(+), 98 deletions(-)
 create mode 100644 arch/arm64/include/asm/kvm_define_hypevents.h
 create mode 100644 arch/arm64/include/asm/kvm_hypevents.h
 create mode 100644 arch/arm64/include/asm/kvm_hypevents_defs.h
 create mode 100644 arch/arm64/include/asm/kvm_hyptrace.h
 create mode 100644 arch/arm64/kvm/hyp/include/nvhe/arm-smccc.h
 create mode 100644 arch/arm64/kvm/hyp/include/nvhe/clock.h
 create mode 100644 arch/arm64/kvm/hyp/include/nvhe/define_events.h
 create mode 100644 arch/arm64/kvm/hyp/include/nvhe/trace.h
 create mode 100644 arch/arm64/kvm/hyp/nvhe/clock.c
 create mode 100644 arch/arm64/kvm/hyp/nvhe/events.c
 create mode 100644 arch/arm64/kvm/hyp/nvhe/trace.c
 create mode 100644 arch/arm64/kvm/hyp_events.c
 create mode 100644 arch/arm64/kvm/hyp_trace.c
 create mode 100644 arch/arm64/kvm/hyp_trace.h
 create mode 100644 tools/testing/selftests/hyp-trace/Makefile
 create mode 100644 tools/testing/selftests/hyp-trace/config
 create mode 100644 tools/testing/selftests/hyp-trace/hyp-trace-test


base-commit: e4fc196f5ba36eb7b9758cf2c73df49a44199895
-- 
2.46.0.rc2.264.g509ed76dc8-goog

