Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C401F0E25
	for <linux-trace-kernel@vger.kernel.org>; Tue,  7 Jan 2025 14:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736261442; cv=none; b=InJD5b/zfkLXoHzcE+/QNABaRo3hvU/902RFwFsZO/Wmk9Hp8sZuw37EyycPJ2jrs1P95G/LwAyU2OUByR/GZiY8p4z/9wcWlPw1IW6QqwX+mEF9jGUPb/G/T1+kxxEaAxKG5s8hMMoWz32LopTlJS5iaV4LBHBUFjFqsOZHYhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736261442; c=relaxed/simple;
	bh=yWJNeLUlUwSkJjpwIh1lxy4NhW8QzCWxVfdVz1RS7ZY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AvLAuQLVsR2ieU8qZcoB/SdvckWCrY2XsnNCptDdkNhTFPZnGD4S7SmMLFM3JeU8uBMsJ2JgdXNHj3yx5pvDxfLfo0rOzLTWd20Bny0bdaS7F7KFSEeWI28DwScg6MbWD5XTPKSiocGOewfB5BPPn8y8OkqQNB1jzQ4NGpgQNoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PrJCCQjo; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PrJCCQjo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736261439;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NM0ibh4ovGXHvVLVyF/bSYQFn1AYBfBKeO4PWD9Syis=;
	b=PrJCCQjoUquiFozwid3zcjPt+aakfMWOAQ5UzbCjRLEDpxwWV0KFLsgt//S+wz1Nleg5Bb
	FZ1iLRw4TAA5auyHIBu5tdhUMJBZh2BVtmSSkasG9EZ027YhDpFuaOT06yNElN/3ebo+te
	H4B2loB5qDytq8lHoau6h1Ns9aLKw/k=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-250-wqNov7CjNkqUSEe-QgB86A-1; Tue,
 07 Jan 2025 09:50:36 -0500
X-MC-Unique: wqNov7CjNkqUSEe-QgB86A-1
X-Mimecast-MFC-AGG-ID: wqNov7CjNkqUSEe-QgB86A
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 279DC1956057;
	Tue,  7 Jan 2025 14:50:35 +0000 (UTC)
Received: from fedora.brq.redhat.com (unknown [10.43.17.159])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3B339195609D;
	Tue,  7 Jan 2025 14:50:32 +0000 (UTC)
From: Tomas Glozar <tglozar@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	John Kacur <jkacur@redhat.com>,
	Luis Goncalves <lgoncalv@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>
Subject: [PATCH 1/3] rtla/osnoise: Distinguish missing workload option
Date: Tue,  7 Jan 2025 15:48:21 +0100
Message-ID: <20250107144823.239782-2-tglozar@redhat.com>
In-Reply-To: <20250107144823.239782-1-tglozar@redhat.com>
References: <20250107144823.239782-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

osnoise_set_workload returns -1 for both missing OSNOISE_WORKLOAD option
and failure in setting the option.

Return -1 for missing and -2 for failure to distinguish them.

Cc: stable@vger.kernel.org
Signed-off-by: Tomas Glozar <tglozar@redhat.com>
---
 tools/tracing/rtla/src/osnoise.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/tracing/rtla/src/osnoise.c b/tools/tracing/rtla/src/osnoise.c
index 245e9344932b..699a83f538a8 100644
--- a/tools/tracing/rtla/src/osnoise.c
+++ b/tools/tracing/rtla/src/osnoise.c
@@ -867,7 +867,7 @@ int osnoise_set_workload(struct osnoise_context *context, bool onoff)
 
 	retval = osnoise_options_set_option("OSNOISE_WORKLOAD", onoff);
 	if (retval < 0)
-		return -1;
+		return -2;
 
 	context->opt_workload = onoff;
 
-- 
2.47.1

