Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED2772F0680
	for <linux-trace-kernel@vger.kernel.org>; Fri,  5 Jun 2026 16:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780677579; cv=none; b=tZqkN2ExnAcBeM2fTxN5O7OpjEmxqSPysLjKqG9oauHVqEa7DCNp/wu+OpUcYanvz8BycW0YLLJT19ALsNv7itT/e3ta0AdtCSrOL97XTs/90huvSsKJOzquJSMo7Bb6/EIscnJzuvqqea+IO06u7ntkNJacdnAnM3mPboSHiKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780677579; c=relaxed/simple;
	bh=Ou4NOC3RweibhE/OPn6kkNtDhvTbvKxOzaWKLbp8KQk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=P62nEM/ZhPDPjY3SfMKs1JCXLqJWD9L9ikQISrGPYcjDXwDucClMyJuEVcwE5qDVwGvvl9oNdiqMvzXp4P8TijZAuqcM/XtJcOXQXuPfzq6R3XsLazoMdnSill8kv1Y4JN0jis7CEp7yoaoIUYzXEvB9Ll8kxCJq/cXsZiBsyRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tdEKWiHp; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tdEKWiHp"
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-45ef55779d1so1322624f8f.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 05 Jun 2026 09:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780677574; x=1781282374; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IPSpJhxzh4X00UlVR7WrKQlFsaZV4UMVYTBRdkl53D0=;
        b=tdEKWiHpb0D/An5rYCrCYG7JIAcJNuRvFlOdUWACz6nGTE4AUOvPymWUXIf8tc0SoK
         Bneo94Yu3VYE0K6q/OC7Mtuf0AtcaAM+OprCvHQ4hIWOO/jGL5qka1EmtJVRA4g+/ruu
         TbUEjYe3Iu4HJeb77HpL5WLW7ftXXkNgl8LKjY6+S5rmGPirdttzOSzIxHrM++9lx5Ak
         HsCSgzK3LgC0nROJ2Jk2at2ih8rf5sTVPp+l8YOSbEJ3l/r5PGIP2M+4O9Or/YLETNLa
         m2X4a1mQkSbp1OmzrOPQqAZnEk9xzVUG4lNBPfAU+yPCZ77H9xpTKmJ7hM8FAmzjbzJ6
         7nsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780677574; x=1781282374;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IPSpJhxzh4X00UlVR7WrKQlFsaZV4UMVYTBRdkl53D0=;
        b=F9XMrUgaO3bcFMv7lmEbpTRUznYK/bkwbiwKV4yefRL+HcBM8xT2DoSwojCJKXyl15
         xD6r9HIBvN7sjWm+qbtLndIupfDvzY1qjj37K+v4iLcDg/0V2ddKssieVupTEavDwhDM
         R0l0XQkYKgnWLcoXa7XZ3mrYc1eD1eQcAxxYnOdqCmRcxJtj89UuKuyu5YtuN1Z/5LbS
         0keZKf19zjjhNF81m9hN4o++GqbAdLd/dj05dGTy44jy9MxW0d8cdWyTwu3LQHlW0EcC
         y7QlApQ3Ce5n6hjJthOMiVr62M/X9AEpLwDW30bD09DA04UeuKkAq26WZ5i9tTYtZ6WN
         FSGg==
X-Forwarded-Encrypted: i=1; AFNElJ/daClXDxaJkLtmNYv6FKv00dy0K0aHcrq5a5DPd3EcocNzkQaJn3acZF+xKSboChuxADBbfFAIRG/Is7IXnTWH/iQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpiRxIhfzmERd5z6wgzLcGwttKBdv/kU7a7WfuDUe+8fKSseEv
	sJ9a3BDkXZ2jLpMXDyVv4q+lCm7+m6txZee4XSNKJ7rdRXacF1KC0CEInSH4Ob1hpuV1ow+g4ja
	A1zRd45IxDnDxiVTNMaRttg==
X-Received: from wrvb13.prod.google.com ([2002:a5d:550d:0:b0:460:2d58:857b])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:adf:fa10:0:b0:45e:655d:6f7 with SMTP id ffacd0b85a97d-46030643ac2mr6397037f8f.24.1780677573917;
 Fri, 05 Jun 2026 09:39:33 -0700 (PDT)
Date: Fri,  5 Jun 2026 17:38:07 +0100
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
Message-ID: <20260605163825.1762953-1-vdonnefort@google.com>
Subject: [PATCH v2 00/18] tracing/remotes: Add printk, dump_on_panic and boot parameters
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	linux-trace-kernel@vger.kernel.org
Cc: kernel-team@android.com, linux-kernel@vger.kernel.org, 
	Vincent Donnefort <vdonnefort@google.com>
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

v2:

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
 kernel/trace/ring_buffer.c                    |  86 +-
 kernel/trace/simple_ring_buffer.c             |  25 +-
 kernel/trace/trace_remote.c                   | 823 +++++++++++++++---
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
 17 files changed, 1028 insertions(+), 139 deletions(-)
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


base-commit: e43ffb69e0438cddd72aaa30898b4dc446f664f8
-- 
2.54.0.1032.g2f8565e1d1-goog

