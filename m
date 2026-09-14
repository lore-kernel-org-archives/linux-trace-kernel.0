Received: from mta0.migadu.com (out-81.mta0.migadu.com [91.218.175.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 743BE383983
	for <linux-trace-kernel@vger.kernel.org>; Mon, 14 Sep 2026 19:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789413247; cv=none; b=BqV0GcN47BhM062lAjIhBxsWapzCp016tDw1c5FMOFE13YfPDeLcXG0nEliVgZBUT44SoO7m6ARLH1euM7dJTqA4sARICXSJuQ/Hnp5dhNppWEiN3kUCZBJFantdumUVil6bGI0Av2B4MHZROQwFcGaB4zHvkjjzNs8FBtFF4xU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789413247; c=relaxed/simple;
	bh=eTbZ0dyiDFT16Alt0dAIvaliqkaJj1LNEmU2jMelxIc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=juAOe55j8Wa2c1Gf52sIL9/fayjE/1ocRWd5iATtUzqjdjZe+/hfRn3Zu4ww+XqV8ZMypKRZTjUEKJkmAxhQkoydE598B+Hddu7hX+FHdQw9M0mGHKxprheGWWdA7/y8g2p6n+TpzpLogG7WK51M2NsYBqLnlbyTQAJX2GCMuv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BCovMbmy; arc=none smtp.client-ip=91.218.175.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BCovMbmy"
X-Envelope-To: linux-trace-kernel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=eTbZ0dyiDFT16Alt0dAIvaliqkaJj1LNEmU2jMelxIc=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789413240; v=1; x=1790018040;
 b=BCovMbmyPrNqc6gHI2f5W1ngdPia/9aFsDW5ZkgCqv1rkSRI/sWx8ssAx+Gf1HusgsW2QCw5
 41Xv0FCca8WPv69XVVH7GD/Z9V58X6XDbvIWlNv5XWVGZIbQkfRPiAl4QLASbWAqoMu5w+tQ1OW
 yU5GI2Eyw6qzm34uj6c76H1w=
X-Envelope-To: linux-trace-kernel@vger.kernel.org
Received: by mta10.migadu.com with ESMTPS id 0d17df70ff850e5e;
	Mon, 14 Sep 2026 19:14:00 +0000
X-Mizu-Trace-ID: 0d17df70ff850e5e
X-Migadu-Flow: FLOW_OUT
From: wen.yang@linux.dev
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Nam Cao <namcao@linutronix.de>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wen Yang <wen.yang@linux.dev>
Subject: [PATCH v6 3/4] rv/reactors: export rv_register_reactor() and rv_unregister_reactor()
Date: Tue, 15 Sep 2026 03:13:36 +0800
Message-Id: <94b7ec120a92b9368541ac050601e66be8fe653a.1789412799.git.wen.yang@linux.dev>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1789412799.git.wen.yang@linux.dev>
References: <cover.1789412799.git.wen.yang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wen Yang <wen.yang@linux.dev>

rv_react() is exported to modules, but the reactor registration helpers
are not.  Export them with EXPORT_SYMBOL_GPL() so reactor modules and
the tristate KUnit test module can register and unregister reactors
without hitting undefined symbol errors at link time(modpost).

Commit 3d3800b4f7f4 ("rv: Remove reactor's reference counter") noted
that module-based reactors, if supported, should be pinned with
try_module_get()/module_put() to prevent unloading under an active
monitor. This patch does not add that support. The only in-tree module
consumer, the tristate KUnit reactor test module, registers and
unregisters its reactor within a controlled test lifecycle.
The actual pinning is left to a follow-up series that adds support for
loadable-module reactors.

Reviewed-by: Gabriele Monaco <gmonaco@redhat.com>
Signed-off-by: Wen Yang <wen.yang@linux.dev>
---
 kernel/trace/rv/rv_reactors.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/trace/rv/rv_reactors.c b/kernel/trace/rv/rv_reactors.c
index ff7d478227c3..8e57a95d446b 100644
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

