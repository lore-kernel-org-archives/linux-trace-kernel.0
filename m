Received: from mta1.migadu.com (out-221.mta1.migadu.com [95.215.58.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42370490C07
	for <linux-trace-kernel@vger.kernel.org>; Thu, 27 Aug 2026 18:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787854991; cv=none; b=GQIABWz6I3dDv2yE0lhGc4iFB/E4/rOgiEsZ2HJDDQ6HMtu+hRwwGe20bUqEt3rwv4QWaUlD6cyyXZ+DBIxrecYmuAmin1PzgRJYzYrlBmZxJ0NYEcOH345oULhOkaIM9VlAAV526QXODA5K2EIgDG7ASL9f4XbeeIL9XJ2uqIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787854991; c=relaxed/simple;
	bh=xb99JgDGTtCItKyuxlPAFODc8L6TfNE8KIBXgN0TWUQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mPt9PUjh0SSSsyUJ/jUh57TZ6cCfyVR3SEHMDg1yzjP2OaIpYEnaG+413HgVu9rqOQBYGUdgvaXylsUldphCghj108WWBMLufF8IQIiz2ynKizFfDoA4GVu897GlIHXUUe4c93hurJHczky6YPUgGeheYJCwUipRPDt6Bax9UfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PdS1hFgT; arc=none smtp.client-ip=95.215.58.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PdS1hFgT"
X-Envelope-To: linux-trace-kernel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=xb99JgDGTtCItKyuxlPAFODc8L6TfNE8KIBXgN0TWUQ=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787854986; v=1; x=1788459786;
 b=PdS1hFgTN9o8N1NH3DiyiwbgIkId+ekz1g/47QL1oIOCKGS/at00Lp+apW8+T6Y9GHjtJnq+
 qhyuU+CPAnm444mEhiYN6+H7n0F/TsgbEwuSixWMsUXxH50yNR/Jz6a7DlsvGbgID47kj5sCgGO
 IYleiJwY7P5SUdMc8j4i1l4Q=
X-Envelope-To: linux-trace-kernel@vger.kernel.org
Received: by mta11.migadu.com with ESMTPS id 94ff23ca2328d543;
	Thu, 27 Aug 2026 18:23:06 +0000
X-Mizu-Trace-ID: 94ff23ca2328d543
X-Migadu-Flow: FLOW_OUT
From: wen.yang@linux.dev
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Nam Cao <namcao@linutronix.de>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wen Yang <wen.yang@linux.dev>
Subject: [PATCH v4 2/4] rv/reactors: propagate rv_register_reactor() error from reactor init
Date: Fri, 28 Aug 2026 02:22:44 +0800
Message-Id: <dd145b5165805923f9503c573a4e107ac002d455.1787854397.git.wen.yang@linux.dev>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1787854397.git.wen.yang@linux.dev>
References: <cover.1787854397.git.wen.yang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wen Yang <wen.yang@linux.dev>

Both register_react_printk() and register_react_panic() ignore the
return value of rv_register_reactor() and always return 0.  If the
registration fails (e.g. a duplicate reactor name), the init functions
silently report success even though the reactor was not registered.

Propagate the error from rv_register_reactor() so a failed registration
is reported instead of being silently ignored.

Reviewed-by: Gabriele Monaco <gmonaco@redhat.com>
Reviewed-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Wen Yang <wen.yang@linux.dev>
---
 kernel/trace/rv/reactor_panic.c  | 3 +--
 kernel/trace/rv/reactor_printk.c | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/rv/reactor_panic.c b/kernel/trace/rv/reactor_panic.c
index 76537b8a4343..db7116ceafff 100644
--- a/kernel/trace/rv/reactor_panic.c
+++ b/kernel/trace/rv/reactor_panic.c
@@ -26,8 +26,7 @@ static struct rv_reactor rv_panic = {
 
 static int __init register_react_panic(void)
 {
-	rv_register_reactor(&rv_panic);
-	return 0;
+	return rv_register_reactor(&rv_panic);
 }
 
 static void __exit unregister_react_panic(void)
diff --git a/kernel/trace/rv/reactor_printk.c b/kernel/trace/rv/reactor_printk.c
index 48c934e315b3..002a10f6aa7b 100644
--- a/kernel/trace/rv/reactor_printk.c
+++ b/kernel/trace/rv/reactor_printk.c
@@ -25,8 +25,7 @@ static struct rv_reactor rv_printk = {
 
 static int __init register_react_printk(void)
 {
-	rv_register_reactor(&rv_printk);
-	return 0;
+	return rv_register_reactor(&rv_printk);
 }
 
 static void __exit unregister_react_printk(void)
-- 
2.25.1

