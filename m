Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F9E459167
	for <linux-trace-kernel@vger.kernel.org>; Tue, 11 Jun 2024 20:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718136686; cv=none; b=dCbVI4jlkrf4+v+/qUlKalB392qYJUmuUCgMnG50R5ks05SjOoUOj5U8P6Rsy3+Q/UusGIvEoOjLm0h7tVYfvt5szzmW4CVdHsJBfCuCWgcH8m22FGceUHibmYnmTgRJ79cVWNd/DkyJYQuX8rF6k4ZgZRxvy9ET3bppzGbuwTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718136686; c=relaxed/simple;
	bh=cMK1CclC04MqeTJsWHlOEoNGqcBkfXz7uVhSatuhjZs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=R5h3EI82L2LEiF+9FB/Yzi8BTH2rNviYXsX3ny9PiAiBPUj3lq94MnNOwEK6kRcPMAC5YR/oQhq0C+HDAGWSsnleboxsD7klAFBVkNPu6zUK8s5BPvAiHITro8Fp9/4kdQJV9SPxg4Z2Jtk2LgsZlsMdOlZs4kJ45J88fUWP6K8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=EyShCcyP; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="EyShCcyP"
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-6f9fbec4fd9so608000a34.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 11 Jun 2024 13:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1718136684; x=1718741484; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qjr4bFDIJ+rHSyjjaa7KT8dWhd5ireGzkoHLGps+PSs=;
        b=EyShCcyPpRX4D/EoeHsgCuop8yzU60B1oo8qKOJ5mSbCZh8350MEnv6zzsPts9f68a
         3pRNsY0LpRlg5fKGMjUcLSAliMQa6Zq2qXY2jUU++A8o4esvK6OG4Ns3zbkR13iHL1/7
         8ZAv2a1MvhwGxVGci/lZRUvIxMV8BznrGENmPj1x51+5mcDlzDOamGESP/kLZvrlajJv
         mf0zz7LZrl/YOjqhvJxkvfbeMctO/3+GnTkNLJYobL7yTasyKiOCPDTTPw1gc7J1YsO/
         wPMYeJos7zQRftdkAtz4kvahO1l7ZXLsnB3D0c6nuajSnsq0H2IRyTddrgY8qC60aZJJ
         zJ+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718136684; x=1718741484;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qjr4bFDIJ+rHSyjjaa7KT8dWhd5ireGzkoHLGps+PSs=;
        b=Sc/4N+mU7zKpCBDHEt76DHP6XbInyvdjkdiIE56wPd3c+aqu2yTB4r4gNos+kFfsb7
         llmeaotF+KQ84RZEHbfiAXfQyH+jwHak63K4XOPYkCNlLMkD5BU+ISGS8WDXuQRauAsS
         w0EZg7nZyUbnZ7Um9N8kxZ1F0kffVsCYJHcB8i3gnlhE+JrcIMKYOfs2EkgnAKMeirH9
         NOnMPuZ6WpaNZ5WpbDE9rWCtT2kdyghu+FXTZup8POLuBESrpTuuu0hObQn1ufQCK2u7
         470czto0r8Qa6HMMZJoPcWK50PO5FQOVwZ0AZ1j+HYI/uAoLvzbhyV6K1DrtuDSWk3xQ
         95oQ==
X-Forwarded-Encrypted: i=1; AJvYcCWPFWsNd9dVNKFiDsY0FObJAJCMteWo13rO2uxNSi52FPR60Q+nbKv5pbGs7OUUmw+JcfD61LW4HNcfIFULcWUrGIEOjCau7/Lg2gZvfKlcnfu+
X-Gm-Message-State: AOJu0YzzRLRphCbEAmPgjn+FIZtGSw55m5715Exsz0m4t2VEaU/qY8Q4
	XGMKhAiuvxF7kxMaBc1WaFB5Xs26OZc7cMXRWU1DO+HX3hyxwjwiEyQHYUk8hUI=
X-Google-Smtp-Source: AGHT+IFz1Ms0snKjZtG9L+HNZ1t6P1akSp4QJpXcnWnIlLYJv61LFdwm5UM+mEJAFbBnr90b6HVUUw==
X-Received: by 2002:a05:6830:e82:b0:6ef:9ec1:2bf8 with SMTP id 46e09a7af769-6f9572dcbefmr13810482a34.23.1718136683902;
        Tue, 11 Jun 2024 13:11:23 -0700 (PDT)
Received: from debian.debian ([2a09:bac5:7a49:f9b::18e:1c])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-440c9fed96asm22522311cf.17.2024.06.11.13.11.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 13:11:23 -0700 (PDT)
Date: Tue, 11 Jun 2024 13:11:20 -0700
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
Subject: [PATCH v4 net-next 0/7] net: pass receive socket to drop tracepoint
Message-ID: <cover.1718136376.git.yan@cloudflare.com>
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

V3->V4: adjusted the TP_STRUCT field order to align better, suggested by
Steven Rostedt.

V2->V3: fixed drop_monitor function signatures; fixed a few uninitialized sks;
Added a few missing report tags from test bots (also noticed by Dan
Carpenter and Simon Horman).

V1->V2: instead of using skb->cb, directly add the needed argument to
trace_kfree_skb tracepoint. Also renamed functions as Eric Dumazet
suggested.

V3: https://lore.kernel.org/netdev/cover.1717529533.git.yan@cloudflare.com/
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


