Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D2E3019A3
	for <linux-trace-kernel@vger.kernel.org>; Mon, 27 Oct 2025 15:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761579260; cv=none; b=QydXIKk8N917NnizM60vvTCkP0BORdaFgif2lEtkkxXQw/OyVFzn488Lv0l5/xj24CRz5o0LmJdQRcwEADyj7DojT3LVZFpb6tFu2CREwlj9Kqjt9BpGMLiqLhJbAtSMQLL6zp3kkTXr1mQBRoy0Y7IzbhWKY5hMnl5QxJbRSCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761579260; c=relaxed/simple;
	bh=m9HAqtHEDODV1Tq89zMk21K6Tjw2WP0raOQyntR2cpk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Hqy9FvTCbhOoW1fDhDP1lMOdWAQql/AeWPi2pwEmeBYig2evkhHgmqWcQdyd2lu8xVRaxc/V8jKqUYKNj23RSgidcKOmttoZdR9T7YIexyHV2Y2fb4u7BBj1o4PaYBYKFevygxCyewGV7ACGz6mCR4tRp6iddgBLNHrUwWJflfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Pu4c0rBK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pu4c0rBK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761579256;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=CD4i2iZFS9xedSj3xP6wgeh57TGwEaIr7MnRTFTZx0I=;
	b=Pu4c0rBKCnRju+nkMbw+fvUmIQ4XocbR4L/j+uEKJxBaov0a5uBwvrq/b0khrXa36As1+x
	t6wZDf4NfduNe7t31KVjsOXAXLAqoB2Bw0mY2caFRr+afSXDVcEesyZpy8lSoTu+g+4qqK
	XN79vffcZnC/zrOOaRFGAepJDVeYs5A=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-152-DGroyKNtNL6yXZBNOaE6AA-1; Mon,
 27 Oct 2025 11:34:12 -0400
X-MC-Unique: DGroyKNtNL6yXZBNOaE6AA-1
X-Mimecast-MFC-AGG-ID: DGroyKNtNL6yXZBNOaE6AA_1761579251
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 68779180065F;
	Mon, 27 Oct 2025 15:34:11 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.224.137])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5E1871955F1B;
	Mon, 27 Oct 2025 15:34:07 +0000 (UTC)
From: Tomas Glozar <tglozar@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
	John Kacur <jkacur@redhat.com>,
	Luis Goncalves <lgoncalv@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Crystal Wood <crwood@redhat.com>,
	Wander Lairson Costa <wander@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Tomas Glozar <tglozar@redhat.com>
Subject: [PATCH v3 0/7] rtla/timerlat: Add --bpf-action option
Date: Mon, 27 Oct 2025 16:33:54 +0100
Message-ID: <20251027153401.1039217-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

This patchset extends rtla-timerlat's BPF support with the option of
executing a user-supplied BPF program on latency threshold overflow.

See the supplied example and documentation for how to create a program.
bpf_tail_call() is used to chain the program with the built-in BPF
sample collection program, if the threshold is hit.

The feature can be used for both in-kernel data collection and sending
signals to userspace directly from the kernel, if the kernel version
allows it.

Note: The patchset will have to be rebased on top of [1], or vice versa,
since they both touch stop_tracing() ([1] adds one call of it, and this
patchset adds an extra argument to it).

I have contemplated adding this as --on-threshold bpf,... but it does
not fit the existing actions infrastructure very well, since the action
happens in the BPF program, not in RTLA, and only one BPF action is
supported.

[1] https://lore.kernel.org/linux-trace-kernel/20251006143100.137255-1-tglozar@redhat.com/

v3 changes:
- Add tests/bpf/bpf_action_map.c to test commit (forgot to run
git add before).

v2 changes:
- Properly bpf__object_close() also when bpf__object_load() fails.
- Use goto for error paths in timerlat_load_bpf_action_program().
- Remove unneeded NULLing of obj and prog in timerlat_bpf_init().
- Add entry to Makefile to build example.
- Add test for BPF actions.
- Rename sample/ directory to example/, also in docs.
- Run Test::Harness in verbose mode during "make check".

Thanks to Crystal and Wander for their input.

Tomas Glozar (7):
  rtla/timerlat: Support tail call from BPF program
  rtla/timerlat: Add --bpf-action option
  rtla/timerlat: Add example for BPF action program
  rtla/tests: Test BPF action program
  rtla/tests: Run Test::Harness in verbose mode
  Documentation/rtla: Rename sample/ to example/
  Documentation/rtla: Document --bpf-action option

 .../tools/rtla/common_timerlat_options.rst    | 22 ++++++-
 tools/tracing/rtla/Makefile                   | 19 +++++-
 .../rtla/example/timerlat_bpf_action.c        | 16 +++++
 .../rtla/{sample => example}/timerlat_load.py |  0
 tools/tracing/rtla/src/timerlat.bpf.c         | 23 ++++++-
 tools/tracing/rtla/src/timerlat.c             | 11 ++++
 tools/tracing/rtla/src/timerlat.h             |  2 +-
 tools/tracing/rtla/src/timerlat_bpf.c         | 66 +++++++++++++++++++
 tools/tracing/rtla/src/timerlat_bpf.h         |  7 +-
 tools/tracing/rtla/src/timerlat_hist.c        |  5 ++
 tools/tracing/rtla/src/timerlat_top.c         |  5 ++
 tools/tracing/rtla/tests/bpf/bpf_action_map.c | 25 +++++++
 tools/tracing/rtla/tests/engine.sh            |  1 -
 tools/tracing/rtla/tests/timerlat.t           | 15 +++++
 14 files changed, 207 insertions(+), 10 deletions(-)
 create mode 100644 tools/tracing/rtla/example/timerlat_bpf_action.c
 rename tools/tracing/rtla/{sample => example}/timerlat_load.py (100%)
 create mode 100644 tools/tracing/rtla/tests/bpf/bpf_action_map.c

-- 
2.51.0

