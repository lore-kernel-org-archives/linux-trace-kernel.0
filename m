Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19AF714D2B2
	for <linux-trace-kernel@vger.kernel.org>; Tue,  4 Jun 2024 21:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717537685; cv=none; b=KHaxFIMz0MmdQOiOAaE/Pa/JDgBo/VHbTyU6SxQ4CdOcE7eXP0ISepbUcLKUHCAZXipmlJJd34mXAlC4OMJfB4J685ZRZOT1jPMS17XvqCxVl3LtEp7hwDCznmkrRNCHu/yFTmOuOd73LAKtgkr62s8LMf0Pr9CUWIV/5em5hik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717537685; c=relaxed/simple;
	bh=uEGMHEFbMp0HLSU5Z7U4ENmeA4RvQ8IslnoZTeDpYIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=afHCgW8ISos4OBk/kMXNPTS8CAx/GqEun9H4JPlNfQhIVQbl38A0NqS5KXmE+k5Q4f0ErnYkIOawA3+yspQgABnLy2ItAbkl3Eurc9utNA7vDk3HuWBmVy+k0B1DGGAeC0C9lytG35SkipLc3OENxXrymsr54yG+RHzep6ogRIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=F0YGIPaM; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="F0YGIPaM"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6ae12762134so32327106d6.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 04 Jun 2024 14:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1717537683; x=1718142483; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+04wpAGrgh0quqRhPOuIE9e5b5DYf6qkerlRm6e6uUE=;
        b=F0YGIPaM93k2hd8gAAMatCKDnEXoBJD0/kl28LTYZPwbQgJOaSlpNPIySbvb8tpCUb
         LTfyQlbFJr3uE6aIYr1Fq8awtTVe6uijQlzsui4kBZKgdzbmV2zXQ+LmdQM64i4qI7zC
         E1OrxBwneRq1oFhNE+7MBHsf9KC3l+/cXKf05bieZUjjW2rwlpDKV/KZTL+mLc+Hvfnr
         nfWKopr9oWoPaGjwmQa05zEOFBPlRTBQdKIQJGYfJ+TTPS9GPr/gHQFgPMPT16o3bne9
         9OwXAv3qzfYebk6ycFiBxZgAvb/5OK/+sCuX+5IEor9DyYXVn6jGR1zM5+f9EZfkKp9f
         nHqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717537683; x=1718142483;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+04wpAGrgh0quqRhPOuIE9e5b5DYf6qkerlRm6e6uUE=;
        b=BjcOor53XEPEKsIbWUvmm2ShyXaKRlEJPnvYDuH482P4UL+VBv4WAQ7tqyWztGGOUW
         8UYZdfVX43GVrAXpN2rytson812wkHrtIKBAhAZ0NfxYQwTIboExc/WdRQgxagVyOkWI
         Lrf4NLKnoM6iacc3cBIwsO3p25h3vpSeL1xl1RrQjD5Rl3ePPWEEu5CQ4uiigpuIf7wn
         MLxJwH6xG1dTsn194L65xhz7+huzqtPRDoDZLQwTBC66ZhbhEYeFDbtwK0X2F9I8fudw
         Ke/wfF2q0/2aRRRHVi3mm98uJeV1mIQaFbpcJk+jWaILD6mLfKBFgk8e42vxsa9JIY0T
         nkZg==
X-Forwarded-Encrypted: i=1; AJvYcCUlRPWe9Enas9aHsxbl58w4t/nUWJ/87epLX39N/A+NkAS0nRP7vBSxOvNBn6fDTgcAqtCWs56so1YCgB1fqqF+lke60P/Wa4NOCH7wmid0Bwbq
X-Gm-Message-State: AOJu0YxMBoRjk6aSV7OmJ8dWwpTWZfFrhizPQ8LohY0pdMe5/41G2zUP
	rNP4NxCxkf5iESsbn5fwDw1EvfVIdOHAvhxl4upZlrEH13VObREdKfgvKosXsiY=
X-Google-Smtp-Source: AGHT+IG6/GBC9sNG+exjZROqqV20El9+yth58LdwTrthEzSlb+iKsIQbqjd2bF6oWHOLCPDaM1c5tg==
X-Received: by 2002:a05:6214:3902:b0:6af:cb9f:59dc with SMTP id 6a1803df08f44-6b020320c02mr6439866d6.1.1717537683041;
        Tue, 04 Jun 2024 14:48:03 -0700 (PDT)
Received: from debian.debian ([2a09:bac5:7a49:f9b::18e:1c])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ae4b418d5csm42118766d6.106.2024.06.04.14.48.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 14:48:01 -0700 (PDT)
Date: Tue, 4 Jun 2024 14:47:59 -0700
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
Subject: [RFC v3 net-next 7/7] af_packet: use sk_skb_reason_drop to free rx
 packets
Message-ID: <0fa6bd81ccb75b9fe28971a895bb7a700b30b81b.1717529533.git.yan@cloudflare.com>
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

Replace kfree_skb_reason with sk_skb_reason_drop and pass the receiving
socket to the tracepoint.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/r/202406011859.Aacus8GV-lkp@intel.com/
Signed-off-by: Yan Zhai <yan@cloudflare.com>
---
v2->v3: fixed uninitialized sk, added missing report tags.
---
 net/packet/af_packet.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index fce390887591..42d29b8a84fc 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -2121,7 +2121,7 @@ static int packet_rcv(struct sk_buff *skb, struct net_device *dev,
 		      struct packet_type *pt, struct net_device *orig_dev)
 {
 	enum skb_drop_reason drop_reason = SKB_CONSUMED;
-	struct sock *sk;
+	struct sock *sk = NULL;
 	struct sockaddr_ll *sll;
 	struct packet_sock *po;
 	u8 *skb_head = skb->data;
@@ -2226,7 +2226,7 @@ static int packet_rcv(struct sk_buff *skb, struct net_device *dev,
 		skb->len = skb_len;
 	}
 drop:
-	kfree_skb_reason(skb, drop_reason);
+	sk_skb_reason_drop(sk, skb, drop_reason);
 	return 0;
 }
 
@@ -2234,7 +2234,7 @@ static int tpacket_rcv(struct sk_buff *skb, struct net_device *dev,
 		       struct packet_type *pt, struct net_device *orig_dev)
 {
 	enum skb_drop_reason drop_reason = SKB_CONSUMED;
-	struct sock *sk;
+	struct sock *sk = NULL;
 	struct packet_sock *po;
 	struct sockaddr_ll *sll;
 	union tpacket_uhdr h;
@@ -2494,7 +2494,7 @@ static int tpacket_rcv(struct sk_buff *skb, struct net_device *dev,
 		skb->len = skb_len;
 	}
 drop:
-	kfree_skb_reason(skb, drop_reason);
+	sk_skb_reason_drop(sk, skb, drop_reason);
 	return 0;
 
 drop_n_account:
@@ -2503,7 +2503,7 @@ static int tpacket_rcv(struct sk_buff *skb, struct net_device *dev,
 	drop_reason = SKB_DROP_REASON_PACKET_SOCK_ERROR;
 
 	sk->sk_data_ready(sk);
-	kfree_skb_reason(copy_skb, drop_reason);
+	sk_skb_reason_drop(sk, copy_skb, drop_reason);
 	goto drop_n_restore;
 }
 
-- 
2.30.2


