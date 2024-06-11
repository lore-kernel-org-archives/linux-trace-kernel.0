Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD8331552ED
	for <linux-trace-kernel@vger.kernel.org>; Tue, 11 Jun 2024 20:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718136700; cv=none; b=hh34k8ji1i8H5IcmG4qugrkCDdrzVcoJ4LcqyKhXbFkRa6x8qpCYOoBq9EJsUGf/JQMxhWe08x5HHHwHoO/BhrwXUHlEzq/j0eSvBUW4oTPRRgJDoUv0HEsaCXSaAWUzJiHqvsvW+nCe5OTsTP059iZob2nd1cTak4r9ihS2qiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718136700; c=relaxed/simple;
	bh=kSyvuVmoawm0A1229Z9cjCnSswrtkKHtT2WgaP8HoEM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tlH5vDSRHuBzMpCnQ6OXMSOy5B18IIz4iuuqCcroFaeKjezg5tVsEGE+UHhve0S0VH6PrTbxeb6F+bgWS0nJu/RbG+uJjQXG72yjqBNYVQd/9Jgy4AhEgtrIQRsrDcT5o+DTSQfs8wau/hcZytEgke9hjN4XzGEBFq4F2K5tZQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=QdNHsRvr; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="QdNHsRvr"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6b06bb80d7dso17449906d6.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 11 Jun 2024 13:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1718136698; x=1718741498; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GJDm6iwovalgWz0sxMpvGD5PNxGmSKas+lavj2Qq0ow=;
        b=QdNHsRvrK/UIDkzD04IWuss4jSKUmKqm0ZHqFWUwBkRgK5xsYV2Gc2vyi4CHxQ0gaj
         U1SA8tcDR3lokSPN5NcIvpsEmNS9KJCTNBSkO2rL1HuXoqRvyFNqVJfK7YEtn3WCPlGC
         dKeo2cIZ1tIR9Eo3tu0b+s+iNiywvehiXMJ/UPy21vbPSNJDBTJxgEOtAH5kuTG/AOMY
         kKxB++fE1Rhmps2Mb263QKGGe5JUsRkVMruhYY0o8c/Ym1NGEVLqvk4iXsHmeH5mdVGh
         Su4yN9vLUm1MxAE6RFcIF3QNbBeScr4RUId2hmPZyGSPZPLJmEHH1xR/lMtgKtaWcRz4
         nF2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718136698; x=1718741498;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GJDm6iwovalgWz0sxMpvGD5PNxGmSKas+lavj2Qq0ow=;
        b=ldyYTDorFSumdeP1OJtv6eWliYEGmTTj6RK5gCJeMwAurODiXO3GRmCY48nsN5t3c8
         dyiX2v4FWbDIQYh48aVCxOT9tYJss7eafka76QmZy+ZCKHgvgJAqBNpAYIcZodJsklDu
         eSvsvm4XjvXxnwivf8jsUZT0bHLvPmwizaixEg/N/WC7eFOdswmg4Wjc15nczCSp/h+6
         bfxOkjvKzBfkAB76hfywo4CsWfGVk5hBF+fs9GbKH4h1SQW6+4CQe5XuQvVE9XAUoZgu
         i3M7OXAYLo4FO7Cf79UthJ6I5q+8FNsJ1fLc7KHnh/aSawJK/dqzlS471zjVoBFbMo4e
         miCQ==
X-Forwarded-Encrypted: i=1; AJvYcCWSJ+sbmD/gbMDfnzmPeokqlzso3mYfFniIqF+O4q8sKmbxs4fFNcZMNQUzPQhyklgqP6mrRF1IPqQTStMbzWplqpRrVAm2/tm/x+jX9fptZ77x
X-Gm-Message-State: AOJu0YyUM0uQ5TeI9HaSzY98ooVdgIl5SdRu5F+sac0eYvB6onWUydEp
	TsAdAlIlW7Nub0I6mmx/SoV0nmbhBHbTlLr6o76leJv6qQEfJNQtH9APJ9/omQQ=
X-Google-Smtp-Source: AGHT+IFG2LHNkNrmM8LwyxsmAjLFzEZPaw4Rgpe4bevZPvjwtxPqdhXi5BWC700Tr4m+jS69RvXT0A==
X-Received: by 2002:a05:6214:3011:b0:6b0:64d5:62a8 with SMTP id 6a1803df08f44-6b06651fcd8mr140324296d6.33.1718136697822;
        Tue, 11 Jun 2024 13:11:37 -0700 (PDT)
Received: from debian.debian ([2a09:bac5:7a49:f9b::18e:1c])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b075a5b295sm31838136d6.38.2024.06.11.13.11.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 13:11:37 -0700 (PDT)
Date: Tue, 11 Jun 2024 13:11:34 -0700
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
Subject: [PATCH v4 net-next 4/7] net: raw: use sk_skb_reason_drop to free rx
 packets
Message-ID: <3657744364d746046fae2306c26cdbf2e8c8c4a8.1718136376.git.yan@cloudflare.com>
References: <cover.1718136376.git.yan@cloudflare.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1718136376.git.yan@cloudflare.com>

Replace kfree_skb_reason with sk_skb_reason_drop and pass the receiving
socket to the tracepoint.

Signed-off-by: Yan Zhai <yan@cloudflare.com>
---
 net/ipv4/raw.c | 4 ++--
 net/ipv6/raw.c | 8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/net/ipv4/raw.c b/net/ipv4/raw.c
index 1a0953650356..474dfd263c8b 100644
--- a/net/ipv4/raw.c
+++ b/net/ipv4/raw.c
@@ -301,7 +301,7 @@ static int raw_rcv_skb(struct sock *sk, struct sk_buff *skb)
 
 	ipv4_pktinfo_prepare(sk, skb, true);
 	if (sock_queue_rcv_skb_reason(sk, skb, &reason) < 0) {
-		kfree_skb_reason(skb, reason);
+		sk_skb_reason_drop(sk, skb, reason);
 		return NET_RX_DROP;
 	}
 
@@ -312,7 +312,7 @@ int raw_rcv(struct sock *sk, struct sk_buff *skb)
 {
 	if (!xfrm4_policy_check(sk, XFRM_POLICY_IN, skb)) {
 		atomic_inc(&sk->sk_drops);
-		kfree_skb_reason(skb, SKB_DROP_REASON_XFRM_POLICY);
+		sk_skb_reason_drop(sk, skb, SKB_DROP_REASON_XFRM_POLICY);
 		return NET_RX_DROP;
 	}
 	nf_reset_ct(skb);
diff --git a/net/ipv6/raw.c b/net/ipv6/raw.c
index f838366e8256..608fa9d05b55 100644
--- a/net/ipv6/raw.c
+++ b/net/ipv6/raw.c
@@ -362,14 +362,14 @@ static inline int rawv6_rcv_skb(struct sock *sk, struct sk_buff *skb)
 	if ((raw6_sk(sk)->checksum || rcu_access_pointer(sk->sk_filter)) &&
 	    skb_checksum_complete(skb)) {
 		atomic_inc(&sk->sk_drops);
-		kfree_skb_reason(skb, SKB_DROP_REASON_SKB_CSUM);
+		sk_skb_reason_drop(sk, skb, SKB_DROP_REASON_SKB_CSUM);
 		return NET_RX_DROP;
 	}
 
 	/* Charge it to the socket. */
 	skb_dst_drop(skb);
 	if (sock_queue_rcv_skb_reason(sk, skb, &reason) < 0) {
-		kfree_skb_reason(skb, reason);
+		sk_skb_reason_drop(sk, skb, reason);
 		return NET_RX_DROP;
 	}
 
@@ -390,7 +390,7 @@ int rawv6_rcv(struct sock *sk, struct sk_buff *skb)
 
 	if (!xfrm6_policy_check(sk, XFRM_POLICY_IN, skb)) {
 		atomic_inc(&sk->sk_drops);
-		kfree_skb_reason(skb, SKB_DROP_REASON_XFRM_POLICY);
+		sk_skb_reason_drop(sk, skb, SKB_DROP_REASON_XFRM_POLICY);
 		return NET_RX_DROP;
 	}
 	nf_reset_ct(skb);
@@ -415,7 +415,7 @@ int rawv6_rcv(struct sock *sk, struct sk_buff *skb)
 	if (inet_test_bit(HDRINCL, sk)) {
 		if (skb_checksum_complete(skb)) {
 			atomic_inc(&sk->sk_drops);
-			kfree_skb_reason(skb, SKB_DROP_REASON_SKB_CSUM);
+			sk_skb_reason_drop(sk, skb, SKB_DROP_REASON_SKB_CSUM);
 			return NET_RX_DROP;
 		}
 	}
-- 
2.30.2


