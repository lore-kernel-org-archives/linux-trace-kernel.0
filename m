Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C26C52E2DDD
	for <linux-trace-kernel@vger.kernel.org>; Fri, 23 Jan 2026 15:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769183013; cv=none; b=T/nDX/vo1CzV6meQG1p4qoD1Jz0ZLwfG+xeDM5lb0oCABZuQj0OM6E7Jve8tpQiEnY4JxpxHZT07D4bvplt7R9i0JxPLsGJaPHYBdFaB8Y4doQOlOQP65zpAGZ5HP9IYtdH6CHmmxdiqlui0g8zfuDqDzSrQpwdIM25nhf0R7W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769183013; c=relaxed/simple;
	bh=io6Axc8Zw06pqqNF8zTkCdEAw36zOo1RbWMEMrv5PiE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=T7EdUS3lEFFDr5Kpn1BDJkDh77bwFmyxFr+GmRvYf1LXO0AlSgz9CX63a3O/o0p6a5T0UviDslQsEd6793KHa6CIZskpOviHvhXpY8FaW8Pbh33uWJgQl0l7fWkZIx5ILuAZxuPATQMOw+Jdco/tKupl2U2Qz7hhg35H040REnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UYZ/Z9T0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UYZ/Z9T0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769183010;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=euKT/VjBXiLb8DY3+3vm6VEzIejDpKPic0S7QebozOs=;
	b=UYZ/Z9T0kWQMw65UQOKMa7/1zbkcEtQppskFixSvvjuzzwrDCnYMnrrKy3XHIBbj3tqJoU
	UMCUpHawoWavIfuM7OKRACABNVeq6JX3J9zZ9CCzAYl1JQXs28w1Hx3r8j+WOzNZED9VVy
	3zLyIfLD/PBqqAUFgI5bSsCfh5Y7gwY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-584-09lIhQddNFK4P6OjpT_FwA-1; Fri,
 23 Jan 2026 10:43:20 -0500
X-MC-Unique: 09lIhQddNFK4P6OjpT_FwA-1
X-Mimecast-MFC-AGG-ID: 09lIhQddNFK4P6OjpT_FwA_1769182999
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0D0C31944EB7;
	Fri, 23 Jan 2026 15:43:19 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.33.59])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 98B9B18004D8;
	Fri, 23 Jan 2026 15:43:15 +0000 (UTC)
From: Tomas Glozar <tglozar@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Crystal Wood <crwood@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	Luis Goncalves <lgoncalv@redhat.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
	Tomas Glozar <tglozar@redhat.com>
Subject: [RFC PATCH 0/3] rtla: Synchronize sample collection methods
Date: Fri, 23 Jan 2026 16:25:31 +0100
Message-ID: <20260123152534.1036533-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

This is a proposal to synchronize the start of sample collection throughout
all places where samples are collected in RTLA, using a lockless method of
tracking the count of active tracefs instances set to the timerlat tracer.

There are three different places where timerlat samples are collected in RTLA:
two tracefs instances (auto-analysis and record), and a BPF program attached
to the osnoise:timerlat_sample tracepoint.

The BPF program collects all samples and generates the main statistics from
them in either top or hist mode, while the auto-analysis and record instances
are used as ring buffers with the intention of capturing the tail of both
timerlat samples and additional tracepoints.

In instances where BPF support is not available, the BPF program is replaced
by a third tracefs instance, called the "main instance".

One problem with this approach is each of these sample collectors is
turned on [1] separately, in the present state of RTLA, in the following order:

- record instance
- auto-analysis instance
- BPF program / main instance

[1] By "turned on", I mean toggling tracing on (for tracefs instances) or
attachment (for the BPF program). Note that timerlat starts measurement
on tracer registration, even if tracing is off by default. This might have
been originally unintentional - considering that explicitly turning off
tracing stops the measurement threads - but is now relied upon in RTLA.

This leads to some samples being seen only by tracers that are enabled
earlier, leading to confusing results. For example, auto-analysis might
show spikes that are not seen in the histogram, and trace output (record)
might show samples that are not seen by either the histogram or
auto-analysis.

To enable RTLA to analyze samples consistently, the first patch adds two fields
to the osnoise:timerlat_sample tracepoint: instances_registered and
instances_on. During the recording of a timerlat sample, timerlat counts
how many instances are registered and how many are on, and attaches
the information to the osnoise:timerlat_sample trace event, which is moved
to occur after the samples are recorded.

The second patch makes RTLA count how many tracefs instances are to be enabled
in total, passes this number to the BPF program, and makes it drop any samples
that arrive before the instances are turned on. This ensures all samples
recorded in the main statistics (e.g. histogram) are seen by all active tracefs
instances, that is, auto-analysis and trace output (record).

The third patch then moves the attachment of the BPF program before the enabling
of the tracefs instances, provided that the kernel supports instance counting
introduced in the first patch. The second patch enforces that all samples
recorded by the program are seen by the last enabled tracefs instance.

Synchronization between different tracefs instances, that is, auto-analysis and
trace output, and the main instance in non-BPF mode, is possible by looking at
the osnoise:timerlat_sample record that comes after each sample, but is not yet
implemented in the current version of the patchset.

Tomas Glozar (3):
  tracing/osnoise: Record timerlat instance counts
  rtla/timerlat_bpf: Filter samples unseen by tracer
  rtla/timerlat: Attach BPF program before tracers

 include/trace/events/osnoise.h        | 14 ++++++---
 kernel/trace/trace_osnoise.c          | 10 +++++--
 tools/tracing/rtla/src/timerlat.bpf.c |  9 ++++++
 tools/tracing/rtla/src/timerlat.c     | 43 +++++++++++++++++++++++++--
 tools/tracing/rtla/src/timerlat.h     |  2 ++
 tools/tracing/rtla/src/timerlat_bpf.c |  8 +++++
 6 files changed, 78 insertions(+), 8 deletions(-)

-- 
2.52.0

