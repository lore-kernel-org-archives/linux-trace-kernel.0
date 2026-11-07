Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794085120;
	b=4ZnslGI0v8gyIkosRmPQCkWHTZeHzd8RPqvn7MKU+UTcugqCvIGISJQm03OPmtysIFDa
	 yDp5e09bd0sCazjLDu4yeBeSOT6OQTdv+xISGFqsdIp58K8lgkP+hJ48bNIJqU1tWYQQI
	 ajaI55F5/dg7Dq0r+4MSNwshojhcpMCRHaxIu79EkrMMNP65QjGuSWiOdakuPnsFhg9I5
	 RR5TgL7rn0wLD0TiLx3PE8gIZTKR0tNGUu10g7ICxyDadGziSiqhE+2ta88krSg402vKD
	 1vrHxGBI0a8OKjQm/8RPZUk2LsgoX6hc3/L9YTI2L8nErzkbhnUic6MJB7yXjqt63/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794085120;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=MquOJTyAOSA85wPBCkYjBgdo8R4QVbXqYtRJqICmdiI=;
	b=B+TtI24KpVvf9vtohXUWLXoOUIpU8JTW+I45x/KMACU1VfFC/iskCCt/j7dQBLUU3a9L
	 T8Dv6zy6BjU81StsCN+Qh5yyl/EC9ltFMDTk5RyHdEXSGxyI9qngopixcwannB0FqY4iJ
	 mNKY9UHvt8dV5FB/2Iowv24rmN5WmZJU8h/267Kz3VGD4+t/0Pefq8+JVNt5s0jXtwF58
	 WhLW59z4euOnUR7lsfCd156NoBrKgJ4AskWfcBQNoAxrwH6x6jgaeOuZW/EQ9jTGd1lav
	 v9pH9mD+nj13B+SEqs7nkd+6op77v2czfzfU68aBCFjZ0YBNIhx/k/muNJ9whhqa6ww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=O+zMOrQB;
	arc=none smtp.remote-ip=209.85.128.47
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D027F606A32D
	for <linux-trace-kernel@vger.kernel.org>; Sat,  7 Nov 2026 20:58:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D027F606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=O+zMOrQB
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4a2069b9710so106225e9.2
        for <linux-trace-kernel@vger.kernel.org>; Sat, 07 Nov 2026 12:58:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794085118; x=1794689918; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=MquOJTyAOSA85wPBCkYjBgdo8R4QVbXqYtRJqICmdiI=;
        b=O+zMOrQBc6YPVqLx7vh4M83N1v+pRXf5SAk27K9jRtk5LMl1sqRKMTIWe3E30PZ0n3
         2ABeN4Zd0tE42EOb/hsgrDMSKQLNNWwG9JqvLrMa7Bt5vdLlAFRtx0JEPWa5ZYcXKh3t
         JG/QKW6I8OD78M4TftXyCsvDJhoWWunh2trOJwV9ugF7hcKdo4VQsqZ8vBtzcGQP/fva
         f2/3mJiuHqyIkJURlbT3oY96XldAAoiEbZ3NA82l0JqYW5GRfFoLhNhUUH6ScpEtS0Dc
         t25t0Rt5wbLLDdp9Dw+FaTO748r1cvuXvySVLFtWMF3HTB6TBijZ+uzwWoe5nYZUSkt0
         sKqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794085118; x=1794689918;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MquOJTyAOSA85wPBCkYjBgdo8R4QVbXqYtRJqICmdiI=;
        b=Vkd2WL/RVYuQKFvfL+yQwr1ngGCWA110saxxfp1MTSKjXMVmd65udbU2C537g2t/w0
         2bCe3rhSR6MQflXGHvRoYbvk6Iqtufj5hp36Dyg2j+i7cp3kSror1rzWRa8TCrtf+gW3
         7fVl/5vrTeA/cz6Yg5sY/7S2mNeenVvbLr90ovdClmK2/UddPnl/WklCZ6eAZa6uEMMa
         USm236VymZ/bFT5ZnnOhjWuXOOJr+aVqUUji2hN2NKkrfo9bk26kCYJYWp9Jxsv68RMi
         ddkWxbAWVJZIMovoYTd14uGd9yYXSdSudweWBRbuOgdUSSSMTFdkzAncn6aOQQv3cWl6
         5SXA==
X-Forwarded-Encrypted: i=1; AKwUvBxywBHfC5zOUifFkxDp1QyTQyIcWJaQaHOtPhXYsb0F1K2Zz4W3gmt6ujTd5MoUJ4PSAWs9JN8Ar+T7wyZBbRCn/Dg=@vger.kernel.org
X-Gm-Message-State: APuU4Z8+k145NCUXgdtgCfDDKjm8mKxOWqVstX4wsNNJh3oy95enm4cd
	z1R61Y6ndYRrk6qaYRuG46Jttrp4xVMY4sswqIab1GLmGf3rsFNsbevk
X-Gm-Gg: AYBFou3IHeHdQKqOp4HPv3Ld92I343LK7eGkWnPTqLQXkppQCNyMeVdrsS4JjuaItqm
	xvivIyRhnVuSi6E1tnr8oQGNNBYfJFPQymJvrkJz+zLHlVyc8DvPfb5r5K0ydNL+GSCYQF5gozH
	X8nhWimI3FDVOZsZ9X1Rnq1Ug9AphtBc54MJfWTmYIeXeoHDEdCRPpXPjRJmhz42N2TvXj0Zr2V
	3FUo7mbV+SId0Vy+J0p+5AOOOqbSAOGL6yQlNRdFlrCVzaMbzywioFm5JUVVVj72wDWAFWd1vkP
	G8MvDF/dwUxuRM9rdpSCqaf8QD2A3mGQ5uloiZ8KFEJVN2aPCS8hVpFndXlhbEXSgHgEgnwmGgp
	VJVwx3NRfkvAzKrbdChP90bwR6Y8RLeaBtT5jshbTBngZRs3TGGXnVHtei1qvBszdrNjeDagf3X
	aEnCgFDf8Y3WmxF/ftmpDrV/G8kNzYYfSXOcZaIWlvjtpGQnvcdqaSvrNrM3j9BK8/kjKpWFRmb
	8tMLFvD98o7flB4ZRsbwGikyaOgHqdSWe1W2CEnfPW85GhLMixENu7y0qZDw11UUh5wKLxmM/ZH
	kagsTXBWrlFRzgXilpVpfs1rMGbOiv1R8nP3tO2TfcvkgTkNsiW3G1SRIwRD1wKT/g8epjlD3RE
	whIQXVxj9SJlyqvE1Kxzj4qOYxc/AXgwE33MTQg==
X-Received: by 2002:a05:600c:3d96:b0:4a1:7ec7:a479 with SMTP id 5b1f17b1804b1-4b6df7d4d86mr97639175e9.33.1794085118056;
        Sat, 07 Nov 2026 12:58:38 -0800 (PST)
Received: from DESKTOP-0KSTGNI.localdomain ([197.52.47.229])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b90ee1ddc7sm8536545e9.4.2026.11.07.12.58.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 12:58:37 -0800 (PST)
From: Temitope obabi <obabitemitope765@gmail.com>
To: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: linux-afs@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Temitope obabi <obabitemitope765@gmail.com>
Subject: [PATCH v3] rxrpc: Remove unused rxrpc_drop_ack tracepoint
Date: Sat,  7 Nov 2026 22:56:37 +0200
Message-ID: <20261107205637.665-1-obabitemitope765@gmail.com>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The only call to trace_rxrpc_drop_ack(), in rxrpc_send_ACK(), was removed
by commit 5e6ef4f1017c ("rxrpc: Make the I/O thread take over the call and
local processor work"). The tracepoint is no longer reached by any caller.

Removing this tracepoint avoids keeping unused tracing code and makes the
code easier to maintain. Each defined tracepoint also takes up around 5K of
code and data, even when it is never used.

Fixes: 5e6ef4f1017c ("rxrpc: Make the I/O thread take over the call and local processor work")
Signed-off-by: Temitope obabi <obabitemitope765@gmail.com>
---
 include/trace/events/rxrpc.h | 29 -----------------------------
 1 file changed, 29 deletions(-)

diff --git a/include/trace/events/rxrpc.h b/include/trace/events/rxrpc.h
index 56dc9b614071..ec145da21ca8 100644
--- a/include/trace/events/rxrpc.h
+++ b/include/trace/events/rxrpc.h
@@ -1837,35 +1837,6 @@ TRACE_EVENT(rxrpc_send_ack,
 		      __entry->serial)
 	    );
 
-TRACE_EVENT(rxrpc_drop_ack,
-	    TP_PROTO(struct rxrpc_call *call, enum rxrpc_propose_ack_trace why,
-		     u8 ack_reason, rxrpc_serial_t serial, bool nobuf),
-
-	    TP_ARGS(call, why, ack_reason, serial, nobuf),
-
-	    TP_STRUCT__entry(
-		    __field(unsigned int,			call)
-		    __field(enum rxrpc_propose_ack_trace,	why)
-		    __field(rxrpc_serial_t,			serial)
-		    __field(u8,					ack_reason)
-		    __field(bool,				nobuf)
-			     ),
-
-	    TP_fast_assign(
-		    __entry->call	= call->debug_id;
-		    __entry->why	= why;
-		    __entry->serial	= serial;
-		    __entry->ack_reason	= ack_reason;
-		    __entry->nobuf	= nobuf;
-			   ),
-
-	    TP_printk("c=%08x %s %s r=%08x nbf=%u",
-		      __entry->call,
-		      __print_symbolic(__entry->why, rxrpc_propose_ack_traces),
-		      __print_symbolic(__entry->ack_reason, rxrpc_ack_names),
-		      __entry->serial, __entry->nobuf)
-	    );
-
 TRACE_EVENT(rxrpc_retransmit,
 	    TP_PROTO(struct rxrpc_call *call,
 		     struct rxrpc_send_data_req *req,
-- 
2.53.0

