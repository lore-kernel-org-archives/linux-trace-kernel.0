Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E11B390235
	for <linux-trace-kernel@vger.kernel.org>; Mon,  1 Jun 2026 15:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780328347; cv=none; b=Ieub5CwXv5cAUcc8/2Nr1/xwbDL8qD9JOcEAIPWEM8ZGAcoibfYLq5syd9sjJsJ9czE7qY1LOju1O6QZVx+P7D1QTErV6z+wnH+d4GkMJnxnZAj3ku/B+YaFagcHZPGBxqwvlYlFnImQWuBNOAgvb/n+5sQZwAJaygYN9CL065M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780328347; c=relaxed/simple;
	bh=gFdwMA8XHL/34A2qgdCDIwi1WjLV/OpiyLi0vEnRgYk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=TasbhNPGQ0w+TeaKFKskp9CoKKHcTgIy4hIxKV3pcaJGK0qfx7OT4fRGPpcUcmCBLEPMgZh7YMlgzShFXnLbWF9yAJgDORt5QRsZD8hAVUragE34O2mimY1czpCf99f0KeT/VaRs3csRthSeM7Yfkq9a+bsgvlszTq8DtDmVfwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gjzNDHW0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gjzNDHW0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780328345;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Dl6dXWp6P9btDw571JyJSrz97r1npQl76nCQ2UqxzpM=;
	b=gjzNDHW0NW+h9ZYRs4Jt/ASufp7cH66ZfeCs6c04lcBh365mNRfOyxqzhztvijLTygUFa1
	uUt3h3J+OiaSZg2Fmb/SsfnVkX+L56D8uzWImu7+nxTaFJWDJUHpQtBnnBmv09G7VtZnCj
	byW3QowLNQA0fnHBGrjC2H9YJztNxsM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-391-qG2RD2zjPbech16biPHcog-1; Mon,
 01 Jun 2026 11:39:02 -0400
X-MC-Unique: qG2RD2zjPbech16biPHcog-1
X-Mimecast-MFC-AGG-ID: qG2RD2zjPbech16biPHcog_1780328341
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E99F619560B9;
	Mon,  1 Jun 2026 15:39:00 +0000 (UTC)
Received: from fedora-pc.redhat.corp (headnet01.pony-001.prod.iad2.dc.redhat.com [10.2.32.101])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 240321800577;
	Mon,  1 Jun 2026 15:38:58 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	linux-trace-kernel@vger.kernel.org
Cc: Wen Yang <wen.yang@linux.dev>,
	Nam Cao <namcao@linutronix.de>
Subject: [PATCH v4 04/13] rv: Ensure all pending probes terminate on per-obj monitor destroy
Date: Mon,  1 Jun 2026 17:38:31 +0200
Message-ID: <20260601153840.124372-5-gmonaco@redhat.com>
In-Reply-To: <20260601153840.124372-1-gmonaco@redhat.com>
References: <20260601153840.124372-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: 3qftbIZ8iznY-QA7MBahB7rHHs-QAP2oruBv9aQKX7U_1780328341
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

