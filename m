Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A01436CE1E
	for <linux-trace-kernel@vger.kernel.org>; Mon, 19 Jan 2026 13:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768830651; cv=none; b=FF2Y7F5wRu+6jPcRclJUw9x/EmwpJDHmAi0sBhDccLN0+RgruM3nm95HlSbe/yhXxt+P08YWMmHknnCyrgXzPQJmSbEZZhyT5mlcbZyFmKqAFEZl87mj2GfQPhDFYsiJXCGzlwLh0/kyOQwBO6hhifhDiy5qEmWr1iOaFyVgcb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768830651; c=relaxed/simple;
	bh=ymnxlvbnscMXsNpA9pMPg+Z+OFN+wSBHjzzhWO+/kz0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=njlfwgsUKkhmaTK/icHOy0abpQOcOiRH4Xd7iZRVjBjyJN5+FnODXAR/iWX8HwNINUOSnkGY4oP+k5aN2eFcGrQPNT4IqXNdv8h8+lBNTtdCZ+TauNZ2Pt6hVx8cv8LfVZ7AuWUUenBDCksjVbujO3169g1Qf11dUNJuHCeLQhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Dp1GPXaN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dp1GPXaN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768830647;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=MMehZMg/kw3DNT8DgMJ+tS+8zKMICcmIPRJ4ZIh9O4Y=;
	b=Dp1GPXaNAQx3ZRPIT5PnxDgotAc9NUYqvQnjD/Oi834CbG2xI9i37Y37Yu6NGUYQ+2vvF/
	gEbdymtjkSQEd7got2CZxzmiu98LlcgR3tJC2zFPpueLIAU3vdNbbR3QNE8A7trm/MJhwV
	ODdLsQj7hBrsMxWKgzy5nI32SQnD3ps=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-556-OZzsFHHgOcKmVtvmekn5kQ-1; Mon,
 19 Jan 2026 08:50:46 -0500
X-MC-Unique: OZzsFHHgOcKmVtvmekn5kQ-1
X-Mimecast-MFC-AGG-ID: OZzsFHHgOcKmVtvmekn5kQ_1768830645
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id ED0A1180034D;
	Mon, 19 Jan 2026 13:50:44 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.34.49])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E9E1C19560AB;
	Mon, 19 Jan 2026 13:50:42 +0000 (UTC)
From: Tomas Glozar <tglozar@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Costa Shulyupin <costa.shul@redhat.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
	Tomas Glozar <tglozar@redhat.com>
Subject: [GIT PULL] RTLA additional fixes for v6.20
Date: Mon, 19 Jan 2026 14:50:38 +0100
Message-ID: <20260119135038.756221-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Steven,

please pull additional fixes for bugs that were caught in RTLA during
the testing of linux-next.

Thanks,
Tomas

The following changes since commit fb8b8183208d8efe824e8d2c73fb1ab5ad1191fd:

  rtla: Fix parse_cpu_set() return value documentation (2026-01-07 15:57:56 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tglozar/linux.git/ tags/rtla-v6.20-fixups

for you to fetch changes up to 6ea8a206108fe8b5940c2797afc54ae9f5a7bbdd:

  rtla: Fix parse_cpu_set() bug introduced by strtoi() (2026-01-13 08:32:52 +0100)

----------------------------------------------------------------
RTLA additional fixes for v6.20

- Fix bug in cpuset parsing

A commit queued for 6.20 changed atoi() to a new strtoi() function on
a tree-wide level. This broke cpuset parsing, which relies on atoi()'s
behavior of skipping non-numeric prefixes.

Revert cpuset parsing back to using atoi() to prevent the breakage.

The log entries above are purely informative; since the fix is for a bug
not yet merged upstream, it needs no mention in the merge description.

The tag was tested (make && make check) as well as pre-tested on top of
next-20260116. There are no additional known conflicts.

Signed-off-by: Tomas Glozar <tglozar@redhat.com>

----------------------------------------------------------------
Costa Shulyupin (1):
      rtla: Fix parse_cpu_set() bug introduced by strtoi()

 tools/tracing/rtla/src/utils.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

