Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB8F43E9FD
	for <linux-trace-kernel@vger.kernel.org>; Tue,  4 Aug 2026 17:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785865400; cv=none; b=Cs3LI+Y6dP3QWcc/8YoteYoBgTji+tGrTxtefvbjCARNTzfBuMPBEZzAIT5FN8F4ik5+gaZ4ukcWesRdWtlHxY3maqbTx6/aqAXOC5q/ZU6pS8ZBaYGUTpShInOTC0jTq7NNuEXgyf3BWToGgBnmnEYYH6J3gHoz6kjfWMhvA5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785865400; c=relaxed/simple;
	bh=LmtkPNT7OA50pIWREDZmmsPOFGwY+6prfDBN425VXOE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=e5i+dlQE15eYz3Fqan1vPwHTPeJwnOGFxFlEFAMpymo1iTrv55aOR1lZQHY31r32AtpmXQPg1DYekDQlhdmSbhNk8qExesU3e9AyfhKnXcoGarlHQUQgkceIM1HE5QsCXTH8ANTPm6nODFc8WDf5BrKDGrOOJ5KVKvEwJkqtE4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZEhqClzJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZEhqClzJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785865397;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=5HNEiOmcNvNIRoVh955nnmNdw9FkXY2EZFVZ3Ml4Ei0=;
	b=ZEhqClzJmP4lovFRcbrTy3Kj0vJlEp2qXELDRAypl5+IEGh81DCepIzoM7y3p38+/UUt0I
	rsWzFukkNWISqT/eZ9IZ2WWRV4gB3qOSDBfTtzqETrv2icK4szK1r4yFKeQ33WXahVSJ8/
	FzgJ7xYhGuOf8L8KAi1EUrcZJlbJ2Os=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-556-okZE7ZHSP6O-FyeAqpchyQ-1; Tue,
 04 Aug 2026 13:43:14 -0400
X-MC-Unique: okZE7ZHSP6O-FyeAqpchyQ-1
X-Mimecast-MFC-AGG-ID: okZE7ZHSP6O-FyeAqpchyQ_1785865393
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AD33A19560BB;
	Tue,  4 Aug 2026 17:43:12 +0000 (UTC)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (unknown [10.44.34.30])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 91FF7195608E;
	Tue,  4 Aug 2026 17:43:08 +0000 (UTC)
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
Subject: [PATCH v4 0/6] tracing/osnoise: Track IPIs
Date: Tue,  4 Aug 2026 19:42:32 +0200
Message-ID: <20260804174242.2288433-1-vschneid@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-MFC-PROC-ID: j7zTSMRhQvRJF5QrRfdyYFnoUtChQlal65YSJbLLO2k_1785865393
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

https://gitlab.com/vschneid/linux.git -b mainline/tracing/osnoise-ipi-userspace/v4

Cheers,
Valentin

Revisions
=========

v3 -> v4
++++++++

o Rebased onto v7.2-rc4
o Fixed changelog typo

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

Valentin Schneider (6):
  rtla/osnoise: Add IPI tracking cmdline option
  rtla/osnoise: Record IPI count in osnoise top
  rtla/osnoise: Leverage IPI event filters when tracing a subset of CPUs
  rtla/osnoise: Allow IPI filters to gracefully fail
  rtla: Unconditionally clean any pre-existing filters for user-provided
    events
  rtla/osnoise: Trace IPI events when recording a trace file

 Documentation/tools/rtla/rtla-osnoise-top.rst |   4 +
 tools/tracing/rtla/src/cli.c                  |   1 +
 tools/tracing/rtla/src/cli_p.h                |   3 +
 tools/tracing/rtla/src/common.c               |   2 +-
 tools/tracing/rtla/src/common.h               |   3 +-
 tools/tracing/rtla/src/osnoise.c              |  72 +++++++-
 tools/tracing/rtla/src/osnoise.h              |   4 +
 tools/tracing/rtla/src/osnoise_top.c          | 155 +++++++++++++++++-
 tools/tracing/rtla/src/trace.c                |   4 +
 9 files changed, 244 insertions(+), 4 deletions(-)

--
2.55.0

