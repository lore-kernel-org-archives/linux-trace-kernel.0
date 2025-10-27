Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10E5B30C635
	for <linux-trace-kernel@vger.kernel.org>; Mon, 27 Oct 2025 15:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761579282; cv=none; b=rVGHYKpAT/TQw0Y1QGkEA0mMzhn1HXkSyoCxGpYJtgzonT+MpJ2usb5D5Ixv0ZfcgR2ZwlA6DAzETwmCEDHtx/iZvokgzI2lVprF/ogvOmArSEfNff8fTXoXIG2NGH2g204r6+nv99CspRgVEgX0ny1L9GnyViwQNqMtLbzgsDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761579282; c=relaxed/simple;
	bh=E4UmDRrfK427SBmAu3QgG9274GYyOCRnkLTnbkQSZ48=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Omxuyeah6dOLn7WazylFIu/Qt/1vmwWePSUk6X6qDLT8AlD7AmUmrFpszCIBHsFg5V6YYDZftvsFmRZtOj21QPgX7tNTVK3DLEZSqDAVstntVNCoiFS36x86YXNTOO5FWAG2fFD1QfSzsnlNTDMpDlMJT9U/hTHf7hvKHn8Txko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WrYQ70Xw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WrYQ70Xw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761579279;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z8kAhx3O+cWF32TZgKmRfF3DYFNfvgUR9bkHyjA8PvA=;
	b=WrYQ70XwMpYnPaB1TEMbysTd8ORScEAd+gDSoFHWMS+0CulJItQourSvFwqpApetnlTqId
	hhfYA9wRG0Q4qOzsROUEf5LHdfTQqFL2rHgEXthYwAM6ktcixsPJk3kxVdaO+/Rv30yv6f
	SrdXLg9BW51ZwJvaHydR/HcQ+zXMVjU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-624-NvjvoCvuOj2zeU0NjRNbkQ-1; Mon,
 27 Oct 2025 11:34:35 -0400
X-MC-Unique: NvjvoCvuOj2zeU0NjRNbkQ-1
X-Mimecast-MFC-AGG-ID: NvjvoCvuOj2zeU0NjRNbkQ_1761579274
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 40A4E180A224;
	Mon, 27 Oct 2025 15:34:34 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.224.137])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CB21419539B2;
	Mon, 27 Oct 2025 15:34:30 +0000 (UTC)
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
Subject: [PATCH v3 6/7] Documentation/rtla: Rename sample/ to example/
Date: Mon, 27 Oct 2025 16:34:00 +0100
Message-ID: <20251027153401.1039217-7-tglozar@redhat.com>
In-Reply-To: <20251027153401.1039217-1-tglozar@redhat.com>
References: <20251027153401.1039217-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

The sample/ directory in tools/tracing/rtla was renamed to example/ in
an earlier commit.

Rename it also in the documentation.

Signed-off-by: Tomas Glozar <tglozar@redhat.com>
---
 Documentation/tools/rtla/common_timerlat_options.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/tools/rtla/common_timerlat_options.rst b/Documentation/tools/rtla/common_timerlat_options.rst
index 1f5d024b53aa..c6046fcf52dc 100644
--- a/Documentation/tools/rtla/common_timerlat_options.rst
+++ b/Documentation/tools/rtla/common_timerlat_options.rst
@@ -64,4 +64,4 @@
 
         Set timerlat to run without workload, waiting for the user to dispatch a per-cpu
         task that waits for a new period on the tracing/osnoise/per_cpu/cpu$ID/timerlat_fd.
-        See linux/tools/rtla/sample/timerlat_load.py for an example of user-load code.
+        See linux/tools/rtla/example/timerlat_load.py for an example of user-load code.
-- 
2.51.0

