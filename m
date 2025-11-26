Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A75D7302170
	for <linux-trace-kernel@vger.kernel.org>; Wed, 26 Nov 2025 14:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764168147; cv=none; b=kr5E3RkOKa7M6hCCa4Ki7hP30NRt7etgosIZaDEgWCFESmpC20cXdvcb8xlN81o8bWZClO+1YVpqPPFkGRn9qQQDaH+wEnA85q+4yvInW7aX4ByR4r3xyEpLcOVGYOV7lnXA8Wo9GGxvscVW+718FHwY8T1r+VsXMQnRZmddXSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764168147; c=relaxed/simple;
	bh=2u+hYAbYC/DD5N/RGhaUVT+7rhxfGLqZ4tASQ85IUOc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rRQKjnlc8t/gqAjnD7OpKiDRYMWkbYPdzWhKA2sHNCvoXpMOw7+MHrI7KcS4/QFwo4G2XUg6AZ8d1xQXbqsiCBIXGAKPsifOqrFkxwvo/BzZxT/AJVIbWeTVO8t6wtNT2xV1LqmEA78gWOTuKWTQS2/58SJKMl94M5iDRdDfdgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KLr/vcKa; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KLr/vcKa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764168144;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Q1fsBKQjQIprBlqksMIF9OAXMfQvbi0YT/uhjmW/QoY=;
	b=KLr/vcKaXEK42Q0cxnGbBxoBRHfNWdfUR2r4o4RdHyNojHwnWe0t/AqYatxJm/bnwCcEKz
	kdPEOZ15mP2r1DR1+dtdI2osMSfh3gzWSEndgfKoE/tnFFiU/pcFZ6fuaPDLV+lFp8waB/
	qcB3g4xtm1pXgRoEdJSOd811CUTu8ZM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-197-nJ9s2dUwPbOOjCm2ErwNeg-1; Wed,
 26 Nov 2025 09:42:21 -0500
X-MC-Unique: nJ9s2dUwPbOOjCm2ErwNeg-1
X-Mimecast-MFC-AGG-ID: nJ9s2dUwPbOOjCm2ErwNeg_1764168140
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 379481956048;
	Wed, 26 Nov 2025 14:42:20 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.33.141])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5CD6030044DD;
	Wed, 26 Nov 2025 14:42:16 +0000 (UTC)
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
Subject: [PATCH v4 0/7] rtla/timerlat: Add low-latency BPF-based actions
Date: Wed, 26 Nov 2025 15:41:58 +0100
Message-ID: <20251126144205.331954-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

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

v4:
- Rename cover letter to avoid confusing the Gmail web client.
- Rebase over latest linux-next.
- Fix typo "doing doing" -> "doing".
- Add reviews by Wander from v3.
- Clarify documentation entry about BPF program name.

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

 .../tools/rtla/common_timerlat_options.txt    | 20 +++++-
 tools/tracing/rtla/Makefile                   | 19 +++++-
 .../rtla/example/timerlat_bpf_action.c        | 16 +++++
 .../rtla/{sample => example}/timerlat_load.py |  0
 tools/tracing/rtla/src/timerlat.bpf.c         | 25 +++++--
 tools/tracing/rtla/src/timerlat.c             | 11 ++++
 tools/tracing/rtla/src/timerlat.h             |  2 +-
 tools/tracing/rtla/src/timerlat_bpf.c         | 66 +++++++++++++++++++
 tools/tracing/rtla/src/timerlat_bpf.h         |  7 +-
 tools/tracing/rtla/src/timerlat_hist.c        |  5 ++
 tools/tracing/rtla/src/timerlat_top.c         |  5 ++
 tools/tracing/rtla/tests/bpf/bpf_action_map.c | 25 +++++++
 tools/tracing/rtla/tests/engine.sh            |  1 -
 tools/tracing/rtla/tests/timerlat.t           | 15 +++++
 14 files changed, 206 insertions(+), 11 deletions(-)
 create mode 100644 tools/tracing/rtla/example/timerlat_bpf_action.c
 rename tools/tracing/rtla/{sample => example}/timerlat_load.py (100%)
 create mode 100644 tools/tracing/rtla/tests/bpf/bpf_action_map.c

-- 
2.51.1

