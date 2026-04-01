Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 165AB348452
	for <linux-trace-kernel@vger.kernel.org>; Wed,  1 Apr 2026 02:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775011921; cv=none; b=BAK2TaB53zBg22Wrv/xkGJjBwEoRYGexAW1XcUIw/Hn3YvY2h0xC1nwJwreB6TWwz9wXBPFhxVC04JVuXWt0Ki3u8Ioc4snJhelN1SCljSDR2ZTyTHnjwlXYS7LNW2vBwD6Mhtt0WkmXm7xhLCpC7S55MZ1FpNhl1yjms7HYJOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775011921; c=relaxed/simple;
	bh=v8uP+loqAODVvNXhIzGHgbVhwp3PKZxKHMCifhit8Nc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=pVv+eM2AZ+EZf1+/Gg82PYZxSfJkPMbUfZg/MsR29wY/mrSryJPayiyTIs04h2B3On4dAYWVEw99K0NrMGI5oTN/11I4VFIusTtRkLqhaMbHwhOo4qZqhJ48tEn1tY/38OoUzhGLBsqpyV6bxCz+nP3clmN1w/5CU/vSDz+T7Lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oV384VkH; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oV384VkH"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-4852ccff333so68301465e9.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 31 Mar 2026 19:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775011913; x=1775616713; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nCQmN6VtcmQnyUl+5vnWl7vaYlGtjGH8RG3CJJU7FUw=;
        b=oV384VkH7bjvYXZsQDM93eOCf17tLwZxsWPEjnLzpGDBZcdDx/B/LO6N5K6Xm6PeN+
         e8x/s9mpTgdLYs2aOq/sOyAIcz2vdb+CjFO4TVrDFKJH7o9HbXHDGZs0IPdjflPtQMQh
         0JzwoMXNppNO5Dz/I85TMKBbcYZCkG6c3T72Nr4xomOeO3lkqw4aadXuOYNenSWZumlm
         tvRkItYbjPaDsnZ7WO4JgLAHxyY5Uciuxh8Y9WZFb7i/pA8m8L1DSwJR/CZU4CPJRJnb
         L8rX7oUXYZ75nzG9E+a1JRetU6b4NjsdEhIpqXnBdBUGNevs2wPfDdMF210ROsc2XRc4
         ANEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775011913; x=1775616713;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nCQmN6VtcmQnyUl+5vnWl7vaYlGtjGH8RG3CJJU7FUw=;
        b=rPa8NhWADYp5/QVhnbzL1UcYViYYO2VnEqgpNmOfYR5AqMaTOFwgon5bbAAfeh0CZ2
         sQMPX5gSZyFh4NtJbgeUK7kE55VV+7gLjIP0X60lJZLw+lhL0g01JkS3YofP9bGT99Kk
         F33wAJDiKalr18mB3DTrCe12kSGEh1Z3/D+K6ItyH7XfB/yQtSGlmuXO8R9/Z3wg1UzW
         iRRpvdwqqnCpD9rP/x+a1ionAGxSqMnTmzyZe/uqwQWi+9lscYAn39Yo48V3NzqnDdUs
         dLZczfngMcHY/MIG9IdGS2fCprtbeFZ1lcpsvTuxokp4B3oYPw4np4AEj45VPV+SUHIQ
         kspA==
X-Forwarded-Encrypted: i=1; AJvYcCUIgUtZkPJbjsW4wGWa4VxL3PlzhdyQH6ayWEjz5M6EiL/UfSbhrepSZhR/rAmmRMh7ZS6KFJuCFBPaKGJyBp1QzBc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLfSKmN9OCnGmY9fFguJo8LiHq4MZg+Zd9Wgc2i6CVoOLO+O4/
	9Lsm9gkjTKJ1yy3MEK7qUyeyxlF3dZ6xzXsD66wrra5cVjCesvk5ckdA56ZlwCE6ocBuY20fUpp
	ODQirOzGUrfLmzTGTPbhwFw==
X-Received: from wmpv8.prod.google.com ([2002:a05:600c:4d88:b0:485:696a:671a])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1d16:b0:485:3e19:9e01 with SMTP id 5b1f17b1804b1-4888359d2afmr26992145e9.28.1775011913424;
 Tue, 31 Mar 2026 19:51:53 -0700 (PDT)
Date: Wed,  1 Apr 2026 03:50:01 +0100
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.1118.gaef5881109-goog
Message-ID: <20260401025003.3258729-1-vdonnefort@google.com>
Subject: [PATCH 0/2] Fix trace remotes read with an offline CPU
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	linux-trace-kernel@vger.kernel.org, maz@kernel.org
Cc: kernel-team@android.com, linux-kernel@vger.kernel.org, 
	Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

This small series is fixing non-consuming read of a trace remote when the
trace_buffer is created after a CPU is offline.

It also extends hotplug testing coverage to include this test case.

I have based this series on top of kvmarm/next which contains the hypervisor
tracing patches.

Vincent Donnefort (2):
  tracing: Non-consuming read for trace remotes with an offline CPU
  tracing: selftests: Extend hotplug testing for trace remotes

 kernel/trace/trace_remote.c                   | 21 ++++-
 .../selftests/ftrace/test.d/remotes/functions | 15 +++-
 .../ftrace/test.d/remotes/hotplug.tc          | 86 +++++++++++++++++++
 .../test.d/remotes/hypervisor/hotplug.tc      | 11 +++
 .../selftests/ftrace/test.d/remotes/trace.tc  | 27 +-----
 .../ftrace/test.d/remotes/trace_pipe.tc       | 25 ------
 6 files changed, 129 insertions(+), 56 deletions(-)
 create mode 100644 tools/testing/selftests/ftrace/test.d/remotes/hotplug.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/remotes/hypervisor/hotplug.tc


base-commit: 5ad2ff071b5980f072a85c8114649218971c586e
-- 
2.53.0.1118.gaef5881109-goog

