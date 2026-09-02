Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A2D948551D
	for <linux-trace-kernel@vger.kernel.org>; Wed,  2 Sep 2026 12:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788352824; cv=none; b=J8DSu85DT8lM9KmnSpo085U9j84l6hn4kA9hwyh1xlTdxXlIQXPDVFh+s8RPZ/xsZ4zfpBPPcHj7SaMp7Q3ynIsJOtd+uxy8TncBZq/+xQ6S+cVu83Y5dre6gIbyMXejOjW9z12L76rsaUXo+JNvw3COCVywJghGAgBn2/hCxOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788352824; c=relaxed/simple;
	bh=6ldI2oWhqqciz/d7Opr319MQFKF+Zkje0h47Bfp/ifQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gD16f4Hs22jT7RgBDGsh9qiI5hBf1h6oG3EWijW1q2MtjvYB3diGjA/aoHW5VHPIFcsWr/UBwuiVRGaNOCkUcFPYcrz+fhkgqLNh481p/bMxSqgK2zQcPJ3SBdJ3tDuPlmFdAJEEDah8HA8Xvs/HtkToycQUHdS1p3J6F6xbkNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GY107tkB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GY107tkB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788352821;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=DPabCix+pfnXhCWbiytjvC43Wtk1N7h4RXWap1DJTBc=;
	b=GY107tkByJncsgwneMH3ug3JoZhyqsPAvyw9P1k1SdXSata77/VQR2g0n/QsDllWcCToa9
	gQe9xQ74LP5IbaQ33hQMxdEhpTvrHieJ6GHhQ5UHuHhBPMVb2JPjvvCM6qZ/cRJ6V6mqRw
	WzzXUzzMaCgbuitI3B9UmZ9Sv/Tqb2U=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-435-m_Uqogk1PoWtCeGweqR7dQ-1; Wed,
 02 Sept 2026 08:40:17 -0400
X-MC-Unique: m_Uqogk1PoWtCeGweqR7dQ-1
X-Mimecast-MFC-AGG-ID: m_Uqogk1PoWtCeGweqR7dQ_1788352816
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 651F3192DD61;
	Wed,  2 Sep 2026 12:40:16 +0000 (UTC)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (unknown [10.44.33.19])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1E0121955F72;
	Wed,  2 Sep 2026 12:40:11 +0000 (UTC)
From: Valentin Schneider <vschneid@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Tomas Glozar <tglozar@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Crystal Wood <crwood@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	Ivan Pravdin <ipravdin.official@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v5 0/8] tracing/osnoise: Track IPIs
Date: Wed,  2 Sep 2026 14:39:29 +0200
Message-ID: <20260902123942.695822-1-vschneid@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-MFC-PROC-ID: AX4xhvZolrb4tdp5q4pF_JIWfNQdSj4semqGVqRtNR8_1788352816
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi folks,

So I've seen a few times now reports of latency spikes caused by IPIs, usually
because of isolation misconfiguration, but only detected at the tail of end
e.g. a 24h timerlat run.

It's not because those IPIs are rare, but rather that they don't by themselves
cause a monitered CPU to reach the latency threshold, it's usually a combined
interference that gets us there.

I'd like to make it easier to detect such misconfigurations and thus IPIs
hitting supposedly-isolated CPUs. I initially kludged a timerlat option to stop
tracing as soon as an IPI was sent to a monitored CPU, regardless of the latency
threshold. It sort of did the trick, but Tomáš convinced me timerlat wasn't
really the place for that.

Patches are available at

https://gitlab.com/vschneid/linux.git -b mainline/tracing/osnoise-ipi-userspace/v5

Cheers,
Valentin

Revisions
=========

v4 -> v5
++++++++

o Made events processing follow user-specified order

v3 -> v4
++++++++

o Rebase onto v7.2-rc4
o Fix changelog typo

v2 -> v3
++++++++

o Dropped the short-form -i option to leave it free 
o Re-arranged top header printing 
o Fixed tracefs_event_file_write() return value handling

o Changed IPI filtering to allow it to gracefully fail on older kernels
o Added filter clearing for -e events to ensure a known state

v1 -> v2
++++++++

o Dropped the in-kernel osnoise_sample changes and made it all userspace

Valentin Schneider (8):
  rtla/osnoise: Add IPI tracking cmdline option
  rtla/osnoise: Record IPI count in osnoise top
  rtla/osnoise: Leverage IPI event filters when tracing a subset of CPUs
  rtla/osnoise: Allow IPI filters to gracefully fail
  rtla: make struct trace_events double linked
  rtla: Enable and disable events in the user-defined order
  rtla: Unconditionally clean any pre-existing filters for user-provided
    events
  rtla/osnoise: Trace IPI events when recording a trace file

 Documentation/tools/rtla/common_options.txt   |   9 +-
 Documentation/tools/rtla/rtla-osnoise-top.rst |   4 +
 tools/tracing/rtla/src/cli.c                  |   1 +
 tools/tracing/rtla/src/cli_p.h                |   7 +-
 tools/tracing/rtla/src/common.c               |   2 +-
 tools/tracing/rtla/src/common.h               |   3 +-
 tools/tracing/rtla/src/osnoise.c              |  72 +++++++-
 tools/tracing/rtla/src/osnoise.h              |   4 +
 tools/tracing/rtla/src/osnoise_top.c          | 155 +++++++++++++++++-
 tools/tracing/rtla/src/trace.c                |  28 +++-
 tools/tracing/rtla/src/trace.h                |   1 +
 11 files changed, 276 insertions(+), 10 deletions(-)

-- 
2.55.0

