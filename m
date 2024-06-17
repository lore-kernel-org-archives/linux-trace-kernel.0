Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 616E419A28A
	for <linux-trace-kernel@vger.kernel.org>; Mon, 17 Jun 2024 18:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718647771; cv=none; b=okLhxFsOCjiRgV1XgbVeW0+i3z5E/3go4yJ10uiboaM9Dvfy960RGrW+60nsH+rDpWi2n5LM5MjJeuFjeN9+g77ubwWCiAOH1d1V9ExpFkfzIl6fgSUBi0HOG4bzItgmqX1itNJgE5Fh087V+PHdejs9meiVZwc3eURdXmal+Hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718647771; c=relaxed/simple;
	bh=j0ydkIBK6v7Eeei6xO8sCTgU/f0LdUJsud2ZNVHdLms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ShDxHDQ1AEXq1X175jAVLGriEeaj/xxgVYA4LNHJbZ69MtIx7OVNva6OrhQI887bIyVJHd/0e0qrgnPxMSZzYwDt52JgwY11/OyK6fvZ8V35ebv1uuCGxLojH7kgSsLv27LgNPm+Fr3wul68nWGIJyB3qYAV/toLGcrkYFrJPps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=X7WPN2uL; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="X7WPN2uL"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-440609dd118so22141791cf.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 17 Jun 2024 11:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1718647767; x=1719252567; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rAchTAFhWTofDy57Shf/o1FtCjgXoHrGCl9Vam22s+I=;
        b=X7WPN2uL/vNVy4eeiSg36efFoQojPKsHB8z4bIF8Z9ix25Qq6u+R0EkeUFHlQscu/B
         DhIOl3SzCcgGuFAH4aBV+nhwMyunfxX79WyRIT8CdtTWWkEv7DWxz8WoSuGJwsPAPcqJ
         S0hjXDT0vDEcXABhTr0LC4ia81cqIpn35zHQkQi37pgykC6PKUfgKVaLBFzkJXnmV542
         X6iIMW7Sk2BWV6ajk8+nTAaBPL+op6CYCThpOcivvcIJQYuhPBtaj4FWme6bbDswEPkz
         9t6rh+bI8EBH5PuJxpqdti484TOD7NNpX9A1q49X4UDkilEEtrXAbq0UA19hGelcMzWD
         FoPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718647767; x=1719252567;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rAchTAFhWTofDy57Shf/o1FtCjgXoHrGCl9Vam22s+I=;
        b=A0P6mTrtPYQ75crF/ZYqeyrJOF/eTyIg+1LKUAu1vO3XQe8BKltjSCRM9UDga5ZlG2
         s+Be8V5jTNCb8xYsCtLJZVRixtS8+WWZuRcSJ7/wexuBi2Vze8xTTS7L2Z07L4mRVkTe
         XZTQiyZuNyJ8R799hXmRxG2Ok4AvUCQ+qlERdS7GLZI1221BKtOKbL98V6wsZjwd5v1R
         7Gd8r3EMwAJ64b/uQWsz7f0dc/z921XsYonxsezKlAOD6HYDtrwhVr/XPYlAxcVeK3Yc
         mm1OSFMc+ueNFJ55y7fvUdPx6IxbXFGW95pL8WSesX/5iopwcFCrC+bk9ybgqUPdEoae
         9rxQ==
X-Forwarded-Encrypted: i=1; AJvYcCV/73PjJGiZ5CDzRHIGsVV6vk7MJj1i6TqtXr/Rb1i9741s9A6KqZ8o/EUY33yUcZNGdJHMTUh0duAHKvNaHqQUM2/q5BQqBucbQj2lbSvqVSEt
X-Gm-Message-State: AOJu0YyCgmBp8YCu/iyTNTZrwOMhrlV9UL3MTlOdCJxAWwLBay/FK2Rw
	5BqloYDVK27oOlRdMngK0EKM0K8JS/m5VtRBNkVa1Kr1GHktu8bSSw60Fc+dnuI=
X-Google-Smtp-Source: AGHT+IHU20E/vH3tuOoGnMYnwnyFAYZBXpO4X2O5Jq0Lmh9IZlBFVL9nnnRaS0XvmvVLWF79L8T33Q==
X-Received: by 2002:a05:622a:588:b0:441:382b:75c with SMTP id d75a77b69052e-4421687bef3mr144055741cf.20.1718647767426;
        Mon, 17 Jun 2024 11:09:27 -0700 (PDT)
Received: from debian.debian ([2a09:bac5:7a49:f9b::18e:164])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-441f2ff831bsm48550431cf.80.2024.06.17.11.09.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 11:09:26 -0700 (PDT)
Date: Mon, 17 Jun 2024 11:09:24 -0700
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
Subject: [PATCH net-next v5 6/7] udp: use sk_skb_reason_drop to free rx
 packets
Message-ID: <0dca67a158f2a3bed1a2cee3bc3582b34af70252.1718642328.git.yan@cloudflare.com>
References: <cover.1718642328.git.yan@cloudflare.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1718642328.git.yan@cloudflare.com>

Replace kfree_skb_reason with sk_skb_reason_drop and pass the receiving
socket to the tracepoint.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/r/202406011751.NpVN0sSk-lkp@intel.com/
Signed-off-by: Yan Zhai <yan@cloudflare.com>
---
v2->v3: added missing report tags
---
 net/ipv4/udp.c | 10 +++++-----
 net/ipv6/udp.c | 10 +++++-----
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 189c9113fe9a..ecafb1695999 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -2074,7 +2074,7 @@ static int __udp_queue_rcv_skb(struct sock *sk, struct sk_buff *skb)
 		}
 		UDP_INC_STATS(sock_net(sk), UDP_MIB_INERRORS, is_udplite);
 		trace_udp_fail_queue_rcv_skb(rc, sk, skb);
-		kfree_skb_reason(skb, drop_reason);
+		sk_skb_reason_drop(sk, skb, drop_reason);
 		return -1;
 	}
 
@@ -2196,7 +2196,7 @@ static int udp_queue_rcv_one_skb(struct sock *sk, struct sk_buff *skb)
 drop:
 	__UDP_INC_STATS(sock_net(sk), UDP_MIB_INERRORS, is_udplite);
 	atomic_inc(&sk->sk_drops);
-	kfree_skb_reason(skb, drop_reason);
+	sk_skb_reason_drop(sk, skb, drop_reason);
 	return -1;
 }
 
@@ -2383,7 +2383,7 @@ static int udp_unicast_rcv_skb(struct sock *sk, struct sk_buff *skb,
 int __udp4_lib_rcv(struct sk_buff *skb, struct udp_table *udptable,
 		   int proto)
 {
-	struct sock *sk;
+	struct sock *sk = NULL;
 	struct udphdr *uh;
 	unsigned short ulen;
 	struct rtable *rt = skb_rtable(skb);
@@ -2460,7 +2460,7 @@ int __udp4_lib_rcv(struct sk_buff *skb, struct udp_table *udptable,
 	 * Hmm.  We got an UDP packet to a port to which we
 	 * don't wanna listen.  Ignore it.
 	 */
-	kfree_skb_reason(skb, drop_reason);
+	sk_skb_reason_drop(sk, skb, drop_reason);
 	return 0;
 
 short_packet:
@@ -2485,7 +2485,7 @@ int __udp4_lib_rcv(struct sk_buff *skb, struct udp_table *udptable,
 	__UDP_INC_STATS(net, UDP_MIB_CSUMERRORS, proto == IPPROTO_UDPLITE);
 drop:
 	__UDP_INC_STATS(net, UDP_MIB_INERRORS, proto == IPPROTO_UDPLITE);
-	kfree_skb_reason(skb, drop_reason);
+	sk_skb_reason_drop(sk, skb, drop_reason);
 	return 0;
 }
 
diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index c81a07ac0463..b56f0b9f4307 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -673,7 +673,7 @@ static int __udpv6_queue_rcv_skb(struct sock *sk, struct sk_buff *skb)
 		}
 		UDP6_INC_STATS(sock_net(sk), UDP_MIB_INERRORS, is_udplite);
 		trace_udp_fail_queue_rcv_skb(rc, sk, skb);
-		kfree_skb_reason(skb, drop_reason);
+		sk_skb_reason_drop(sk, skb, drop_reason);
 		return -1;
 	}
 
@@ -776,7 +776,7 @@ static int udpv6_queue_rcv_one_skb(struct sock *sk, struct sk_buff *skb)
 drop:
 	__UDP6_INC_STATS(sock_net(sk), UDP_MIB_INERRORS, is_udplite);
 	atomic_inc(&sk->sk_drops);
-	kfree_skb_reason(skb, drop_reason);
+	sk_skb_reason_drop(sk, skb, drop_reason);
 	return -1;
 }
 
@@ -940,8 +940,8 @@ int __udp6_lib_rcv(struct sk_buff *skb, struct udp_table *udptable,
 	enum skb_drop_reason reason = SKB_DROP_REASON_NOT_SPECIFIED;
 	const struct in6_addr *saddr, *daddr;
 	struct net *net = dev_net(skb->dev);
+	struct sock *sk = NULL;
 	struct udphdr *uh;
-	struct sock *sk;
 	bool refcounted;
 	u32 ulen = 0;
 
@@ -1033,7 +1033,7 @@ int __udp6_lib_rcv(struct sk_buff *skb, struct udp_table *udptable,
 	__UDP6_INC_STATS(net, UDP_MIB_NOPORTS, proto == IPPROTO_UDPLITE);
 	icmpv6_send(skb, ICMPV6_DEST_UNREACH, ICMPV6_PORT_UNREACH, 0);
 
-	kfree_skb_reason(skb, reason);
+	sk_skb_reason_drop(sk, skb, reason);
 	return 0;
 
 short_packet:
@@ -1054,7 +1054,7 @@ int __udp6_lib_rcv(struct sk_buff *skb, struct udp_table *udptable,
 	__UDP6_INC_STATS(net, UDP_MIB_CSUMERRORS, proto == IPPROTO_UDPLITE);
 discard:
 	__UDP6_INC_STATS(net, UDP_MIB_INERRORS, proto == IPPROTO_UDPLITE);
-	kfree_skb_reason(skb, reason);
+	sk_skb_reason_drop(sk, skb, reason);
 	return 0;
 }
 
-- 
2.30.2


