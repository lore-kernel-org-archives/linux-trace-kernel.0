Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B096349253B
	for <linux-trace-kernel@vger.kernel.org>; Wed, 17 Jun 2026 15:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781710264; cv=none; b=WWvOzNE+THyROJZFMP1YU9ZrxPmQCDhoBbz6LbveDZWs7G71ZSRhzax3YMVbgw8sktmOJmp+xkpfFxmpeVqTgmGg4gDsaJ+2HViejT9HKOknk5OKYCau5PJ84+TYN72nB7jEHDlVTQLBLHrzrtgp9Wc4Yq1IomQSm0RnZbYPDiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781710264; c=relaxed/simple;
	bh=pM/v+IrE+w/e/po0lusIv2R4jEM2u12GFlhEO89/9zs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=fOts8MRxRe0IiXloNA2bH6qCFL1QosmbuuTqDmpbzrWWZtRpYnH6Pf9E0UaJImCdVe1NGEP8/CrVjtzI/qap0wTgQD8rSXeHo/QgKb+NBS8YMtg8FKdSSFD2cUjR5IQUpmsa95lq0Po1P43chWzzZgsO6lqn8FQOBgHwZ/pu+kA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eNGRqQY7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eNGRqQY7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781710255;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=FvlovZfXpcg213DAl2+5WtEKoGQDD7ZYprUYj1XK4MY=;
	b=eNGRqQY7yx+VIec+PMudNt5MOuryT8A7nK2cX25cEMQjc674LylB8Y8omxCfzq7Js3hCWy
	qOHW/gAhnxjCoaZZya0DBljh2yS1dPr/tBbQ76ZHVIHx+svso2CZiAefGrc+7vY070pFBT
	3HzQn9hCJy6YwVLECG7UPmgV5p2WsPY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-117-IYQ39RZQNKe7wXOSsZDvyA-1; Wed,
 17 Jun 2026 11:30:52 -0400
X-MC-Unique: IYQ39RZQNKe7wXOSsZDvyA-1
X-Mimecast-MFC-AGG-ID: IYQ39RZQNKe7wXOSsZDvyA_1781710251
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0585419560BE;
	Wed, 17 Jun 2026 15:30:51 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.32.156])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8F58219540C9;
	Wed, 17 Jun 2026 15:30:49 +0000 (UTC)
From: Tomas Glozar <tglozar@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>,
	Tomas Glozar <tglozar@redhat.com>
Subject: [GIT PULL v2] RTLA additional fixes for v7.2
Date: Wed, 17 Jun 2026 17:30:45 +0200
Message-ID: <20260617153045.546686-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-MFC-PROC-ID: YKvJ8ytADPJXleOV4N0djVDPpv1f18_XXQw9d-ZbIaU_1781710251
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Steven,

The following changes since commit 6b5a2b7d9bc156e505f09e698d85d6a1547c1206:

  Merge tag 'trace-tools-v7.2' of git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace (2026-06-16 17:50:34 +0530)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/tglozar/linux.git tags/rtla-v7.2-fixups-v2

for you to fetch changes up to c35eb77a67515d4201bc91294f40761591f43bbd:

  rtla/tests: Fix pgrep filter in get_workload_pids.sh (2026-06-17 16:26:44 +0200)

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

v2:
- Rebase onto 6b5a2b7d9bc156e505f09e698d85d6a1547c1206 to avoid merge
  conflicts.

Signed-off-by: Tomas Glozar <tglozar@redhat.com>

----------------------------------------------------------------
Tomas Glozar (2):
      rtla: Fix and clean up .gitignore
      rtla/tests: Fix pgrep filter in get_workload_pids.sh

 tools/tracing/rtla/.gitignore                             | 13 ++++---------
 tools/tracing/rtla/tests/scripts/lib/get_workload_pids.sh |  2 +-
 2 files changed, 5 insertions(+), 10 deletions(-)

