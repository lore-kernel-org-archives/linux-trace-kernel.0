Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0964143739
	for <linux-trace-kernel@vger.kernel.org>; Tue,  4 Jun 2024 21:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717537661; cv=none; b=MeahhHPSoXaW6qvpU8ruaEa1HANNfHpGEkm91KvDAFwS/7E4jT5kJaegzuJ4growNZ2JZaS8URg8ESEur5R1+aMJIjk/flQy2LtPIab/GB7WcGEguIsjhN/rjXtdSai6+o8Awgjjl5J7zhol20Avvjah5IEj5pcE8Q6WkvBXruw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717537661; c=relaxed/simple;
	bh=b1fwLs8L3PPzev26UBlSg8JhfZG8X2v0wz71kYRDvME=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=mPFT2+wbCqMP7Zr/DEqgK3mDiHf24o00IDUJ7yeEYCzSyMhMnoKhnSbzJAA4v3hGa4O/gEOiZJSjHGT+AXxPNJJbvGagyQYwuLuhawp2QAX8wy/czA3p5jUucrCF0s1HLDR3qdvarDNQsZ8D98pEc5N4886lq3xxDuQxlbeJGcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=QKZt8Yue; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="QKZt8Yue"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-44027277ebdso4490541cf.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 04 Jun 2024 14:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1717537658; x=1718142458; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tVAiho8NfA9+3WTngyAHQcgY5VXgLMOywVJbQtGO8Go=;
        b=QKZt8YueWz8YkeqgIU89O+E5nXuXOua3ZE3RjRdfFD4m8cWVzPFxV1mXmxJSAbJmw7
         ZMiS1k3eLcqL2hVg1l7pcuTZfX7aBL/A75hfeZx3KguoC1biNTX3Bjw9W6H6oYgQ26LW
         ww9u5vcApdVIfy4ghvxmP26b1Ng8QqqmJh0RY2NNc3h4fRyGKyyX+8kZfMgR1tYaENYL
         tcqk6eZEFN58NShrKAd+XOyi5C3clc8wcRCzW1bs5C/B0RoR4xBloj6YND0okFTV9GW4
         OzehNUVdPWzJxXRgCz5wxa4VodsXIFxrL4btgr9f+C3EiF0iQ+WV89+FsVrxg4M/cZcK
         fUQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717537658; x=1718142458;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tVAiho8NfA9+3WTngyAHQcgY5VXgLMOywVJbQtGO8Go=;
        b=UnBCcNZcsH+9zMGvqGEZ77QS2763h+sOAxEiQ85wr19YWRSFYWv8RU24s+/phlJ05+
         sTKbkK/vQhBvPnd/q4yZMG+/a2J044BRQ4HqoZ8s8ZSYfAkGp67Os4eJ+nLpqgY1AACL
         m0nGb2Msw6aZd6+NlEsaI5iVlksSZMNqYDuIyoQldkrcRZRklEZ6yhFHsizpqxe/ob6K
         38dws8l48gaS8Dq/0GBo4FSE/YQheFnNIj2REJLmKAygvgnbZe050Il3Nr/v+6xL0L45
         85QL9hA+NG0t49A/lt9ZEdIUSmcu6sbdYsoCjvsmYPyylv8w4UL4jdwLeLckFimQYYfb
         GysA==
X-Forwarded-Encrypted: i=1; AJvYcCXH/WTREZ1GS/HI0/mY/gZugaiBjOXw+wipV0tJ8mFRqg+QCDvApfUhDkjJ1DHFLtNxkwDLdPtgwcqLR1h6brTJ9Jx7JjQuyjulC15nZfoeeIaC
X-Gm-Message-State: AOJu0YwF6QfNYnWrUwwH+clYlhkCAmWQlaUJ7NWMxd9sIUouoXr1r4WY
	IDCp9xlNUCaE3wy2SPgpBexODd5Mpn1Fa3IqQcqtCfXqvhzt2Y1CflCf1JmWgxw=
X-Google-Smtp-Source: AGHT+IEOHx4XoXSQ6kFRU5GEomKxiyrOHwNRgManl23j4v38Hr1ojjv2nQJf3Igp3esuwYvpzpunBw==
X-Received: by 2002:a05:622a:1823:b0:43f:ee83:3362 with SMTP id d75a77b69052e-4402b6d6cd0mr7631391cf.61.1717537658447;
        Tue, 04 Jun 2024 14:47:38 -0700 (PDT)
Received: from debian.debian ([2a09:bac5:7a49:f9b::18e:1c])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43ff23c5ef2sm53183961cf.24.2024.06.04.14.47.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 14:47:37 -0700 (PDT)
Date: Tue, 4 Jun 2024 14:47:34 -0700
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
Subject: [RFC v3 net-next 0/7] net: pass receive socket to drop tracepoint
Message-ID: <cover.1717529533.git.yan@cloudflare.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

We set up our production packet drop monitoring around the kfree_skb
tracepoint. While this tracepoint is extremely valuable for diagnosing
critical problems, it also has some limitation with drops on the local
receive path: this tracepoint can only inspect the dropped skb itself,
but such skb might not carry enough information to:

1. determine in which netns/container this skb gets dropped
2. determine by which socket/service this skb oughts to be received

The 1st issue is because skb->dev is the only member field with valid
netns reference. But skb->dev can get cleared or reused. For example,
tcp_v4_rcv will clear skb->dev and in later processing it might be reused
for OFO tree.

The 2nd issue is because there is no reference on an skb that reliably
points to a receiving socket. skb->sk usually points to the local
sending socket, and it only points to a receive socket briefly after
early demux stage, yet the socket can get stolen later. For certain drop
reason like TCP OFO_MERGE, Zerowindow, UDP at PROTO_MEM error, etc, it
is hard to infer which receiving socket is impacted. This cannot be
overcome by simply looking at the packet header, because of
complications like sk lookup programs. In the past, single purpose
tracepoints like trace_udp_fail_queue_rcv_skb, trace_sock_rcvqueue_full,
etc are added as needed to provide more visibility. This could be
handled in a more generic way.

In this change set we propose a new 'sk_skb_reason_drop' call as a drop-in
replacement for kfree_skb_reason at various local input path. It accepts
an extra receiving socket argument. Both issues above can be resolved
via this new argument.

V2->V3: fixed drop_monitor function signatures; fixed a few uninitialized sks;
Added a few missing report tags from test bots (also noticed by Dan
Carpenter and Simon Horman).

V1->V2: instead of using skb->cb, directly add the needed argument to
trace_kfree_skb tracepoint. Also renamed functions as Eric Dumazet
suggested.

V2: https://lore.kernel.org/linux-kernel/cover.1717206060.git.yan@cloudflare.com/
V1: https://lore.kernel.org/netdev/cover.1717105215.git.yan@cloudflare.com/

Yan Zhai (7):
  net: add rx_sk to trace_kfree_skb
  net: introduce sk_skb_reason_drop function
  ping: use sk_skb_reason_drop to free rx packets
  net: raw: use sk_skb_reason_drop to free rx packets
  tcp: use sk_skb_reason_drop to free rx packets
  udp: use sk_skb_reason_drop to free rx packets
  af_packet: use sk_skb_reason_drop to free rx packets

 include/linux/skbuff.h     | 10 ++++++++--
 include/trace/events/skb.h | 11 +++++++----
 net/core/dev.c             |  2 +-
 net/core/drop_monitor.c    |  9 ++++++---
 net/core/skbuff.c          | 22 ++++++++++++----------
 net/ipv4/ping.c            |  2 +-
 net/ipv4/raw.c             |  4 ++--
 net/ipv4/syncookies.c      |  2 +-
 net/ipv4/tcp_input.c       |  2 +-
 net/ipv4/tcp_ipv4.c        |  6 +++---
 net/ipv4/udp.c             | 10 +++++-----
 net/ipv6/raw.c             |  8 ++++----
 net/ipv6/syncookies.c      |  2 +-
 net/ipv6/tcp_ipv6.c        |  6 +++---
 net/ipv6/udp.c             | 10 +++++-----
 net/packet/af_packet.c     | 10 +++++-----
 16 files changed, 65 insertions(+), 51 deletions(-)

-- 
2.30.2


