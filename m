Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C9FF27FB35
	for <linux-trace-kernel@vger.kernel.org>; Mon, 21 Jul 2025 08:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753086240; cv=none; b=iD231AC2xd3VT7q2MrEra0/l0sJRotmrrIGGLTiMSP/6nesvY/Fsz9g/+TzMzeZ7clrKJBu6iud68wQ7D8stCUnKmSvi5Bk0Ll6MEf7KoebQVl9wMydwDA2JsNFINmHcRTMNZzfgE1gFWWn2e5C6rPKsGIWtsQEu3Rq8SjNJg+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753086240; c=relaxed/simple;
	bh=yWiUq8fghZDhX5ma9boL3BXbQhkeBz7R0cP557CB3fA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P0mx7t+z8phxTbdNj4LtGAtkZuKafrteyw9USfEBhRWPVFp+RegJI8mdfzPDeHj5Ct9pqQM/3WbKkVaVqjlYWPfSgAzOV8o66JhqClw2dQFws27t40id0bh9HPG1yglcK2RaAAE1cBVgLR0AfEON0uP14lbtI+pxSaKzLmcoC/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EBXm8CKK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EBXm8CKK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753086238;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ltwOXqFjqgE+HbNtjGzELCnivw3kypC1AN2XcT9IjAE=;
	b=EBXm8CKK0/OJO2bhccaqnivaek3C+RyUm7HSZM3OUuI7FbSmdYKuqWWNHOr4dhpX6KdMNd
	8ij7/w2Ayhi8bv71PxpbfaMCtR6EcRmp8PulvX1xHePH1FHgQka0aUSFbx4E91KRsPZqr4
	p8rGG+m3ceRkadgvMfQozM9gICthBrg=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-548-a33FVAvtPoiioe1XZhug0w-1; Mon,
 21 Jul 2025 04:23:54 -0400
X-MC-Unique: a33FVAvtPoiioe1XZhug0w-1
X-Mimecast-MFC-AGG-ID: a33FVAvtPoiioe1XZhug0w_1753086233
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EA8BA19560B5;
	Mon, 21 Jul 2025 08:23:52 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.com (unknown [10.44.32.136])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D4F66195608D;
	Mon, 21 Jul 2025 08:23:48 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-trace-kernel@vger.kernel.org
Cc: Gabriele Monaco <gmonaco@redhat.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Nam Cao <namcao@linutronix.de>,
	Tomas Glozar <tglozar@redhat.com>,
	Juri Lelli <jlelli@redhat.com>,
	Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: [PATCH v4 02/14] tools/rv: Stop gracefully also on SIGTERM
Date: Mon, 21 Jul 2025 10:23:12 +0200
Message-ID: <20250721082325.71554-3-gmonaco@redhat.com>
In-Reply-To: <20250721082325.71554-1-gmonaco@redhat.com>
References: <20250721082325.71554-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Currently the userspace RV tool starts a monitor and waits for the user
to press Ctrl-C (SIGINT) to terminate and stop the monitor.
This doesn't account for a scenario where a user starts RV in background
and simply kills it (SIGTERM unless the user specifies differently).
E.g.:
 # rv mon wip &
 # kill %

Would terminate RV without stopping the monitor and next RV executions
won't start correctly.

Register the signal handler used for SIGINT also to SIGTERM.

Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 tools/verification/rv/src/rv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/verification/rv/src/rv.c b/tools/verification/rv/src/rv.c
index 239de054d1e06..b8fe24a87d97c 100644
--- a/tools/verification/rv/src/rv.c
+++ b/tools/verification/rv/src/rv.c
@@ -191,6 +191,7 @@ int main(int argc, char **argv)
 		 * and exit.
 		 */
 		signal(SIGINT, stop_rv);
+		signal(SIGTERM, stop_rv);
 
 		rv_mon(argc - 1, &argv[1]);
 	}
-- 
2.50.1

