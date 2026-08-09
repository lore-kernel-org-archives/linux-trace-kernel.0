Received: from out-173.mta1.migadu.com (mta1.migadu.com [37.59.57.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34CF43B38B8
	for <linux-trace-kernel@vger.kernel.org>; Sun,  9 Aug 2026 17:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.59.57.117
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786295477; cv=none; b=ErnQjwYFmvja/DsVyV4GEsIR6BtDLo2BqnuCf0kUSmTpeUYyEau9Yxty4xOsPjK6668vOW/tgZnxmbtNkrgCb1DNPRej6ICCFr0NYaSi4Ztth/jXyfVk5bWV1besit2ssdSJvOd273SOwzG04rA/H5yIHaNWWEdxydM0Dfn1Wgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786295477; c=relaxed/simple;
	bh=JbsI9yfPOBsdH+UmNWDF8eZ1SFtsOLnJfGlkmJRqsso=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eJD7wmzy/KwrVphS915/hC87ZyfJuivM1/gucaXCTRSYf8mpTKmNygoMXJx8OvzZiRUwZ/criW6bvResfN2riH8p2r2hV4KbsVcFfMI8GnadvI3znmcpmT2Jqa6ZvKyDlCp6/rItWApx3HfBvAnK2APb9/5f6NuSE3wWLQ5IJgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WpdmEODe; arc=none smtp.client-ip=37.59.57.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WpdmEODe"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786295473;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KbHqbqg+2l0IB5FBzF8BcE24Z+K4eE6uADC0MfP/Hxc=;
	b=WpdmEODeaHOf2M1n4Cwvb9hmPr3Z7Ju2yfpWo2BhLPz6DCeSs2hHDJOnqRkD/qN6nParWR
	NEamFsmfaHkRpg8b91q55ZgKBVKCdx3J4SmPjT9yISWIu1cXLj3rg37ibB1g1/zDZYD4Mn
	ZBSH5TJtjlC2kaKYK9ODeaYWRrIvFJY=
From: wen.yang@linux.dev
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Nam Cao <namcao@linutronix.de>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wen Yang <wen.yang@linux.dev>
Subject: [PATCH v3 3/4] rv/reactors: export rv_register_reactor() and rv_unregister_reactor()
Date: Mon, 10 Aug 2026 01:10:40 +0800
Message-Id: <71492c2a3a4596131bc1cdc4256d855ca527daf6.1786294920.git.wen.yang@linux.dev>
In-Reply-To: <cover.1786294920.git.wen.yang@linux.dev>
References: <cover.1786294920.git.wen.yang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Wen Yang <wen.yang@linux.dev>

rv_react() is exported to modules, but the reactor registration helpers
are not.  Export them with EXPORT_SYMBOL_GPL() so reactor modules and
the tristate KUnit test module can register and unregister reactors
without hitting undefined symbol errors at link time(modpost).

Reviewed-by: Gabriele Monaco <gmonaco@redhat.com>
Signed-off-by: Wen Yang <wen.yang@linux.dev>
---
 kernel/trace/rv/rv_reactors.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/trace/rv/rv_reactors.c b/kernel/trace/rv/rv_reactors.c
index 5830229210e8..5c85e3efe42e 100644
--- a/kernel/trace/rv/rv_reactors.c
+++ b/kernel/trace/rv/rv_reactors.c
@@ -314,6 +314,7 @@ int rv_register_reactor(struct rv_reactor *reactor)
 	guard(mutex)(&rv_interface_lock);
 	return __rv_register_reactor(reactor);
 }
+EXPORT_SYMBOL_GPL(rv_register_reactor);
 
 /**
  * rv_unregister_reactor - unregister a rv reactor.
@@ -327,6 +328,7 @@ int rv_unregister_reactor(struct rv_reactor *reactor)
 	list_del(&reactor->list);
 	return 0;
 }
+EXPORT_SYMBOL_GPL(rv_unregister_reactor);
 
 /*
  * reacting_on interface.
-- 
2.25.1

