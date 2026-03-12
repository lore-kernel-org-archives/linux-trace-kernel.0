Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E10DE3C7E01
	for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Mar 2026 15:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773327949; cv=none; b=EjvjtkQEMUIgSIfwb+C1ycJrrsvMl4IXkLRzGkkSuZcM30I9M5+L2vbGBjsbJl16IuHep51M3RTmxdcoaz3kiowup1l/ffygzRIgwji3lTmMA2bmBwX99NuVpnSbvdhdRCRlyVVui2ZKKK0SPihQ04b8wIPVrbm6bUnCud9cebc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773327949; c=relaxed/simple;
	bh=guxb5JuRwHt26SwsPKoWQpt9pRz3v9T6U6dLZoAc/AY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dG39OVmsH1CK59oG7t9a4zXJtGOhSuf4tCmbDI2QBDWrqYmfnoS+6WuAcGGwrGmRFugrhEGrjXQKzjaC/bMrQs1snT28nvTPTUp2Ciac7gmDPx+hUCwDoRs+EUIAm2Kj0F9j8ZtIs7bVtIY69z2mbUnLNiZYCgznLrc+iKjq9yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org; spf=pass smtp.mailfrom=bitbyteword.org; dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b=E7acLtoB; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b="E7acLtoB"
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-463a0e14abfso731617b6e.2
        for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Mar 2026 08:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bitbyteword.org; s=google; t=1773327947; x=1773932747; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0owfrX/RnsqtfciHeZROr5f5IRld381S+Ztj32xJcD4=;
        b=E7acLtoB8mTSc5rKgK+bcbcoNEW30IvGv1X5OTafcXa2xszBHSLO6ESNPg8lkFMH6E
         XwVwaqKbjjeXXjYHEj0zTphL8oUg0Ax0UdLbhlIAmFAUcl2bgBlcy0RBPxLhTWu8Hnyb
         4jHazNJmreWykfp4yNYGTS28OHAiGmAk2YFsnb6es7ZIe5DHlrmTtTC22ulHeJ72rF45
         yxjQ+vbXxJxnczKH0isIUCeXnrMJRRgsJmwTCHJUFXN+0n0G309wjzuaKJKxFW4fXFEM
         GNDQIlhKjv0NPLUM3CYDrBqAb+GyX7w13fVN3VpF+UKnrcHj9meKsF8oTEzq23X8QS14
         wJFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773327947; x=1773932747;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0owfrX/RnsqtfciHeZROr5f5IRld381S+Ztj32xJcD4=;
        b=eNGMqGBHzDIhb5DyXRE+qPsyu7c/+nvBpdeEHXPkDxqxARduTrtB7Wk2odxjPVl97X
         gTO3ge4qWabMWjFzx77bWJ6/3LqYtRqORwDoKaYF8mVYFm8DZnVQGCF09lbqHc8ji2J8
         Q/UFqK07LQMOUA7dYBYhvTFRbbm6LPuAmqrJox3raIE7gEKpUIhBk58sSoT/V2hb+rlL
         pPIgvKPB4649uOxQGRpo6fWcHnTa87DYIgsjYDoxd6rNOf1Fm45TVk9wja1QpEr02bE7
         FcG135y+f1e60BbnU4HA//EH3fqlAZZ2EHugFNn8SuYktQfVinmbYMpACq9mA6i8HJ3x
         4OFw==
X-Forwarded-Encrypted: i=1; AJvYcCX1vRUPqp024T0hGzoPm0yFgCzodYqfpY5amUAPFfDTqvQXeeAP985cGy5i06v1hiUUb4Z4Ih4oPEEBql6hwc4YT0I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzUCReBheWFxI2yQsZlLoxzf7201y2By9efkbu619iy5WGJxP3
	hWkTnLo0D159yYt7DqHVsehFdrrkqHgNMwu/UMETnhmHiQZs+aozjgC0p3N0Fpaorm0=
X-Gm-Gg: ATEYQzyc5W7ZdtV5UhYRnr4ESHCaOXqr9aV+hwcZ0DpgX2cJSR3zPt/WehEDrMZYl+D
	5VlVXpG1pqutmvNaQ/iaMGLH0s2MFHEqHya8Gb3heCIfsInn3x4BzWxonNPiFnfEL3Tqd91gWFL
	YkQxvJUjeCA0iKSehmEdFn4o6olPpBgljhxN4hAfjeGIfApJ0SwaXkIYpahv3w3oAWfKPsHc0tq
	QjyqMKvEUN54lns7rfaozmk1hKOdIxkqNZUJG1LejgoojX2xeU3SKbMScK6kAc4KC1xA2nvL3Iu
	vPL+PTQ2YURSlS3D689OWwgDUyZNBQZsFeKfqi8CkekX2VujiwqTGu1SwGpclAXNZdNu7mzM47q
	+bpUL1+PNVgYIGRHnUT0bVck/SecayAS3B4Gz5pyYuPRG+8MobElD4fVAgHZtQkGmY7nNlg6a1O
	EVWwphLwS+5Y9a720GMtASO3lNNkNySTHgQe0+3udYSIwx4ZPr2d4zfFdgbLb4mJIx6Q==
X-Received: by 2002:a05:6808:308c:b0:45e:69af:6bc6 with SMTP id 5614622812f47-467333c5d11mr5089686b6e.13.1773327946780;
        Thu, 12 Mar 2026 08:05:46 -0700 (PDT)
Received: from vinmini.lan (c-73-143-21-186.hsd1.vt.comcast.net. [73.143.21.186])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d76aedae57sm4321776a34.28.2026.03.12.08.05.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 08:05:46 -0700 (PDT)
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
	Kuniyuki Iwashima <kuniyu@google.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Hangbin Liu <liuhangbin@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	dev@openvswitch.org,
	linux-sctp@vger.kernel.org,
	tipc-discussion@lists.sourceforge.net,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH 04/15] net: Use trace_invoke_##name() at guarded tracepoint call sites
Date: Thu, 12 Mar 2026 11:04:59 -0400
Message-ID: <20260312150523.2054552-5-vineeth@bitbyteword.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260312150523.2054552-1-vineeth@bitbyteword.org>
References: <20260312150523.2054552-1-vineeth@bitbyteword.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace trace_foo() with the new trace_invoke_foo() at sites already
guarded by trace_foo_enabled(), avoiding a redundant
static_branch_unlikely() re-evaluation inside the tracepoint.
trace_invoke_foo() calls the tracepoint callbacks directly without
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
index 14a83f2035b93..a48fae2bbf57e 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -6444,7 +6444,7 @@ void netif_receive_skb_list(struct list_head *head)
 		return;
 	if (trace_netif_receive_skb_list_entry_enabled()) {
 		list_for_each_entry(skb, head, list)
-			trace_netif_receive_skb_list_entry(skb);
+			trace_invoke_netif_receive_skb_list_entry(skb);
 	}
 	netif_receive_skb_list_internal(head);
 	trace_netif_receive_skb_list_exit(0);
diff --git a/net/core/xdp.c b/net/core/xdp.c
index 9890a30584ba7..53acc887c3434 100644
--- a/net/core/xdp.c
+++ b/net/core/xdp.c
@@ -362,7 +362,7 @@ int xdp_rxq_info_reg_mem_model(struct xdp_rxq_info *xdp_rxq,
 		xsk_pool_set_rxq_info(allocator, xdp_rxq);
 
 	if (trace_mem_connect_enabled() && xdp_alloc)
-		trace_mem_connect(xdp_alloc, xdp_rxq);
+		trace_invoke_mem_connect(xdp_alloc, xdp_rxq);
 	return 0;
 }
 
diff --git a/net/openvswitch/actions.c b/net/openvswitch/actions.c
index 792ca44a461da..420eb19322e85 100644
--- a/net/openvswitch/actions.c
+++ b/net/openvswitch/actions.c
@@ -1259,7 +1259,7 @@ static int do_execute_actions(struct datapath *dp, struct sk_buff *skb,
 		int err = 0;
 
 		if (trace_ovs_do_execute_action_enabled())
-			trace_ovs_do_execute_action(dp, skb, key, a, rem);
+			trace_invoke_ovs_do_execute_action(dp, skb, key, a, rem);
 
 		/* Actions that rightfully have to consume the skb should do it
 		 * and return directly.
diff --git a/net/openvswitch/datapath.c b/net/openvswitch/datapath.c
index e209099218b41..02451629e888e 100644
--- a/net/openvswitch/datapath.c
+++ b/net/openvswitch/datapath.c
@@ -335,7 +335,7 @@ int ovs_dp_upcall(struct datapath *dp, struct sk_buff *skb,
 	int err;
 
 	if (trace_ovs_dp_upcall_enabled())
-		trace_ovs_dp_upcall(dp, skb, key, upcall_info);
+		trace_invoke_ovs_dp_upcall(dp, skb, key, upcall_info);
 
 	if (upcall_info->portid == 0) {
 		err = -ENOTCONN;
diff --git a/net/sctp/outqueue.c b/net/sctp/outqueue.c
index f6b8c13dafa4a..9831afbff070f 100644
--- a/net/sctp/outqueue.c
+++ b/net/sctp/outqueue.c
@@ -1267,7 +1267,7 @@ int sctp_outq_sack(struct sctp_outq *q, struct sctp_chunk *chunk)
 	/* SCTP path tracepoint for congestion control debugging. */
 	if (trace_sctp_probe_path_enabled()) {
 		list_for_each_entry(transport, transport_list, transports)
-			trace_sctp_probe_path(transport, asoc);
+			trace_invoke_sctp_probe_path(transport, asoc);
 	}
 
 	sack_ctsn = ntohl(sack->cum_tsn_ack);
diff --git a/net/tipc/node.c b/net/tipc/node.c
index af442a5ef8f3d..01e07ec18c56c 100644
--- a/net/tipc/node.c
+++ b/net/tipc/node.c
@@ -1943,7 +1943,7 @@ static bool tipc_node_check_state(struct tipc_node *n, struct sk_buff *skb,
 
 	if (trace_tipc_node_check_state_enabled()) {
 		trace_tipc_skb_dump(skb, false, "skb for node state check");
-		trace_tipc_node_check_state(n, true, " ");
+		trace_invoke_tipc_node_check_state(n, true, " ");
 	}
 	l = n->links[bearer_id].link;
 	if (!l)
-- 
2.53.0

