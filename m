Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86BCE3A7D98
	for <linux-trace-kernel@vger.kernel.org>; Tue, 12 May 2026 14:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778594594; cv=none; b=BjWedPugtCT+P+ouxDS4Y3FSXbEoXfeazUkDGkmkY1II0UB2A8p3u3+hWLB6lgoMjnlVksYyWrChLHBCl416tl7H3Zrx9b2I1kotrCweZl0RjfdBAoawFvd85oKpvgeAlLOln3SaUlSdZw8xZTSvSz+7TQxsSSkhdTAYirY8Kes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778594594; c=relaxed/simple;
	bh=KiLKwPoJlA2vEfRaq9M95ZmvMaQej3NzbE2j+tTZLcI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=nO0dkq+P95Pnf8FREXMeXEnOE7hfPXVEhcUtzS16VE7MFFxs/5mezRwaT1xD01jcAcu6LWfJM7zJJXM2uWdY+gRzjgzUuYBztGNtsfeWVMXglNU5H1vYlWY/+/mMnEjyJ4zotOe6gFGjtu5BgNZ+3Tdgm3Nro+w2ztgDLqgEw6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R7zD8zAw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R7zD8zAw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778594592;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aHElBfRuNx3SycBITv8R/wJt3ZRVorE+97ws8GUTNok=;
	b=R7zD8zAw6e6udSx91XEsrPevpxqO/imp+tYny8BZu7fCzriALPn1T0NDKq0b2LGP7mJEPX
	2mmah7w5tN+Bgc195pBKL3pfN3t1nOOUPgwiZrz6Z9D+ZB58Cv9jzw3qRP5MVWBdAE6kJG
	LWn85LS1OwZdYU5KCA5dz11pgFR74b0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-655-PFzwYH41Ph2PfyKtBmClNQ-1; Tue,
 12 May 2026 10:03:05 -0400
X-MC-Unique: PFzwYH41Ph2PfyKtBmClNQ-1
X-Mimecast-MFC-AGG-ID: PFzwYH41Ph2PfyKtBmClNQ_1778594584
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9AE2B1955F03;
	Tue, 12 May 2026 14:03:03 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (unknown [10.44.34.139])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3DA8A1800240;
	Tue, 12 May 2026 14:03:00 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Nam Cao <namcao@linutronix.de>,
	linux-trace-kernel@vger.kernel.org
Cc: Wen Yang <wen.yang@linux.dev>
Subject: [PATCH 2/9] rv: Fix read_lock scope in per-task DA cleanup
Date: Tue, 12 May 2026 16:02:43 +0200
Message-ID: <20260512140250.262190-3-gmonaco@redhat.com>
In-Reply-To: <20260512140250.262190-1-gmonaco@redhat.com>
References: <20260512140250.262190-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: _aWQT-7-lUZ3U7KgwmDjUfcNatujrYYBgSoEPukHy1Y_1778594584
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

The da_monitor_reset_all() function for per-task monitors takes
tasklist_lock while iterating over tasks, then keeps it also while
iterating over idle tasks (one per CPU). The latter is not necessary
since the lock needs to guard only for_each_process_thread().

Use a scoped_guard for more compact syntax and adjust the scope only
where the lock is necessary.

Fixes: 30984ccf31b7f ("rv: Refactor da_monitor to minimise macros")
Fixes: 8259cb14a7068 ("rv: Reset per-task monitors also for idle tasks")
Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 include/rv/da_monitor.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/rv/da_monitor.h b/include/rv/da_monitor.h
index 39765ff6f098..250888812125 100644
--- a/include/rv/da_monitor.h
+++ b/include/rv/da_monitor.h
@@ -272,12 +272,12 @@ static void da_monitor_reset_all(void)
 	struct task_struct *g, *p;
 	int cpu;
 
-	read_lock(&tasklist_lock);
-	for_each_process_thread(g, p)
-		da_monitor_reset(da_get_monitor(p));
+	scoped_guard(read_lock, &tasklist_lock) {
+		for_each_process_thread(g, p)
+			da_monitor_reset(da_get_monitor(p));
+	}
 	for_each_present_cpu(cpu)
 		da_monitor_reset(da_get_monitor(idle_task(cpu)));
-	read_unlock(&tasklist_lock);
 }
 
 /*
-- 
2.54.0

