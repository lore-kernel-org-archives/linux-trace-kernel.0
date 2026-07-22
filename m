Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 092B3478870
	for <linux-trace-kernel@vger.kernel.org>; Wed, 22 Jul 2026 11:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784718117; cv=none; b=N/B5f/dL8aEBxUsjCn1Qo0shK+aZ1U0FmevxqZ4avQSriJyvOgAcz7diKVAopZSUhYbnR/coM3wJG6wUsQllGfJcTeRP+yUfkbB1EpeOgqLhplXyKS/epYj2vXTD0KVK80OSwx8RO3ySGmtGVk28skVzC0bcxb7i7rYLKFRmYEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784718117; c=relaxed/simple;
	bh=jxDugtjpdugmhjjIFWXHowAGdQRSO0je0GiHBkfyyOk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=I2q8o4iyPGZ8Q3LAndbD1v0V6lqfySSw0MvOK7Nq9qllyxOeutPvwwrb20Tm3Nzjdlyd292ANlPnWndZHhkfjWMlg6F7pNnySV/7Y/Dz5s3vGooRZRTeYSeEYZe9VhIqyge+g3hybH/BA6unTEZAb/4Q4SBmi8WCBxkFyKDf9e0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Fik/v2ng; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fik/v2ng"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784718114;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=SjLl8zJrsgDdtiYlURa+MEU0ZY5wN5KxSsAz5xQcSG0=;
	b=Fik/v2ngeL+5JSM05seShhgns3VIb0s7V5MgN0k1Ae7GLVz3ey1Rs+iSuFisqN5vjNphPv
	6RUBB6/6eu2fU8t6Baq1pLWME2bWHFPB46zM3sQZrVSFzuEpqb16/I5ifVtCVFVEQz2Pux
	X7YpZujy63vg00p58BXE6lU70e6qHaI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-453-dMphl5PJMNO-2VpS8RcTCg-1; Wed,
 22 Jul 2026 07:01:53 -0400
X-MC-Unique: dMphl5PJMNO-2VpS8RcTCg-1
X-Mimecast-MFC-AGG-ID: dMphl5PJMNO-2VpS8RcTCg_1784718112
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5349A196DFC3;
	Wed, 22 Jul 2026 11:01:46 +0000 (UTC)
Received: from fedora.brq.redhat.com (unknown [10.43.17.39])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E06BF3004A51;
	Wed, 22 Jul 2026 11:01:44 +0000 (UTC)
From: Tomas Glozar <tglozar@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>,
	Tomas Glozar <tglozar@redhat.com>
Subject: [GIT PULL] RTLA fixes for v7.2-rc5
Date: Wed, 22 Jul 2026 13:01:16 +0200
Message-ID: <20260722110116.1387495-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: _jraMr0XzOk9UtrNfyOArC6Vbms-8TtWT5mgsClz9bQ_1784718112
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Steven,

One more RTLA fix, this time a one-liner fixing an older bug found just after
the previous pull request.

The following changes since commit 1590cf0329716306e948a8fc29f1d3ee87d3989f:

  Linux 7.2-rc4 (2026-07-19 13:54:41 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/tglozar/linux.git tags/rtla-fixes-v7.2-rc5

for you to fetch changes up to fafb66e5903c2bcfc7b7e259042a8282f18a6faa:

  rtla/timerlat_top: Fix on-threshold actions firing on signal (2026-07-21 15:42:08 +0200)

----------------------------------------------------------------
RTLA fixes for v7.2-rc5

- Fix timerlat top actions triggering on signal

Fix a bug in RTLA's timerlat top actions feature where on-threshold
actions are triggered on any signal, regardless of whether a latency
spike had actually occured during the measurement.

Signed-off-by: Tomas Glozar <tglozar@redhat.com>

----------------------------------------------------------------
Tomas Glozar (1):
      rtla/timerlat_top: Fix on-threshold actions firing on signal

 tools/tracing/rtla/src/timerlat_top.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

