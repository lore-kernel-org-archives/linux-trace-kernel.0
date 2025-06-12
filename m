Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3411F8753
	for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Jun 2025 10:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749725048; cv=none; b=aqjUSy1mpBUF2lti/7PvzEvXedjIsMI7JS+wb90qMgO/Y2XOsW/l3QbxjhxdtwUYiNhM9TO3Ur5pXKmW+0ASLvJtxLlMZTxsP12VkM+zqZlmlOeijVNaEuaCP104J4HzbA2kDqzvVY6uFlmNo4uHumgSzEL0Gj9nUuEQR8d7T1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749725048; c=relaxed/simple;
	bh=IR2tm94ReCty00Me3LuhlSMLcePN3XeMWFB4N6hGKp0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ogxn8LRpqOMuY/U2VhMuLCoLQRyM1+KAk3XO1tsxGOD9UcuRMdGBb/aX7xPByweNi+UY9CKTyH9kyT5Z+d446LYzQoSE6NKgCVSe2zOMh/+UjzyGc00vspGcq+WDeQXZI7v2v9V/L1Omy09Lxvnqo5PDHMlHmFXIWvwJPMcdV8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=axYtKBiO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="axYtKBiO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749725045;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=evoxoq79rUNR1aL96QrvR7FxasZWL1eL5arK+Kk98Uw=;
	b=axYtKBiOQR3afWfNmgfU2/N7GdP41gzqIt61hxASYu+/ZWkhUxEMTR/eVg5HraFXAde9nR
	nA9F8Y8Lc+ojNXPzxpOPiO+2FpErY3TsJ/5weP84r0dxgaC4EujcMrD6pLMq85n+fODlGH
	zPaEGz8Gb+PhWsuWpzMJGNwZQbwV2qM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-636-RJVN8nC1M16lxocY0wblCg-1; Thu,
 12 Jun 2025 06:44:02 -0400
X-MC-Unique: RJVN8nC1M16lxocY0wblCg-1
X-Mimecast-MFC-AGG-ID: RJVN8nC1M16lxocY0wblCg_1749725041
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C98601809C87;
	Thu, 12 Jun 2025 10:44:00 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.242.17])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B881719560A3;
	Thu, 12 Jun 2025 10:43:56 +0000 (UTC)
From: Gabriele Paoloni <gpaoloni@redhat.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: acarmina@redhat.com,
	chuck.wolber@boeing.com,
	Gabriele Paoloni <gpaoloni@redhat.com>
Subject: [RFC PATCH 0/2] tracing: ftrace_enable_fops fixes
Date: Thu, 12 Jun 2025 12:43:47 +0200
Message-ID: <20250612104349.5047-1-gpaoloni@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

This patchset addresses some issues found in ftrace_enable_fops and
proposes low-level documentation for event_enable_write/read.

Gabriele Paoloni (2):
  tracing: fixes of ftrace_enable_fops
  tracing: add testable specifications for event_enable_write/read

 kernel/trace/trace_events.c | 83 +++++++++++++++++++++++++++++++++++--
 1 file changed, 80 insertions(+), 3 deletions(-)

-- 
2.48.1

