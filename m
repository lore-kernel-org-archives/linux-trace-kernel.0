Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE0A44418FC
	for <linux-trace-kernel@vger.kernel.org>; Thu,  4 Jun 2026 13:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780579542; cv=none; b=JM+O2FRC1Vbe8n/UYswdMXJPMKG3GLvCFuEN7PC9HwpO1Ce9XpVj0W9jWf2fwQhQNcaovQWbFO9faGnjouAAJ96v0g1z2fNtZSKG36Wk9ge6gNhesa/o2+7mJqAPaSHOQjbpesIHiZMMoFaMTYZsdVdJxlB/gWjnptjt8J6WmrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780579542; c=relaxed/simple;
	bh=BFNkqLrF5dTaHm3tuZ0PfICrnwF8BWPVCLq9SdgVJP8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=ieyUJx5PcLzXli85sxCrFdHx9ySjpNPrmPkhCxA8f1VQZEPI0mAQu0LqvPAC7DVieNCu7mifU6EZcvWsOjVs0hKYl680m69OOgRDy0TXo7jgHN8aMZRogzGFTx5T/d5QTI0hFCuvAF/8PESp5bht92VwOPEVt0rM0hg3JPTXigE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WCCj7swa; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WCCj7swa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780579539;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Cl1r6/pbsgg9eK3CtNqzO8MD+yHcfOavjRF3lsbOthQ=;
	b=WCCj7swaOWDdP9Ris0tOcGe8qW3eWyr6NzAj+gUeqAYEi5emOQy8FSF8ApbYWJuw0Cw64L
	HJUqL+snfb6j6BwSnHXI/zgvxFmq/xhPQRGhzOpa65MbO5r7Ea5NBLk6jxGJxTOfEbkA8I
	rgGchM3U7ZQMbHp48MrKGHZpZbrEZlE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-655-5KrnLzAbPlCJ4Z6mcVx6ng-1; Thu,
 04 Jun 2026 09:25:36 -0400
X-MC-Unique: 5KrnLzAbPlCJ4Z6mcVx6ng-1
X-Mimecast-MFC-AGG-ID: 5KrnLzAbPlCJ4Z6mcVx6ng_1780579535
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CF7161800562;
	Thu,  4 Jun 2026 13:25:35 +0000 (UTC)
Received: from fedora.brq.redhat.com (unknown [10.43.17.109])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A0EBB1955D87;
	Thu,  4 Jun 2026 13:25:34 +0000 (UTC)
From: Tomas Glozar <tglozar@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>,
	Tomas Glozar <tglozar@redhat.com>
Subject: [GIT PULL] RTLA fixes for v7.1-rc7
Date: Thu,  4 Jun 2026 15:25:28 +0200
Message-ID: <20260604132528.3593844-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-MFC-PROC-ID: lFKBXre2kiW7ZsxwVg3PdrxN29h7hx-mO4sMd_ykkRQ_1780579535
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Steven,

The following changes since commit e43ffb69e0438cddd72aaa30898b4dc446f664f8:

  Linux 7.1-rc6 (2026-05-31 15:14:24 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/tglozar/linux.git tags/rtla-fixes-v7.1-rc7

for you to fetch changes up to e9e41d3035032ed6053d8bad7b7077e1cb3a6540:

  rtla: Fix parsing of multi-character short options (2026-06-04 10:53:25 +0200)

----------------------------------------------------------------
RTLA fixes for v7.1-rc7

- Fix multi-character short option parsing

Fix regression in parsing of multiple-character short options (e.g.
-p100 /= -p 100/, -un /= -u -n/) caused by getopt_long() internal state
corruption after a refactoring.

Build, runtime tests, unit tests pass. Extended runtime tests from next
also pass, except for timerlat hist --dump-tasks (expected).

Signed-off-by: Tomas Glozar <tglozar@redhat.com>

----------------------------------------------------------------
Tomas Glozar (1):
      rtla: Fix parsing of multi-character short options

 tools/tracing/rtla/src/common.c        | 28 +++++-----------------------
 tools/tracing/rtla/src/common.h        | 12 +++++++++++-
 tools/tracing/rtla/src/osnoise_hist.c  |  7 ++++---
 tools/tracing/rtla/src/osnoise_top.c   |  7 ++++---
 tools/tracing/rtla/src/timerlat_hist.c |  7 ++++---
 tools/tracing/rtla/src/timerlat_top.c  |  7 ++++---
 6 files changed, 32 insertions(+), 36 deletions(-)

