Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E2735944
	for <linux-trace-kernel@vger.kernel.org>; Thu, 13 Mar 2025 14:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741875047; cv=none; b=U2vKvgyW3vdrzyjbxNvtgl6YhIqtKKG4HbvV42wvwf87iZSaGnqzaSfql6syBUrBCiQghpR1djj6qflTEENdG23HSoNbRWKda0HhPeaxSqyt2cAsuHP3sfclC7RnST/eDdHPNWKVHtzkQ7UwWGRWVu3jS7nEXBzLgi4qU+zdCLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741875047; c=relaxed/simple;
	bh=EJUTitUtD81Y4bLuGqwLvb2dQonGPDfF1oZONJIlL4o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BpREpiwIuuJwjGoQtfCFVR7ExL5wAQ5pTBINkU8Nun0PUaivWIPRGNaOkQ0elhQsV9GVprW6kDZ2y0yMEz/ii5rPXH5zx+ZA3yb71Ia7o8+Yl+SwMCOlxnT0PwkuTtqbkLBrYMhJZlh/wQYKEkVJe1M7i/U2t+000HeCNxN2iVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P1mAiq9r; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P1mAiq9r"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741875043;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=dKqf08821exowg6WUhMV197zYPDi7Ol6Vs+4dmfDUQU=;
	b=P1mAiq9rqQgVIv3jMmT4Cc1UXx0RnXJGdoEMSoexKICI6K88PlGERQFYcFnYMPAO+aSQHC
	A5w5F15T48iRkjR4XxZRduZVskxfWviBVtow2aIsJ7dwjZoPZfC7hHfknheXTVBlAIcv8L
	xRXpLwkeR5dgRnr95H0GTneIPTVq50U=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-191-H1vHTVnzNvC551eOvE71Ng-1; Thu,
 13 Mar 2025 10:10:42 -0400
X-MC-Unique: H1vHTVnzNvC551eOvE71Ng-1
X-Mimecast-MFC-AGG-ID: H1vHTVnzNvC551eOvE71Ng_1741875041
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BFEED180AF57;
	Thu, 13 Mar 2025 14:10:41 +0000 (UTC)
Received: from fedora.brq.redhat.com (unknown [10.43.17.52])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5BE6B300376F;
	Thu, 13 Mar 2025 14:10:39 +0000 (UTC)
From: Tomas Glozar <tglozar@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	John Kacur <jkacur@redhat.com>,
	Luis Goncalves <lgoncalv@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>
Subject: [PATCH] rtla: Fix segfault in save_trace_to_file call
Date: Thu, 13 Mar 2025 15:10:34 +0100
Message-ID: <20250313141034.299117-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Running rtla with exit on threshold, but without saving trace leads to a
segmenetation fault:

$ rtla timerlat hist -T 10
...
Max timerlat IRQ latency from idle: 4.29 us in cpu 0
Segmentation fault

This is caused by null pointer deference in the call of
save_trace_to_file, which attempts to dereference an uninitialized
osnoise_tool variable:

save_trace_to_file(record->trace.inst, params->trace_output);
                   ^ this is uninitialized if params->trace_output is
                     not set

Fix this by not attempting to dereference "record" if it is NULL and
passing NULL instead. As a safety measure, the first field is also
checked for NULL inside save_trace_to_file.

Fixes: dc4d4e7c72d1 ("rtla: Refactor save_trace_to_file")
Signed-off-by: Tomas Glozar <tglozar@redhat.com>
---
Note: As this fixes a commit in linux-next, the Fixes commit ID might
have to be adjusted.

 tools/tracing/rtla/src/osnoise_hist.c  | 3 ++-
 tools/tracing/rtla/src/osnoise_top.c   | 3 ++-
 tools/tracing/rtla/src/timerlat_hist.c | 3 ++-
 tools/tracing/rtla/src/timerlat_top.c  | 3 ++-
 tools/tracing/rtla/src/trace.c         | 2 +-
 5 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/tools/tracing/rtla/src/osnoise_hist.c b/tools/tracing/rtla/src/osnoise_hist.c
index 7c6ef67ef3e6..f4c9051c33c4 100644
--- a/tools/tracing/rtla/src/osnoise_hist.c
+++ b/tools/tracing/rtla/src/osnoise_hist.c
@@ -983,7 +983,8 @@ int osnoise_hist_main(int argc, char *argv[])
 
 	if (osnoise_trace_is_off(tool, record)) {
 		printf("rtla osnoise hit stop tracing\n");
-		save_trace_to_file(record->trace.inst, params->trace_output);
+		save_trace_to_file(record ? record->trace.inst : NULL,
+				   params->trace_output);
 	}
 
 out_hist:
diff --git a/tools/tracing/rtla/src/osnoise_top.c b/tools/tracing/rtla/src/osnoise_top.c
index 0eeefbbbf317..dacec2f99017 100644
--- a/tools/tracing/rtla/src/osnoise_top.c
+++ b/tools/tracing/rtla/src/osnoise_top.c
@@ -813,7 +813,8 @@ int osnoise_top_main(int argc, char **argv)
 
 	if (osnoise_trace_is_off(tool, record)) {
 		printf("osnoise hit stop tracing\n");
-		save_trace_to_file(record->trace.inst, params->trace_output);
+		save_trace_to_file(record ? record->trace.inst : NULL,
+				   params->trace_output);
 	}
 
 out_top:
diff --git a/tools/tracing/rtla/src/timerlat_hist.c b/tools/tracing/rtla/src/timerlat_hist.c
index 93d0c9e45020..822c068b4776 100644
--- a/tools/tracing/rtla/src/timerlat_hist.c
+++ b/tools/tracing/rtla/src/timerlat_hist.c
@@ -1473,7 +1473,8 @@ int timerlat_hist_main(int argc, char *argv[])
 		if (!params->no_aa)
 			timerlat_auto_analysis(params->stop_us, params->stop_total_us);
 
-		save_trace_to_file(record->trace.inst, params->trace_output);
+		save_trace_to_file(record ? record->trace.inst : NULL,
+				   params->trace_output);
 	}
 
 out_hist:
diff --git a/tools/tracing/rtla/src/timerlat_top.c b/tools/tracing/rtla/src/timerlat_top.c
index 3894ac37d81c..c3196a0bb585 100644
--- a/tools/tracing/rtla/src/timerlat_top.c
+++ b/tools/tracing/rtla/src/timerlat_top.c
@@ -1295,7 +1295,8 @@ int timerlat_top_main(int argc, char *argv[])
 		if (!params->no_aa)
 			timerlat_auto_analysis(params->stop_us, params->stop_total_us);
 
-		save_trace_to_file(record->trace.inst, params->trace_output);
+		save_trace_to_file(record ? record->trace.inst : NULL,
+				   params->trace_output);
 	} else if (params->aa_only) {
 		/*
 		 * If the trace did not stop with --aa-only, at least print the
diff --git a/tools/tracing/rtla/src/trace.c b/tools/tracing/rtla/src/trace.c
index 74ed2f6208ba..69cbc48d53d3 100644
--- a/tools/tracing/rtla/src/trace.c
+++ b/tools/tracing/rtla/src/trace.c
@@ -75,7 +75,7 @@ int save_trace_to_file(struct tracefs_instance *inst, const char *filename)
 	int out_fd, in_fd;
 	int retval = -1;
 
-	if (!filename)
+	if (!inst || !filename)
 		return 0;
 
 	in_fd = tracefs_instance_file_open(inst, file, O_RDONLY);
-- 
2.48.1

