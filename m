Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 420843F210C
	for <linux-trace-kernel@vger.kernel.org>; Thu,  6 Aug 2026 10:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786010490; cv=none; b=bRbmz83fUlStHu5lkT3Edg+oTqww8TJ18iaCVy+t/L1XwLNnRjwSjujmDoGHc4tV6VIwGXDf3cqfoyaqO5MV1o/9Q+al0yJ1c7ncvjq9CE73ORtfB81Le68M7OtRuiCnzJ+enjVCZP6npms6xrMmrAR4adCAaSwxrUPUnH2mPV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786010490; c=relaxed/simple;
	bh=FKQymnvLP+45tnKKdIOvzx6ghqHQww6/gA67X3JR0uU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=ihepUdWrYl4750lMxGJqIMbaa2HBpmJPWPewG/0qMVQXo5oCoVJi6lT3n6oG1oqAF0tBX+kiBzaBkY5ZGs2GOi9UzxFx6FziOQnAdwKpZhCp+qLNVWCwmW8IzHt2HyOfxS3EzHrwYqHr4xHj14rF3Qa+/dfL8242JXHSjkeuuL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d7ljlDEs; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d7ljlDEs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786010488;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=sR0E8zPFJ/0Uasd45XPRVgC5GfJL0Xwf6xufPDhKRAc=;
	b=d7ljlDEsQ4BthnhIR6gxoZIR0+OYr6/U0fq8GesUHOym5kNBoSg/yz8VLsoCCAHS6kbJTH
	oEgLUzxUx54YkwM90NeHM/8anbNwhV1Iux0JameGFSWy6nLMUmxV5f4AZJ0nmbw5Vgqimx
	hDnhvl15gsMIE0JHQuAW3DlWRh8IMbE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-622-jjirUl9sO2GEA6d20rt6KQ-1; Thu,
 06 Aug 2026 06:01:26 -0400
X-MC-Unique: jjirUl9sO2GEA6d20rt6KQ-1
X-Mimecast-MFC-AGG-ID: jjirUl9sO2GEA6d20rt6KQ_1786010485
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 91F981955F29;
	Thu,  6 Aug 2026 10:01:25 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.redhat.corp (headnet05.pony-001.prod.iad2.dc.redhat.com [10.2.32.117])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B5496426;
	Thu,  6 Aug 2026 10:01:23 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	linux-kernel@vger.kernel.org
Cc: linux-trace-kernel@vger.kernel.org,
	Chao Liu <chao.liu@processmission.com>,
	Gabriele Monaco <gmonaco@redhat.com>
Subject: [GIT PULL] rv fixes for v7.3 (for-next)
Date: Thu,  6 Aug 2026 12:00:27 +0200
Message-ID: <20260806100026.112251-2-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Mimecast-MFC-PROC-ID: QbuPt48FL00S4xB1XeX-Tnm_oO6pTuJOHz74lOsX89U_1786010485
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Steve,

The following changes since commit 984b5a36fd12d1849511a45fda32036fe2b0d004:

  selftests/verification: Add selftests for deadline and stall monitors (2026-07-31 16:27:46 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gmonaco/linux.git rv-fixes-7.3-next

for you to fetch changes up to 7d81675d1bb2cc6db61a2d93b1e0dc7fb0929f9c:

  Documentation/rv: Explain epoll and aborted sleeps (2026-08-04 16:11:28 +0200)

----------------------------------------------------------------
rv fixes for v7.3 (for-next)

Summary of changes:

- Fix 32-bit build of nomiss KUnit test

  A previous commit introduced a division between an u64 and a constant
  value and that doesn't build on 32-bit systems. Use div_u64() instead.

- Document changes in sleep monitor

  The sleep monitor introduced some changes in the past like allowing
  epoll_wait() as a valid sleep and a task going to runnable before
  scheduling as a valid wakeup. Document both.

----------------------------------------------------------------
Chao Liu (1):
      Documentation/rv: Explain epoll and aborted sleeps

Gabriele Monaco (1):
      rv: Fix 32-bit build of nomiss KUnit test

 Documentation/trace/rv/monitor_rtapp.rst       | 6 ++++++
 kernel/trace/rv/monitors/nomiss/nomiss_kunit.c | 2 +-
 2 files changed, 7 insertions(+), 1 deletion(-)

To: Steven Rostedt <rostedt@goodmis.org>
Cc: Chao Liu <chao.liu@processmission.com>
Cc: Gabriele Monaco <gmonaco@redhat.com>

