Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA717448BBB
	for <linux-trace-kernel@vger.kernel.org>; Tue, 25 Aug 2026 15:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787673426; cv=none; b=sURnsakz7XL4X3P4cBSzFDDAury+1OWH9QzXTgZIXPseIRNy4vhi2lA9jWtm0J7YJ1RFIpaeKz/CWn+/5JGqrNSrXjCw4Z71+BJgIiPbravYGb9E5RSLgVgFQGuMKaeBoSJpaLcdI8E0d60bJ7GrpzQ2n5hLbNTbVy+s9F4mVec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787673426; c=relaxed/simple;
	bh=cG4WhUqK/HznFZLCCKi8XHnHtUkwENjTUxb21MyOzVo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=hx9XF7UkOHpYPfoQ6IMn6jOVvnsBDsHg8vO1Mu/d2DchvfpBVI7M2hgPV/OOfRfl9b0NZIGeglsJl/SuqnbTEtuDa+qLridrBUg59CMMB84saVAPXrn2V3q1sPAPQKfyiu8TOf0Y2whO2iLLowY/cW4a/xLFy+SoB1//SOCxqw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Pq7ZUlvI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pq7ZUlvI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787673423;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+nvZ5D2LyuLZA/QE6Ne9uRGyt2sBAwDJpKawb8XytTo=;
	b=Pq7ZUlvI5S3q9puz0MXH+HCi+hpeFHOi6YSsxJxqyl8OfN8du1KrL0JKyNEfUzHSWvi0Uv
	sGiupgzXXU5d7t3+qCG0JKcgMc0EiLY0ws4RS9+wzUcSkMYbw3BdEwOH8w2oTzTJo7UimD
	OOX4iHr2KyTi3kBCGxUVy3iUSCVVdJY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-416-uR45v8VfMQyWKfbCcjJHUg-1; Tue,
 25 Aug 2026 11:56:59 -0400
X-MC-Unique: uR45v8VfMQyWKfbCcjJHUg-1
X-Mimecast-MFC-AGG-ID: uR45v8VfMQyWKfbCcjJHUg_1787673418
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BEECB1955F1F;
	Tue, 25 Aug 2026 15:56:57 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.redhat.corp (headnet05.pony-001.prod.iad2.dc.redhat.com [10.2.32.117])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 416F918005BA;
	Tue, 25 Aug 2026 15:56:55 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	linux-kernel@vger.kernel.org
Cc: linux-trace-kernel@vger.kernel.org,
	Gabriele Monaco <gmonaco@redhat.com>
Subject: [GIT PULL] rv fixes for v7.3-rc1
Date: Tue, 25 Aug 2026 17:56:01 +0200
Message-ID: <20260825155600.300355-2-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: CcW_RGRApsHp1EnNBdlAaM1R1hefd1ACsPPWd79Uml4_1787673418
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Steve,

The following changes since commit 7d81675d1bb2cc6db61a2d93b1e0dc7fb0929f9c:

  Documentation/rv: Explain epoll and aborted sleeps (2026-08-04 16:11:28 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gmonaco/linux.git rv-fixes-7.3-rc1

for you to fetch changes up to ab0304fd69b07605553e9f161d65ecf9ccc2e2fe:

  verification/rvgen: Use .old instead of .bak for kunit backup files (2026-08-25 13:56:53 +0200)

----------------------------------------------------------------
rv fixes for v7.3-rc1

Summary of changes:

- Use .old instead of .bak for rvgen kunit backup files

  The rvgen kunit command generates .bak backup files and these are
  checked in for selftests as "golden" files for make check. Clean
  make disclean removes such files, leaving the tree dirty.
  Switch to .old to preserve a clean tree after make disclean.

----------------------------------------------------------------
Gabriele Monaco (1):
      verification/rvgen: Use .old instead of .bak for kunit backup files

 tools/verification/rvgen/rvgen/kunit.py                                 | 2 +-
 .../{test_bak_kunit_kunit.c.bak => test_bak_kunit_kunit.c.old}          | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename tools/verification/rvgen/tests/golden/test_bak_kunit/{test_bak_kunit_kunit.c.bak => test_bak_kunit_kunit.c.old} (100%)

To: Steven Rostedt <rostedt@goodmis.org>
Cc: Gabriele Monaco <gmonaco@redhat.com>

