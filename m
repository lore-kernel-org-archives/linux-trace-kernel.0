Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B2D1553B0
	for <linux-trace-kernel@vger.kernel.org>; Tue, 11 Jun 2024 20:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718136704; cv=none; b=l75jVMwKA8+lHZxPn+KVvPj0Bq9Y47TOcjEVU2ZunkW7JFI/1lRFLH1iaHcpIUx7/PugiFKn5s7p48O6u+SvTx0j+3/Jjy15I7VWDUdvM+WwcKDUcK3JIv7cCU/4G8AjfAYttGqxn9BOfg8WAV0lCqnQ1jKZeERSGd8WK1dBZc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718136704; c=relaxed/simple;
	bh=deJZMXGB4u9IlWilhC165qOhNKSkcsd0Cq2qS5gJdV8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dX6Hkwnl756KDDZ/gMmm03mKGUOY8v40/l217qcNqy4QPHwsqUgXyP6veH9G1hXeWEey8e6iw8e2hdg1F/BNqXx19JJUgGdAk4bIuOJ/hJ6qM/7qPWtcAHQmyhEhyQbYVphW0EkCGcD3nDWLQLMDMaHxiRpS6S0Jw2+6mx/ZJwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=Pby7o0l5; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="Pby7o0l5"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4405304d062so24422891cf.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 11 Jun 2024 13:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1718136702; x=1718741502; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=J+g79hCGPCQt1VIhgByLxRis8HiHyiHDdOiniWzs6eI=;
        b=Pby7o0l57RayWkgjpXOfjuQdO9l7IgCAPaG2RRnBfCtnX+xqGEnh419m98RnF80n67
         HTGvxI5e6r4bJ5l2UvolY2njDTIH/vqdOLezvFtJMYBxy57m1kWmTvsrzrK9sFSz3N7s
         epjzfbF0z0Pp3zB/QSn05OmoVMOkB62yeyBiJ2Z73thjlWJMoUkUjJyoPEmAFWuxwQ61
         9r1hWePLP6qti2E8+3K5kAPX/5wcjwr5IDg+nNsp1vvFub7AiwwreZxWN9CcOuCikKDx
         vAFQLQAu8ThUN7Dp74Lqh4hdpxykRKGCuujsmdjvWmFQoQs77p9WU21/yA9yZ6ocHVFN
         t4xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718136702; x=1718741502;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J+g79hCGPCQt1VIhgByLxRis8HiHyiHDdOiniWzs6eI=;
        b=TLn+LMsOnfOhoCA7+GenSFUUNXM2ij0UwSIp1vzfHSYLyQDsxDMYtQu62re0qeQ1Lx
         vrbApDbkjYVYqSVLIhda7x81X66KfUgNQSDuJU09giv9T1JP2wegTSWpmRW488ubMtFu
         18C9qVyQ7jwZv+pqIoXam8W9jSir3yFdHlEDpY9XclZkROnvQDge4VYxw6o0rnT7d62M
         ZkEneLn+ll0BP3O59MCneaQG+a6Ml/ShYYY7M2yYUhRNOM1bngxOzjIYKiEdDICZrY7M
         mpJbgHv5QJpwVQTtGOB7Gah2XMMTM81kU5sV7IKjoyqrLsW6IsyfmjyYFyUKjrC7jxnq
         1B3A==
X-Forwarded-Encrypted: i=1; AJvYcCWsl7JSYLtpBX3YtCVM3Vb3lIdI1RbjH4v8EeM0s8TluE8/WC24KF4n1x7ClAS+Hvr7bUdZebRrQwxPWhOR43IswR0AzLbircQHD3ByEaHw8HJj
X-Gm-Message-State: AOJu0Yxar0WLv4KRG4MRkh0hDa2BKJFk7757VqoesYDAlylN12pKAs5z
	UtRl1P2bbS3K3X1z4U4R/FMzADrUFVE+D7VCfwzjMjbu03Fa/V1YR1DGCnNMyaQ=
X-Google-Smtp-Source: AGHT+IEWtuUfSx77Bbf2QPCSwXpf5lk+TXIDXuDGBLk4/0nf17pY4+xXrJ50vWppx/TAeftTZpJB+w==
X-Received: by 2002:ac8:5a51:0:b0:441:338c:77cf with SMTP id d75a77b69052e-441338c7e81mr42000111cf.65.1718136701328;
        Tue, 11 Jun 2024 13:11:41 -0700 (PDT)
Received: from debian.debian ([2a09:bac5:7a49:f9b::18e:1c])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4405cfb81fcsm31452431cf.69.2024.06.11.13.11.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 13:11:40 -0700 (PDT)
Date: Tue, 11 Jun 2024 13:11:38 -0700
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
Subject: [PATCH v4 net-next 5/7] tcp: use sk_skb_reason_drop to free rx
 packets
Message-ID: <f0ff4a1458a2636ccbb36c9952a8a86a1ef5ac09.1718136376.git.yan@cloudflare.com>
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

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/r/202406011539.jhwBd7DX-lkp@intel.com/
Signed-off-by: Yan Zhai <yan@cloudflare.com>
---
v2->v3: added missing report tags
---
 net/ipv4/syncookies.c | 2 +-
 net/ipv4/tcp_input.c  | 2 +-
 net/ipv4/tcp_ipv4.c   | 6 +++---
 net/ipv6/syncookies.c | 2 +-
 net/ipv6/tcp_ipv6.c   | 6 +++---
 5 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/net/ipv4/syncookies.c b/net/ipv4/syncookies.c
index b61d36810fe3..1948d15f1f28 100644
--- a/net/ipv4/syncookies.c
+++ b/net/ipv4/syncookies.c
@@ -496,6 +496,6 @@ struct sock *cookie_v4_check(struct sock *sk, struct sk_buff *skb)
 out_free:
 	reqsk_free(req);
 out_drop:
-	kfree_skb_reason(skb, reason);
+	sk_skb_reason_drop(sk, skb, reason);
 	return NULL;
 }
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 5aadf64e554d..bedb079de1f0 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -4859,7 +4859,7 @@ static void tcp_drop_reason(struct sock *sk, struct sk_buff *skb,
 			    enum skb_drop_reason reason)
 {
 	sk_drops_add(sk, skb);
-	kfree_skb_reason(skb, reason);
+	sk_skb_reason_drop(sk, skb, reason);
 }
 
 /* This one checks to see if we can put data from the
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 041c7eda9abe..f7a046bc4b27 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -1939,7 +1939,7 @@ int tcp_v4_do_rcv(struct sock *sk, struct sk_buff *skb)
 reset:
 	tcp_v4_send_reset(rsk, skb, sk_rst_convert_drop_reason(reason));
 discard:
-	kfree_skb_reason(skb, reason);
+	sk_skb_reason_drop(sk, skb, reason);
 	/* Be careful here. If this function gets more complicated and
 	 * gcc suffers from register pressure on the x86, sk (in %ebx)
 	 * might be destroyed here. This current version compiles correctly,
@@ -2176,8 +2176,8 @@ int tcp_v4_rcv(struct sk_buff *skb)
 	int dif = inet_iif(skb);
 	const struct iphdr *iph;
 	const struct tcphdr *th;
+	struct sock *sk = NULL;
 	bool refcounted;
-	struct sock *sk;
 	int ret;
 	u32 isn;
 
@@ -2376,7 +2376,7 @@ int tcp_v4_rcv(struct sk_buff *skb)
 discard_it:
 	SKB_DR_OR(drop_reason, NOT_SPECIFIED);
 	/* Discard frame. */
-	kfree_skb_reason(skb, drop_reason);
+	sk_skb_reason_drop(sk, skb, drop_reason);
 	return 0;
 
 discard_and_relse:
diff --git a/net/ipv6/syncookies.c b/net/ipv6/syncookies.c
index bfad1e89b6a6..9d83eadd308b 100644
--- a/net/ipv6/syncookies.c
+++ b/net/ipv6/syncookies.c
@@ -275,6 +275,6 @@ struct sock *cookie_v6_check(struct sock *sk, struct sk_buff *skb)
 out_free:
 	reqsk_free(req);
 out_drop:
-	kfree_skb_reason(skb, reason);
+	sk_skb_reason_drop(sk, skb, reason);
 	return NULL;
 }
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 1ac7502e1bf5..93967accc35d 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -1678,7 +1678,7 @@ int tcp_v6_do_rcv(struct sock *sk, struct sk_buff *skb)
 discard:
 	if (opt_skb)
 		__kfree_skb(opt_skb);
-	kfree_skb_reason(skb, reason);
+	sk_skb_reason_drop(sk, skb, reason);
 	return 0;
 csum_err:
 	reason = SKB_DROP_REASON_TCP_CSUM;
@@ -1751,8 +1751,8 @@ INDIRECT_CALLABLE_SCOPE int tcp_v6_rcv(struct sk_buff *skb)
 	int dif = inet6_iif(skb);
 	const struct tcphdr *th;
 	const struct ipv6hdr *hdr;
+	struct sock *sk = NULL;
 	bool refcounted;
-	struct sock *sk;
 	int ret;
 	u32 isn;
 	struct net *net = dev_net(skb->dev);
@@ -1944,7 +1944,7 @@ INDIRECT_CALLABLE_SCOPE int tcp_v6_rcv(struct sk_buff *skb)
 
 discard_it:
 	SKB_DR_OR(drop_reason, NOT_SPECIFIED);
-	kfree_skb_reason(skb, drop_reason);
+	sk_skb_reason_drop(sk, skb, drop_reason);
 	return 0;
 
 discard_and_relse:
-- 
2.30.2


