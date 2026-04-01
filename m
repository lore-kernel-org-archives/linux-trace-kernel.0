Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC2783806AB
	for <linux-trace-kernel@vger.kernel.org>; Wed,  1 Apr 2026 04:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775019142; cv=none; b=Ad9qbyICapBz+9D0tiUcoDv9jMCAHgMq8hSUrJO+vWqfmcyAIFYaYtyOfT/TXkVt2kEyf8oyLPeITKMBCRBhV/RUQBPN/SIOL/M102C0744OQfuwxFB3D7uRzIjYrEy8MhUvJz0MIXUN8Dz9ZyB2xTM2fRTI4S/zbgTzyJD0Jx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775019142; c=relaxed/simple;
	bh=grGFTVLPv65sl/Hn2DJe9oA1SWNVRane3IRgDiEV/F0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=iMfVoUEsLggiJr9eOAyYsbn6hnkSEdOTYUo/4XelDN2KNLdRYZ3HqmFx2kZ7ERdj1rySTCCu/oeeFRqG7gD1XJuczc61mODtBxr7Zt1coyy+Pz6hO3iWz8oO26A4FmXx9a2Q7IwDr/4Vy2EYdtsaDs66enSNPDTijEh2MWlugr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wGtsGd3X; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wGtsGd3X"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-4852ccff333so69304335e9.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 31 Mar 2026 21:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775019139; x=1775623939; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=g1PpmfUIWf1zcZyj49gq+9F8wyiExSgwklOaqkbrltk=;
        b=wGtsGd3XAh2v7lLLzPjgjiP3kyy9gK6NR3tcTPdmApRpeSy1owZF074wbSKWnKXANJ
         CefMzOTOHE9h+h/FhcBduQDgyMWNsjBlAmAzLc0nzMyBH7yXkgvGRL/i19aAkJxtdAWe
         4ny9awMAu2bEUoEN27xoxUdg0ps7++8T54oPkSJyYv3/nSuJrgR1AhABUVrCijFU4Lyx
         tLoh3RzBLN2EktfbWlDSz3v++cFi8g4F/wJJ9m+yqwBmOGl/n/HfuHzJlKIT+Cz8XrGD
         cfvNPiBmEio3ypKzqquyxW5jsM+mio/5UwR8Z+TxpwcTtxHVwcm3Gs0lSPB6GoQCcQpN
         L9UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775019139; x=1775623939;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g1PpmfUIWf1zcZyj49gq+9F8wyiExSgwklOaqkbrltk=;
        b=lvjTQvklrbnCi4kRX1hualEFLlGvq583dRnLnY+egICyy8yTfnw69QaPebkUScKEwA
         r3UHjuFglkEmPoMonpEqdvnYk9UJ5WjVfzvUn8kXJdj3LecpzC0F4wagGJWgDkpBH12Y
         0+urLaeoNXvjf075gj6QC+3IDjOUfnrwID84aKXcSRjjxzr4V5/QDTptbkN7cFXo63UP
         X37IS0ZcC8e8jRzMeulCywgmJt9uAbIO82fJiStWM5jtFd/1tWQpuW6MXM3FiznjzrwT
         OtrLOg39e0anJVvfeSthWoACevb2a0yMJpf5OI2w/xxSeL4//I9Ire7Ze+bBy5h4MFBI
         V5qA==
X-Forwarded-Encrypted: i=1; AJvYcCU6OBeHfpNdyOZ7OmwPncv3HodNHi4sn9yk+yDxCvR+Ysim3jjkgQPcuKqA5HhrXn1kTIV118HRxJltVzTasI1Pwzg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPBIhJLkZSY3iAuGZpnTBeMKqVJMTscp9QMt4EmSt/n3T3Q2TU
	NUxphFpvfhu7jUvE9lXpjLh/oYICqysHj3Y67qfsnMAExgsWQw5jS5btU1uGY9JyIQHJZYdu3QV
	6H8s3yVHj5OKSM99DXhmq+g==
X-Received: from wmba9.prod.google.com ([2002:a05:600c:6dc9:b0:487:201c:8d57])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:8903:b0:485:4533:9c47 with SMTP id 5b1f17b1804b1-48883595155mr22603555e9.22.1775019138900;
 Tue, 31 Mar 2026 21:52:18 -0700 (PDT)
Date: Wed,  1 Apr 2026 05:50:58 +0100
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.1118.gaef5881109-goog
Message-ID: <20260401045100.3394299-1-vdonnefort@google.com>
Subject: [PATCH v2 0/2] Fix trace remotes read with an offline CPU
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

Changes in v2:

 * Add a trap to restore offlined CPU on test failure in hotplug.tc.
 * Fix assert_loaded/assert_unloaded error propagation.
 * Ensure we probe for existing events when setting up consuming read
   iterator.

v1: https://lore.kernel.org/all/20260401025003.3258729-1-vdonnefort@google.com/

Vincent Donnefort (2):
  tracing: Non-consuming read for trace remotes with an offline CPU
  tracing: selftests: Extend hotplug testing for trace remotes

 kernel/trace/trace_remote.c                   | 22 ++++-
 .../selftests/ftrace/test.d/remotes/functions | 19 +++-
 .../ftrace/test.d/remotes/hotplug.tc          | 88 +++++++++++++++++++
 .../test.d/remotes/hypervisor/hotplug.tc      | 11 +++
 .../selftests/ftrace/test.d/remotes/trace.tc  | 27 +-----
 .../ftrace/test.d/remotes/trace_pipe.tc       | 25 ------
 6 files changed, 134 insertions(+), 58 deletions(-)
 create mode 100644 tools/testing/selftests/ftrace/test.d/remotes/hotplug.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/remotes/hypervisor/hotplug.tc


base-commit: 5ad2ff071b5980f072a85c8114649218971c586e
-- 
2.53.0.1118.gaef5881109-goog

