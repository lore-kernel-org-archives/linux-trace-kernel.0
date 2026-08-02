Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A4A3264F9
	for <linux-trace-kernel@vger.kernel.org>; Sun,  2 Aug 2026 18:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785696219; cv=none; b=MJ26fWQks0XWlII3hYror11Y6F3vzeFzpoL38SvtpTuhAvcMcghPla/iQtH0+l7cQcbftydf9CMGwAx1kjKdQUlBHPcNBGeps/NQreXegW2rVlIK5oYWYywhro4yR+ay+RYIk04ylOhkzPOYBpZPrHiJc7VoNEOdAhy/DdS3n0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785696219; c=relaxed/simple;
	bh=ZIuhFCaqOxV6wf9wRCdEeM/YUvZJrMgP4lMgUvgAZCw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iXINZMynvH8jjZMFhAw9DL+4OaOhVlx+pbdNoW4AZ3OUPqg6E5hsAuuCqWHftK8bpk3OKTa2JV54nvdJIBsOO2awiPLLf6u7a+jVvQK5hj7jXkCnWqyzhRUkyebPCUdI6E+jpN2uBmdlFPecsHCW/90WiGLwFDI3BgrZvWcp6+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cySl5Ofa; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cySl5Ofa"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785696216;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uV2s8PsuJocgqni44DIMvUciMbVy/lKZUSh93ut9JnY=;
	b=cySl5OfaXtMQYT0y8wUMg8Vsz2hVLNg+dsOdyLBJTJnPerY9ONeiQ6+o1PcmfcYzRXGOjj
	bBPYxe39VHXyRhdfdYD4X+HBfc+FHFiZqwXAmKIE5ywj9g9mDe+1TnZelsBh9kdFGDjTFk
	hxqwhhBPiAxwJb6ezEvoXejTN1RYYuo=
From: wen.yang@linux.dev
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Nam Cao <namcao@linutronix.de>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wen Yang <wen.yang@linux.dev>
Subject: [PATCH v2 3/4] rv/reactors: export rv_register_reactor() and rv_unregister_reactor()
Date: Mon,  3 Aug 2026 02:43:04 +0800
Message-Id: <d228eefa5ae3616f3d96640583cc2be771a83c82.1785695669.git.wen.yang@linux.dev>
In-Reply-To: <cover.1785695669.git.wen.yang@linux.dev>
References: <cover.1785695669.git.wen.yang@linux.dev>
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
without hitting undefined symbol errors at load time.

Signed-off-by: Wen Yang <wen.yang@linux.dev>
---
 kernel/trace/rv/rv_reactors.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/trace/rv/rv_reactors.c b/kernel/trace/rv/rv_reactors.c
index cd571b1649f5..228ed043bd73 100644
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

