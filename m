Received: from akranes.kaiser.cx (akranes.kaiser.cx [152.53.16.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE89C3FE372;
	Mon, 15 Jun 2026 14:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=152.53.16.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781535369; cv=none; b=R1OL59vmPWHarlwLonvzyd1gFszox22wf4FLoYQUmqOZSy5Nozdoxmcv9j7kBNnAAYsdusKGHFruI9Pv6aRTUAK+QRdqtnOD9Nfw2oQckVGpZcricf2rs6EslUUt5Vfui4DAYtxk7FA74bpfMoo1BggcceA8bWc/TkDnsDc7J28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781535369; c=relaxed/simple;
	bh=xsG6veHYxFNjsTkWOn2Yh6ovbvHzO1GHmYdqnfQnOWo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b0BMe1gnjF9sAU0ehGc8prMcU3iNiWARnkncFRlZvhp3lR3wXyPZ8Msncif846YDwPFAYodKXpNtTa7fvZjnERhpiubUHe5ynZ7dSgpVgyHhfHWnMnPsu98qJDa5V3RWpTB6cavPA3NwsNcNQYgWbWuMnGqu+e2qOiB0pwB59+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kaiser.cx; spf=pass smtp.mailfrom=kaiser.cx; arc=none smtp.client-ip=152.53.16.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kaiser.cx
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kaiser.cx
Received: from ipservice-092-209-184-216.092.209.pools.vodafone-ip.de ([92.209.184.216] helo=nb282.user.codasip.com)
	by akranes.kaiser.cx with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <martin@kaiser.cx>)
	id 1wZ8jF-00000000Z9d-2Epn;
	Mon, 15 Jun 2026 16:55:57 +0200
From: Martin Kaiser <martin@kaiser.cx>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH] tracing: eprobe: read the complete FILTER_PTR_STRING pointer
Date: Mon, 15 Jun 2026 16:54:12 +0200
Message-ID: <20260615145500.2662456-1-martin@kaiser.cx>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For a char * element in an event, the FILTER_PTR_STRING filter type is
used. When the event occurs, a pointer is stored in the ringbuffer.

If an eprobe references such a char * element of a "base event" and
decodes the pointer as string, the pointer cannot be dereferenced.

$ echo 'e syscalls.sys_enter_openat $filename:string' > \
		/sys/kernel/tracing/dynamic_events
$ trace-cmd start -e eprobes
$ trace-cmd show
    ... : sys_enter_openat: (syscalls.sys_enter_openat) arg1=(fault)

The problem is in get_event_field

	val = (unsigned long)(*(char *)addr);

addr points to the position in the ringbuffer where the pointer was
stored. We must read the complete pointer, not just the lowest byte.

Fix the assignment, make the example above work.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 kernel/trace/trace_eprobe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_eprobe.c b/kernel/trace/trace_eprobe.c
index b66d6196338d..50518b071414 100644
--- a/kernel/trace/trace_eprobe.c
+++ b/kernel/trace/trace_eprobe.c
@@ -315,7 +315,7 @@ get_event_field(struct fetch_insn *code, void *rec)
 			val = (unsigned long)addr;
 			break;
 		case FILTER_PTR_STRING:
-			val = (unsigned long)(*(char *)addr);
+			val = *(unsigned long *)addr;
 			break;
 		default:
 			WARN_ON_ONCE(1);
-- 
2.43.7

