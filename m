Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F08E1A23A7
	for <linux-trace-kernel@vger.kernel.org>; Wed,  8 Jan 2025 11:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736336764; cv=none; b=i9kBaId14icelsLG7qbl8LQeh2kj58t8cZ2y91HRX8pg4DHjRucYEgdfIAWxHhrMvW0i/o/v3lJ4fDduR/budiwxsnVsgNFYPsujqIEDUOMKw+A9sLuH3RtpDixyueOAEV5duyaD0lMo46RfJmGYNYQbvMpj/4U9Z0pCB+iyqMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736336764; c=relaxed/simple;
	bh=NfgoprGHIMSS8z9YNODnVo/t9Cu+B2IUcSp7ihfKn7o=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Xf85tjD2fWFwjcMZ+PajMiEjdyEGBJAN5MLga/W6i7gxGCJDV00jk1nS5cCdanGMn/TdiFUlop7NjCpY6XufWY0ctC/AErNHqPO1kbt1tB4MKb7MEIvnNUB2gu359ykBOliUpMmS/0SzmowYxVY7bsVGGjbmSjNUqOm/sH8Np4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TVfJBRdU; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TVfJBRdU"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-43626224274so53252725e9.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 08 Jan 2025 03:46:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736336761; x=1736941561; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=u9S7W0HfHvJI5190vNjSmuT5KotC5Nh+CN9GUxaRb6A=;
        b=TVfJBRdUxxA4/pMPrvtaUyXTVM9IgcBBsWA9iYgh5U774I40KR+zIUNXaok8gOGo11
         udvLtBh1mBRPtMNopIEEYLt0/F8WUhF210k1oGXNlZM2dgOFlvP34VEnCARRV0SUSyTq
         FOp2yf7h1g8LhJxkw1NLT9ZnBRJIPqZVo9yW7hfwyMcTwWu76Sg+LbYbljhWnlFMXJXo
         QO7Kys/XA9sDzD0dWEkegsIEtam+TrT8CU/RxWCSsQxGxmWyGQvhioOR5guNAr0Wd8Pn
         wkx9xo+ibIiL4O8OvdNQTX6057TzHRhoCJPZTyU/uZ0IGRM09kj+VUJKaqAjHPVG4C34
         MY9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736336761; x=1736941561;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=u9S7W0HfHvJI5190vNjSmuT5KotC5Nh+CN9GUxaRb6A=;
        b=ZGewB84RzU3vpKo6DtaKgaCIj/cOJvD+eQpkCUWL+kzxZk3oEJ4R/2TyRhz+EsveC7
         F+ZjulYI+lhIyctId3crq5vQET/cX0l3FxVvrS8wTPCtaAe/ri9Gz/9IM6Nhwjmkail8
         Yh/trwZAGJHtoDZMBpQaScSToQ0bUlEiVsTlNE65YW35v/49sVtP+D/XRzXyxKYxjI52
         qUzmq6dozo/mz08GvO/HvaqfaLEDvjNCK1EOEkBvIMya+qxdmT1ysuWxQJdPDRPznZlL
         E46Pt0D61zNUIcJMmIyH98W07KYdlYM4fZ8HxY72ce+2aMt+rWEjwxH2VGCUMXfsEO10
         du3A==
X-Forwarded-Encrypted: i=1; AJvYcCVsAMZmnllj42XhAyX6QpJyDNj+cUTWLixdOtOqrcdVUwIPlBgtdhE6OxZIJ7j3ti44h+Y2h1xIOV/xKOy1WQySrMY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUcSjCP6zjyPwvEoRTsQmahoQXAlBIcU/SSt2zVXw5EATo1vEG
	P11l0i2sGeA8rxH8SV+DMBCfMq/uK+QLj4b/IwLkVG6d+j4RJXMd75F3EU3nulfUpyrS3gY4P/0
	xYbF/MBAdWoLbA7RIXg==
X-Google-Smtp-Source: AGHT+IEuXsIa0p+08ntfuOYSXDRZbRggsKddBxRV+z+mWnkpVnsaXUObKqP1qE0FqwA+Az1xv45anGjrQ+vmf5da
X-Received: from wmqa17.prod.google.com ([2002:a05:600c:3491:b0:434:fa72:f1bf])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1c28:b0:434:a734:d268 with SMTP id 5b1f17b1804b1-436e2699dfbmr21482055e9.14.1736336760817;
 Wed, 08 Jan 2025 03:46:00 -0800 (PST)
Date: Wed,  8 Jan 2025 11:45:24 +0000
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20250108114536.627715-1-vdonnefort@google.com>
Subject: [PATCH v2 00/12] Tracefs support for pKVM
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	linux-trace-kernel@vger.kernel.org, maz@kernel.org, oliver.upton@linux.dev, 
	joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com
Cc: kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	jstultz@google.com, qperret@google.com, will@kernel.org, 
	kernel-team@android.com, linux-kernel@vger.kernel.org, 
	Vincent Donnefort <vdonnefort@google.com>
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

  ring_buffer_remote:	Describes what the kernel needs to know about the
			remote writer, that is, the set of pages forming the
			ring-buffer and a callback for the reader/head
			swapping (enables consuming read)

  ring_buffer_remote():	Creates a read-only ring-buffer from a
			ring_buffer_remote.

To keep the internals of `struct ring_buffer` in sync with the writer,
the meta-page is used. It was originally introduced to enable user-space
mapping of the ring-buffer [1]. In this case, the kernel is not the
producer anymore but the reader. The function to read that meta-page is:

  ring_buffer_poll_remote():
			Update `struct ring_buffer` based on the writer
			meta-page. Wake-up readers if necessary.

The kernel has to poll the meta-page to be notified of newly written
events.

2. Tracefs interface
--------------------

The interface is a hypervisor/ folder at the root of the tracefs mount
point.  This folder is like an instance and you'll find there a subset
of the regular Tracefs user-space interface:

  hypervisor/
     buffer_size_kb
     trace_clock
     trace_pipe
     trace_pipe_raw
     trace
     per_cpu/
             cpuX/
                 trace
                 trace_pipe
                 trace_pipe_raw
     events/
            hypervisor/
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

4. Limitations:
---------------

Non-consuming reading of the buffer isn't supported (i.e. cat trace ->
-EPERM) due to current the lack of support in the ring-buffer meta-page.

[1] https://tracingsummit.org/ts/2022/hypervisortracing/
[2] https://lore.kernel.org/all/20240510140435.3550353-1-vdonnefort@google.com/

Changes since v1: https://lore.kernel.org/all/20240911093029.3279154-1-vdonnefort@google.com/

  - Add 128-bits mult fallback in the unlikely event of an overflow. (John)
  - Fix ELF section sort.
  - __always_inline trace_* event macros.
  - Fix events/<event>/enable permissions.
  - Rename ring-buffer "writer" to "remote".
  - Rename CONFIG_PROTECTED_NVHE_TESTING to PKVM_SELFTEST to align with
    Quentin's upcoming selftest
  - Rebase on 6.13-rc3.

Changes since RFC: https://lore.kernel.org/all/20240805173234.3542917-1-vdonnefort@google.com/

  - hypervisor trace clock:
     - mult/shift computed in hyp_trace.c. (John)
     - Update clock when it deviates from kernel boot clock. (John)
     - Add trace_clock file.
     - Separate patch for better readability.

  - Add a proper reset interface which does not need to teardown the
    tracing buffers. (Steven)

  - Return -EPERM on trace access. (Steven)

  - Add per-cpu trace file.

  - Automatically teardown and free the tracing buffer when it is empty,
    without readers and not currently tracing.

  - Show in buffer_size_kb if the buffer is loaded in the hypervisor or
    not.

  - Extend tests to cover reset and unload.

  - CC timekeeping folks on relevant patches (Marc)

Vincent Donnefort (12):
  ring-buffer: Check for empty ring-buffer with rb_num_of_entries()
  ring-buffer: Introducing ring-buffer remote
  ring-buffer: Expose buffer_data_page material
  KVM: arm64: Support unaligned fixmap in the nVHE hyp
  KVM: arm64: Add clock support in the nVHE hyp
  KVM: arm64: Add tracing support for the pKVM hyp
  KVM: arm64: Add hyp tracing to tracefs
  KVM: arm64: Add clock for hyp tracefs
  KVM: arm64: Add raw interface for hyp tracefs
  KVM: arm64: Add trace interface for hyp tracefs
  KVM: arm64: Add support for hyp events
  KVM: arm64: Add kselftest for tracefs hyp tracefs

 arch/arm64/include/asm/kvm_asm.h              |   8 +
 arch/arm64/include/asm/kvm_define_hypevents.h |  61 ++
 arch/arm64/include/asm/kvm_hyp.h              |   1 -
 arch/arm64/include/asm/kvm_hypevents.h        |  41 +
 arch/arm64/include/asm/kvm_hypevents_defs.h   |  41 +
 arch/arm64/include/asm/kvm_hyptrace.h         |  37 +
 arch/arm64/kernel/image-vars.h                |   4 +
 arch/arm64/kernel/vmlinux.lds.S               |  18 +
 arch/arm64/kvm/Kconfig                        |  10 +
 arch/arm64/kvm/Makefile                       |   2 +
 arch/arm64/kvm/arm.c                          |   6 +
 arch/arm64/kvm/hyp/hyp-constants.c            |   4 +
 arch/arm64/kvm/hyp/include/nvhe/arm-smccc.h   |  13 +
 arch/arm64/kvm/hyp/include/nvhe/clock.h       |  16 +
 .../kvm/hyp/include/nvhe/define_events.h      |  21 +
 arch/arm64/kvm/hyp/include/nvhe/trace.h       |  60 ++
 arch/arm64/kvm/hyp/nvhe/Makefile              |   1 +
 arch/arm64/kvm/hyp/nvhe/clock.c               |  65 ++
 arch/arm64/kvm/hyp/nvhe/events.c              |  35 +
 arch/arm64/kvm/hyp/nvhe/ffa.c                 |   2 +-
 arch/arm64/kvm/hyp/nvhe/hyp-main.c            |  85 ++
 arch/arm64/kvm/hyp/nvhe/hyp.lds.S             |   6 +
 arch/arm64/kvm/hyp/nvhe/mm.c                  |   2 +-
 arch/arm64/kvm/hyp/nvhe/psci-relay.c          |  14 +-
 arch/arm64/kvm/hyp/nvhe/switch.c              |   5 +-
 arch/arm64/kvm/hyp/nvhe/trace.c               | 660 ++++++++++++
 arch/arm64/kvm/hyp_events.c                   | 159 +++
 arch/arm64/kvm/hyp_trace.c                    | 988 ++++++++++++++++++
 arch/arm64/kvm/hyp_trace.h                    |  15 +
 include/linux/ring_buffer.h                   |  99 +-
 kernel/trace/ring_buffer.c                    | 308 ++++--
 tools/testing/selftests/hyp-trace/Makefile    |   6 +
 tools/testing/selftests/hyp-trace/config      |   4 +
 .../selftests/hyp-trace/hyp-trace-test        | 254 +++++
 34 files changed, 2955 insertions(+), 96 deletions(-)
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
 create mode 100755 tools/testing/selftests/hyp-trace/hyp-trace-test


base-commit: 09a0fa92e5b45e99cf435b2fbf5ebcf889cf8780
-- 
2.47.1.613.gc27f4b7a9f-goog

