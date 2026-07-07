Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D9B420878
	for <linux-trace-kernel@vger.kernel.org>; Tue,  7 Jul 2026 01:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783386116; cv=none; b=CTc+VKfmQ9OQi/E03eqQEPjHwL5QFg+L19MPUglwYW1nZIecKy2u3stMyaCpZk8BuTX4FNKI1Yi07mJnPmvPz1kvJUXpP10f2cCuhrI6Ey+DPYyKc4/XZnolT2Fes1K0O1/lBNRECVZdHH2mr8XWSVZnl6P8XjJPRdddSQwGu/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783386116; c=relaxed/simple;
	bh=Cl4hxMwrRdfbEdaST7P89yCfniPHJVHCdUtxmwWGDBE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IUkNxVv/lLp6q+778KBYcKk0lXU2CJtNJ1Tled8KH8eYkppv+kjCZACAPhbEfR5Dq8zWs7Q6xJvXT1FeJL7rVsINGGnyMYlmuWuYYZjnV8wASGOcHyTyA8xZ4+YG7sx5XqCm0PAu94bBesYqVnOfcRjykyO0lh+AvFsY9PfxuZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=HqKoV3ra; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="HqKoV3ra"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-385ea3ce80dso1700943a91.2
        for <linux-trace-kernel@vger.kernel.org>; Mon, 06 Jul 2026 18:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1783386114; x=1783990914; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Mn7lUDGZ7NP4xadPAgx4FMS5SBwqLelhcDxZx9BPNhU=;
        b=HqKoV3raJ7kpmysTanWbcn97V7rF8ucR/Y+BaLEIwYMqeozY6njDiwntwi0r4Pu+2F
         d0yZ9PUgb71PIM89EuGcjIYkRkuLJGnw8qlKfBUZgId2EXo67viDkTxsG9GB93igBghg
         JCBP8Ngzn+N5I4nDaKedz6s5B+GSN2CJOERMpFw/1wjBnNn6Q0cQ38TISjXQ2i+NsiQt
         imTZGuQGmdMF9IeaQz87c6i61B1Gq1hOfUoDnL7/MLssV6Q1UXiM7RtT7la4D+7Q18oH
         1UjtXoejd4PTwdKcMBtgBLYzGOcGDEu7ucVr3zvw/jY7r8UCCR2QnSM2WwnpHRErLzcG
         UzuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783386114; x=1783990914;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mn7lUDGZ7NP4xadPAgx4FMS5SBwqLelhcDxZx9BPNhU=;
        b=STkDqb45eT+sGxr5zH53CefxpztuEbb49Jlv61MDRaJAnJQ03EU8oFLaYX8OWJ+q7s
         e2wxgJa9kdUgFUduMpuyoeDal60M2R4oEhkW89ZAb1o09D8UWF+8im03A6YOdQPFZSih
         Y00VUDO4J5hElckzdO5Cg35Nfnz+wExkN7gRdvQmeDefWXw+IyfbgmUsAQrhdGLrT6pM
         p4xgGpgmXl8PHlQO6pEKmnRnxNT54lE0KazWITERrB8nBIN4kI6YNmTisAM5xbs6MXKg
         cWAHX+7W5F2jIzSOkVOBzXPlnRzyfJrB716FC1BG+TIjLbLNj8sXc5Rg+ZvDX2kvLXG5
         gwXA==
X-Forwarded-Encrypted: i=1; AHgh+RqDxLZTSm41MrNsqEitqPG4CtGbe6YesuY6QqUawzebZxdVIlptuPHulYgNgEjDj1HjQSw/mmd4MtkP5VwPmI3AuZ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfRn1Kc0ckmlM7WWiQZgucBcJQDdzwynczMdRCgTOTkBr7MAwy
	XNWzom/qk0mFminDG7OPZZtSAgjou4m5fONeORctmzBJJRGp1e0LtEqG/xC2rqoKJZA=
X-Gm-Gg: AfdE7cndSPAsThuj1fJ6m+qoaV/T05ioyZL1U2hyLQ5rJkVTfBLmZfje6AuTKcypHny
	+DPEITYDeupI0YRoC27eaMS2CQgkmXsjAsJjmU5v6PgcALgB/jQx9Rwj90V5T+qW/kP2328Q8JB
	IyUKFOCy+n716FtaF+b0r+Pkr1r8oz8EVAYsNOuyBjUaP5NiKefSEOH92psMhSMT1v7ztp62wlj
	5dbIsPBiTnm+uwU47V1+Rr0bDTt9AAesu/9YGC4FK+2a8BzPB/gwDszedWS3C6S1AaTjoWeCFfN
	oANcFyFt9l/W0qp78iBh1dzroxgkkGyYUsYrB0s9bpsgFggbp1LhjjrYMouKsOsJOSOa8g0+KJA
	lJHvu0nLVD0tj3O6x1x7fhRNUbR/nvXu0V75rbrY3hDcYiaFAgrHzUxy5lvvQtML9TwZMpfDwdT
	3oNv5Wb9m3IVgohXw8zpttvEzUr2x7UBoft6hZZzMT7cURKGuFWXhYkPwKvw==
X-Received: by 2002:a17:90b:2801:b0:380:71eb:4014 with SMTP id 98e67ed59e1d1-3875621eb68mr3220612a91.15.1783386114234;
        Mon, 06 Jul 2026 18:01:54 -0700 (PDT)
Received: from krios.ht.home (107-190-31-17.cpe.teksavvy.com. [107.190.31.17])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9bdb56fsm2567785ad.15.2026.07.06.18.01.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 18:01:53 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: netdev@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: edumazet@google.com,
	ncardwell@google.com,
	kuniyu@google.com,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH net-next] net/tcp: Add explicit tracepoint for tcp_syn_ack_timeout()
Date: Mon,  6 Jul 2026 21:01:51 -0400
Message-ID: <20260707010151.43976-1-emil@etsalapatis.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Clang can inline the tcp_syn_ack_timeout() function during compilation,
making it impossible to use kprobes for tracing without preventing
inlining. Add an explicit tracepoint to it instead.

Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 include/trace/events/tcp.h | 72 ++++++++++++++++++++++++++++++++++++++
 net/ipv4/tcp_timer.c       |  3 ++
 2 files changed, 75 insertions(+)

diff --git a/include/trace/events/tcp.h b/include/trace/events/tcp.h
index f155f95cdb6e..37ffaa50faad 100644
--- a/include/trace/events/tcp.h
+++ b/include/trace/events/tcp.h
@@ -332,6 +332,78 @@ TRACE_EVENT(tcp_retransmit_synack,
 		  __entry->saddr_v6, __entry->daddr_v6)
 );
 
+TRACE_EVENT(tcp_syn_ack_timeout,
+
+	TP_PROTO(const struct request_sock *req),
+
+	TP_ARGS(req),
+
+	TP_STRUCT__entry(
+		__field(const void *, req)
+		__field(__u16, sport)
+		__field(__u16, dport)
+		__field(__u16, family)
+		__array(__u8, saddr, 4)
+		__array(__u8, daddr, 4)
+		__array(__u8, saddr_v6, 16)
+		__array(__u8, daddr_v6, 16)
+		__field(u8, state)
+		__field(u8, num_timeout)
+		__field(bool, acked)
+	),
+
+
+	TP_fast_assign(
+		const struct inet_request_sock *ireq = inet_rsk(req);
+		__be32 *p32;
+
+		__entry->req = req;
+
+		__entry->sport = ireq->ir_num;
+		__entry->dport = ntohs(ireq->ir_rmt_port);
+		__entry->family = req->__req_common.skc_family;
+
+		p32 = (__be32 *) __entry->saddr;
+		*p32 = ireq->ir_loc_addr;
+
+		p32 = (__be32 *) __entry->daddr;
+		*p32 = ireq->ir_rmt_addr;
+
+#if IS_ENABLED(CONFIG_IPV6)
+		/*
+		 * Cannot use TP_STORE_ADDRS directly because it assumes
+		 * there is an sk available.
+		 */
+		if (__entry->family == AF_INET6) {
+			struct in6_addr *pin6;
+
+			pin6 = (struct in6_addr *)__entry->saddr_v6;
+			*pin6 = ireq->ir_v6_loc_addr;
+			pin6 = (struct in6_addr *)__entry->daddr_v6;
+			*pin6 = ireq->ir_v6_rmt_addr;
+		} else {
+			TP_STORE_V4MAPPED(__entry, ireq->ir_loc_addr, ireq->ir_rmt_addr);
+		}
+#else
+		TP_STORE_V4MAPPED(__entry, ireq->ir_loc_addr, ireq->ir_rmt_addr);
+#endif
+
+		__entry->state		= ireq->ireq_state;
+		__entry->num_timeout	= req->num_timeout;
+		__entry->acked		= ireq->acked;
+	),
+
+	TP_printk("family=%s sport=%hu dport=%hu saddr=%pI4 "
+		"daddr=%pI4 saddrv6=%pI6c daddrv6=%pI6c "
+		"ireq_state=%s num_timeout=%u acked=%d",
+		  show_family_name(__entry->family),
+		  __entry->sport, __entry->dport,
+		  __entry->saddr, __entry->daddr,
+		  __entry->saddr_v6, __entry->daddr_v6,
+		  show_tcp_state_name(__entry->state),
+		  __entry->num_timeout, __entry->acked)
+);
+
 TRACE_EVENT(tcp_sendmsg_locked,
 	TP_PROTO(const struct sock *sk, const struct msghdr *msg,
 		 const struct sk_buff *skb, int size_goal),
diff --git a/net/ipv4/tcp_timer.c b/net/ipv4/tcp_timer.c
index bf171b5e1eb3..8f482a6b43e3 100644
--- a/net/ipv4/tcp_timer.c
+++ b/net/ipv4/tcp_timer.c
@@ -24,6 +24,7 @@
 #include <net/tcp.h>
 #include <net/tcp_ecn.h>
 #include <net/rstreason.h>
+#include <trace/events/tcp.h>
 
 static u32 tcp_clamp_rto_to_user_timeout(const struct sock *sk)
 {
@@ -753,6 +754,8 @@ void tcp_syn_ack_timeout(const struct request_sock *req)
 	struct net *net = read_pnet(&inet_rsk(req)->ireq_net);
 
 	__NET_INC_STATS(net, LINUX_MIB_TCPTIMEOUTS);
+
+	trace_tcp_syn_ack_timeout(req);
 }
 
 void tcp_reset_keepalive_timer(struct sock *sk, unsigned long len)
-- 
2.54.0

