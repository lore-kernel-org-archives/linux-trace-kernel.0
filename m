Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98912286430
	for <linux-trace-kernel@vger.kernel.org>; Fri,  5 Jun 2026 14:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780668139; cv=none; b=tbadBKQRo+R0IF7+NQah0GQ/LllmjXpwX5asZkPMTlouRamBQJhYP6sOZ7oyS3vXdF+jarZGyyIvOkecJwhWMf3Wqogkh7oQ67HqmsHakCPpHMS1/gjLoZq1c2xmV0L+BmMr/IYCIHywvbEjXS438qmk6UUWHkIMYbhscPVcY5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780668139; c=relaxed/simple;
	bh=6TQHkJm/Pq1mSnJHL1hBGX56th80IiC0wY5uxCKGmeQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=OIYWKyLJqPD3mfwMLnV0h8hxT5t56ppekRq/yuDiWqyx5y7bcVuHOwiz8L86wTbbHSVVFbKwQp8npV658XXS8KBcfq8y9+32WSLWTssxMfQHZlyyI4YrGU3kCXaSxn4OA2g7QWds+lyMJJSrq+5kKwyuOR0k/FCkSTVGfRm8Zlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hNrppq6n; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hNrppq6n"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780668137;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=wMY3iHR5pg2hpyn+V/okPE+FLq4GgaXTs1SF9UWIVaM=;
	b=hNrppq6ncOT4kfi6ygBrDhgKujGjiPp5ijwCB9ud37hQu3hHHKikf6/0bMqO1698cdGpU5
	FOsPlgIOghp3n9qjy7A6Rv7GJJxDcF/wY1PnkkXFhu7Jbe8js0x7473gAWhuqy0AchOMFH
	TbW/kWRWdAAyDGIGTExP/lMM92iYGhw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-661-sZKRiS6mPP2VxlxiFFj4WA-1; Fri,
 05 Jun 2026 10:02:14 -0400
X-MC-Unique: sZKRiS6mPP2VxlxiFFj4WA-1
X-Mimecast-MFC-AGG-ID: sZKRiS6mPP2VxlxiFFj4WA_1780668134
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D1DBC1944CC5;
	Fri,  5 Jun 2026 14:02:13 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.49.160])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6CD821800361;
	Fri,  5 Jun 2026 14:02:12 +0000 (UTC)
From: Tomas Glozar <tglozar@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>,
	Tomas Glozar <tglozar@redhat.com>
Subject: [GIT PULL] RTLA additional fixes for v7.2
Date: Fri,  5 Jun 2026 16:02:09 +0200
Message-ID: <20260605140209.101548-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: GgRYY7HBCyUAp-0936Xdep8z7O5jWrx5Y1z2OmE5hOI_1780668134
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Steven,

The following changes since commit db956bcf8d681b5a01ebe04c79f6a7b29b9934f9:

  rtla: Document tests in README (2026-05-29 09:40:54 +0200)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/tglozar/linux.git/ tags/rtla-v7.2-fixups

for you to fetch changes up to 930645785902d5830f9c41862d21af651b8e5371:

  rtla/tests: Fix pgrep filter in get_workload_pids.sh (2026-06-05 14:11:31 +0200)

----------------------------------------------------------------
RTLA additional fixes for v7.2

- Fix and clean up .gitignore

Narrow match range of entries in .gitignore to only what is needed,
fixing "lib/" matching tools/tracing/rtla/tests/scripts/lib/*.

- Fix pgrep filter in runtime tests

Make the pgrep filter used by runtime tests to get workload PIDs work
on both older and newer versions of pgrep, regardless of whether
square brackets are counted as part of kthread comm or not.

Build, runtime tests, unit tests pass.

Signed-off-by: Tomas Glozar <tglozar@redhat.com>

----------------------------------------------------------------
Tomas Glozar (2):
      rtla: Fix and clean up .gitignore
      rtla/tests: Fix pgrep filter in get_workload_pids.sh

 tools/tracing/rtla/.gitignore                             | 13 ++++---------
 tools/tracing/rtla/tests/scripts/lib/get_workload_pids.sh |  2 +-
 2 files changed, 5 insertions(+), 10 deletions(-)

