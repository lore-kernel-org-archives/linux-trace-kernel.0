Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 055CB3BC692
	for <linux-trace-kernel@vger.kernel.org>; Wed, 11 Mar 2026 07:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773215806; cv=none; b=d8MfFl4KwYg3KS04OivvXL0y8IPyyPuzSiCml29Ty42hUwkaX4RRSJV95Xjy4M46GSjOpiuRX4aFJgm2e3uXf2NtLx/mORQGwGVTKHkNk783GdoVR7zEmeX2ysiGEJ9cqq6/ciiHloSHVwUZqnYmHkd7xDo+02Z8k0BIrewW3nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773215806; c=relaxed/simple;
	bh=C939i0d+rKTXWj91cA/6uhlPcNX1BycjNPrjJIyRlB0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Yi1hsdy1PddbfJI1NR+vjaToZS8Q1nGDrXUlWR2Q6XwiPCuOiCDGaKbsL1qzyvq8FsqjhJXOLBJCbeFZoDDKF1f2BkjMYgkqOubXQjMQXWH80wFsaKWy/pEUTJAKJ1BDvKmFYiO9aecLSofkIIUX0z+rU9toHWoNA3fDmiAVnCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kh/S2Ut8; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kh/S2Ut8"
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-40429b1d8baso3514580fac.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 11 Mar 2026 00:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773215799; x=1773820599; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4epqsXquWuAivDGaqjYARTGwK/kOqEMKWTt83y67gTo=;
        b=Kh/S2Ut8Mz3IOrJyUF1u8U1hKxWbezXDQfvjBZZZSRIxPlXeO/7kz+0xvq1bMEiJAe
         lXzcI5udhKCFXJqU2fL1KoH6Jdn0FZiXxgwW39Y5VOznkbwDLALQDwc3P74kEVEYjYq+
         yig8cAAHYZAQ9qcVilzLP9jNYCgVewxw+Yb2TwGYXDOSkqfDkRmwMpg3p/Tfa3pSEe9u
         g7bABRqWYHbWBfa3Hjar5WRpxYmkbhu4XEe3Rvhy/d2yHHE/pxgWgsqKVIWOOYvwEhnl
         AVOMSDCrZpk1GXQMspz5ABATP+Km1F5tyN8Czb/z1EperES+Pbim2ngZgi1MZtlBkUbW
         hTDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773215799; x=1773820599;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4epqsXquWuAivDGaqjYARTGwK/kOqEMKWTt83y67gTo=;
        b=Q4KBNrigASz5HM96fEoYdVgQVnAkR22CFPsYuAzJZg013DMggYr1KIS7FSua3hUVPu
         dm9YF7xCh0JJhTGA61AuOxrRzDNJ+6WzPALl55+nM+je7e7fQJda9l+ny5WmRFJJ/FCR
         UWOMFyj1zPW2TP56/WjAHmJimd2RawziAf6kolgI3oUwtdTfQuoECX98zsW3jMKQqQfz
         AQJ69u2C+bYqIx5Y3fLw6+6LzL2A6NICkCeOWMzicOou79H5oiY4Q5QGi1UwhPkF1gJg
         dhODqWlQD4/OlSg3XC5TAte4Z+5jX4ln8PSuT9wPoqvIjVy5gv0lPIHFrD1XprGUlWLw
         R6uQ==
X-Forwarded-Encrypted: i=1; AJvYcCX1peSW7YnIWt1qReFD0tD+iconUz9O1Tpx2AoABod7C4ae/AXk4mCFJUZyNWewjIm2cEREwzzEv0wE/GKhercYSUk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+UDNir5WrYl4cnaf2KukxzYj1I4QE16lf/ei2sWwAgT9i1jLt
	Qdc/zh15sY56/wLaRKYJ/KiuNcr+hm5BFYRKjyQV/XVvaJztbXJeqaBj
X-Gm-Gg: ATEYQzxOIz7wzNf2s6XJ6eeV79s08UdMgz0Yrqk7b3D7BtAyvIPATwCWIoFm+6zpovf
	nfmFmhwX2H3qMPceo1e6rq7+c7xxfxvkOdQh4I98vtjgFhBmJan5RERAs/kOjHo49Edx5MHBWbT
	owXKRHqFPaudSsoHPwV6NyVm8QzfGdnSMn/N0uztptGcOvtjjrBbCwJiVCO3rQ33Qfb7WX5ww/i
	dODVumpLyuzqILpwXx/q8L4ZzuidxC72bUbziWv6a6jknSlVwm63PrGBnmFO4cKqegz3MhzDoCw
	Axk6nXSv2UELPB60zNpJNDB7Ap7Jd8PdNGtFHH5WeXMjmZEW5gaEoOn6itA/mxc8jTSOhJ7g/Xz
	Hed1TTi17g8uLCuK6Wqq3Pf+O0rgd6OYAfXfY/ra894YPeoyVmkwwhdUpNy4Bi/i3FT8sTftd4K
	WFIdhMOPKqgLQ0gN+FMW3HL4icyPNOih2CsGNbysiTJcTk5SCY2+ZhIsKHfPE9YzInd7SE+h1Cw
	mF3S2EQBxeDXEESHiC4B7LQ7D7lE32szmXvppjgoW+y2U8Z
X-Received: by 2002:a05:6870:8e07:b0:3e0:de76:31e5 with SMTP id 586e51a60fabf-4177c8b4e62mr1075613fac.25.1773215798847;
        Wed, 11 Mar 2026 00:56:38 -0700 (PDT)
Received: from localhost.localdomain (108-212-132-20.lightspeed.irvnca.sbcglobal.net. [108.212.132.20])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4177e6ae0e3sm1568938fac.16.2026.03.11.00.56.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 00:56:38 -0700 (PDT)
From: Wesley Atwell <atwellwea@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	ncardwell@google.com,
	dsahern@kernel.org,
	matttbe@kernel.org,
	martineau@kernel.org,
	netdev@vger.kernel.org,
	mptcp@lists.linux.dev
Cc: kuniyu@google.com,
	horms@kernel.org,
	geliang@kernel.org,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	0x7f454c46@gmail.com,
	linux-doc@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org,
	atwellwea@gmail.com
Subject: [PATCH net 6/7] tcp: expose rmem and backlog accounting in rcvbuf_grow tracepoints
Date: Wed, 11 Mar 2026 01:55:59 -0600
Message-Id: <20260311075600.948413-7-atwellwea@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260311075600.948413-1-atwellwea@gmail.com>
References: <20260311075600.948413-1-atwellwea@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The receive-window work now depends on keeping sender-visible rwnd and
hard receive-memory accounting aligned.

Expose the current rmem charge and backlog reservation in the TCP and
MPTCP rcvbuf_grow tracepoints so that later drift between advertised
window and local backing is visible during review and debugging.

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
2.34.1

