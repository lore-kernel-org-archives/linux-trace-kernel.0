Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10BBF3B9600
	for <linux-trace-kernel@vger.kernel.org>; Mon, 23 Mar 2026 16:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774281677; cv=none; b=WYThf0+RWpnABrNRGd9v942fP92qoNsVfMygaPSoKu0AQ7I09VIcadeo5Fhf0NgTup8X+L87EOafW8f2PAQdMp0QMmDh02Bk6fI89MGkzbRMqlAuiMXKHbtjY627JnqXghFt4vFU33DTVXKlLOn0vYjI+uNW/Tn24Oo/Bg4inAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774281677; c=relaxed/simple;
	bh=xyAGaEXQZTWs4DlMf28kBT1WbT71fLVTUKX8/OJIrfo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kW45t5hNlWhEck7SETnVBX7QRsFCS8XrW1pELB+IIvtCkoL/Ru6lzKFMYbgdELUIxFDiJrS2GI2VVb82cY5RWTUMsVwoqgykfmOe5PjWXZi7Uo13hGXSwK3ffLo+ZwPAOEbs0p8pAELjbh8lvuG368cWwhLZ9dclTTtjC1o19qE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org; spf=pass smtp.mailfrom=bitbyteword.org; dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b=tCiidTFQ; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b="tCiidTFQ"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-8cd8a189f44so441417185a.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 23 Mar 2026 09:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bitbyteword.org; s=google; t=1774281675; x=1774886475; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zzezBvlbzIGXplopQPhzXRTVv1p4U7sUNeKcBaGOoCw=;
        b=tCiidTFQ7qgvwelsnitMx+MlaYKCt1PDy488Bos+z0M4gALZSPysD6uED5Lay1Joil
         o8MKnT0KuetxDzQMFZnGLqUvPU+EIztk0uBmJwlI6eJIGZhPrd8lBeL+t9WHoYThcJba
         hWIWVfuj8x7/1r98kVmYsF0rS4+20hskeiQdqClLDSdXxCr6Qoxh7KfSJVLMpL+dnoxR
         YiEawU+vuIhGIvv5EgoxcHSsL8VgaAGmhEEWkBWclrzj7kyEou40xDqPsMG/GF4cLmJZ
         1L5hql6AHYCMgViigflIQ1coZ80elgn5igKHIQUkz2TCZa7DGkooLhtzCi1e2BFsxuLZ
         WbiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774281675; x=1774886475;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zzezBvlbzIGXplopQPhzXRTVv1p4U7sUNeKcBaGOoCw=;
        b=ETxjWPpJru6b1vUFg1CUv5a1IPlYZTaRzbz/4Qvfnb47TeZzvvNt0o4pax8l03ktkf
         ssLMp/t+PzK5M6YYTTguxB0xG48PvrsGzGWMbPCrHh3NVWQoVvsSHxJvC4XomDn45FdX
         m0DgEwyVE5sF6u1YlKwW3vj+lW3t2aDOM9I48mswDhw3LgF0aA3duy0xRzodN0HO6PlU
         5ZSURXcUjRwdbGUd+JVEXT0Sh8DodgSWpsKCqNnBnyX2v5ITsiofq1Zya/zG20mVqUnJ
         APrZ1QlqA1m+4udE/lnFFCT+tRDbIZOZn9HTzfQCcjfg/jWcSls88EwtOb0UtDsoXMPy
         YEEQ==
X-Forwarded-Encrypted: i=1; AJvYcCU4TESZ2NJHYjN1i1u0fAjXGjOVUaxCpapf7Ck5WzEeD7Wrn66iLCyXBCDc+Fj1NOP19zLqJRqADQUBd5fCXVttFbE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMvCz8XOAAfvuhZGNaAiFbh3fSg2w+j69+cVcNh8TEZLxz+9wC
	hzfNLRoDxtCGO8UPIei111cd916DGjCWU5LkojJxOHT83N5pknXjV92+bBg+/gOoYgM=
X-Gm-Gg: ATEYQzx5ylPwxmMN0ycx51oFCFEqmdXdR+gr1XgCVFse0D8+B4upZfxqgdrjQuaWhbQ
	o/7mUDrIco/L3n39P1qgG+On75vHD4Ym2UE6sKhPcfUQVUTPK86B7f0WC0vd9arEJwjMjwnEsxl
	hWal8ktKXKsJaFyF8XD7d2OZekJ31FWvEuYUkg6UygafRzR1RyJhKg6wnwMDnUEFxCXKVTYHtKB
	guyxWOrMwm6IkImmfYHObsplyoUAQ5HvOZR+rdtPWKAO9e42LTGbAzDY78FjUH6nSjB8c2TxYuf
	nxZ3VltZLM+ikxHYLlV+oOgH9vLspIdn9L51OWgqDz2ckQCbdflSs27LurrAE1ggoJgVKEb7F1q
	Umz3LQNwgMuZRC0PszNGVwXtUVdeVY24kYz/0k/QSz351LdUjIV6r9zHh+C/oVz/9LVovTdgXEm
	zu7YKCegDs1cBsOo6DxpwaNvtc7jUgV3G2f7M4/oa1IcZe336xdgMne9BfzY7uYRM0tA==
X-Received: by 2002:a05:620a:4594:b0:8cd:75df:f2fb with SMTP id af79cd13be357-8cfc80dd30cmr1961607085a.65.1774281669680;
        Mon, 23 Mar 2026 09:01:09 -0700 (PDT)
Received: from vinmini.lan (c-73-143-21-186.hsd1.vt.comcast.net. [73.143.21.186])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cfc9088df1sm843364185a.25.2026.03.23.09.01.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 09:01:09 -0700 (PDT)
From: "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>
To: 
Cc: "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <peterz@infradead.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Aaron Conole <aconole@redhat.com>,
	Eelco Chaudron <echaudro@redhat.com>,
	Ilya Maximets <i.maximets@ovn.org>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Xin Long <lucien.xin@gmail.com>,
	Jon Maloy <jmaloy@redhat.com>,
	Willem de Bruijn <willemb@google.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Hangbin Liu <liuhangbin@gmail.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	dev@openvswitch.org,
	linux-sctp@vger.kernel.org,
	tipc-discussion@lists.sourceforge.net,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v2 04/19] net: Use trace_call__##name() at guarded tracepoint call sites
Date: Mon, 23 Mar 2026 12:00:23 -0400
Message-ID: <20260323160052.17528-5-vineeth@bitbyteword.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323160052.17528-1-vineeth@bitbyteword.org>
References: <20260323160052.17528-1-vineeth@bitbyteword.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace trace_foo() with the new trace_call__foo() at sites already
guarded by trace_foo_enabled(), avoiding a redundant
static_branch_unlikely() re-evaluation inside the tracepoint.
trace_call__foo() calls the tracepoint callbacks directly without
utilizing the static branch again.

Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Vineeth Pillai (Google) <vineeth@bitbyteword.org>
Assisted-by: Claude:claude-sonnet-4-6
---
 net/core/dev.c             | 2 +-
 net/core/xdp.c             | 2 +-
 net/openvswitch/actions.c  | 2 +-
 net/openvswitch/datapath.c | 2 +-
 net/sctp/outqueue.c        | 2 +-
 net/tipc/node.c            | 2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 14a83f2035b93..f7602b1892fea 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -6444,7 +6444,7 @@ void netif_receive_skb_list(struct list_head *head)
 		return;
 	if (trace_netif_receive_skb_list_entry_enabled()) {
 		list_for_each_entry(skb, head, list)
-			trace_netif_receive_skb_list_entry(skb);
+			trace_call__netif_receive_skb_list_entry(skb);
 	}
 	netif_receive_skb_list_internal(head);
 	trace_netif_receive_skb_list_exit(0);
diff --git a/net/core/xdp.c b/net/core/xdp.c
index 9890a30584ba7..3003e5c574191 100644
--- a/net/core/xdp.c
+++ b/net/core/xdp.c
@@ -362,7 +362,7 @@ int xdp_rxq_info_reg_mem_model(struct xdp_rxq_info *xdp_rxq,
 		xsk_pool_set_rxq_info(allocator, xdp_rxq);
 
 	if (trace_mem_connect_enabled() && xdp_alloc)
-		trace_mem_connect(xdp_alloc, xdp_rxq);
+		trace_call__mem_connect(xdp_alloc, xdp_rxq);
 	return 0;
 }
 
diff --git a/net/openvswitch/actions.c b/net/openvswitch/actions.c
index 792ca44a461da..60823de201417 100644
--- a/net/openvswitch/actions.c
+++ b/net/openvswitch/actions.c
@@ -1259,7 +1259,7 @@ static int do_execute_actions(struct datapath *dp, struct sk_buff *skb,
 		int err = 0;
 
 		if (trace_ovs_do_execute_action_enabled())
-			trace_ovs_do_execute_action(dp, skb, key, a, rem);
+			trace_call__ovs_do_execute_action(dp, skb, key, a, rem);
 
 		/* Actions that rightfully have to consume the skb should do it
 		 * and return directly.
diff --git a/net/openvswitch/datapath.c b/net/openvswitch/datapath.c
index e209099218b41..2b9755e2e4731 100644
--- a/net/openvswitch/datapath.c
+++ b/net/openvswitch/datapath.c
@@ -335,7 +335,7 @@ int ovs_dp_upcall(struct datapath *dp, struct sk_buff *skb,
 	int err;
 
 	if (trace_ovs_dp_upcall_enabled())
-		trace_ovs_dp_upcall(dp, skb, key, upcall_info);
+		trace_call__ovs_dp_upcall(dp, skb, key, upcall_info);
 
 	if (upcall_info->portid == 0) {
 		err = -ENOTCONN;
diff --git a/net/sctp/outqueue.c b/net/sctp/outqueue.c
index f6b8c13dafa4a..4025d863ffc84 100644
--- a/net/sctp/outqueue.c
+++ b/net/sctp/outqueue.c
@@ -1267,7 +1267,7 @@ int sctp_outq_sack(struct sctp_outq *q, struct sctp_chunk *chunk)
 	/* SCTP path tracepoint for congestion control debugging. */
 	if (trace_sctp_probe_path_enabled()) {
 		list_for_each_entry(transport, transport_list, transports)
-			trace_sctp_probe_path(transport, asoc);
+			trace_call__sctp_probe_path(transport, asoc);
 	}
 
 	sack_ctsn = ntohl(sack->cum_tsn_ack);
diff --git a/net/tipc/node.c b/net/tipc/node.c
index af442a5ef8f3d..5745d6aa0a054 100644
--- a/net/tipc/node.c
+++ b/net/tipc/node.c
@@ -1943,7 +1943,7 @@ static bool tipc_node_check_state(struct tipc_node *n, struct sk_buff *skb,
 
 	if (trace_tipc_node_check_state_enabled()) {
 		trace_tipc_skb_dump(skb, false, "skb for node state check");
-		trace_tipc_node_check_state(n, true, " ");
+		trace_call__tipc_node_check_state(n, true, " ");
 	}
 	l = n->links[bearer_id].link;
 	if (!l)
-- 
2.53.0

