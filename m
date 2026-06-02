Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E13633F59F
	for <linux-trace-kernel@vger.kernel.org>; Tue,  2 Jun 2026 17:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780420323; cv=none; b=rU4BJYwFrtSNbcpVVoO8y8vv68F4JJHRATK/a9r/NTv+jWEseSI2ecLYnIOPvKtro+xmHx4DfWF2YcIHDze8OnAqfjzrJpIaBrSUMTYtVvFQ2ZvkRgkrUAXOxaZ6FQnGKfM/2vfwFPXyXIVAd4XwZC6pUo+Y3V5Nik/Ena+qzh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780420323; c=relaxed/simple;
	bh=fiNG0bAcUjAZK4NTTiRQq0OnOgp3jdJRwQP3jyuyjAk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=QWnnHLkn/1txMd3Cr8aCHdIo44KJMwNWHdGI6W9FUrJqYZYwtaP2iIu0EnO3qH3+LR2fRremmZEMvPeOTMqVAFi0ORn50qNu3JaQfXVdACS+JgPXbJBdQZeTXNYEksD1Iqf7mCsRh0Vfyaw1FYpCj1DC68JGccHAim9e5Doq22Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IuygI/Wj; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IuygI/Wj"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-490b0682d2fso15329995e9.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 02 Jun 2026 10:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780420319; x=1781025119; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wqZunzsPs9Rmtn5BX9hYGSB16hs/d08mpMJAHStoyTM=;
        b=IuygI/Wj7L7pSk7uV8c3nc+B538T4iLB5PMlerF2bCTZhSS+iWlh51Z/ErzpiZu3GS
         PVGB9tcPnjxL6BQQ4GxKvT4gY3D26PjQWKeJyQ6710KFiUXwZe+8srqA7KrX2D3ZehS8
         18X/X0NDek1BSJJ7FARCNeDhs+MINS5gd0a/3X+/FK1xHLSo9AtJtEJ/Mg7ovcOOjMHh
         Pa4c7TBbYNXksiryFWztPATxpcSL8QUBwKTkETfIWWPSScNz7dato5LslIV2ux6j+VKg
         WngE/w3NFacbbqH1/KpXc7S/c8E7BUS77JLpzCZzb2U9y8sjAMpkUsHPvg9JCjWs6Vhs
         V09A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780420319; x=1781025119;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wqZunzsPs9Rmtn5BX9hYGSB16hs/d08mpMJAHStoyTM=;
        b=S4Edjvn/vHCUKUxUQQJwU4amn9redcmlM0edJGJPMw+53xqUPxGs+6yGzMXvCRVL7e
         LvECbtysWP359L3ywRxysZu695V+990mkU2m2zz/UgbW/9mUu6Nly9c5n80yK1yBKkog
         +2U1M53bSH+uCYfHr+H7DH91+7ORLnMjb+69pCVjt9jkYRTkl9Zc0HEbdGcMd7GyC6Di
         dLjI42OtE4VD+OCezwlqLcoG0MlCWKD9ZXZPvmeDbrPXfJuUG8ntPgbcWgJfzSwHMupa
         HfX3YFQJNzohesqFbnQL++5L0GDmpMghBFlT2jSPipS0Iy8ZLn4gN+Vz+OtaZY+WIplV
         S8xg==
X-Forwarded-Encrypted: i=1; AFNElJ8kSSMatzYwPJ3nMxhWe5Gby0Z0inEDAgX9LTxyP5JCm7xKTOIDclmuP3sONF0U7wSkkBwZ9BQd0arYf9agVcnSAO8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzfHg+E0qDbMkZ4L3O83tP8fdbTLVQP/L0lRMrwyFmJBjmRC3k
	8IZY53JAeIgrjFtufD3P1FZrvrJe6jzYvBZfWVu1TSG0db2N979VoVtzrP+OH/OCSPuc/nC1M5u
	rUmbZZGn23qJb4W1l9Gg4BQ==
X-Received: from wmbfj3.prod.google.com ([2002:a05:600c:c83:b0:490:b2a6:e6f5])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:8b11:b0:490:ab8b:1bb3 with SMTP id 5b1f17b1804b1-490b508e70fmr11385055e9.18.1780420318673;
 Tue, 02 Jun 2026 10:11:58 -0700 (PDT)
Date: Tue,  2 Jun 2026 18:11:32 +0100
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
Message-ID: <20260602171146.2238998-1-vdonnefort@google.com>
Subject: [PATCH 00/13] tracing/remotes: Add printk, dump_on_oops and boot parameters
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	linux-trace-kernel@vger.kernel.org
Cc: kernel-team@android.com, linux-kernel@vger.kernel.org, 
	Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

This series extends the recently introduced trace remotes
infrastructure, bringing useful features for developers:

  * dump_on_oops: Dump the trace remote buffer on system panic.
  * printk: Redirect remote events to dmesg.
  * trace_remote=: Configure a trace_remote from the commandline.

It also brings a couple of optimisations:

  * Header compressed length support for small events.
  * Single work thread for remote polling.

And some misc improvements:

  * Use kstrtobool where possible
  * Fix trace remote unregistering

I didn't put a "Fixes:" tag on the commit which is fixing the remote
registration because I do not believe this is something any user can
trigger.

Vincent Donnefort (13):
  tracing/remotes: Release tracefs,eventfs on registration failure
  tracing/remotes: Use kstrtobool for boolean tracefs files
  tracing/remotes: Use a single per-remote polling work
  tracing/simple_ring_buffer: Add support for compressed length
  tracing/remotes: Add printk tracefs file
  tracing/remotes: selftests: Add a test for the printk tracefs file
  tracing/remotes: selftests: Prefix hypervisor folder
  ring-buffer: Add ring_buffer_read_remote_meta_page()
  tracing/remotes: Add dump_on_oops tracefs file
  tracing/remotes: selftests: Add a test for the dump_on_oops tracefs
    file
  Documentation: tracing/remotes: Add detailed tracefs layout
  tracing/remotes: Add trace_remote cmdline options
  Documentation/kernel-parameters: Add trace_remote

 .../admin-guide/kernel-parameters.txt         |  16 +
 Documentation/trace/remotes.rst               |  63 +-
 include/linux/ring_buffer.h                   |   1 +
 kernel/trace/ring_buffer.c                    |  53 ++
 kernel/trace/simple_ring_buffer.c             |  22 +-
 kernel/trace/trace_remote.c                   | 649 +++++++++++++++---
 .../buffer_size.tc                            |   0
 .../remotes/00hypervisor/dump_on_oops.tc      |  11 +
 .../{hypervisor => 00hypervisor}/hotplug.tc   |   0
 .../test.d/remotes/00hypervisor/printk.tc     |  11 +
 .../{hypervisor => 00hypervisor}/reset.tc     |   0
 .../{hypervisor => 00hypervisor}/trace.tc     |   0
 .../trace_pipe.tc                             |   0
 .../{hypervisor => 00hypervisor}/unloading.tc |   0
 .../ftrace/test.d/remotes/dump_on_oops.tc     |  51 ++
 .../selftests/ftrace/test.d/remotes/functions |   2 +
 .../selftests/ftrace/test.d/remotes/printk.tc |  72 ++
 17 files changed, 847 insertions(+), 104 deletions(-)
 rename tools/testing/selftests/ftrace/test.d/remotes/{hypervisor => 00hypervisor}/buffer_size.tc (100%)
 create mode 100644 tools/testing/selftests/ftrace/test.d/remotes/00hypervisor/dump_on_oops.tc
 rename tools/testing/selftests/ftrace/test.d/remotes/{hypervisor => 00hypervisor}/hotplug.tc (100%)
 create mode 100644 tools/testing/selftests/ftrace/test.d/remotes/00hypervisor/printk.tc
 rename tools/testing/selftests/ftrace/test.d/remotes/{hypervisor => 00hypervisor}/reset.tc (100%)
 rename tools/testing/selftests/ftrace/test.d/remotes/{hypervisor => 00hypervisor}/trace.tc (100%)
 rename tools/testing/selftests/ftrace/test.d/remotes/{hypervisor => 00hypervisor}/trace_pipe.tc (100%)
 rename tools/testing/selftests/ftrace/test.d/remotes/{hypervisor => 00hypervisor}/unloading.tc (100%)
 create mode 100644 tools/testing/selftests/ftrace/test.d/remotes/dump_on_oops.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/remotes/printk.tc


base-commit: e43ffb69e0438cddd72aaa30898b4dc446f664f8
-- 
2.54.0.1032.g2f8565e1d1-goog

