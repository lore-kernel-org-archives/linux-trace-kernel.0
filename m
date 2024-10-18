Received: from out-184.mta1.migadu.com (out-184.mta1.migadu.com [95.215.58.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FEFB1D7E4C
	for <linux-trace-kernel@vger.kernel.org>; Fri, 18 Oct 2024 11:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729249689; cv=none; b=C0HQeICeYAv7vI6rQnp9Vi++zmUet0P+PR8hBejQVUOA/jLw7tizwxkbIJddm4LumAP1ovHlfk+s+HAVryS9a1lKAa7kidoze8UfmBoqqIgza3K/bXBuvlo2QmdBsIFWDXzxQF5YN10gHzWG9WsMA5AeYUFI3ubRAdXRGaq109s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729249689; c=relaxed/simple;
	bh=2dykOaDocdoeUGOi6ZyrRq9wQyJ9q60Dh04Mdz4OtPU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nQGoRdVKknbIIzIZvkM0+m4AS68xM5+egOazVdSf4fK+7t32BDkuZpNX4S4LPl/LsmFtDOoqkv/wYX8NQ5ZoylQYNLAjXSWW/EYugBZDyCym2YWWqV301j5O3fe0Viazt5dnxeUD1kH4U2JikkY4AtueRLB2KWIm7WQRUqNRwYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ahKq3fIc; arc=none smtp.client-ip=95.215.58.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ahKq3fIc"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729249683;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=FFS3M7sbO4p1IWXMEOjxLWO1Q9u2Y4kIF/muM4ow1dc=;
	b=ahKq3fIczcWr/DpKd5yEN+DfjeJDielS95Yd7pllg6kAhjRJo1TeCProyBWa62En8VHHpY
	6mr05rS23GW8ri0LOjWfuJ21dVMc1viTEzEC/EDI6Kgcg2qeTvrmkMeYwjAUbEMZqQUued
	werXSFkFKUuEDmRlqgBovMrvz/cPn+U=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH] ring-buffer: Use str_low_high() helper in ring_buffer_producer()
Date: Fri, 18 Oct 2024 13:07:10 +0200
Message-ID: <20241018110709.111707-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Remove hard-coded strings by using the helper function str_low_high().

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 kernel/trace/ring_buffer_benchmark.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/ring_buffer_benchmark.c b/kernel/trace/ring_buffer_benchmark.c
index 008187ebd7fe..cdc3aea12c93 100644
--- a/kernel/trace/ring_buffer_benchmark.c
+++ b/kernel/trace/ring_buffer_benchmark.c
@@ -307,14 +307,14 @@ static void ring_buffer_producer(void)
 	if (!disable_reader) {
 		if (consumer_fifo)
 			trace_printk("Running Consumer at SCHED_FIFO %s\n",
-				     consumer_fifo == 1 ? "low" : "high");
+				     str_low_high(consumer_fifo == 1));
 		else
 			trace_printk("Running Consumer at nice: %d\n",
 				     consumer_nice);
 	}
 	if (producer_fifo)
 		trace_printk("Running Producer at SCHED_FIFO %s\n",
-			     producer_fifo == 1 ? "low" : "high");
+			     str_low_high(producer_fifo == 1));
 	else
 		trace_printk("Running Producer at nice: %d\n",
 			     producer_nice);
-- 
2.47.0

