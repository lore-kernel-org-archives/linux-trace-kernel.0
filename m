Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9C9E420460
	for <linux-trace-kernel@vger.kernel.org>; Wed, 15 Jul 2026 15:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784130402; cv=none; b=u5Apvn5VwDfhTB8WV3KCWlt+JeQDh2qS2ES0ByERiGn0tF6cuTYyqe+ztuodYMjsX/NqpANdaZp0CKB/LGMjOitAUc1moHvyikqptllTB1VwLCsV/HhElKSEXc9pl5tPZfExsOWPNhfVdNNavQQpi2j2peGBO+ge+l9YGNlUe6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784130402; c=relaxed/simple;
	bh=5I9JXTfCoOjJWD27NxtoK7xV86pWgSn2StdgF8ycldg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TBdQ2t4Heq47as0nwzbYg83PtBpwYvuEv2vnvvpWiHJDVAiBJCY8wM0CrwN5JvAgOumADVfIgufzVyzTM4dFShljij2XRuDuc5nitIMLQG/RuzvZYEirtD0lfefdXyvw2hnEzRZSGV/PtWHiKvAesn9/zTY4Kp3oc7Vf3jDiwu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=icxzpZ7Q; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="icxzpZ7Q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784130399;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=8igb6RUYV3TWkz5S52S+3lpVMd+LuALGSZc7HI4jsoo=;
	b=icxzpZ7QyX/JIBnmU0qWEYlnBenD0EyNXTGVbjKlR/A4O2SqCxdRFZMOog85UxLfsgtZRf
	kmSFcZ7h0jArkael24WYCgIG5MtCUlb8WrvUzpISW/hlUEHIuco+fp4DDseTAAd90pP3Up
	lNJ/bZX7k3n0H6e6QUH+yujtpmfcEvc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-112-dqrzOX2LMFmbzC7hlr0bLw-1; Wed,
 15 Jul 2026 11:46:37 -0400
X-MC-Unique: dqrzOX2LMFmbzC7hlr0bLw-1
X-Mimecast-MFC-AGG-ID: dqrzOX2LMFmbzC7hlr0bLw_1784130396
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 40F5F180065B;
	Wed, 15 Jul 2026 15:46:36 +0000 (UTC)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (unknown [10.44.32.112])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 882C41800361;
	Wed, 15 Jul 2026 15:46:32 +0000 (UTC)
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
Subject: [PATCH v3 0/6] tracing/osnoise: Track IPIs
Date: Wed, 15 Jul 2026 17:45:45 +0200
Message-ID: <20260715154553.2020891-1-vschneid@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: _vjBSk3H9ChnlsdOSg76jhvbWNqu9gxmpIhSz-xpVes_1784130396
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

So here's IPI tracking added to osnoise. This time around fully in userspace, as
Tomáš pointed out to me that this will make it a lot easier to deploy to older
kernels.

Based on top of linux/next at 'next-20260710' to have the latest libsubcmd
changes. 
  
Cheers,
Valentin

Revisions
=========

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

