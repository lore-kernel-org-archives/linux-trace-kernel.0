Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.13
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793199974;
	b=GtfaJg0wS+mo7/XaAaNHapouMzxGmGJwuRlUPAuxbporYvzWFfwqhpbVbyP+B8lf2DVL
	 Ho/teaOOWHNUN8wrOYdB02Td+5xaHgxufTEmZYfFJzKWNn4NJ7HISH7V9MyklPqfrS8Pj
	 4aOOgvlv7igNzPOPnE7QmEv9LPVlSH1xjgHFmFBBtVAg5IqsAq4/CkRt9H69UjWjYk2RP
	 kEOWH1t0bTtoTuqkhvLZyz+ZjwheUoZQBlImxlyayEQ+iM0bIfK3TPbU4Epa/26YCwNH2
	 LMDyG0u7y6D9gDRvYaXXLyX0wVmIc2dP+xGrkQqk/cpu9HGSqRJ3EYaSNr7G+Szm1FA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793199974;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 X-Mailer:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Rspamd-Server:X-Rspamd-Queue-Id:X-Stat-Signature:X-Spam-Status:
	 X-Session-Marker:X-Session-ID:DKIM-Signature:X-HE-Tag:X-HE-Meta;
	bh=DvMFBOuC+lE/7TfkLR3276yFGneJeApHjnS0pvtPb9I=;
	b=h3+mZRDBsBNEOf3I1C8bQaAGSSLDzXA+69DHmkIbsWZzqvQ28nBTSUWyKel6gd8T90d7
	 CdQcwsYJm16Ybw8ZPA9a6XXn2jr2UDB0N/uik12t0yBzLCRFM0XodqdYs4U/fJtlNukZA
	 TWcMdXnNkffKkTKaR8OKvv27Y0wnGa5jXWgpTlxOafsB12neIMnUxT8O6gYCXLrIO758S
	 d18eJQgK4ihLX+hYfaGfat4mlRym9DwLguVQ77Y/MSJWaTOeVV8VJpr7bbYDRZRHB+7dr
	 pcqvFA88eF7ELQpHanPmAd+Vbi+zerhpJXRfcGE+cZVsh0RecUdOUOQeYYuKRKt2DRQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goodmis.org;
	spf=pass smtp.mailfrom=goodmis.org;
	dkim=pass header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b="bQY/X0Fc";
	arc=none smtp.remote-ip=216.40.44.13
Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11F59606A320;
	Wed, 28 Oct 2026 15:06:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 11F59606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=bQY/X0Fc
Received: from omf20.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id CCFB54013B;
	Wed, 28 Oct 2026 15:06:02 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf20.hostedemail.com (Postfix) with ESMTPA id 258312002A;
	Wed, 28 Oct 2026 15:06:01 +0000 (UTC)
Date: Wed, 28 Oct 2026 11:05:58 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Yury Norov <yury.norov@gmail.com>
Subject: [PATCH] lockdep: Add #include <linux/instruction_pointer.h> to
 lockdep.h
Message-ID: <20261028110558.623a92d1@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: 258312002A
X-Stat-Signature: s8c6b83ep6x5c1dj3m64fsoo9umt5y8b
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+bXBQkukfq2HEdWq8kVQu/rkCQi9JTMtE=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=DvMFBOuC+lE/7TfkLR3276yFGneJeApHjnS0pvtPb9I=; b=bQY/X0FcZYVYDmWSL/UjMc1Tf1fAQlXzXasVZnCzgicLvi1yEWAFmGlhH6jdjVEmlO87+4AnE54u/DpMZYM06qASd6xIyaDV/Kw5PxjaMON9yVVHUqVN9vAEbW0ttTd9Z4cKuSWf3DH4fhBK4nYyF5xIUX6uXbaqfR0sk6LtoWk=
X-HE-Tag: 1793199961-588814
X-HE-Meta: U2FsdGVkX19l+BcAiKgtkwVZaosQG5l7SkCdUK6vqSqvTfauv80eX+p+EZ8r3Y3z6zJlPXraK7iOb5yo9E3s0Vvxb83y3/fPdTcqv30+qLjJ3hiquHqsu3erDaEpw1Z1mrJrtqWWVW+cqj7NvjjO2+cs/3WFL204kY9scJ5jcB1kpRQpmumJGILR6+a7yGWRCzK1bo2Hxlm0Cmwl+rABVuv9/tlFU/Q+DSC5iRcTjlzybM9f3mFoG2QXXVyAsP1trhiJYB1awdYUbghmeUsGSkpI78/BaPHUscrH06Lvvw4bpL3YsFNJ3g6EtDjXDmwIX1AYv4cYEIr4+lNeMAbFKO3kkOSH4QJu/AyZR37juEM4l1BlK9C42RSuXcBE6kyUhhQK6PsOsqem6Cr3BkM3WseScv5JIji3

From: Steven Rostedt <rostedt@goodmis.org>

On 32bit x86, _THIS_IP_ is not defined in asm/linkage.h. It happens to get
included into lockdep.h via kernel.h pulling in trace_printk.h which
includes instruction_pointer.h that has _THIS_IP_ defined when linkage.h
does not.

In order to remove trace_printk.h from kernel.h, have lockdep.h include
instruction_pointer.h directly.

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 include/linux/lockdep.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index a6451ecbbe9a..c6b0168f5fc9 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -22,6 +22,7 @@ struct task_struct;
 #include <linux/list.h>
 #include <linux/debug_locks.h>
 #include <linux/stacktrace.h>
+#include <linux/instruction_pointer.h> /* In case _THIS_IP_ isn't defined */
 
 static inline void lockdep_copy_map(struct lockdep_map *to,
 				    struct lockdep_map *from)
-- 
2.53.0

