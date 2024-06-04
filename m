Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A2AC14C5B8
	for <linux-trace-kernel@vger.kernel.org>; Tue,  4 Jun 2024 21:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717537665; cv=none; b=bxJV5VmfbMyMfN5pquJ1y8ilIdL0s+EwiL5vxx+gLwVCBeca5ALcg4Cwmahwd27aAomGa89Re5wjpYt7GuQG8hqUYb/6NGHFo+3bosj2kv9yCiOUAUY3pL9DPw53iXO0IFC6W3BQRE3PlFj4yZ5VX1+vy+3yZ1j+rrFPIsKABt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717537665; c=relaxed/simple;
	bh=veQ5oIfiTUvENwX+KQoiXEtvqEcqUv4Rq16hqY4Km9E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QSICsASQrlpYdvB953pMEaA1jkgrjv4eZph/1r0YxGxUGqQmCKPZcIQ1dMRh9UPjguSUHH7cAf0FHMHpx/JA6eA2l3wKPDmDY3TCrBSYdauc30lnWEWIe/op2cNfowhBjKyN6HAa0nkAo6pM+z+6fUIhdPdCSXTzmbL4jkswxWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=HbNJ9QXT; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="HbNJ9QXT"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-44020b1466aso5518511cf.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 04 Jun 2024 14:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1717537662; x=1718142462; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Xi5+LcSX/bATxH1bP5/g0ND+UBH3qoQYjHtyB8LNLkE=;
        b=HbNJ9QXTw1kP/iOYD/zVm27UI2YfJa2P2I9CwiY9+fGhe0BRJQXUyHSqSkEWkgbVD5
         7bgNgnCuKuwf3xfPF5ywp5g2W8XOP1i7h40xq29lmmVBx4uxe/4a/1kSYf//ow8bSlrI
         6gGLUaXhyKjkEANT9bfLVKsqjw9cCkRA13VHbZoa1QaS5/AtgbblxuVDOTkwJi7WQ1tw
         TisbUTPQ5HUHRvGXhUr+hf3YpYEd9RN0UKXjfEqn6he72A9vEWxr8kUX29DXOFxJF8Ys
         ybHwB+ai9F/QshoS7P2osYz6J7UjGUgUsxSGLD8cdech1l940PLmjoh443EIfWO0wff2
         oysQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717537662; x=1718142462;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xi5+LcSX/bATxH1bP5/g0ND+UBH3qoQYjHtyB8LNLkE=;
        b=uWsEAjfvVRTa2skbGJFFap/4u5HraqnqqdSx+YXlRC0ss4CckDG2mUe7OANQ4AM+iq
         mZqtJgX2g0Mtc+GSh4jsyFqj9IAXon2b7DrSMZoMJXIWuKD9LQRdQiLAKdAVdJ4910Mv
         KAf5qiodMpWZH9EzDRNKqaFhBHDl2BjKJG6d5v3UCGSgP7bZ1wHANBOJnKz5xbKi+4nr
         ZZhdDfoA9W72by4jzLn+zwFkr2fmUjewc0KPyksbA46+4Aoog7258hIwPbB+jR105/hj
         9y6cd0b+eSP4ef6YulbcK4c6FPxZsuFEjNFzZTqo22ZvwJeTv6xQg9uzsW6+lkyx4QQS
         hBow==
X-Forwarded-Encrypted: i=1; AJvYcCXsOn8eEfki4p8tLfDcCzrd890wnWFY/E5NCXU51CmUGWtQsu6aEnrjcYOAlXdNPZPZ73n96bcFqs78TgbkESWQ5G+pQBAEk0vS7ZwsilPO4rIq
X-Gm-Message-State: AOJu0Yyfg+U1DxHdJIhb/cVECdFceLbdUySzidVXL3yyc5l2rUe+I4I1
	1kcXNycLsGQ+3EKAaXB83bibV0Hpe0yQ9JIQI9M6fTDcLS4LnRgf+DTJdikPUEg=
X-Google-Smtp-Source: AGHT+IGCqyUWLOmLdxsaYYhKUdgkQw3I4w6PUaZPCC47ZQJ4/1mMkcgZLWaDyGJ5cfuUWXcsXf9IPw==
X-Received: by 2002:a05:6214:440b:b0:6af:c491:8cfe with SMTP id 6a1803df08f44-6b030a76552mr5722376d6.45.1717537661766;
        Tue, 04 Jun 2024 14:47:41 -0700 (PDT)
Received: from debian.debian ([2a09:bac5:7a49:f9b::18e:1c])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6af5576960bsm28947326d6.3.2024.06.04.14.47.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 14:47:41 -0700 (PDT)
Date: Tue, 4 Jun 2024 14:47:38 -0700
From: Yan Zhai <yan@cloudflare.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>,
	Abhishek Chauhan <quic_abchauha@quicinc.com>,
	Mina Almasry <almasrymina@google.com>,
	Florian Westphal <fw@strlen.de>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	David Howells <dhowells@redhat.com>, Jiri Pirko <jiri@resnulli.us>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Pavel Begunkov <asml.silence@gmail.com>,
	linux-kernel@vger.kernel.org, kernel-team@cloudflare.com,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Neil Horman <nhorman@tuxdriver.com>,
	linux-trace-kernel@vger.kernel.org,
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: [RFC v3 net-next 1/7] net: add rx_sk to trace_kfree_skb
Message-ID: <983c54f98746bd42d778b99840435d0a93963cb3.1717529533.git.yan@cloudflare.com>
References: <cover.1717529533.git.yan@cloudflare.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1717529533.git.yan@cloudflare.com>

skb does not include enough information to find out receiving
sockets/services and netns/containers on packet drops. In theory
skb->dev tells about netns, but it can get cleared/reused, e.g. by TCP
stack for OOO packet lookup. Similarly, skb->sk often identifies a local
sender, and tells nothing about a receiver.

Allow passing an extra receiving socket to the tracepoint to improve
the visibility on receiving drops.

Signed-off-by: Yan Zhai <yan@cloudflare.com>
---
v2->v3: fixed drop_monitor function prototype
---
 include/trace/events/skb.h | 11 +++++++----
 net/core/dev.c             |  2 +-
 net/core/drop_monitor.c    |  9 ++++++---
 net/core/skbuff.c          |  2 +-
 4 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/include/trace/events/skb.h b/include/trace/events/skb.h
index 07e0715628ec..aa6b46b6172c 100644
--- a/include/trace/events/skb.h
+++ b/include/trace/events/skb.h
@@ -24,15 +24,16 @@ DEFINE_DROP_REASON(FN, FN)
 TRACE_EVENT(kfree_skb,
 
 	TP_PROTO(struct sk_buff *skb, void *location,
-		 enum skb_drop_reason reason),
+		 enum skb_drop_reason reason, struct sock *rx_sk),
 
-	TP_ARGS(skb, location, reason),
+	TP_ARGS(skb, location, reason, rx_sk),
 
 	TP_STRUCT__entry(
 		__field(void *,		skbaddr)
 		__field(void *,		location)
 		__field(unsigned short,	protocol)
 		__field(enum skb_drop_reason,	reason)
+		__field(void *,		rx_skaddr)
 	),
 
 	TP_fast_assign(
@@ -40,12 +41,14 @@ TRACE_EVENT(kfree_skb,
 		__entry->location = location;
 		__entry->protocol = ntohs(skb->protocol);
 		__entry->reason = reason;
+		__entry->rx_skaddr = rx_sk;
 	),
 
-	TP_printk("skbaddr=%p protocol=%u location=%pS reason: %s",
+	TP_printk("skbaddr=%p protocol=%u location=%pS reason: %s rx_skaddr=%p",
 		  __entry->skbaddr, __entry->protocol, __entry->location,
 		  __print_symbolic(__entry->reason,
-				   DEFINE_DROP_REASON(FN, FNe)))
+				   DEFINE_DROP_REASON(FN, FNe)),
+		  __entry->rx_skaddr)
 );
 
 #undef FN
diff --git a/net/core/dev.c b/net/core/dev.c
index 85fe8138f3e4..7844227ecbfd 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -5233,7 +5233,7 @@ static __latent_entropy void net_tx_action(struct softirq_action *h)
 				trace_consume_skb(skb, net_tx_action);
 			else
 				trace_kfree_skb(skb, net_tx_action,
-						get_kfree_skb_cb(skb)->reason);
+						get_kfree_skb_cb(skb)->reason, NULL);
 
 			if (skb->fclone != SKB_FCLONE_UNAVAILABLE)
 				__kfree_skb(skb);
diff --git a/net/core/drop_monitor.c b/net/core/drop_monitor.c
index 430ed18f8584..2e0ae3328232 100644
--- a/net/core/drop_monitor.c
+++ b/net/core/drop_monitor.c
@@ -109,7 +109,8 @@ static u32 net_dm_queue_len = 1000;
 struct net_dm_alert_ops {
 	void (*kfree_skb_probe)(void *ignore, struct sk_buff *skb,
 				void *location,
-				enum skb_drop_reason reason);
+				enum skb_drop_reason reason,
+				struct sock *rx_sk);
 	void (*napi_poll_probe)(void *ignore, struct napi_struct *napi,
 				int work, int budget);
 	void (*work_item_func)(struct work_struct *work);
@@ -264,7 +265,8 @@ static void trace_drop_common(struct sk_buff *skb, void *location)
 
 static void trace_kfree_skb_hit(void *ignore, struct sk_buff *skb,
 				void *location,
-				enum skb_drop_reason reason)
+				enum skb_drop_reason reason,
+				struct sock *rx_sk)
 {
 	trace_drop_common(skb, location);
 }
@@ -491,7 +493,8 @@ static const struct net_dm_alert_ops net_dm_alert_summary_ops = {
 static void net_dm_packet_trace_kfree_skb_hit(void *ignore,
 					      struct sk_buff *skb,
 					      void *location,
-					      enum skb_drop_reason reason)
+					      enum skb_drop_reason reason,
+					      struct sock *rx_sk)
 {
 	ktime_t tstamp = ktime_get_real();
 	struct per_cpu_dm_data *data;
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 466999a7515e..2854afdd713f 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -1203,7 +1203,7 @@ bool __kfree_skb_reason(struct sk_buff *skb, enum skb_drop_reason reason)
 	if (reason == SKB_CONSUMED)
 		trace_consume_skb(skb, __builtin_return_address(0));
 	else
-		trace_kfree_skb(skb, __builtin_return_address(0), reason);
+		trace_kfree_skb(skb, __builtin_return_address(0), reason, NULL);
 	return true;
 }
 
-- 
2.30.2


