Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B96221DBC
	for <linux-trace-kernel@vger.kernel.org>; Thu, 20 Mar 2025 09:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742462741; cv=none; b=Gwq66syGjpS1kY0vt4JX1GQ1gikQSYmHc+bEo2Ss3nZxKSryGr6dyMLvk5cR77c9XvUZ7Wm1yDIxh3gUjpF1NATzzaYeE/IRnPEq6PtMBBqI6GXOOBAmmGYOmMaXDRrVHdb8CoOCjebrjRFWp3mSXmqsQjN+K9w2trxafVimGOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742462741; c=relaxed/simple;
	bh=kKKw2YDnQQHPnT9LbTVKhigQoKma9s2FHV+0OsoJoik=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zr6buUXHRQpr5GXKoHptZ5cxDA4DgVWDPaxGxomaEEE4kisyUHpTrFkXtu0hlvlmuQZmIwWWgV21LoKp4DdN6tousRsbOwTrGRazOS1VFoVmYd2Cix4QYpF5pPifPw3DeNObhRdP6K8ZCxC9yk6agrWxmCzgNxuK1j6JXYj1ZxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bGIBip5o; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bGIBip5o"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742462738;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=npOoAdwDRfq/OwDwgMN6XaA4VXQ/Fv54SkxXQuW++/A=;
	b=bGIBip5o5YLitAprZ8Zkc2Th7Zz0M/xKyT/WgmuKnUment5pR2kBEhHJVgoAXhk0e3ARFm
	9diSPfc+pBI0+usQZlUVyw1MI81DDxTD8xANlGtLo+tvTXiLVO+DDDTNOoX0+A8LvlpDSP
	alQ06WxWMc4PREmhoPj/2uT6lPqWRmA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-77-55VbvF5HNBimGStKPyYL7w-1; Thu,
 20 Mar 2025 05:25:35 -0400
X-MC-Unique: 55VbvF5HNBimGStKPyYL7w-1
X-Mimecast-MFC-AGG-ID: 55VbvF5HNBimGStKPyYL7w_1742462734
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7019B1933B44;
	Thu, 20 Mar 2025 09:25:34 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.224.73])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1C4CD19560AF;
	Thu, 20 Mar 2025 09:25:31 +0000 (UTC)
From: Tomas Glozar <tglozar@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	John Kacur <jkacur@redhat.com>,
	Luis Goncalves <lgoncalv@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>
Subject: [PATCH 3/6] rtla/osnoise: Set OSNOISE_WORKLOAD to true
Date: Thu, 20 Mar 2025 10:24:57 +0100
Message-ID: <20250320092500.101385-4-tglozar@redhat.com>
In-Reply-To: <20250320092500.101385-1-tglozar@redhat.com>
References: <20250320092500.101385-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

If running rtla osnoise with NO_OSNOISE_WORKLOAD, it reports no samples:

$ echo NO_OSNOISE_WORKLOAD > /sys/kernel/tracing/osnoise/options
$ rtla osnoise hist -d 10s
Index
over: 0
count: 0
min: 0
avg: 0
max: 0

This situation can also happen when running rtla-osnoise after an
improperly exited rtla-timerlat run.

Set OSNOISE_WORKLOAD in rtla-osnoise, too, similarly to what we
already did for timerlat in commit 217f0b1e990e ("rtla/timerlat_top: Set
OSNOISE_WORKLOAD for kernel threads") and commit d8d866171a41
("rtla/timerlat_hist: Set OSNOISE_WORKLOAD for kernel threads").

Note that there is no user workload mode for rtla-osnoise yet, so
OSNOISE_WORKLOAD is always set to true.

Fixes: 1eceb2fc2ca5 ("rtla/osnoise: Add osnoise top mode")
Fixes: 829a6c0b5698 ("rtla/osnoise: Add the hist mode")
Signed-off-by: Tomas Glozar <tglozar@redhat.com>
---
 tools/tracing/rtla/src/osnoise.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/tracing/rtla/src/osnoise.c b/tools/tracing/rtla/src/osnoise.c
index 1735a36466c4..a71618d876e9 100644
--- a/tools/tracing/rtla/src/osnoise.c
+++ b/tools/tracing/rtla/src/osnoise.c
@@ -1187,6 +1187,12 @@ osnoise_apply_config(struct osnoise_tool *tool, struct osnoise_params *params)
 		auto_house_keeping(&params->monitored_cpus);
 	}
 
+	retval = osnoise_set_workload(tool->context, true);
+	if (retval < -1) {
+		err_msg("Failed to set OSNOISE_WORKLOAD option\n");
+		goto out_err;
+	}
+
 	return 0;
 
 out_err:
-- 
2.48.1

