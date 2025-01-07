Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E521F2370
	for <linux-trace-kernel@vger.kernel.org>; Tue,  7 Jan 2025 14:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736261444; cv=none; b=Dq4T7rzesAVB1KP6u7HP6XVrFFMETbEjYTpRi/0KlaUF8AC7NivnRCNVGaOx5Qaop7IqkvCvo1DLgaxgZvhJau1sB22io4ohdETKII/DZLrAr64nqsv7cyArZcSAQ7op7gb1j2urcS/5gowgusZN8MCI6OJdZUhK9VuDM0iM8+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736261444; c=relaxed/simple;
	bh=w0c3rNLDyxO6JHtLQmyOE++mY8R4pmsFiFv3QAnGGpw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kkP175byFpIlTo5yNdS3EXG9ztcecTiU2Mnp5oxzpscqZ1SIJiviBdo2jnr6MQyIhR2EenjCYrDkGpeDBTQ92djK2ppCqgSYmaEvcNLSNTVseXfGu8VtclwUyiF53TQgLteH/gnw1cELIm0vMZxbCDpZyaw38TmmOlEttDq44Os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VpzLUgfd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VpzLUgfd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736261442;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nqf+2O72YPOi9tYokBhg/rAaOaHnIjswD4gdhGy2+dg=;
	b=VpzLUgfdO0y1BMj+aTNq1/nrmIMvkaqsMFSh53rnz1e5AvaSaQ7g2v6xMGZNQ1ey0d2SPj
	XdRxpQLgi+Dal2pj7U/zCbIWE0FmFTvVhjQGM365o4NvYuA54J9hUXZH0DCu3pUp4PU88B
	qwqTGukusRMMRP/nB797QnjwQzSfmqs=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-261-pXFpWcSgMw6eMUXXtjQnPg-1; Tue,
 07 Jan 2025 09:50:38 -0500
X-MC-Unique: pXFpWcSgMw6eMUXXtjQnPg-1
X-Mimecast-MFC-AGG-ID: pXFpWcSgMw6eMUXXtjQnPg
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 742431955F65;
	Tue,  7 Jan 2025 14:50:37 +0000 (UTC)
Received: from fedora.brq.redhat.com (unknown [10.43.17.159])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 917CE1956088;
	Tue,  7 Jan 2025 14:50:35 +0000 (UTC)
From: Tomas Glozar <tglozar@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	John Kacur <jkacur@redhat.com>,
	Luis Goncalves <lgoncalv@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>
Subject: [PATCH 2/3] rtla/timerlat_hist: Set OSNOISE_WORKLOAD for kernel threads
Date: Tue,  7 Jan 2025 15:48:22 +0100
Message-ID: <20250107144823.239782-3-tglozar@redhat.com>
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

When using rtla timerlat with userspace threads (-u or -U), rtla
disables the OSNOISE_WORKLOAD option in
/sys/kernel/tracing/osnoise/options. This option is not re-enabled in a
subsequent run with kernel-space threads, leading to rtla collecting no
results if the previous run exited abnormally:

$ rtla timerlat hist -u
^\Quit (core dumped)
$ rtla timerlat hist -k -d 1s
Index
over:
count:
min:
avg:
max:
ALL:        IRQ       Thr       Usr
count:        0         0         0
min:          -         -         -
avg:          -         -         -
max:          -         -         -

The issue persists until OSNOISE_WORKLOAD is set manually by running:
$ echo OSNOISE_WORKLOAD > /sys/kernel/tracing/osnoise/options

Set OSNOISE_WORKLOAD when running rtla with kernel-space threads if
available to fix the issue.

Cc: stable@vger.kernel.org
Fixes: ed774f7481fa ("rtla/timerlat_hist: Add timerlat user-space support")
Signed-off-by: Tomas Glozar <tglozar@redhat.com>
---
 tools/tracing/rtla/src/timerlat_hist.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/tools/tracing/rtla/src/timerlat_hist.c b/tools/tracing/rtla/src/timerlat_hist.c
index 4403cc4eba30..66dbc034bdc7 100644
--- a/tools/tracing/rtla/src/timerlat_hist.c
+++ b/tools/tracing/rtla/src/timerlat_hist.c
@@ -1100,12 +1100,15 @@ timerlat_hist_apply_config(struct osnoise_tool *tool, struct timerlat_hist_param
 		}
 	}
 
-	if (params->user_hist) {
-		retval = osnoise_set_workload(tool->context, 0);
-		if (retval) {
-			err_msg("Failed to set OSNOISE_WORKLOAD option\n");
-			goto out_err;
-		}
+	/*
+	* Set workload according to type of thread if the kernel supports it.
+	* On kernels without support, user threads will have already failed
+	* on missing timerlat_fd, and kernel threads do not need it.
+	*/
+	retval = osnoise_set_workload(tool->context, params->kernel_workload);
+	if (retval < -1) {
+		err_msg("Failed to set OSNOISE_WORKLOAD option\n");
+		goto out_err;
 	}
 
 	return 0;
-- 
2.47.1

