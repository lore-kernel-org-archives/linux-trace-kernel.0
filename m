Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99100437844
	for <linux-trace-kernel@vger.kernel.org>; Tue, 21 Jul 2026 10:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784630185; cv=none; b=KnGBdbgo8YPZUarNWeKOgWalxIfaCouW+gw0T2NYzX99QNFlRISNWxWAlMZR04Yqmh2S/lhUD3p1J1wrQYkRFc9+we1z0P/NGRC6Hk4sBfKXDZAWED7YLfC3++HKttVAQvABhRwsbT3Cfpi3d56pAU/UBI2xxHITuIbp9fWuOrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784630185; c=relaxed/simple;
	bh=UBal+MUspsHlq0J61JV2zjLILte2l5BRU+SUqJaNMqc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=o5zaXrFXYqcjsB2A9C84kJu43iU5NmGJxUUAZTu8vMLFYBwFju1ViNrCfKj3lobliVgmI+WLKm0Bg/a2XeWMxXNYV5MubV/vahK+GTlN6fFR7YDrNxKTC2RM8a+IB6O9ptJEXfPSqhuhHNwx2F+eJxDcsjaXOqNBOLCZTyrWTz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kMSMpHCe; arc=none smtp.client-ip=209.85.128.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kMSMpHCe"
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4954dcd6131so35998225e9.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 21 Jul 2026 03:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784630181; x=1785234981; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=F2vHuF7qw3o+XDYk1bRfnFG/zmMo9aEJv5/fWrgkpCg=;
        b=kMSMpHCekt87+jrnTxPFeOGO/v/6qOfsQv8x0jX/Z09h4YA/pu7+HJhnlC9z2ipM9G
         Oq7pA7IuC/RyQSr2j4e3ke7uvRXhOfCBRu6LiJ3QYrSsZhveH3+X9nuBalnHxa9Nt4Sd
         lkHwSJ84raY11j+J008JG9Ag7ba6Wi9pYdMa7zF0IgKQwpPw5QazCn1PyTdUupLkfAYb
         ce5vsvWP3xMSyomoNuyHWAJbmHzWaNPz6P6PHOylwuFCTrljjSmKsz/thlrh+AWKGYw9
         mFfk/d4foKszKHrNDSqowCIkjr2iJz42zCyA05bzTU/N7nJRHFfPi/Y5WTDwjjAsTt3A
         +kmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784630181; x=1785234981;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=F2vHuF7qw3o+XDYk1bRfnFG/zmMo9aEJv5/fWrgkpCg=;
        b=Htey04eR3DtYQwQkfWFFIgwitoN/NofhxM8DWdiWfVrCUy6oYiGtOONup5YE5R3Jks
         1NZDYD/ls4hjKUFhtFb8jFG6R7TLf1iM5w4VU54nrIPYtCpZQiLMipU/MsxFi/mRbj3x
         mSU/7byQTAcnnbYbGvVcUga7Qpz4plJEle+NXpVM3zDAvL7yFhEyPNdRUMak+xWhkxtW
         48LR5RzTyeeq6r9aQLrcCEYTCsYwKIujt4tBirQJwV3LIwvA9G+dcDhYhzh6hVKYkg51
         ZdyP9x5c3Sz3j7ascZf+e9YKU9qN7VBk0fj8t+zhJjMrnFNxIFI6MPjLlqPFKQEvduGm
         KeLg==
X-Forwarded-Encrypted: i=1; AHgh+Rq5Fkm4ElfeT72rDUgsCsNQNPS8MV93hXSTl9ypHDueFpOv6WiWuKuRUji4bvYV1BGWvVox4W2MDRsopnn7CdZVQbQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSvqw/bm7fmE3QuKTqJ8XOFgVm+x0rfKylARaSLGbFPgNaAvF3
	FxGJVCIBpDZXcjpmNy+u9sqeKsf3F12ONdKSqoUTzo0AEsyou9i0H2/olF0WnGw6+7iOeXAGYb1
	XdTh82DSe2w2VDGd0xUm4Gg==
X-Received: from wmpj5.prod.google.com ([2002:a05:600c:4885:b0:493:b328:830b])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1548:b0:493:c062:a533 with SMTP id 5b1f17b1804b1-4954a3e8fe1mr204300545e9.17.1784630180542;
 Tue, 21 Jul 2026 03:36:20 -0700 (PDT)
Date: Tue, 21 Jul 2026 11:35:45 +0100
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Message-ID: <20260721103603.342266-1-vdonnefort@google.com>
Subject: [PATCH v3 00/18] tracing/remotes: Add printk, dump_on_panic and boot parameters
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

v3:

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
 kernel/trace/trace_remote.c                   | 825 +++++++++++++++---
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
 17 files changed, 1031 insertions(+), 140 deletions(-)
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


base-commit: 1590cf0329716306e948a8fc29f1d3ee87d3989f
-- 
2.55.0.229.g6434b31f56-goog

