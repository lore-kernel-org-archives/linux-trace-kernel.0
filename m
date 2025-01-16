Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E370722D4E0
	for <linux-trace-kernel@vger.kernel.org>; Thu, 16 Jan 2025 14:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737039011; cv=none; b=dxvJyZ3nXOPKofFyadmiMktyDkA4r+9wH73oawK7bxhqx9Tdm2XVR2/Il8CF4Uql2tXuFnRe/QJb/pZrsSbVhUrku1OcODVtHdPLXRFe6+uQcZ390aQ4kaBWEMSWQH/y0zF1Z5WjPa4Jwg+RmLEwqgmsN+LS8Sy0Etw4OCqPj+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737039011; c=relaxed/simple;
	bh=/8oqNUub/kB+/ikfHWiRq+qTvh0v5LgE8EDv7wxu0Vg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FO/HIShh2XZGdAoPdWI5U0FGobL6U7zQ1AG3Gkd2EHpLHeTvJQoffMzicwG/XKRKAYtVy5xNCPmPHS85js+eZzWCVXwsWz8sajCnbStAxmcNXcpkjtH/E6Li1fyaE53QVhF4cuNuaEa++Sqh2iL2+iH2m6YqL+LV4g6YEyk0Uac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OdyLe9L0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OdyLe9L0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737039008;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1HCimhxo7sWsoxQRywXDbQS0XfhVCKH6Fu3920omuYA=;
	b=OdyLe9L0RI4DXeXuyNZbWb5TB6oa5ajo75CGl48hB11alRPIAeeit4RbPnwb5XuXhmuv+N
	wKwojsy+k7cXfVM8F2px4+V5G2BLYqLzZf/VC7+9t362SuttMGk51xkacOvxELjYsZiIw0
	+xL3I2xM9f8KF2r9BGXNaK01v69BE5s=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-609-wgX6pdY_N72aLuCF3ki2Yw-1; Thu,
 16 Jan 2025 09:50:05 -0500
X-MC-Unique: wgX6pdY_N72aLuCF3ki2Yw-1
X-Mimecast-MFC-AGG-ID: wgX6pdY_N72aLuCF3ki2Yw
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A28A919560A1;
	Thu, 16 Jan 2025 14:50:04 +0000 (UTC)
Received: from fedora.brq.redhat.com (unknown [10.43.17.159])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 91F1919560BF;
	Thu, 16 Jan 2025 14:50:02 +0000 (UTC)
From: Tomas Glozar <tglozar@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	John Kacur <jkacur@redhat.com>,
	Luis Goncalves <lgoncalv@redhat.com>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>
Subject: [PATCH 4/5] rtla/timerlat_hist: Abort event processing on second signal
Date: Thu, 16 Jan 2025 15:49:30 +0100
Message-ID: <20250116144931.649593-5-tglozar@redhat.com>
In-Reply-To: <20250116144931.649593-1-tglozar@redhat.com>
References: <20250116144931.649593-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

If either SIGINT is received twice, or after a SIGALRM (that is, after
timerlat was supposed to stop), abort processing events currently left
in the tracefs buffer and exit immediately.

This allows the user to exit rtla without waiting for processing all
events, should that take longer than wanted, at the cost of not
processing all samples.

Signed-off-by: Tomas Glozar <tglozar@redhat.com>
---
 tools/tracing/rtla/src/timerlat_hist.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/tracing/rtla/src/timerlat_hist.c b/tools/tracing/rtla/src/timerlat_hist.c
index e8d249e22251..d0a4d20b7196 100644
--- a/tools/tracing/rtla/src/timerlat_hist.c
+++ b/tools/tracing/rtla/src/timerlat_hist.c
@@ -1149,6 +1149,14 @@ static int stop_tracing;
 static struct trace_instance *hist_inst = NULL;
 static void stop_hist(int sig)
 {
+	if (stop_tracing) {
+		/*
+		 * Stop requested twice in a row; abort event processing and
+		 * exit immediately
+		 */
+		tracefs_iterate_stop(hist_inst->inst);
+		return;
+	}
 	stop_tracing = 1;
 	if (hist_inst)
 		trace_instance_stop(hist_inst);
-- 
2.47.1

