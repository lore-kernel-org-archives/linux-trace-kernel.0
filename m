Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793988465;
	b=nMCbuaJlpY88Wrnzhc2VMQ5vm9Ok+mVy8hu34MX3U3FY3Y8lohSUHJI109aklZOUnyiz
	 PeC+Z3FHzweWpfYQyDXPidLsY9gCt9NycoMPcXt92V2Rqn4DOTZFbT99oejTJGASU+sse
	 /jvX1R/dfsXssf5B4OUO/Y3n2ayV41Ar45CYE9RCi58y5x/30ZtU5ScdVbfGHSjRuimxI
	 wxMiKCel6WWOlXHfreRbUgNCq3DouW7yIHBLlCkAE+jLq4rEtFCZsF56S+TwYuyNCrMYn
	 48YqQZWAy/WPxdlH3+fl38zgrtioHDw1S1g0B79IIK7+2V4bibA1/C6QGegQkFYXIZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793988465;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=V9J2B7uJaZnPBR4r78rPATYLPeUqp87tolhGzh3XV5Y=;
	b=laaEQqg+VZTCDS0qTp4V3uyrF/0kEpSN6zr08la8802eBT40WfqGlDohNNrzvUFZlHRV
	 UMM35l1zpoB1OS4tmm5UYvBx1s0vwkkvrnpN8xbE2CxtIoIR+beu4vrv7061LbuJsuOoE
	 Xzlp8+NxtjWnm8hioEwna89KviBnJfs1nXEruQ/sgx0QrDl520gvaUtd82PexniLBsLQP
	 S4C0Is03UKHRGBfbBji10dXuydqZ1eDiGn5oKCbyixtjGeDyvGWLOc0cJR9lgxqfQLZjE
	 q81oI+XJtvllvkGXVG117C3SIrcvkhRz1GgLtBCVApJgneIado6pnbVXRfhrn0/2Qow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ATCMNNwG;
	arc=none smtp.remote-ip=209.85.128.69
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21855606A329
	for <linux-trace-kernel@vger.kernel.org>; Fri,  6 Nov 2026 18:07:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 21855606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ATCMNNwG
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4a318cd95e8so7244295e9.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 06 Nov 2026 10:07:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793988462; x=1794593262; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=V9J2B7uJaZnPBR4r78rPATYLPeUqp87tolhGzh3XV5Y=;
        b=ATCMNNwGfsce7iutnocmc/UEnmNph/lus8rVFhMiN0tAxtcFYnnFNLHsi0x3TdrTMt
         9+Xlh1dsL1hL3HtSHL1CoYfXcCaeN04OjXtKky4QFl75a/UJXvaw5xv1mRLyu74XsImF
         1BQYs0QaztOp2bWA6zmD5RF00eIl/SazuyDu72Qode194QGe8Hhp/EMWhXyq9Gz9j2aO
         ukkkQIpN4xOWF9uAMMSA8UtabvwAwEEQVy8Yk3dhGHX99XzJ5lb3lhFOKbdz8OvV/K+A
         29hhQYZpMzI2H/yw7703HH87u7xJeYRHSjMdNxKFOKO5jRFwS1ZNRbesEZhg7YU+gJXi
         SkLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793988462; x=1794593262;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=V9J2B7uJaZnPBR4r78rPATYLPeUqp87tolhGzh3XV5Y=;
        b=GlaJ8o27E4wgKoU7mf6w5FQRrxlgmGPiiJtGHgr+Rpj2uSqbwUaJNsFeZiL2BeRG3H
         t2v2hkrlJFBtppyJzyOBBC4sSSjdgscnmbE/SJ35x0QBSS0y5jVn0OJ63mFOvy8XLtKK
         wtiKwCr6VcS2ZocaeeBetPUjE40A4fF0QA9EI602YJGjobKr4NYgxMZa+8jhHxowZgmX
         PSjfBERCavK/S8IKzguY9npTyfj+fhOS5GR7Oa8fzVXhDLpCukZ9pkQJ9sSGmUN3cDTT
         8JEOGx+qXiTZO5W+S8Fm8TF8Dz/7it7DWKJb9031hbRCyJV5ndYSbY0Nd5/3mzYnXoLg
         sFdQ==
X-Forwarded-Encrypted: i=1; AKwUvBxboBIVw9ODVJPGwWFPdztFxyzmFPnzC8MfTlACpL/pCuEAaNY1xue+b6vksYocsR8BP0geSNr44hx0A+GTwl9YO28=@vger.kernel.org
X-Gm-Message-State: APuU4Z/d/m8ttH13ypaoPK3h5hVydzuKHyJo3TkoRXkUEpRcgMubnbdk
	BTkkL22DvavlMM0fk4CGOnGnPhOtB9vjQ/5ijBXkUS2HuoDxkqOBxkuZtJ8Yj7jPaXylxJNJM6k
	btcAp+az2SS7sMHzvZDjACw==
X-Received: from wmep6.prod.google.com ([2002:a05:600c:4306:b0:4a5:7d42:bd0f])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:310f:b0:4a2:18c4:61a5 with SMTP id 5b1f17b1804b1-4b6dea69297mr54280945e9.6.1793988462339;
 Fri, 06 Nov 2026 10:07:42 -0800 (PST)
Date: Fri,  6 Nov 2026 18:06:36 +0000
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.455.g6c5a503b38-goog
Message-ID: <20261106180657.2460376-1-vdonnefort@google.com>
Subject: [PATCH v8 00/21] tracing/remotes: Add printk, dump_on_panic and boot parameters
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, 
	linux-trace-kernel@vger.kernel.org
Cc: mathieu.desnoyers@efficios.com, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

This series extends the recently introduced trace remotes
infrastructure, bringing useful features for developers:

  * dump_on_panic: Dump the trace remote buffer on system panic.
  * dmesg: Redirect remote events to dmesg.
  * trace_remote=: Configure a trace_remote from the commandline.
  * poll_ms: Modify the polling period.

It also brings a couple of optimisations:

  * In-header compressed length support for small events.
  * Single work thread for remote polling.

And some misc improvements:

  * Use kstrtobool where possible
  * Free resources on remote registration failure

Changelog:

v8:

  * Use trylock in rb_reader_lock() when panic_on_this_cpu(). (Sashiko)
  * Drop ring_buffer_read_remote_meta_page() and use ring_buffer_capacity() in trace_remote_has_cpu().
  * Avoid mixing __free(kfree) with goto in trace_remote_iter(). (Sashiko)
  * Cancel and reschedule poll_work on poll_ms update. (Sashiko)
  * Validate buf_size and use WRITE_ONCE() for poll_ms in cmdline parsing. (Sashiko)
  * Rebase on 7.4-rc1

v7 (https://lore.kernel.org/all/20260924145754.1285146-1-vdonnefort@google.com/):

  * Check for printk timestamps in dmesg selftest. (Sashiko)
  * Touch NMI watchdog in the panic dump loop. (Sashiko)
  * Add READ_ONCE()/WRITE_ONCE() for panic_on. (Sashiko)
  * Defer dmesg and tracing enabling after all cmdline options are parsed. (Sashiko)
  * Guard sysrq panic trigger in dump_on_panic.tc with TRIGGER_PANIC env variable. (Sashiko)
  * Rebase on 7.3-rc4

v6 (https://lore.kernel.org/all/20260817135517.3919534-1-vdonnefort@google.com/):

  * Replace WARN_ON with pr_warn for buf_size in cmdline parsing. (Sashiko)
  * Add READ_ONCE()/WRITE_ONCE() for poll_ms (Sashiko)
  * Add support for HAVE_64BIT_ALIGNED_ACCESS arch is set in simple_ring_buffer. (Sashiko)
  * Add selftest tracefs file requirements, TMPDIR leak, and awk regex. (Sashiko)
  * Rebase on 7.2

v5 (https://lore.kernel.org/all/20260812161340.2417322-1-vdonnefort@google.com/):

  * Use seq_buf_str() for safe, properly terminated trace_seq extraction. (Steven)
  * Remove destructive dmesg -c from selftests and rely on timestamp matching instead. (Steven)
  * Allow several trace_remote=XXX cmdline options.
  * Rebase on 7.2-rc7

v4 (https://lore.kernel.org/all/20260804140333.797210-1-vdonnefort@google.com/):

  * Rebase on 7.2-rc6
  * Use trace_append_boot_param() to parse cmdline options.
  * Fix trace_remote_iterator cleanup order for non-consuming iterators
    (Sashiko).

v3 (https://lore.kernel.org/all/20260721103603.342266-1-vdonnefort@google.com/):

  * Make sure dmesg and panic handlers are using null-terminated
    trace_seq.
  * Make struct trace_remote more compact
  * Fix dump_on_panic test unloaded case (Sashiko)
  * Rebase on 7.2-rc4

v2 (https://lore.kernel.org/all/20260605163825.1762953-1-vdonnefort@google.com/):

Sashiko had a few spot-on comments on the v1 which forced me to heavily
re-arrange the series, so I thought it'd be alright to send a v2
already including those changes.

  * dump_on_oops -> dump_on_panic
  * printk -> dmesg
  * Allow to configure poll_ms
  * Make the ring_buffer_iter functions panic-friendly
  * Gate tracefs .open on remote registration (Sashiko)
  * Use irqsave for reader lock (Sashiko)
  * Fix iter locking for TRI_DMESG (Sashiko)
  * Yield in the dmesg work (Sashiko)

v1 (https://lore.kernel.org/all/20260602171146.2238998-1-vdonnefort@google.com/)

Vincent Donnefort (21):
  tracing/remotes: Gate tracefs files opening on trace remote
    registration
  tracing/remotes: Release tracefs,eventfs on registration failure
  tracing/remotes: Use kstrtobool for boolean tracefs files
  tracing/remotes: Initialise pos in trace_start()
  tracing/remotes: Annotate remote shared fields with
    READ_ONCE/WRITE_ONCE
  tracing/remotes: Use a single per-remote polling work
  tracing/simple_ring_buffer: Add support for compressed length
  tracing/remotes: Add dmesg tracefs file
  tracing/remotes: selftests: Add a test for the dmesg tracefs file
  tracing/remotes: selftests: Prefix hypervisor folder
  ring-buffer: Use irqsave for the reader lock in
    ring_buffer_poll_remote
  ring-buffer: Avoid reader_lock deadlock during panic
  ring-buffer: Use panic-friendly locking in ring_buffer_iter interface
  ring-buffer: Add kerneldoc for ring_buffer_poll_remote
  tracing/remotes: Use ring_buffer_capacity() in trace_remote_has_cpu()
  tracing/remotes: Add dump_on_panic tracefs file
  tracing/remotes: selftests: Add a test for the dump_on_panic tracefs
    file
  tracing/remotes: Add poll_ms tracefs file
  tracing/remotes: Add trace_remote cmdline options
  Documentation: tracing/remotes: Add detailed tracefs layout
  Documentation/kernel-parameters: Add trace_remote

 .../admin-guide/kernel-parameters.txt         |  19 +
 Documentation/trace/remotes.rst               |  66 +-
 kernel/trace/ring_buffer.c                    |  48 +-
 kernel/trace/simple_ring_buffer.c             |  23 +-
 kernel/trace/trace_remote.c                   | 848 +++++++++++++++---
 .../buffer_size.tc                            |   0
 .../test.d/remotes/00hypervisor/dmesg.tc      |  11 +
 .../remotes/00hypervisor/dump_on_panic.tc     |  11 +
 .../{hypervisor => 00hypervisor}/hotplug.tc   |   0
 .../{hypervisor => 00hypervisor}/reset.tc     |   0
 .../{hypervisor => 00hypervisor}/trace.tc     |   0
 .../trace_pipe.tc                             |   0
 .../{hypervisor => 00hypervisor}/unloading.tc |   0
 .../selftests/ftrace/test.d/remotes/dmesg.tc  |  86 ++
 .../ftrace/test.d/remotes/dump_on_panic.tc    |  50 ++
 .../selftests/ftrace/test.d/remotes/functions |   2 +
 16 files changed, 1018 insertions(+), 146 deletions(-)
 rename tools/testing/selftests/ftrace/test.d/remotes/{hypervisor => 00hypervisor}/buffer_size.tc (100%)
 create mode 100644 tools/testing/selftests/ftrace/test.d/remotes/00hypervisor/dmesg.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/remotes/00hypervisor/dump_on_panic.tc
 rename tools/testing/selftests/ftrace/test.d/remotes/{hypervisor => 00hypervisor}/hotplug.tc (100%)
 rename tools/testing/selftests/ftrace/test.d/remotes/{hypervisor => 00hypervisor}/reset.tc (100%)
 rename tools/testing/selftests/ftrace/test.d/remotes/{hypervisor => 00hypervisor}/trace.tc (100%)
 rename tools/testing/selftests/ftrace/test.d/remotes/{hypervisor => 00hypervisor}/trace_pipe.tc (100%)
 rename tools/testing/selftests/ftrace/test.d/remotes/{hypervisor => 00hypervisor}/unloading.tc (100%)
 create mode 100644 tools/testing/selftests/ftrace/test.d/remotes/dmesg.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/remotes/dump_on_panic.tc


base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
-- 
2.56.0.455.g6c5a503b38-goog

