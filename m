Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35BA046A5FE
	for <linux-trace-kernel@vger.kernel.org>; Tue,  4 Aug 2026 14:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785852239; cv=none; b=FEx1B1OpijAP7aDAEcZgd5fzdtFXKa2yfhIQ9AYWNZoCAmrekujnTY1RUN8e1wbNUO8TUhGpk9IShml/X9N+9+lEUQ1xkR356T1Sq3ucs0a9ryhKH0zGm4J1HkEqRgYlxTPkXgA6LdkZf6vc9kxEyu7+HLuYuHDO/pd21M7G838=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785852239; c=relaxed/simple;
	bh=JdJVJRr81jEmInEKg/XYBpLF+3BsPU2zrgBOdf3DJ1E=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=kPYN+gje25V+LkQ/s2RtNIRVWquOZCKChPy94m4hAgklwiTntRBXvaniLAE3FLXrgcNdghbQQhEsjotFP5q0NjvlbT2/GVQiyKm1CsJ7nsBstpYA4PnBWhnl1hcaBx073G0pH0qhE8UEMKiB80A0f3aELvGASRlC0JY+t0rj1MI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rOWzpooZ; arc=none smtp.client-ip=209.85.128.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rOWzpooZ"
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-495529a93f9so35141985e9.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 04 Aug 2026 07:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785852235; x=1786457035; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zNucLJePQltcgf958PL+TOF4pNitbALZrPMNVguzHOU=;
        b=rOWzpooZdYpVAqMc1Shn7k81/29qMEqeW598aAzqGcIuEKW8NUSAN77OwXGp/DaTVq
         94E88pzvKIQzNrvUC7YDUx37y3Tj7oUL4g67WoAGIug3ZM7w0tWuwoGHZnTjfrWNXOHh
         zIAVQLmVBsib7OAebqpX0qIsn9ID3AtJxb82fzRjpABnF6k87T0hl3HK0UclVQxrrvkR
         sOFPyTNSWT6tEXpUiGVG8Nf7jWuBOS51fQR7HQrnl/2LkIq1koGoteO/c+cAgAp5nSwZ
         H57nWEEJ+WCBNDMqCYBsPp8bI87hdZZgOQppCYK/031jDtkd7NEohGoMlRL1mrQ2vzf7
         EyJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785852235; x=1786457035;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zNucLJePQltcgf958PL+TOF4pNitbALZrPMNVguzHOU=;
        b=FN0uFmMqR2gRqbOBCqnU1HQ1fOUIrEscadd67sPMn4zt9czlCQXd7UZUt++PXPpK5a
         94oep3jg+IOFi1YnSIrrDUaznISrdtm45mLJL+5czrBJ/GKnWP0TzbV4UwAhZ7/V6mLx
         aJOzV7x0CeWUe4iJl8Hw6/5T4aD7gaHj45HWHMS2Rm/gi0+oshNP5TdzFJ8mA3skQLFh
         JlLxgF0zCIxtHR5RAFT3UOUZTNZWDSa9akqa+PrdFwV+j84gw1RGOyw6yh3HlTB0tsWE
         y2IQ/gENL4yaZtuJ3mmAD904KX1DMC7PlpJbqD+LyBUWLUM6ykH8RuC3G+vAI2m8rnGF
         7eqA==
X-Forwarded-Encrypted: i=1; AHgh+RoQQtWY8F5m4ymHDH1wz+/yEbB5EJoa1K3totoaq/dHx7f9Phhha7rGIfltlBQPni8+hufRhh+jPLyjn+OWbHX5BCs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyCB655vqhjIRcnG7OFK0fpn+cEOJu8pT83422Zav3ZZFrzYiv
	wIa7AfeKokFw6Fc47q5ZMMKCQOCDefN6LZt/hTmWI7e2JUBDcLvfjBVeFElnhVmovA3nm2ZjcEn
	EfCqw5V+khl7S6xMzvcCmiw==
X-Received: from wmjx19.prod.google.com ([2002:a05:600c:21d3:b0:493:c42c:7e97])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4f84:b0:496:bbcb:b0bb with SMTP id 5b1f17b1804b1-4980c674e31mr336259875e9.18.1785852229916;
 Tue, 04 Aug 2026 07:03:49 -0700 (PDT)
Date: Tue,  4 Aug 2026 15:03:15 +0100
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.571.g244d577d93-goog
Message-ID: <20260804140333.797210-1-vdonnefort@google.com>
Subject: [PATCH v4 00/18] tracing/remotes: Add printk, dump_on_panic and boot parameters
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

v4:

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
 kernel/trace/simple_ring_buffer.c             |  25 +-
 kernel/trace/trace_remote.c                   | 818 +++++++++++++++---
 .../buffer_size.tc                            |   0
 .../test.d/remotes/00hypervisor/dmesg.tc      |  11 +
 .../remotes/00hypervisor/dump_on_panic.tc     |  11 +
 .../{hypervisor => 00hypervisor}/hotplug.tc   |   0
 .../{hypervisor => 00hypervisor}/reset.tc     |   0
 .../{hypervisor => 00hypervisor}/trace.tc     |   0
 .../trace_pipe.tc                             |   0
 .../{hypervisor => 00hypervisor}/unloading.tc |   0
 .../selftests/ftrace/test.d/remotes/dmesg.tc  |  72 ++
 .../ftrace/test.d/remotes/dump_on_panic.tc    |  51 ++
 .../selftests/ftrace/test.d/remotes/functions |   2 +
 17 files changed, 1024 insertions(+), 140 deletions(-)
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


base-commit: 075b74841bd0065a3bda3440873c747938e69b68
-- 
2.55.0.571.g244d577d93-goog

