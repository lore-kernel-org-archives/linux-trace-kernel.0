Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F79B19AA5C
	for <linux-trace-kernel@vger.kernel.org>; Mon, 17 Jun 2024 18:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718647774; cv=none; b=RJKwwOHfj2w2umkE7/Zx+kiPC6tcgRGOQyyUqSV+QUJ53VbSPzGMKcmrY+aIm5wWibyeesxc04Zo9UAPrWMZySSfqTnrg3DBGlVkvTJwqdeCfhJtlgJQhRD6O1HVUiqu7R6lGmvygC/BxGIkgdWSxWBpgLgTZW7TE7KDMUj+fHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718647774; c=relaxed/simple;
	bh=uEGMHEFbMp0HLSU5Z7U4ENmeA4RvQ8IslnoZTeDpYIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cq1WXF5CBU/OYIiUx/hf3rd47F4sCaTZiSMC6g8xfHNB8Jc37V84QNscSrKy7TU6NpY5SbMWuosicp6ndysWRYht/RAHtDLlPa3mCBRoyByz3lrKxhNVgMUcutTmFeGQ7GqaT4pZaOPRZqIalqsQlNsHhgMQKuY5hNR9JMNeOss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=UfBBODtG; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="UfBBODtG"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6b2a6e99be8so26233886d6.2
        for <linux-trace-kernel@vger.kernel.org>; Mon, 17 Jun 2024 11:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1718647771; x=1719252571; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+04wpAGrgh0quqRhPOuIE9e5b5DYf6qkerlRm6e6uUE=;
        b=UfBBODtGKX/lYpNEADTZF7usQLHAoR7lXwZbFTkCpc9B7H2T3I/qYP7GWU92eAz7SK
         zmaNweOEbrnmPRsjPUlZTDKNxP2qsZkNN5h/l5B/dYvfVrCgWIBDWYbz/5oboRKEYabs
         pU0b6btpML9W2UmqbXhViWf5fUSU4LQRDn7IzEhHUL4LLcMEKx2WJ6RWli3mflUKNm+h
         p8sdZBX6DGzKQ4TUVyQ9FJqwm29WMJOc8L+Yknqwgw0blc5twDq7gwZWzL2MQ8D0rAvK
         420o8o9gHFdRjMhLKKQTKv1kDTHJ5Rob7HGGWbJIi+JlA3YA4ty1td/a19WrEJ8CwzMY
         xMQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718647771; x=1719252571;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+04wpAGrgh0quqRhPOuIE9e5b5DYf6qkerlRm6e6uUE=;
        b=JWo23GG/2O2Vu8XHctSd4JSUF1l6qqAsSsTRgZG0wx5LawDBTIiQ8aXfbh0qkuI1cp
         bIO1D+XuPYVqzEUb0l1GHsCTKuXM/4BNu581ARq2EVoWg2E2T3JTUhCCMaDJLW4p65kx
         Q/UOa14kn32odoAd7jfYbSrQ+y3dD8LLgqGG6QCqpJ8krbBLTOHVy91zDLmnu3dSaLLg
         7jfd6JypiLw2n6JGaG3OEK+F5DnvBRVnzz1HCQ0EIn7mdv2ZrZrvhjpBL2e+TNQwMkDM
         CNaUVvmzRmu7CHscQpJyp/0MiAOpn2zmpZVTx/F+kq/RxDVRmArsXmdFJANxurpTFTEo
         lqhA==
X-Forwarded-Encrypted: i=1; AJvYcCXkMto+ThVDx4MfnjS/kueU6bi4X4BTdyYKIUgVbSXgZTtI2L51U+0OHHpFaVswRuksyS55EJCIUblslvWBEQixo2kDANNMf0wsn/WP5GmqI92w
X-Gm-Message-State: AOJu0Yyy20u+hvdcyx/apeEm15g+FzSC8iSqMcwPGt3XcJbIPNcw3Q4J
	IZojc/KclqjcVbEAi/iq6wMNsncQkrkpIUcleQfCz2Pqi7ClzEE0zCDD7iz0nPw=
X-Google-Smtp-Source: AGHT+IGDb1Z2mu+N6vTL3KwtF1RLgOFuZEZO687nwA+LSC1hobQujIxWESlnTh3cU3IQaPtqTnbLhA==
X-Received: by 2002:a0c:aa59:0:b0:6b0:82ad:e89c with SMTP id 6a1803df08f44-6b2afc7924emr107624276d6.11.1718647771318;
        Mon, 17 Jun 2024 11:09:31 -0700 (PDT)
Received: from debian.debian ([2a09:bac5:7a49:f9b::18e:164])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b2a5c4664csm57391246d6.65.2024.06.17.11.09.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 11:09:30 -0700 (PDT)
Date: Mon, 17 Jun 2024 11:09:27 -0700
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
Subject: [PATCH net-next v5 7/7] af_packet: use sk_skb_reason_drop to free rx
 packets
Message-ID: <5c336e8da85ce9940e75b9090b296cc7fd727cad.1718642328.git.yan@cloudflare.com>
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


