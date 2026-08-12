Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A4138944D
	for <linux-trace-kernel@vger.kernel.org>; Wed, 12 Aug 2026 16:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786551228; cv=none; b=a88MydF0m1WP1ooTFp+jh5dG1hpam6JFdg5GL9x9scfRERUqLCXpyBna2payZle7yCDBenqbgiBwWqGUPuAIV86JPt9E6M1+apiid5uFWNfgvvYpUM+o8NO9JbDLs+bhN+PVLhYcTNdg8gimivTR4qUxGkEWYpmLqNr0KaxcXio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786551228; c=relaxed/simple;
	bh=zlJiy7Lskp7fPiaYc1w00lksFFmHcJT5rhoz2SKnPME=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=C3rCTB/XovXo2bGvRlH1Ei62V9boDTrsapSkdHZj2GM4vYSsOeknC3hhFWLDJVfiEgAQBo1yEwX/QAQNF3XiDcHBVZE/5SiBokjOgd0ec86dwNytKfSH5rwOy7q5enNNTsoZIe4HIbLzybotuMtKWhE1kurJILb3FSFLE0TyFJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OJnoBjzY; arc=none smtp.client-ip=209.85.128.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OJnoBjzY"
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-490a767c7dcso9675895e9.2
        for <linux-trace-kernel@vger.kernel.org>; Wed, 12 Aug 2026 09:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786551224; x=1787156024; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xrE2u64S82F1C4AwUwPP20oILB/i2V5EILdyGWgL5to=;
        b=OJnoBjzY8s70K0MuPANn+odPwhKBSdLM+QutqNMt6fpUuk0RONZkDAMIMtxNt3KS3q
         pJRzic41rKt/nj3xtKvWglLk5aPTHPzX/5Zbf9+0t4dOCk5dsCNdflAjTFrW2MN6TLe5
         yOtslnxyB0J/PgUcuo3AFXqAse0ntSgcgZ2UbrSQ72PF9J4oJdcBGx072JuXnL18Bs56
         TycY/TNiFvLmxjsZYcUcqzKr8X57O+Y1YR9kyjYy4GrxIz+dvvulkpOBaqq77mugrvBj
         3C1rzuDe2HxmMcaMwN+MQwJ4KEon4oaiQo8Y1S8S2V0kV1fW3A7cdYPND77kqWlCznsf
         vMow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786551224; x=1787156024;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xrE2u64S82F1C4AwUwPP20oILB/i2V5EILdyGWgL5to=;
        b=XOhQUubw75+HzkkgOtaSwwSRWD71UbBWLx33QI+vUr6+0qio+Z5uJLc52yJimBpCLr
         Y2TMWZ/SPSdzQ4LBUvRKjKNrh47F4VmOslt+muwOi6R8NUZDfoVZo18LtPIUatyE03uW
         APbByLsm3IVEwnrxq+wHTrur8y2n0qPN+KTlkmbQLqiOb8sQrZYqqgxJmNH0TT6yBGCs
         OQWOtlh4N4TZu4MDggaqXTd2wLcyRWdzZnt79dx6ys2DlsitX2tRcgcXFQzw2mJL6xta
         tXFkeeYVfk5jQOrk89YP+NyyMhVLJAeRqggCu7Ojm2Me3zkgcqGSJqkLIfX9oH2Iou6D
         td0g==
X-Forwarded-Encrypted: i=1; AHgh+RpsCvvB+1BXdd75kA9ySIYRJqWnNetTY4HGYNS0CQjOWqCVDgp57ip6VkOFBx/8REUY/8SVw7ED6H3NIbNYhyuJjCo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKbKYzk59mNsfS3oV5yaDTiDgWOa5yRjxuWgTCdgT7cO42UL7h
	0ee+YuedaYSMIhImUN98t8vXgKObp08d2KFIAYcnAPrmKnqC3XdGN4yBUR+UKs0QsT7kehvb0Dm
	jfTq0AeI0ZC2bL7jukcrGeQ==
X-Received: from wrpr8.prod.google.com ([2002:adf:f708:0:b0:443:10cf:2903])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:6012:b0:499:81ae:1020 with SMTP id 5b1f17b1804b1-49981ae1070mr635165e9.11.1786551224266;
 Wed, 12 Aug 2026 09:13:44 -0700 (PDT)
Date: Wed, 12 Aug 2026 17:13:22 +0100
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
Message-ID: <20260812161340.2417322-1-vdonnefort@google.com>
Subject: [PATCH v5 00/18] tracing/remotes: Add printk, dump_on_panic and boot parameters
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

v5:

  * Use seq_buf_str() for safe, properly terminated trace_seq extraction. (Steven)
  * Remove destructive dmesg -c from selftests and rely on timestamp matching instead. (Steven)

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
 kernel/trace/simple_ring_buffer.c             |  25 +-
 kernel/trace/trace_remote.c                   | 817 +++++++++++++++---
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
 17 files changed, 1032 insertions(+), 140 deletions(-)
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


base-commit: db2ddb87143519e20a95aa36c60b36107b736a58
-- 
2.55.0.691.gc56d675ccc-goog

