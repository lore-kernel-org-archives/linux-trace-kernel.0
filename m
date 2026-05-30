Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E68C6305673
	for <linux-trace-kernel@vger.kernel.org>; Sat, 30 May 2026 14:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780150635; cv=none; b=H2Y7yhJdItm1bVKu2RDaCeN05QbuKePWI+oCcbWuSf7n0u+dugvAPp24xkOVmtHe+hhoE8tZNwPhpPuOqigw4Bk00a+W5mqIHHIdYYLScqoStbhwlHyKXRUFVlwkzIB5dIOXomXKGv/e3Jt5iMi+aqx9Gou4+XdD7YjnrU1K+EA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780150635; c=relaxed/simple;
	bh=gFdwMA8XHL/34A2qgdCDIwi1WjLV/OpiyLi0vEnRgYk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=Cd3Kk0Qq9fEdUevbSNhM4YiEKMjR1d2yCkVTK43ho+CCaSxsWmF1GOKXh27mpbLVTqD1ZE7aFlNfkBPx6NETcrej5pZBTfNih81K7zj73PDHRMt80xXYNuNezd0WLmETyJrDDGYGln/TQ6vbPOqspdNJaC9OgKA7TguzmOZUlf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hwX+nxlP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hwX+nxlP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780150633;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Dl6dXWp6P9btDw571JyJSrz97r1npQl76nCQ2UqxzpM=;
	b=hwX+nxlPTUwIR38QwONwSeSeM5cgHDUeaJhecAgu9WApCUTNphUVTo7vcMUPVFFJXVfKfd
	v3ofwjYm7WuiQXhES5ppkH5LiOhHCBudp6Ui7kuCm15StFSJvX0RqVl2VWa1L6GwObIm/d
	SJo39Z9szaYU/HPxBqFtAQYMAh8BKrk=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-104-BBFmwEcXNT6rK4MMcnNAeg-1; Sat,
 30 May 2026 10:17:11 -0400
X-MC-Unique: BBFmwEcXNT6rK4MMcnNAeg-1
X-Mimecast-MFC-AGG-ID: BBFmwEcXNT6rK4MMcnNAeg_1780150630
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D0C6F19560B2;
	Sat, 30 May 2026 14:17:09 +0000 (UTC)
Received: from fedora-pc.redhat.corp (headnet01.pony-001.prod.iad2.dc.redhat.com [10.2.32.101])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E673730001BB;
	Sat, 30 May 2026 14:17:07 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	linux-trace-kernel@vger.kernel.org
Cc: Wen Yang <wen.yang@linux.dev>,
	Nam Cao <namcao@linutronix.de>
Subject: [PATCH v3 04/13] rv: Ensure all pending probes terminate on per-obj monitor destroy
Date: Sat, 30 May 2026 16:16:43 +0200
Message-ID: <20260530141652.58084-5-gmonaco@redhat.com>
In-Reply-To: <20260530141652.58084-1-gmonaco@redhat.com>
References: <20260530141652.58084-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: VXseMwoyC3NGi5bql-9LIN4QdJ_0zWGdoXRakBBivp4_1780150630
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

The monitor disable/destroy sequence detaches all probes and resets the
monitor's data, however it doesn't wait for pending probes. This is an
issue with per-object monitors, which free the monitor storage.

Call tracepoint_synchronize_unregister() to make sure to wait for all
pending probes before destroying the monitor storage.

Fixes: 4a24127bd6cb ("rv: Add support for per-object monitors in DA/HA")
Reviewed-by: Wen Yang <wen.yang@linux.dev>
Reviewed-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 include/rv/da_monitor.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/rv/da_monitor.h b/include/rv/da_monitor.h
index cc97cc5df..a7e103654 100644
--- a/include/rv/da_monitor.h
+++ b/include/rv/da_monitor.h
@@ -511,9 +511,10 @@ static inline void da_monitor_destroy(void)
 	struct hlist_node *tmp;
 	int bkt;
 
+	tracepoint_synchronize_unregister();
 	/*
-	 * This function is called after all probes are disabled, we need only
-	 * worry about concurrency against old events.
+	 * This function is called after all probes are disabled and no longer
+	 * pending, we can safely assume no concurrent user.
 	 */
 	synchronize_rcu();
 	hash_for_each_safe(da_monitor_ht, bkt, tmp, mon_storage, node) {
-- 
2.54.0

