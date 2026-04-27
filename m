Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5661E32ED55
	for <linux-trace-kernel@vger.kernel.org>; Mon, 27 Apr 2026 15:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777302731; cv=none; b=ejD1MZT8mOVOQYbzNtXRO7aeFC83jkwQpEoYiSSEwAQJfxQUEsmyBscj5wlmZMc4cqPXK53E37AJOyXXcfMh+ziH6pVqi0Ef38hAuqdd9XtFChOXK4TG7x0Wr2yCOOeVhW3ILM/a+u+56cp9t7HNWb6TXGXRl1wYKRcPs4BVHo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777302731; c=relaxed/simple;
	bh=UWUZk4hkdNL4huLX6YHY2/guG7GJc3afMyJjsvaS+Cg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=Fz8wf4X1X+OQgN0SpCOtm5jMVMndyeKnLYKrH4/FVkoCMlcqSlyVTvcrKWP3CoD/R4kVpGhwvk6WFGVz8gZIWXv0Vl/ywn+s5FsTpuRh15ok98/cr0YV3WCFzSoM3n0YjpWQHzj2WPpWIaH8MUBezYXk6R/tG5iIFaKAZHl1nUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hbn5fJ3Y; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hbn5fJ3Y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777302729;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MPiuStO13Gz3S6Lb9B0sQWvORmksHJAodsDQJ8FhIAQ=;
	b=hbn5fJ3YHMLhQAn1TvhQRJ6SodtENDiqeaaz1B9XIPW/KMJ//l/J+iA8vmbKEINrMF4MPZ
	m1XnVh3pzP2vEQEmskjxKSBjz9UupVOngcFFcBHd77TBHEgqm2jBMaeZKkkqBoD2AEIwgz
	LQb4Bhc1KToeYT55fmWK+tLIAsUCbhE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-370-UwQGU9B5N-2YeNfAEn8hLQ-1; Mon,
 27 Apr 2026 11:12:03 -0400
X-MC-Unique: UwQGU9B5N-2YeNfAEn8hLQ-1
X-Mimecast-MFC-AGG-ID: UwQGU9B5N-2YeNfAEn8hLQ_1777302722
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 74F5118002D1;
	Mon, 27 Apr 2026 15:12:02 +0000 (UTC)
Received: from fedora-pc.redhat.corp (headnet01.pony-001.prod.iad2.dc.redhat.com [10.2.32.101])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2ACCB195608E;
	Mon, 27 Apr 2026 15:11:58 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>
Cc: Nam Cao <namcao@linutronix.de>,
	Thomas Weissschuh <thomas.weissschuh@linutronix.de>,
	Tomas Glozar <tglozar@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	Wen Yang <wen.yang@linux.dev>
Subject: [RFC PATCH 03/12] tools/rv: Fix exit status when monitor execution fails
Date: Mon, 27 Apr 2026 17:11:25 +0200
Message-ID: <20260427151134.192971-4-gmonaco@redhat.com>
In-Reply-To: <20260427151134.192971-1-gmonaco@redhat.com>
References: <20260427151134.192971-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-MFC-PROC-ID: 8xignP48u8WYlHraBw2kmix8ivtJII9PLs15MCSXaSQ_1777302722
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

When running "rv mon" on a monitor that is already enabled, the tool
fails to start but incorrectly exits with a success status (0).

Fix the exit condition to ensure it returns a failure code on any
execution error.

Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 tools/verification/rv/src/rv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/verification/rv/src/rv.c b/tools/verification/rv/src/rv.c
index b8fe24a87d97..6d65f4037581 100644
--- a/tools/verification/rv/src/rv.c
+++ b/tools/verification/rv/src/rv.c
@@ -127,7 +127,7 @@ static void rv_mon(int argc, char **argv)
 
 	if (!run)
 		err_msg("rv: monitor %s does not exist\n", monitor_name);
-	exit(!run);
+	exit(run <= 0);
 }
 
 static void usage(int exit_val, const char *fmt, ...)
-- 
2.53.0

