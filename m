Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37D713C3C1E
	for <linux-trace-kernel@vger.kernel.org>; Mon, 27 Apr 2026 13:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777295906; cv=none; b=la29PyqKbtQin6raW72jSaW+olXlwkw2GiLZ4upW6osDWJZnemmK0ydBDVT0Sg+Ubt93slwddQv71TIAdvxIqLYWarELrqBqkEf5ZIWIUb36goDmeVi7GgWGs27zMg9KfmRprYOXEdjzqC6FBBDhFmLOSpgP3YHe4WDoJkExDfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777295906; c=relaxed/simple;
	bh=NwAOthm99zFxWhLQ9aKvtF0eA1BH5/4WTnlSf259zC8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=fxKXReDz76BJwYVYYAIOpGA9CVCRy9sH7bJR1xNIj1HXCKgQDNSEuHbbSkcm4wsJYB8D5iJwB0fx3z55/UDZvsE8YkgGohNRJWNwAD3lz5NWaIAWBVBt1SpqUQPpw+6XHuLr09mX5arcrvY9tVP2/e4Kw8rSVhWRMJlltCSqzZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TEXwdgeO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TEXwdgeO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777295902;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=yRgs59r3qAD41EfRJtu78JhJSt1v0Ckc4btL9xnEnVc=;
	b=TEXwdgeOFBRmex2tXr2y0FrtqWEYNoNfY91wGWfgcMNPCrVGNe7gt5Mh5z15CSC2FlnElX
	VPSVE8nKzXhOO+uMDHGLgCjGUE6C7FWwWuo7UpDoSmcnsvDOSMY/DjxsuVjy14k9nW6Zv3
	EqI15XqGW69kOt7nCwt8xKmPjJy6KU0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-632-BYutafAHNvyqp0A4W7B_tQ-1; Mon,
 27 Apr 2026 09:18:17 -0400
X-MC-Unique: BYutafAHNvyqp0A4W7B_tQ-1
X-Mimecast-MFC-AGG-ID: BYutafAHNvyqp0A4W7B_tQ_1777295895
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BD65719560A3;
	Mon, 27 Apr 2026 13:18:14 +0000 (UTC)
Received: from fedora-pc.redhat.corp (headnet01.pony-001.prod.iad2.dc.redhat.com [10.2.32.101])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 691D31800446;
	Mon, 27 Apr 2026 13:18:10 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: rdunlap@infradead.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-trace-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: matteo.martelli@codethink.co.uk,
	skhan@linuxfoundation.org
Subject: [PATCH v2] Documentation/rv: Replace stale website link
Date: Mon, 27 Apr 2026 15:17:09 +0200
Message-ID: <20260427131709.170505-2-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: j-UbJPM5AjFx7CeRISRkLkx1G_oXmaqcGrbPELtxmgY_1777295895
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

The sched monitor page was linking to Daniel's website which is now
down. The main purpose of the link was to point to a source for the
models from the original author and that can be found also in his
published paper.

Replace the link with a reference to Daniel's "A thread synchronization
model for the PREEMPT_RT Linux kernel" which can be found online and
includes the models definitions as well as the work behind them (not the
original patches but since they're based on a 5.0 kernel and are mostly
included upstream, there's little value in keeping them in the docs).

Fixes: 03abeaa63c08 ("Documentation/rv: Add docs for the sched monitors")
Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
V2: Add link to the PDF and fixed RST references

 Documentation/trace/rv/monitor_sched.rst | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/trace/rv/monitor_sched.rst b/Documentation/trace/rv/monitor_sched.rst
index 0b96d6e147c6..d3ba7edc202f 100644
--- a/Documentation/trace/rv/monitor_sched.rst
+++ b/Documentation/trace/rv/monitor_sched.rst
@@ -36,7 +36,7 @@ Specifications
 --------------
 
 The specifications included in sched are currently a work in progress, adapting the ones
-defined in by Daniel Bristot in [1].
+defined by Daniel Bristot in [1]_.
 
 Currently we included the following:
 
@@ -365,4 +365,7 @@ constraints when processing the events::
 References
 ----------
 
-[1] - https://bristot.me/linux-task-model
+.. [1] Daniel Bristot de Oliveira et al.:
+       `A thread synchronization model for the PREEMPT_RT Linux kernel
+       <https://www.iris.sssup.it/bitstream/11382/533630/1/Elsevier-JSA-2020.pdf>`_,
+       J. Syst. Archit., 2020.

base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
-- 
2.53.0

