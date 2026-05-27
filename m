Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D4233CEB0
	for <linux-trace-kernel@vger.kernel.org>; Wed, 27 May 2026 06:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779863041; cv=none; b=Priee5sNx4EplLXUwMf3dsH3PRVx0Y5FfOYsra1vmliR7z8aXtjoNv/FeHmu03zJELoP3f0gQyvJSi5HV9lMJt3+1Ak+LaTY6y+P86LN8kkK+4RQNa7JNUqDEh+2KAIdl6gZFUgz8l8ACMPIZwSjf6m3PZM90xEvOd47CKC3AU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779863041; c=relaxed/simple;
	bh=yXavbOgJGAdUlQEGS1RBEw+jkgQmb76OwhKj/lFQJqk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=KmxhCcJb054PEG1Kk+uRzBb6YydtW2k9u9jtWeRRskq74VXn029vDjTyg0NmA5Cn/NDeX2eoeutnQtF8IvElo2Rtl18XRojFLq8UhKMxyfQiVn7SqDcrczU0gVEFyXHyLVwYVhmPdrEpvC+QMhTnmVUckIh6WXO+mW6hF7J5ydo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LMw5g4Zs; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LMw5g4Zs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779863039;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UA0PFohOj15Jgq9Y3jQIIxa6b/L9rthaIIUjUoXjxGU=;
	b=LMw5g4ZsYmhxAMM2bCsEPNI/xVQYxGF5bUFr3o9NLzn2cK51tK4v7BjWBMB4QI0QrRWSMO
	E6F0R4AHtXYRjr9ckVet9yaU8qrKNqWgyeiFlIsQ8VGo87mDbUz/eNUO4ohSj5EZYs1Cdk
	o2wi/UOAGSdnu21SUyOESDuq/54EJDY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-98-o-lGshGEMwqorcMa_nz3hg-1; Wed,
 27 May 2026 02:23:54 -0400
X-MC-Unique: o-lGshGEMwqorcMa_nz3hg-1
X-Mimecast-MFC-AGG-ID: o-lGshGEMwqorcMa_nz3hg_1779863033
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 391C318002CB;
	Wed, 27 May 2026 06:23:53 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (unknown [10.44.32.86])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E8F381800576;
	Wed, 27 May 2026 06:23:50 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Nam Cao <namcao@linutronix.de>,
	linux-trace-kernel@vger.kernel.org
Cc: Wen Yang <wen.yang@linux.dev>
Subject: [PATCH v2 06/12] rv: Ensure all pending probes terminate on per-obj monitor destroy
Date: Wed, 27 May 2026 08:23:06 +0200
Message-ID: <20260527062313.39908-7-gmonaco@redhat.com>
In-Reply-To: <20260527062313.39908-1-gmonaco@redhat.com>
References: <20260527062313.39908-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: bRGL1aKrSXx2JVzGp0dYWnrfYm4aYDZMXEc2sN2OltI_1779863033
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
Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 include/rv/da_monitor.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/rv/da_monitor.h b/include/rv/da_monitor.h
index 446a4d53d99c..5f790e1694b4 100644
--- a/include/rv/da_monitor.h
+++ b/include/rv/da_monitor.h
@@ -519,9 +519,10 @@ static inline void da_monitor_destroy(void)
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

