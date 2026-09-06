Received: from mta1.migadu.com (out-239.mta1.migadu.com [95.215.58.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C931E3BB68B
	for <linux-trace-kernel@vger.kernel.org>; Sun,  6 Sep 2026 17:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788714661; cv=none; b=gSvEweuOFH8GVzZWnSpFAnRRGIjmugIZ1n/ZLjroZ7naRedXSkRLiql7fD4X6U2lM5AjOCgulEAYmXoZfGF+ACp1TIqBpcuqWFjBSeOGcRWYOUdey3m14rlhunq7nVLfobTzibOWOfxOzAiMi4TTVYoLrT3o++QxeYglyjA1cBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788714661; c=relaxed/simple;
	bh=xb99JgDGTtCItKyuxlPAFODc8L6TfNE8KIBXgN0TWUQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FfUrhkzWyiKTjN93BSrdyKXUMV5RF/wi9dVADK/OykVtK0sgUkaHpdf/huKHH6RELlLN/Ad1XcNjEpIVx6SzKYb2ZgjB7BKvl8+nF5VF9NBNFccxy7tCn/g16rZNVNJ/tiDuCncu6kIcuZoWAkKfxMTS+eC6zEn4k70sw6gKN3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=muy++HDq; arc=none smtp.client-ip=95.215.58.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="muy++HDq"
X-Envelope-To: linux-trace-kernel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=xb99JgDGTtCItKyuxlPAFODc8L6TfNE8KIBXgN0TWUQ=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788714657; v=1; x=1789319457;
 b=muy++HDqtPp/VbrU4jemK634lmgD8ytWvE3UFxX0ptLpbcZkLMm+EMuJKdbQ043fs5TfpJCT
 Ih0fOOhvorEewrGmKQLrZZtE1lOdg3Ww2ngPcAg9A88sjR6zNCQFrVFde1rv4Nuiv5oMCWQtvPm
 5QCbJCoJb1gY8ScURkYlTUxg=
X-Envelope-To: linux-trace-kernel@vger.kernel.org
Received: by mta11.migadu.com with ESMTPS id 1c5e610d1f1f794a;
	Sun, 06 Sep 2026 17:10:57 +0000
X-Mizu-Trace-ID: 1c5e610d1f1f794a
X-Migadu-Flow: FLOW_OUT
From: wen.yang@linux.dev
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Nam Cao <namcao@linutronix.de>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wen Yang <wen.yang@linux.dev>
Subject: [PATCH v5 2/5] rv/reactors: propagate rv_register_reactor() error from reactor init
Date: Mon,  7 Sep 2026 01:10:38 +0800
Message-Id: <c8b204625715987752e286f6165b5ca3f4c40479.1788705281.git.wen.yang@linux.dev>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1788705281.git.wen.yang@linux.dev>
References: <cover.1788705281.git.wen.yang@linux.dev>
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

