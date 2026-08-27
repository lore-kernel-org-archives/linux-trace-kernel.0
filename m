Received: from mta1.migadu.com (out-224.mta1.migadu.com [95.215.58.224])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D14FA3DCDBC
	for <linux-trace-kernel@vger.kernel.org>; Thu, 27 Aug 2026 18:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.224
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787854997; cv=none; b=ksSBDrkyQvtYfzRkLgTP3OjL712xHnZpUKt2anbx78RdW8JMaSLtm4LNJYWTPIxLv8UC/YYZOj5OWjExTGPa+Ku0Z+mMTX2rvnYRBV+nomZ1Vfh7cGHrPPfzatI/tuoRn453JhF0hHdk4snHYRRavEk/236dyhciXNZEGgvIHfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787854997; c=relaxed/simple;
	bh=oZCQnmaMY7RmKSo6gOlFToZcdvtgy5XfSLCCNn/8tEo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YJhax5iZWId2FKAVlCw8NqqN83ksMZrg1LRqp6Y+HOHp680XNAXpPIW/eC8MuAQ2wJOYYUPehmmBjyeUjyWBeyYM/x0+F2NXD7LevV+oyIB0wehWTUHX4+xMl7tQLGZchzFMMMykKiKnKEx0nnIMRrOhpOaJXDQSZ0jKKPNX91M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bj1UVUjV; arc=none smtp.client-ip=95.215.58.224
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bj1UVUjV"
X-Envelope-To: linux-trace-kernel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=oZCQnmaMY7RmKSo6gOlFToZcdvtgy5XfSLCCNn/8tEo=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787854993; v=1; x=1788459793;
 b=bj1UVUjVgGcDcoLJT1boMRZpeLxzH3z3w58+JuonyeE73pz3BXAb8hpuFNiFncO7p/FjFHup
 X7bkXEbqW3G5R97FF+g/rDYmpDsQm3xo7OJGF/0vMh/z8tzgog68UMWsragQg22F2PMvVSTIWV2
 Em7xBFaau1ElThYBPnVY31g0=
X-Envelope-To: linux-trace-kernel@vger.kernel.org
Received: by mta11.migadu.com with ESMTPS id 4e58507071cf7aed;
	Thu, 27 Aug 2026 18:23:13 +0000
X-Mizu-Trace-ID: 4e58507071cf7aed
X-Migadu-Flow: FLOW_OUT
From: wen.yang@linux.dev
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Nam Cao <namcao@linutronix.de>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wen Yang <wen.yang@linux.dev>
Subject: [PATCH v4 3/4] rv/reactors: export rv_register_reactor() and rv_unregister_reactor()
Date: Fri, 28 Aug 2026 02:22:45 +0800
Message-Id: <888aca9131b5e9c80ac5085f964099b5090e7185.1787854397.git.wen.yang@linux.dev>
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
index afc97d097109..606c530de2f0 100644
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

