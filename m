Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6909638B128
	for <linux-trace-kernel@vger.kernel.org>; Sat, 14 Mar 2026 20:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773519300; cv=none; b=dyHDjpTMOMJSmrwyC6Clv0rcJhSoLpxs9Lic0THYeW0Wrgb1jAaGTkR46gwme+fgHuHl1gRb/oZQirMZpmx3pPBpi5Hhz8ukoulPagNeR9be4M1XMnWmqMQmAgpfhCtCsYXoLCwEuECTiB4Hlh4/W+Wu7KDNK2FNKwMlx4wFE/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773519300; c=relaxed/simple;
	bh=EnceP3zAxby9Gd7UKyzsACNfFh/U0eVEzsye/mjXh5Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qsb8fEQLfkC1+/6UYYPqZ6NAOTHcG/u/aMu0+wdNfU5zO7RujgJFeGk+yYCsU0xaq+BpUJhSRryKDGHoEMdY2REIDFECUjxu3dmRRIdRCKpIv7u5BN1vnDdGxCoWARI61PeiB/Z4FfNqVWyV25mPa62ahk/i14MhUT5zNA/J2tA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZQzm6OK0; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZQzm6OK0"
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-67bb39a1122so1717017eaf.3
        for <linux-trace-kernel@vger.kernel.org>; Sat, 14 Mar 2026 13:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773519297; x=1774124097; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FUx81sAr4LqFx9f2CLQOytjXeMe6lrxWLv4FjaWsnVM=;
        b=ZQzm6OK0AS/dByADCifyfvmuM5Nt67P8C03nokYMZPaCYSMhOi5QYT/N/0p9uOpxal
         KI7yxacerUUpHlkzMRCwgD7Wuq3wVCFkXG6Z7vihdsJDuh3EgGaoGNCiVREgnPjRlDZ6
         19qu5KbKDeaHjzALEqpK1mtq4QuuQUgAVAlgDXXxF5GDFRipdXDjvPdilJoajzk+7n0r
         078x5vhpx2PbL4muLjqTkKNwIdE568pC+duI47AyQy1TN9VXVbJE53Te0UeQuEEn11Gk
         LjouXnMvTt+VPd6svE260ycFYtBLM7XRYyCjnJyCZQnZwxnKetFScLO3kzLCkBKZre9X
         YPng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773519297; x=1774124097;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FUx81sAr4LqFx9f2CLQOytjXeMe6lrxWLv4FjaWsnVM=;
        b=ipDyzd6CT1qxjm76hR//6EtvFQXN0DPb4Ye3a0pQnUDIwIXFyL1Cudb8Hc7tRYNQrM
         r286zX0tYYI4cPsPGDtvIqgzGv35SgBzXIHEjlh9qURHlWiQMqjeXOSjXf4/P9d3jjoY
         3DuKFskm4Q0AF4FRLNkxYd1H/T3PEzhNkzjxHHgHu5KCAIKMng1o12nGYN05zaR3Jy32
         sHRmpF9ArgKuQi5Q6XPBB6abf8XbbZNbsgrF7Ipeiy9t4sc3FOJzpvZT1ETLDIRqvbCZ
         ybdCYAcP2JV1dmn8wbDNuaE9bblDE6m5ZsNvrvHtciNsrhUE6WyqUPSuI/8G1oLIUvdY
         AFtg==
X-Forwarded-Encrypted: i=1; AJvYcCX+zEmXXwkCdVzXPz0gA53/PMNdVjIlPkjd8Cv37CUdj7i1oFcCryntTSjC6NMGCMkJDZVP6GqXD7yk18hb2qHfGcU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxh7VLp31FuedsmSrqqPW6LdSxrmtkTLkE+cjvCRgA2mPSZiHul
	gHiFePDCofydCIdBbG78LJA63ZhKXJPJkZ0xaKIZegfUA9QhA6//Jvkq
X-Gm-Gg: ATEYQzy2tUT8u00ONdJD2VPmnp49mNOftP/cWdSNwhTvvfWCHnulNJ9aA2fK3sICH99
	lF8Kd0TtRnS0uoT49BxSfActt6KCZHFt6kAEFRR399xEr/uRVQ4yZi77vjn28LaheHsz7cAC3Jt
	XmfJtaPVQ4ert+7nObZmpiUI4ScY/50JI2RPyaud1I0Mg/Dws5hiImROUcfOQbL0rnxV5NxOcZ0
	2orLf3v0mybIe5fYskyIco5bYk9RMDBmAolj0zZLib8BkhXkXZIKxxKN+bOonVDtr+1xK8Yar+u
	WWuJaPCD2Egb/b8j5JQo3enS7vlHxiP7KBq0W6ojgehQKTyh7i9TDPHV+FWd595nnyZn0Pef4zR
	6wrx/1PVPRPF1jcWO7IhBKerEUe6yqwr/okb/QwvHXkdOIIkJKJ60JvNMjgOBAmFz7v8cXVKpee
	IdO+qmQAYPklRYwmtsDpJmrsT1s8ba//R8eHEJmwpFyPigSD6iAQDxWl/K+REfWCB744F/tK04S
	AOwWvqTNDaZQxa80fSpWuC/rQ7coUau5ok/hHUj
X-Received: by 2002:a05:6820:883:b0:67a:1d28:7bae with SMTP id 006d021491bc7-67bdaa2eedbmr4832661eaf.37.1773519297408;
        Sat, 14 Mar 2026 13:14:57 -0700 (PDT)
Received: from Atwell-Laptop.. (108-212-132-20.lightspeed.irvnca.sbcglobal.net. [108.212.132.20])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4177e5e8185sm11914165fac.12.2026.03.14.13.14.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Mar 2026 13:14:56 -0700 (PDT)
From: atwellwea@gmail.com
To: netdev@vger.kernel.org,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	ncardwell@google.com
Cc: linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	mptcp@lists.linux.dev,
	dsahern@kernel.org,
	horms@kernel.org,
	kuniyu@google.com,
	andrew+netdev@lunn.ch,
	willemdebruijn.kernel@gmail.com,
	jasowang@redhat.com,
	skhan@linuxfoundation.org,
	corbet@lwn.net,
	matttbe@kernel.org,
	martineau@kernel.org,
	geliang@kernel.org,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	0x7f454c46@gmail.com
Subject: [PATCH net-next v2 10/14] tcp: expose rmem and backlog in tcp and mptcp rcvbuf_grow tracepoints
Date: Sat, 14 Mar 2026 14:13:44 -0600
Message-ID: <20260314201348.1786972-11-atwellwea@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260314201348.1786972-1-atwellwea@gmail.com>
References: <20260314201348.1786972-1-atwellwea@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wesley Atwell <atwellwea@gmail.com>

Extend the tcp_rcvbuf_grow and mptcp_rcvbuf_grow tracepoints with the
live receive-memory allocation and backlog occupancy that now drive the
window-growth decisions in this series.

That makes it easier to inspect sender-visible rwnd state against the
actual hard receive-memory inputs.

Signed-off-by: Wesley Atwell <atwellwea@gmail.com>
---
 include/trace/events/mptcp.h | 11 +++++++----
 include/trace/events/tcp.h   | 12 +++++++-----
 2 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/include/trace/events/mptcp.h b/include/trace/events/mptcp.h
index 269d949b2025..167970e8e0a5 100644
--- a/include/trace/events/mptcp.h
+++ b/include/trace/events/mptcp.h
@@ -199,6 +199,8 @@ TRACE_EVENT(mptcp_rcvbuf_grow,
 		__field(__u32, inq)
 		__field(__u32, space)
 		__field(__u32, ooo_space)
+		__field(__u32, rmem_alloc)
+		__field(__u32, backlog_len)
 		__field(__u32, rcvbuf)
 		__field(__u32, rcv_wnd)
 		__field(__u8, scaling_ratio)
@@ -228,6 +230,8 @@ TRACE_EVENT(mptcp_rcvbuf_grow,
 				     MPTCP_SKB_CB(msk->ooo_last_skb)->end_seq -
 				     msk->ack_seq;
 
+		__entry->rmem_alloc = tcp_rmem_used(sk);
+		__entry->backlog_len = READ_ONCE(msk->backlog_len);
 		__entry->rcvbuf = sk->sk_rcvbuf;
 		__entry->rcv_wnd = atomic64_read(&msk->rcv_wnd_sent) -
 				   msk->ack_seq;
@@ -248,12 +252,11 @@ TRACE_EVENT(mptcp_rcvbuf_grow,
 		__entry->skaddr = sk;
 	),
 
-	TP_printk("time=%u rtt_us=%u copied=%u inq=%u space=%u ooo=%u scaling_ratio=%u "
-		  "rcvbuf=%u rcv_wnd=%u family=%d sport=%hu dport=%hu saddr=%pI4 "
-		  "daddr=%pI4 saddrv6=%pI6c daddrv6=%pI6c skaddr=%p",
+	TP_printk("time=%u rtt_us=%u copied=%u inq=%u space=%u ooo=%u scaling_ratio=%u rmem_alloc=%u backlog_len=%u rcvbuf=%u rcv_wnd=%u family=%d sport=%hu dport=%hu saddr=%pI4 daddr=%pI4 saddrv6=%pI6c daddrv6=%pI6c skaddr=%p",
 		  __entry->time, __entry->rtt_us, __entry->copied,
 		  __entry->inq, __entry->space, __entry->ooo_space,
-		  __entry->scaling_ratio, __entry->rcvbuf, __entry->rcv_wnd,
+		  __entry->scaling_ratio, __entry->rmem_alloc,
+		  __entry->backlog_len, __entry->rcvbuf, __entry->rcv_wnd,
 		  __entry->family, __entry->sport, __entry->dport,
 		  __entry->saddr, __entry->daddr, __entry->saddr_v6,
 		  __entry->daddr_v6, __entry->skaddr)
diff --git a/include/trace/events/tcp.h b/include/trace/events/tcp.h
index f155f95cdb6e..92d0bd6be0ba 100644
--- a/include/trace/events/tcp.h
+++ b/include/trace/events/tcp.h
@@ -217,6 +217,8 @@ TRACE_EVENT(tcp_rcvbuf_grow,
 		__field(__u32, inq)
 		__field(__u32, space)
 		__field(__u32, ooo_space)
+		__field(__u32, rmem_alloc)
+		__field(__u32, backlog_len)
 		__field(__u32, rcvbuf)
 		__field(__u32, rcv_ssthresh)
 		__field(__u32, window_clamp)
@@ -247,6 +249,8 @@ TRACE_EVENT(tcp_rcvbuf_grow,
 				     TCP_SKB_CB(tp->ooo_last_skb)->end_seq -
 				     tp->rcv_nxt;
 
+		__entry->rmem_alloc = tcp_rmem_used(sk);
+		__entry->backlog_len = READ_ONCE(sk->sk_backlog.len);
 		__entry->rcvbuf = sk->sk_rcvbuf;
 		__entry->rcv_ssthresh = tp->rcv_ssthresh;
 		__entry->window_clamp = tp->window_clamp;
@@ -269,13 +273,11 @@ TRACE_EVENT(tcp_rcvbuf_grow,
 		__entry->sock_cookie = sock_gen_cookie(sk);
 	),
 
-	TP_printk("time=%u rtt_us=%u copied=%u inq=%u space=%u ooo=%u scaling_ratio=%u rcvbuf=%u "
-		  "rcv_ssthresh=%u window_clamp=%u rcv_wnd=%u "
-		  "family=%s sport=%hu dport=%hu saddr=%pI4 daddr=%pI4 "
-		  "saddrv6=%pI6c daddrv6=%pI6c skaddr=%p sock_cookie=%llx",
+	TP_printk("time=%u rtt_us=%u copied=%u inq=%u space=%u ooo=%u scaling_ratio=%u rmem_alloc=%u backlog_len=%u rcvbuf=%u rcv_ssthresh=%u window_clamp=%u rcv_wnd=%u family=%s sport=%hu dport=%hu saddr=%pI4 daddr=%pI4 saddrv6=%pI6c daddrv6=%pI6c skaddr=%p sock_cookie=%llx",
 		  __entry->time, __entry->rtt_us, __entry->copied,
 		  __entry->inq, __entry->space, __entry->ooo_space,
-		  __entry->scaling_ratio, __entry->rcvbuf,
+		  __entry->scaling_ratio, __entry->rmem_alloc,
+		  __entry->backlog_len, __entry->rcvbuf,
 		  __entry->rcv_ssthresh, __entry->window_clamp,
 		  __entry->rcv_wnd,
 		  show_family_name(__entry->family),
-- 
2.43.0

