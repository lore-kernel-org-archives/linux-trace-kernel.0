Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C073AA9EF
	for <linux-trace-kernel@vger.kernel.org>; Tue, 12 May 2026 14:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778594604; cv=none; b=VzhJZYtQdXkPT2lBOTAV761ZqCVtEyW+7Lk2J/UrFzkU/fenJrptYkXcR1qJ9R5InEJKJWGXkqvwtz2ta0wQGx2q8+4+rqVcpP3pQa/IavWM0CUqzp6htOyLUkaO+TzKUlAoQQDk4OmuVFH1GfQ2XR4N6FbsuotXL4fZrFWP2vQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778594604; c=relaxed/simple;
	bh=dtRzpASfbz4qs7QnMxiUBF7GyWMlODsA475dPUppOUA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=iYzoQ/wJxd9xKI9U5DWQ2vtxu2hcl/6e+G/56a+shDitJaj2mN42mlxw4fE0NFxcKFEyOMsjmhWe82hMMslPc0wAFb3qhBbVOcvzLe0IVa6nUaRCahx5G6nyi+S3AaBjct7Xmw8ekaqXpTa8rQ+T45ojm/miIt5lEetO6l68i+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D9UpBf5q; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D9UpBf5q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778594600;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oVbHQ3XoNdxH14KbuMU+vAw7+4kZhF6YmDtmf6L30ys=;
	b=D9UpBf5qNMjLu/AEADnuJnvcD5ZIPerTWZ6Of3lrPfPDD/DmJOz8d+dFbf2csi87WSH1Lx
	p74UNWphBOqEiuOxSVFNVYKMb3GDRYxm7ZOsU/R6hl2M0ZrU5AdKByz4NAHtJnUg0+/RN2
	ut3fIaLydVlX5sP5O9ieyJRI075JL3M=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-450-NW9Np98XOke5eNMLG3x8oA-1; Tue,
 12 May 2026 10:03:15 -0400
X-MC-Unique: NW9Np98XOke5eNMLG3x8oA-1
X-Mimecast-MFC-AGG-ID: NW9Np98XOke5eNMLG3x8oA_1778594593
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 880AB1955F38;
	Tue, 12 May 2026 14:03:13 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (unknown [10.44.34.139])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5FA06180058F;
	Tue, 12 May 2026 14:03:11 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Nam Cao <namcao@linutronix.de>,
	linux-trace-kernel@vger.kernel.org
Cc: Wen Yang <wen.yang@linux.dev>
Subject: [PATCH 5/9] rv: Ensure all pending probes terminate on per-obj monitor destroy
Date: Tue, 12 May 2026 16:02:46 +0200
Message-ID: <20260512140250.262190-6-gmonaco@redhat.com>
In-Reply-To: <20260512140250.262190-1-gmonaco@redhat.com>
References: <20260512140250.262190-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: 5kuEfqUlh4Uo2cfSSx8Xa2HHtHpfUHKIKRxyckSxaJ4_1778594593
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

The monitor disable/destroy sequence detaches all probes and resets the
monitor's data, however it doesn't wait for pending probes. This is an
issue with per-object monitors, which free the monitor storage.

Call tracepoint_synchronize_unregister() to make sure to wait for all
pending probes before destroying the monitor storage.

Fixes: 4a24127bd6cb ("rv: Add support for per-object monitors in DA/HA")
Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 include/rv/da_monitor.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/rv/da_monitor.h b/include/rv/da_monitor.h
index a9fd284195ee..a4a13b62d1a4 100644
--- a/include/rv/da_monitor.h
+++ b/include/rv/da_monitor.h
@@ -515,9 +515,10 @@ static inline void da_monitor_destroy(void)
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

