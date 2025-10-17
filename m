Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ACC22F12A4
	for <linux-trace-kernel@vger.kernel.org>; Fri, 17 Oct 2025 14:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760712437; cv=none; b=QVv95fmIRzMODm4rf1qH4mKyQYqAFdohJmED5o4UZCnlPHOCTMLiahxwtYzAgQ26YgJhblEXfwe6+rETFbFAK/E9kJ7pNAoMaVYzMS06gTAgXCosx59lrb5MOWuJ9OKVSlBN+eanRcwSVVwk/ZLRoDusqQIJFaQKWy5xHh0uCgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760712437; c=relaxed/simple;
	bh=75vKCfL3ezS+cf5WDh89YciSjSMKCTJsfcb1LDcqE2Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hjnouNQ55QJyulbulF91oEMKKEKZQfx7U6vIGbOYrN68V6ES3APb5hZdFS8HCl2v0YGHcULGQ8W2o7vc+k4/VlBLC+sBNm45G9PVsAu52fN6kzTrrfHuOkNmU26+jtftLF5MP0eE5d5GmRtavhDi0b0xsVZP4zHTjWVu/xSnet8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R3YrMqze; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R3YrMqze"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760712435;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=blFtHsrz91GSUOxatWU6Sim8/yxuJYJjoWm4023zsuY=;
	b=R3YrMqze9Caay+rHxFmhkO2ZhSzC0iAXoQ7DnocCs/8TFt3WnDCfbUtmFfK7L4KCi/+Vcb
	7Eh7vMOqivfG0OAdluT8Gp8PVMMn3ZqvXw3baJvFcU00vNKLZZLTFVNmbPZhZ/Db/FmnoO
	wKUkVLtP2MEwQz310sr1zXIZQsB/E/U=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-654-KPUfwbanP-CWDkAiOyElsg-1; Fri,
 17 Oct 2025 10:47:12 -0400
X-MC-Unique: KPUfwbanP-CWDkAiOyElsg-1
X-Mimecast-MFC-AGG-ID: KPUfwbanP-CWDkAiOyElsg_1760712431
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D938B19560AD;
	Fri, 17 Oct 2025 14:47:10 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.32.24])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 87AF81800452;
	Fri, 17 Oct 2025 14:47:07 +0000 (UTC)
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
Subject: [PATCH 0/4] rtla/timerlat: Add --bpf-action option
Date: Fri, 17 Oct 2025 16:46:46 +0200
Message-ID: <20251017144650.663238-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

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

Tomas Glozar (4):
  rtla/timerlat: Support tail call from BPF program
  rtla/timerlat: Add --bpf-action option
  rtla/timerlat: Add example for BPF action program
  Documentation/rtla: Document --bpf-action option

 .../tools/rtla/common_timerlat_options.rst    | 18 +++++
 .../tracing/rtla/sample/timerlat_bpf_action.c | 16 +++++
 tools/tracing/rtla/src/timerlat.bpf.c         | 23 ++++++-
 tools/tracing/rtla/src/timerlat.c             | 11 +++
 tools/tracing/rtla/src/timerlat.h             |  2 +-
 tools/tracing/rtla/src/timerlat_bpf.c         | 67 +++++++++++++++++++
 tools/tracing/rtla/src/timerlat_bpf.h         |  7 +-
 tools/tracing/rtla/src/timerlat_hist.c        |  5 ++
 tools/tracing/rtla/src/timerlat_top.c         |  5 ++
 9 files changed, 149 insertions(+), 5 deletions(-)
 create mode 100644 tools/tracing/rtla/sample/timerlat_bpf_action.c

-- 
2.51.0

