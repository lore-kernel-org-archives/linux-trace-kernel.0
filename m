Received: from www2881.sakura.ne.jp (www2881.sakura.ne.jp [49.212.198.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D553383C96
	for <linux-trace-kernel@vger.kernel.org>; Mon, 20 Apr 2026 10:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.212.198.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776682478; cv=none; b=fZx0sZLqLFMHCnE7GuNHVI+F88R6xVQBknckgz/9Xu1AplMHSAjhgLZHogxmd0tfYE1ptUoFHaxqVCQwdSjevrdyhL07M3w4/gT8TOaq4u3Op6wOOFL9C/tMRQtU2NyJOY2iByhlDZfWqspJOUABct4x0VcZTM2glQr+Pdx1NLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776682478; c=relaxed/simple;
	bh=Ih75MiT1nxkV58aMIhTrWoWOIGCJAoBgD4qTv6PZrOs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tUueu85/Ypc4f9YLStUgIzUTwVC5VaPR2mi9e4QBNQsTFh8O6lDvYjoWhuQEgPgfYDgUn8HWjqmoBMn+ysNthIR0y+t4OMp3gSpzuGDQuN5Ezx5Por4HjyRFUgwFYGjGpH1VvzgwH94wIhTeOX3D9JA6KLvNmHmxnz/Sc8IaYcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enjuk.jp; spf=pass smtp.mailfrom=enjuk.jp; dkim=pass (2048-bit key) header.d=enjuk.jp header.i=@enjuk.jp header.b=BiLYxVBY; arc=none smtp.client-ip=49.212.198.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enjuk.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enjuk.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=enjuk.jp header.i=@enjuk.jp header.b="BiLYxVBY"
Received: from ms-a2 (232.154.13.160.dy.iij4u.or.jp [160.13.154.232])
	(authenticated bits=0)
	by www2881.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 63KAsTEk075988
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Mon, 20 Apr 2026 19:54:29 +0900 (JST)
	(envelope-from kohei@enjuk.jp)
DKIM-Signature: a=rsa-sha256; bh=pYioUKZnt9VYwWs6DWfDt4Pc9NsWt3Uf7y1Z3Z+cTps=;
        c=relaxed/relaxed; d=enjuk.jp;
        h=From:Message-ID:To:Subject:Date;
        s=rs20251215; t=1776682469; v=1;
        b=BiLYxVBYfTWboC+uMIy3jXTNSudIeQ+XHWkYkPzmfviXqvZqt1gvmuPfW8VMKTtt
         ukPLJSP5qB0hkeQafKtgmMKCIE8ESafRo9SpYCU/wltk2bxGPPcV1vw9deV4vNTJ
         ncTnwS5SLvlpCPLWQqipygikmGPv/IGSBsInUfFlWJCSIjMSBdQHJuI99MeIrzZ5
         sRdFapX3/CQAP/Su9y4XZE2cmjn6Je+1hd2D62oLG1V3ZT3zJ/OJg9Ur9FMkq85e
         z7Vua7ixIGAR775LFUIHmalvf8ZPuCseaXJQGkv+8K3Gn4bKvWImWfOfa9e7LgM6
         SrtN87bWG/Uz8TZp8soaeg==
From: Kohei Enju <kohei@enjuk.jp>
To: netdev@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Kohei Enju <kohei@enjuk.jp>
Subject: [PATCH net v1] net: validate skb->napi_id in RX tracepoints
Date: Mon, 20 Apr 2026 10:54:23 +0000
Message-ID: <20260420105427.162816-1-kohei@enjuk.jp>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since commit 2bd82484bb4c ("xps: fix xps for stacked devices"),
skb->napi_id shares storage with sender_cpu. RX tracepoints using
net_dev_rx_verbose_template read skb->napi_id directly and can therefore
report sender_cpu values as if they were NAPI IDs.

For example, on the loopback path this can report 1 as napi_id, where 1
comes from raw_smp_processor_id() + 1 in the XPS path:

  # bpftrace -e 'tracepoint:net:netif_rx_entry{ print(args->napi_id); }'
  # taskset -c 0 ping -c 1 ::1

Report only valid NAPI IDs in these tracepoints and use 0 otherwise.

Fixes: 2bd82484bb4c ("xps: fix xps for stacked devices")
Signed-off-by: Kohei Enju <kohei@enjuk.jp>
---
 include/trace/events/net.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/trace/events/net.h b/include/trace/events/net.h
index fdd9ad474ce3..dbc2c5598e35 100644
--- a/include/trace/events/net.h
+++ b/include/trace/events/net.h
@@ -10,6 +10,7 @@
 #include <linux/if_vlan.h>
 #include <linux/ip.h>
 #include <linux/tracepoint.h>
+#include <net/busy_poll.h>
 
 TRACE_EVENT(net_dev_start_xmit,
 
@@ -208,7 +209,8 @@ DECLARE_EVENT_CLASS(net_dev_rx_verbose_template,
 	TP_fast_assign(
 		__assign_str(name);
 #ifdef CONFIG_NET_RX_BUSY_POLL
-		__entry->napi_id = skb->napi_id;
+		__entry->napi_id = napi_id_valid(skb->napi_id) ?
+				   skb->napi_id : 0;
 #else
 		__entry->napi_id = 0;
 #endif
-- 
2.51.0

