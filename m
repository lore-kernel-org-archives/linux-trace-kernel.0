Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF6DA38424D
	for <linux-trace-kernel@vger.kernel.org>; Sat, 14 Mar 2026 20:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773519292; cv=none; b=THOUnZHvdpTdxRfuQrEG2I20RMbskIJzaHwCWI5JILHo2oC4Hgc2Mk4WEHaE4l3b9zh3oT9isS9cKHVD8Ir5cZ1E974aut9WVlmJH9+nsBJwAhBoQs2UXJAFiU3VdwNyvzkVNLfGnFJ0OH2dqWU1TMVsRxe88RD+ixfAQZvoZqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773519292; c=relaxed/simple;
	bh=7izhNqLY7+iqpp+D5zcP+czL6od/LnGYqCsmQoSJSu4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=untnuFumKe+Nc/67Cp98cNY5wcjWRiU36bvoZzlJhQdDUmtR5xbWofsrhJVeiTXz5aflxk5BLJJCUQLygyTNgSr5VHTw7sZAPlpWBlziy9QM1gE4mVBfCY6mDOcQx8tTQMQPfFrbUiUHO/O7Vnt7VorqzzIgmqskelbDaUNfeOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YfSQCnI8; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YfSQCnI8"
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-417400afaeeso3363281fac.1
        for <linux-trace-kernel@vger.kernel.org>; Sat, 14 Mar 2026 13:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773519289; x=1774124089; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fOOOdlrS2+fu1x+v8Rmi5MAUGmJW2DC+1z1Ah1tHPHA=;
        b=YfSQCnI8pcAkQBxbxRmg0IXw0rj6yeiQQBJEY+8xfNyIFRNHohbTtZgFJr19+aIs5d
         po7C/9kl24MwwwIpN7b2TDapKOhvwhx0SOXgfsb9P3JuQo44cThC4EZC4W7qj0lS1R3s
         0WLlVmQ1GtJA79Y7M+esx4Q8tOheHSz8oqqmaiELJYb2BGUQjaWrIaCpPw0+0sjbVib9
         TI8wFudad+LkDCH+nVFSPDUf2JTqlLX9Iqv5B/y3QiV4nEFRGWYQlZku/Iu/0Lm2Jq06
         JErdP0bcSZykMicBHCwDaAsVaAFg0imOj2oy5cCZdXFPzZN7gzZbiCIh9M3UKJiSxIl1
         PI+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773519289; x=1774124089;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fOOOdlrS2+fu1x+v8Rmi5MAUGmJW2DC+1z1Ah1tHPHA=;
        b=Rq99nV3NGFacfwn1fXC6WZH/4ZaOvHyhCGTuvWz6Jjn0cgSUeySg3r0Y1X5vm2g5sT
         6FiagQdy1jgWq7p4c+A6RscbdZ+Q6oeU9IUWatpsRPhESswECXzdArBuXbQtaGPmJAJt
         gLDhku2OJ5E1ac0Wd3NDLWRnY0dSuiMZlWLgmHrN6qiZTULds4F3LfBKFWmGyQD2kuo5
         c/xox6CzXrD6tPsurQXoQz6a3FyEvDb5HWqvOcily8DExXdqwIH817jRSMEkRyWwQTWN
         +Dr+hDEMEqDroBPt0dv9vTBVZ9+EQsZjJjmBlNTJ2ktzZjlclmi8T/LmpwmZqf+kPoh0
         rTbA==
X-Forwarded-Encrypted: i=1; AJvYcCXiBVFPqXBFZadBA4fJmPUg62AEgxwMvRJbo6dwwdeNHRV7sYLBjjL8Mv/B0vVsI5cF/+bRqaXDsyQDHHuhiKM5aoQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuTGhpmRqIJRzIRTjLo1MH3+ViDenn23r5tdXs+davfdUIZHbs
	hMg13czA8AfDwzZ28z9dPH1HwitMaZSwxeGb+qIv9qZGJV6n6/wcPsbQ
X-Gm-Gg: ATEYQzxlU9XYEicwUsrqaGhfJT1bR3gt8VEG/f8xLFbTqXvF3NmJWcltLqrN+/9PNWj
	CfIvYXXEc9Es5K+iIHNjcW06D0oR6N/xBksWoLpZIOoD0KKzx3/reGcC8xJzfQxyOIX6NZUMjR0
	X02JdU1ztsNQryxcATRpEYzfGXrAHVMazJ2NZxU9a9IM1PLyhv1c1aEDd+zefuw7NG3gz5OfVzr
	WuU8zwrPDVBxUlQsfZMqFPi0evk3uekYqXuTa3GF37RtB9jQy7PxRFjnsngBFPAOT9GlmzEJavL
	//qw33I0qKIbtUVuCyVMiBT+NFNHiDd5Q1Q0q1qI09VE8VnQxHTC5om20ARo31a8PSV0SPafTs4
	cekgHS+b5B9poLIvw33/WTIIm/xvmKtVJBUNXicx+7TtFz0pinXvys/uPMzQI2JXh9u8mu0We6C
	Y9A8DulGVhn7C9eJJAlN3jrAr7i5PAKqAC6vYRjGiVY1RLDGbadYJEuqxV67xXvw1iJWFzntykG
	spnD1DJBxFEFGopn5Y862IOCNOJdZlcP4nawt56
X-Received: by 2002:a05:6870:7d86:b0:40a:5870:98bb with SMTP id 586e51a60fabf-4179911cfccmr6459609fac.21.1773519288902;
        Sat, 14 Mar 2026 13:14:48 -0700 (PDT)
Received: from Atwell-Laptop.. (108-212-132-20.lightspeed.irvnca.sbcglobal.net. [108.212.132.20])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4177e5e8185sm11914165fac.12.2026.03.14.13.14.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Mar 2026 13:14:48 -0700 (PDT)
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
Subject: [PATCH net-next v2 05/14] tcp: grow rcvbuf to back scaled-window quantization slack
Date: Sat, 14 Mar 2026 14:13:39 -0600
Message-ID: <20260314201348.1786972-6-atwellwea@gmail.com>
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

Teach TCP to grow sk_rcvbuf when scale rounding would otherwise expose
more sender-visible window than the current hard receive-memory backing
can cover.

The new helper keeps backlog and memory-pressure limits in the same
units as the rest of the receive path, while __tcp_select_window()
backs any rounding slack before advertising it.

Signed-off-by: Wesley Atwell <atwellwea@gmail.com>
---
 include/net/tcp.h     | 12 ++++++++++++
 net/ipv4/tcp_input.c  | 36 ++++++++++++++++++++++++++++++++++--
 net/ipv4/tcp_output.c | 15 +++++++++++++--
 3 files changed, 59 insertions(+), 4 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index fc22ab6b80d5..5b479ad44f89 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -397,6 +397,7 @@ int tcp_ioctl(struct sock *sk, int cmd, int *karg);
 enum skb_drop_reason tcp_rcv_state_process(struct sock *sk, struct sk_buff *skb);
 void tcp_rcv_established(struct sock *sk, struct sk_buff *skb);
 void tcp_rcvbuf_grow(struct sock *sk, u32 newval);
+bool tcp_try_grow_rcvbuf(struct sock *sk, int needed);
 void tcp_rcv_space_adjust(struct sock *sk);
 int tcp_twsk_unique(struct sock *sk, struct sock *sktw, void *twp);
 void tcp_twsk_destructor(struct sock *sk);
@@ -1844,6 +1845,17 @@ static inline int tcp_rwnd_avail(const struct sock *sk)
 	return tcp_rmem_avail(sk) - READ_ONCE(sk->sk_backlog.len);
 }
 
+/* Passive children clone the listener's sk_socket until accept() grafts
+ * their own struct socket, so only sockets that point back to themselves
+ * should autotune receive-buffer backing.
+ */
+static inline bool tcp_rcvbuf_grow_allowed(const struct sock *sk)
+{
+	struct socket *sock = READ_ONCE(sk->sk_socket);
+
+	return sock && READ_ONCE(sock->sk) == sk;
+}
+
 /* Note: caller must be prepared to deal with negative returns */
 static inline int tcp_space(const struct sock *sk)
 {
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 352f814a4ff6..32256519a085 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -774,6 +774,38 @@ static void tcp_init_buffer_space(struct sock *sk)
 				    (u32)TCP_INIT_CWND * tp->advmss);
 }
 
+/* Try to grow sk_rcvbuf so the hard receive-memory limit covers @needed
+ * bytes beyond sk_rmem_alloc while preserving sender-visible headroom
+ * already consumed by sk_backlog.len.
+ */
+bool tcp_try_grow_rcvbuf(struct sock *sk, int needed)
+{
+	struct net *net = sock_net(sk);
+	int backlog;
+	int rmem2;
+	int target;
+
+	needed = max(needed, 0);
+	backlog = READ_ONCE(sk->sk_backlog.len);
+	target = tcp_rmem_used(sk) + backlog + needed;
+
+	if (target <= READ_ONCE(sk->sk_rcvbuf))
+		return true;
+
+	rmem2 = READ_ONCE(net->ipv4.sysctl_tcp_rmem[2]);
+	if (READ_ONCE(sk->sk_rcvbuf) >= rmem2 ||
+	    (sk->sk_userlocks & SOCK_RCVBUF_LOCK) ||
+	    tcp_under_memory_pressure(sk) ||
+	    sk_memory_allocated(sk) >= sk_prot_mem_limits(sk, 0))
+		return false;
+
+	WRITE_ONCE(sk->sk_rcvbuf,
+		   min_t(int, rmem2,
+			 max_t(int, READ_ONCE(sk->sk_rcvbuf), target)));
+
+	return target <= READ_ONCE(sk->sk_rcvbuf);
+}
+
 /* 4. Recalculate window clamp after socket hit its memory bounds. */
 static void tcp_clamp_window(struct sock *sk)
 {
@@ -785,14 +817,14 @@ static void tcp_clamp_window(struct sock *sk)
 	icsk->icsk_ack.quick = 0;
 	rmem2 = READ_ONCE(net->ipv4.sysctl_tcp_rmem[2]);
 
-	if (sk->sk_rcvbuf < rmem2 &&
+	if (READ_ONCE(sk->sk_rcvbuf) < rmem2 &&
 	    !(sk->sk_userlocks & SOCK_RCVBUF_LOCK) &&
 	    !tcp_under_memory_pressure(sk) &&
 	    sk_memory_allocated(sk) < sk_prot_mem_limits(sk, 0)) {
 		WRITE_ONCE(sk->sk_rcvbuf,
 			   min(atomic_read(&sk->sk_rmem_alloc), rmem2));
 	}
-	if (atomic_read(&sk->sk_rmem_alloc) > sk->sk_rcvbuf)
+	if (atomic_read(&sk->sk_rmem_alloc) > READ_ONCE(sk->sk_rcvbuf))
 		tp->rcv_ssthresh = min(tp->window_clamp, 2U * tp->advmss);
 }
 
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 57a2a6daaad3..53781cf591d2 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -3375,13 +3375,24 @@ u32 __tcp_select_window(struct sock *sk)
 	 * scaled window will not line up with the MSS boundary anyway.
 	 */
 	if (tp->rx_opt.rcv_wscale) {
+		int rcv_wscale = 1 << tp->rx_opt.rcv_wscale;
+
 		window = free_space;
 
 		/* Advertise enough space so that it won't get scaled away.
-		 * Import case: prevent zero window announcement if
+		 * Important case: prevent zero-window announcement if
 		 * 1<<rcv_wscale > mss.
 		 */
-		window = ALIGN(window, (1 << tp->rx_opt.rcv_wscale));
+		window = ALIGN(window, rcv_wscale);
+
+		/* Back any scale-quantization slack before we expose it.
+		 * Otherwise tcp_can_ingest() can reject data which is still
+		 * within the sender-visible window.
+		 */
+		if (window > free_space &&
+		    (!tcp_rcvbuf_grow_allowed(sk) ||
+		     !tcp_try_grow_rcvbuf(sk, tcp_space_from_win(sk, window))))
+			window = round_down(free_space, rcv_wscale);
 	} else {
 		window = tp->rcv_wnd;
 		/* Get the largest window that is a nice multiple of mss.
-- 
2.43.0

