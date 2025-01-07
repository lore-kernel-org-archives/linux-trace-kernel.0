Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 168A41F2C59
	for <linux-trace-kernel@vger.kernel.org>; Tue,  7 Jan 2025 14:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736261447; cv=none; b=XEKD7OX9OcqCbGL4IYQOVYTt8Qff6Ujc9wZyr5x74r7PkQp1lvXeInv679uethDkEMy3uUWKOSed0FYwodDOl9tQl9xQIS0hyA0N+KqZLE3+reHceiT625T+wTxW2KtCQmr5m2GxqIdnTcxtKlg2C5jOrZOdmT1bWv9GVZRe/js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736261447; c=relaxed/simple;
	bh=JFHwV3rqAhje+xFwmQcHy9oSgigK/8RdGCoLPRcD5Ro=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PvN+Uy4sYasMkwH1yscrs60i93phT0GRO6TFW+ZctKutiOzYbXPvO3JsU9nbC8pq1wkSnHPOfD3pbivUvThJ8Gqgbz91z6IDYrdzL3tL+GC76HS8klkCV3jnmk9G0xTyzd7J4tOMXpXIDmOFBrt2hkLuaF+n6gHh2qCTFIsErMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cHuoYei2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cHuoYei2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736261445;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p2N17mINbCXI2IZHsY3as/nDrVkZy95kpKV0uMugEi0=;
	b=cHuoYei2W7VrtIevIdt0Z3D+Wi73EOJsR/faLtwhQji63YpdmYlS0qSl3TR1CoidKD0aed
	A0hO2uqFHlAxyMSm5eBuER1CFXF70XMqQgEH9Qt9JbmCRw8hTv8lJSd5HKGp9m2TzhZs+3
	oGYpoYyGh7PFEIy45sIZQ0hhDu4w97A=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-215-BN1CTcmRP9KOrEZHFfrhDA-1; Tue,
 07 Jan 2025 09:50:42 -0500
X-MC-Unique: BN1CTcmRP9KOrEZHFfrhDA-1
X-Mimecast-MFC-AGG-ID: BN1CTcmRP9KOrEZHFfrhDA
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2E4AD19560B3;
	Tue,  7 Jan 2025 14:50:40 +0000 (UTC)
Received: from fedora.brq.redhat.com (unknown [10.43.17.159])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E07111956088;
	Tue,  7 Jan 2025 14:50:37 +0000 (UTC)
From: Tomas Glozar <tglozar@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	John Kacur <jkacur@redhat.com>,
	Luis Goncalves <lgoncalv@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>
Subject: [PATCH 3/3] rtla/timerlat_top: Set OSNOISE_WORKLOAD for kernel threads
Date: Tue,  7 Jan 2025 15:48:23 +0100
Message-ID: <20250107144823.239782-4-tglozar@redhat.com>
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

Apply fix from previous commit also to timerlat-top.

Cc: stable@vger.kernel.org
Fixes: cdca4f4e5e8e ("rtla/timerlat_top: Add timerlat user-space support")
Signed-off-by: Tomas Glozar <tglozar@redhat.com>
---
 tools/tracing/rtla/src/timerlat_top.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/tools/tracing/rtla/src/timerlat_top.c b/tools/tracing/rtla/src/timerlat_top.c
index 059b468981e4..521f9822e747 100644
--- a/tools/tracing/rtla/src/timerlat_top.c
+++ b/tools/tracing/rtla/src/timerlat_top.c
@@ -851,12 +851,15 @@ timerlat_top_apply_config(struct osnoise_tool *top, struct timerlat_top_params *
 		}
 	}
 
-	if (params->user_top) {
-		retval = osnoise_set_workload(top->context, 0);
-		if (retval) {
-			err_msg("Failed to set OSNOISE_WORKLOAD option\n");
-			goto out_err;
-		}
+	/*
+	* Set workload according to type of thread if the kernel supports it.
+	* On kernels without support, user threads will have already failed
+	* on missing timerlat_fd, and kernel threads do not need it.
+	*/
+	retval = osnoise_set_workload(top->context, params->kernel_workload);
+	if (retval < -1) {
+		err_msg("Failed to set OSNOISE_WORKLOAD option\n");
+		goto out_err;
 	}
 
 	if (isatty(STDOUT_FILENO) && !params->quiet)
-- 
2.47.1

