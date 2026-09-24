Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com [209.85.221.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A126949D5BA
	for <linux-trace-kernel@vger.kernel.org>; Thu, 24 Sep 2026 14:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790261912; cv=none; b=Un/LFlYApsiXtGL/Gw/PwaUcz1v9t0jz5o6AWOYV/6cgtZDIRGp6B7Uc5wnksP0GaeobTsBPiqelt8qdbSn+FlbXt+qMze4Xz/Ojnt7Se/i4NcdbFfZ5e7KqOjCZ2gi2p5RGJGJscWonsAI0qJNNoYXDPwK5+DkQiUhIccLVscY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790261912; c=relaxed/simple;
	bh=iGxObYsxfMXVS4DwNX66BB2uJBMvQFGo72urG75z4Kc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=TNqURyqS8svqo0ziBACXPrlpBmW2AnIwxYPPhOqBhlvgW7kxYJ5QsbFE+WFkU1PnrWQgfrQwQLIwV2Y3jits/0gJcDdd2MfH62QQCToHSL7nYjchLTGer1Mn1FxShZjqIZJFdulSJBG+vwpvF5ffzTW+v5+VZlHWyGB5T31WfmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YiINUp4o; arc=none smtp.client-ip=209.85.221.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YiINUp4o"
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-486f768517dso1711585f8f.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 24 Sep 2026 07:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790261904; x=1790866704; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1e18QunqfVE00zml0hGARGcOCLbgPTTNUS9PK9RCQ6c=;
        b=YiINUp4oOTBbiqrGDlgQzk6IUAQC9vYtV9S/k5DXq0U/OBR7LEmOEB+EPloGbprPeX
         zSh8LQdVVse7zJD5Z5u0UVQcmCG2E0426/pWtNxbWexkMOI+yqfloi6GkoE4btnW98Fa
         zrmBEKA4orZcXxKRhWsP8w1D31wzc7utFCwX0vNj6Z//up7Q1XLxjd44na6hd/Ph8jJa
         YsfoOwrzub2MsptsN+T50ozWzDYiLTsOjnQ7Y1zk6b03SRcSATyASw0dl67DuMQ9/gpM
         e5vUOqpcz4f7vQ1qBSSDeYkZ4J6svq/p+6IAJ5wx0GqbNDEsEXlxbcItxEQ//KZmhpu0
         R+vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790261904; x=1790866704;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1e18QunqfVE00zml0hGARGcOCLbgPTTNUS9PK9RCQ6c=;
        b=azc7j+6AiagOWBTuMfvV+GpGj5zMm+YfBL6IPOAfTLaOOvIMav/rP1f2aEe3gH2nNh
         JRXxUeGI61zXDQGNPA5zS+kPkRec3BeecO7h+Qu3J2Rv17NjYxzK4wRq5w0YkkVlAaTN
         TMPtP7UcB4cgZJxT9EmgLTwrkAxokeb31i4X1fhcOo0d0uQ2tcQFBrhearWYNP+3SGK1
         qpBD19zaWKQZi5aKyma2RymAy/BLXFwv0bom3MOb5vbxzrOOw477JnHOjNy5iC4E+jID
         AfBH92AnAu+UG6cGiU8hvlubAdU7Cowhug+UARrHjTB3lDW+7sW4+mm2UjpTU0h5qw/1
         PYYg==
X-Forwarded-Encrypted: i=1; AKwUvBySiZgbfTQ81f2nqwJM6XkIqFKB3CYZFJU9mHPwtkDEeE8mGssX0tGGelYteB33jUww6kNXONE9++mjvIv2OTXA3YE=@vger.kernel.org
X-Gm-Message-State: AFuF++mTR3ZOJl8cJ9pwe50+nFB27Zc14KZKRy5APKaCfSmVJw2GbGuT
	SSNP9pzFv+QAapZZwo9MRUyGnpZtkVfe4rMc5B45sYk3PaFVvY/SWePcPRYu1CbDmMQSOp5i4v5
	7/8M1Kf7QhZvWt60Ydmw1Vg==
X-Received: from wrbep7.prod.google.com ([2002:a05:6000:42c7:b0:487:1add:cc9e])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:3105:b0:487:27f9:82d with SMTP id ffacd0b85a97d-488716f7577mr5418365f8f.34.1790261903929;
 Thu, 24 Sep 2026 07:58:23 -0700 (PDT)
Date: Thu, 24 Sep 2026 15:57:34 +0100
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.rc1.310.g51773c2048-goog
Message-ID: <20260924145754.1285146-1-vdonnefort@google.com>
Subject: [PATCH v7 00/20] tracing/remotes: Add printk, dump_on_panic and boot parameters
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

v7:

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

Vincent Donnefort (20):
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
  ring-buffer: Use panic-friendly locking in ring_buffer_iter interface
  ring-buffer: Add ring_buffer_read_remote_meta_page()
  ring-buffer: Add kerneldoc for ring_buffer_poll_remote
  tracing/remotes: Add dump_on_panic tracefs file
  tracing/remotes: selftests: Add a test for the dump_on_panic tracefs
    file
  tracing/remotes: Add poll_ms tracefs file
  tracing/remotes: Add trace_remote cmdline options
  Documentation: tracing/remotes: Add detailed tracefs layout
  Documentation/kernel-parameters: Add trace_remote

 .../admin-guide/kernel-parameters.txt         |  19 +
 Documentation/trace/remotes.rst               |  66 +-
 include/linux/ring_buffer.h                   |   1 +
 kernel/trace/ring_buffer.c                    |  88 +-
 kernel/trace/simple_ring_buffer.c             |  23 +-
 kernel/trace/trace_remote.c                   | 841 +++++++++++++++---
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
 17 files changed, 1050 insertions(+), 148 deletions(-)
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


base-commit: 93f51579e7df248780214094418f205253383cc5
-- 
2.56.0.rc1.310.g51773c2048-goog

