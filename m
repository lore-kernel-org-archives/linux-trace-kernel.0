Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com [209.85.221.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF104331EB0
	for <linux-trace-kernel@vger.kernel.org>; Mon, 17 Aug 2026 13:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786974925; cv=none; b=pVm1X6Jo6Wb1T7VXdR9YETlI94JxMKjOo6qmM7WIubtzqBgcDLonK2WIg1yG3vVrvD3P+EQlIbSR3r+yflL4WvO4dI3i6Q9Zd8GLKizP4P6DpNMARvcT9Z6P30oiXsiYn4vg1Ktfi9cLwesnmKPd6XWA9I5olRwuqBxD8jfk588=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786974925; c=relaxed/simple;
	bh=A2OLb/BkFpN85xuDPErh6jfr9SKnUlrEVWLPYqt+S+k=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=RCXW1nCa52myqvm0RhqMi3GJyy7bFMhxhpqkFsieN/DWvu8AOlRaq9d09bYUkVb3yX2SHsq1LH8yBCzddKtzzbnTv9/V0yKivNnVU7oZfV9jb3jWhBof9LDkF/fAbDGUUcjqPx7HG+YgIwbdTMt8Rt0S2+LzBnFMwvxhiy9qAdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BMw3mdg5; arc=none smtp.client-ip=209.85.221.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BMw3mdg5"
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-472c330e555so1590166f8f.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 17 Aug 2026 06:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786974919; x=1787579719; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+zfK38K5+8Lp4geyxeDItIa8QbdNxH8AS3ABAGbP7TI=;
        b=BMw3mdg516GvskD8lXUhMsRgf/o4fNNkbnVOK44PJtt/IH6sr/jhc2QLwS3ALGmZYe
         JsW5D8zGJxlfFq96uMReUuH8TUQSTyJ2HFQGvnHKuRLv5Q3jGwf3/bBdPKZRjJpxvpQf
         SQ9s5EOIgXWmapBa8LdjqGY1s9QX11FSytdw/Ifn0oms7/xTPtfDYQY2rDQ0BPkpBSkz
         pBAAHAayR/pe9GBUjwah0IbJQcRw+fRRkE5nfWj94XQXgm+dXWdCU4UGE2V8dE4re4s9
         VZWHIHBTB+DdfR8HIdHr8LF/2UIXpkPjs2SDQeQltKDrlOkLXPOaT8kttvLTPmpcQvTu
         1Wyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786974919; x=1787579719;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+zfK38K5+8Lp4geyxeDItIa8QbdNxH8AS3ABAGbP7TI=;
        b=cYxw0PAQ0uEEX+CX+vGFQvf2PunhATyn2ZMQkDJGv6PEIYeH8uvCO9Omyza293Vk19
         bIUWTUkj4NWqf6O81BtS0O71qqdT8CghHW2zaswooKKseU/UhV2u4TkqJlkw7DcVr1oQ
         HfoweecSDPG5RI7PsEFZnU7BuyuSJScDIPNOb0lv91Dk/3b35lvtL04VQa90PBAhKQiA
         UxdNQD+UxguxmFdPJ4Rl1eG7nu77XDAcOyxXkrTYYAx5nLTgIs2OCgjZyOq5WE5ljCRJ
         PXffHNsufEcoZqhZ7MWPG48Vz4j7ejw6Yy0LrDnGpPHLtqWdra6gjD4CL39inIFZ5I2r
         /i3w==
X-Forwarded-Encrypted: i=1; AHgh+RqiGpKkenEO83BkY3d+InqU/ABVatPoT2/YvKJY7zFGd7TZew6+5P03GYm4AOSnN1BnsmTuaUlbvXtGqzv7UP8fXSU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1qaAfjX8EPQDY7KH7tDu+uqMPT5KIJxAB2WL9VkBU7IoiDDr5
	rS+mxrDhGi+9Mth+uOwY6t9GiB6PFBRRMzsctMi0slyxlUmqjT7FX4qhlFsSvvZhjlIE4LQcURB
	bX+U9iIMgA5EriUDKXnGJLQ==
X-Received: from wrrb12.prod.google.com ([2002:adf:f90c:0:b0:470:19c6:5b61])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:adf:e008:0:10b0:47f:8112:f793 with SMTP id ffacd0b85a97d-48160713d31mr28304546f8f.13.1786974918967;
 Mon, 17 Aug 2026 06:55:18 -0700 (PDT)
Date: Mon, 17 Aug 2026 14:54:59 +0100
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
Message-ID: <20260817135517.3919534-1-vdonnefort@google.com>
Subject: [PATCH v6 00/18] tracing/remotes: Add printk, dump_on_panic and boot parameters
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

v6:

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

Vincent Donnefort (18):
  tracing/remotes: Gate tracefs files opening on trace remote
    registration
  tracing/remotes: Release tracefs,eventfs on registration failure
  tracing/remotes: Use kstrtobool for boolean tracefs files
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
 kernel/trace/trace_remote.c                   | 820 +++++++++++++++---
 .../buffer_size.tc                            |   0
 .../test.d/remotes/00hypervisor/dmesg.tc      |  11 +
 .../remotes/00hypervisor/dump_on_panic.tc     |  11 +
 .../{hypervisor => 00hypervisor}/hotplug.tc   |   0
 .../{hypervisor => 00hypervisor}/reset.tc     |   0
 .../{hypervisor => 00hypervisor}/trace.tc     |   0
 .../trace_pipe.tc                             |   0
 .../{hypervisor => 00hypervisor}/unloading.tc |   0
 .../selftests/ftrace/test.d/remotes/dmesg.tc  |  81 ++
 .../ftrace/test.d/remotes/dump_on_panic.tc    |  51 ++
 .../selftests/ftrace/test.d/remotes/functions |   2 +
 17 files changed, 1033 insertions(+), 140 deletions(-)
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


base-commit: 8d3ae59288f1e7d58d76558a6ee96d533bc5019f
-- 
2.55.0.691.gc56d675ccc-goog

