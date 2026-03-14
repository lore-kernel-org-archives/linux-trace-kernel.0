Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A63B388E71
	for <linux-trace-kernel@vger.kernel.org>; Sat, 14 Mar 2026 20:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773519298; cv=none; b=Q1VIrV18nH434WMiXuig1SXc4fcHI5zCTGZ/BtNzNfguB8sP3wCII9i236DXMMWpKAC93GwNxOVnCw3iVw4xl5jcXT+PlGZxysZjacyaQoTsN1p3QZ/7+IM9Ls99SexYfLsDWSCzE1+TfAv7fVdC3qW46TYC+LjnrGMGbDe9uqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773519298; c=relaxed/simple;
	bh=dcj1s6Dgcrw3Y7tNOEUlJFcSNNEIPs4iabts40+JwIM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=htLw03m2OIKjPDTYlAqflLb3lsBdZbKzUr+eCk2cdQxBz80x70d9E1kPlRo0FvkSsoajJS6Qi/Ez5oNpEEMxDUoKQ/v7XlLJpz13WzMaQnMiWersJrypRA7lFDeKWT8UtH5wtYS+Inr54LaIYcHyIKoK73Zf1Kt7ThtlWhZmJi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mFW7KEXb; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mFW7KEXb"
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7d556c1a79eso3744107a34.3
        for <linux-trace-kernel@vger.kernel.org>; Sat, 14 Mar 2026 13:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773519295; x=1774124095; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xpvhfo9p2XSrc/tbQHeJ0/cabcWcjahm5y6siccjbzs=;
        b=mFW7KEXbx2xHzOcHzEC4+WerjZYDr6T5uY/8RXTxpLRLV9ogJJQlGWMN7baacQtjD8
         0w6nsnlYIhN/otPV6vVvu3g8yy/JiJI5mnP77ZdS4pQ8DJymo/PXbkmVocG9uNYovlLz
         4/5Ocjf42HImX3dEKcpcff1fprnlrROEXn3BA8jyNwI6LVH6z61MUT2DXpwnDo+NBHsn
         nfF8O5euOI/3LCSqq7X6hHeSQb2r1QurUdXyaxbvzNuljzDXVgWg9qd3mAn9NdJQGQsA
         VlLzjLF2EcJ5MOmMhrQ38lHjicLFQO9IiTLg2g4acWNXyaaQvZoGTL8TdOdq/eArIkf8
         QIAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773519295; x=1774124095;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xpvhfo9p2XSrc/tbQHeJ0/cabcWcjahm5y6siccjbzs=;
        b=gQlqalm88nfMuxa3VJYY4emrp6P2YcF8ZwGXP3ynkmieh5GdR2wcljgkuSxY+DiigS
         sATRdZciUUidn4Fuqk8Vjm6qGgq4cbS7wzmxEK7X1Ei2zxrNJg9f+cVfQda4D+D72Nnv
         9JHneNoedTazpSkNwjpk1tTLyMSiL+NOBCbjZAxKMejJtZvuDGKV16K+ZTBbVcDFWG+n
         p+Y8rVbnw6u8SHOfMBO52Bk6YcKa4nbpnnwesEYIVu5CHr5xN1gr5xnttRlXN/eVFLrk
         uK+LRL1UQke9aVGbNFxb4JZo36eAH1+cC5faaby6Ch2u534a2RuXzgnhElIuxaiZYr3L
         kaVg==
X-Forwarded-Encrypted: i=1; AJvYcCXh07diSK3Z89KUKNY/qeB+Ja7vwkbn9d6lXaec3pt4EAefTkMajDUBJPWj2ja3aq9AtbzD49nuM75chETGjYoDXCg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaLpLkzQXksqG6wbSP5Z3k3ZOhR4c5U0wsRT41fAE6zWpNUTRA
	LVsVbLMMwJVQaMXUP5ZYnA/WuDGu0hMs5Ndpqiv2J4N55b+a4lPFR8ZF
X-Gm-Gg: ATEYQzx5r0XjWJ+I3I/Juq8/bHw1q0DszUQVRF33ypbhP46I4PFSZ5E1Po+QvArJnPV
	KBto0r4dAWW2AtU49yyhf0phN8kOfnk2SHv9p62nrJ+Scvf5Zkn5V5VxVP+hfXDhXm52qa1KfeO
	6mP4QccfarSPDO8gTwKa8YG4w0ilkVP82P0ZjhK5GY3am54DBq0JL7+Bv5F3DWrbY1aUCkAiFD0
	wdezkXdi0b0FRA0IEyJy7RPmzUINKOeLWMeiyW5eWKXtPqF3yU3zxRD4aqQvesxwb4VTbme493Y
	dTE69YPTRE+pUoTRO823k2ptZ0M2cGLolPc2qYrRqUKYceWiBlsuhtrwPhF7yzEGPigZH17NDfm
	4CH9ElEi4YzE0M1RlcmuK7UgyA6Z+iDeE+mqkmSsSBWmdZ9RjNxeafJmE9iAsH6V/CG/wEi+jz9
	KsD6DQdQR4KCdA1n6z4dZEHNhbUy2MYxyOIqODuPSQnNHG069Xpuk9rGeMj85kk594T5gDe5yQW
	QPFW0Qg9ypWnNexTzQpImIZODrsokJdr97EAXES
X-Received: by 2002:a05:6870:a796:b0:3e8:8b6f:9d85 with SMTP id 586e51a60fabf-417b937d46cmr4417226fac.29.1773519295129;
        Sat, 14 Mar 2026 13:14:55 -0700 (PDT)
Received: from Atwell-Laptop.. (108-212-132-20.lightspeed.irvnca.sbcglobal.net. [108.212.132.20])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4177e5e8185sm11914165fac.12.2026.03.14.13.14.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Mar 2026 13:14:54 -0700 (PDT)
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
Subject: [PATCH net-next v2 09/14] mptcp: refresh TCP receive-window snapshots on subflows
Date: Sat, 14 Mar 2026 14:13:43 -0600
Message-ID: <20260314201348.1786972-10-atwellwea@gmail.com>
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

When MPTCP resynchronizes the per-subflow TCP shadow window from the
mptcp-level receive state, refresh the live rwnd snapshot and the
remembered maximum-window snapshot along with it.

That keeps subflow TCP bookkeeping aligned with the sender-visible
window state tracked in the core TCP patches.

Signed-off-by: Wesley Atwell <atwellwea@gmail.com>
---
 net/mptcp/options.c  | 14 +++++++++-----
 net/mptcp/protocol.h | 14 +++++++++++---
 2 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 8a1c5698983c..64cd637484a4 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -1073,9 +1073,12 @@ static void rwin_update(struct mptcp_sock *msk, struct sock *ssk,
 		return;
 
 	/* Some other subflow grew the mptcp-level rwin since rcv_wup,
-	 * resync.
+	 * resync. Keep the TCP shadow window in its advertised u32 domain
+	 * and refresh the advertise-time scaling snapshot while doing so.
 	 */
-	tp->rcv_wnd += mptcp_rcv_wnd - subflow->rcv_wnd_sent;
+	tcp_set_rcv_wnd(tp, min_t(u64, (u64)tp->rcv_wnd +
+				  (mptcp_rcv_wnd - subflow->rcv_wnd_sent),
+				  U32_MAX));
 	tcp_update_max_rcv_wnd_seq(tp);
 	subflow->rcv_wnd_sent = mptcp_rcv_wnd;
 }
@@ -1335,12 +1338,13 @@ static void mptcp_set_rwin(struct tcp_sock *tp, struct tcphdr *th)
 	if (rcv_wnd_new != rcv_wnd_old) {
 raise_win:
 		/* The msk-level rcv wnd is after the tcp level one,
-		 * sync the latter.
+		 * sync the latter and refresh its advertise-time scaling
+		 * snapshot.
 		 */
 		rcv_wnd_new = rcv_wnd_old;
 		win = rcv_wnd_old - ack_seq;
-		new_win = min_t(u64, win, U32_MAX);
-		tp->rcv_wnd = new_win;
+		tcp_set_rcv_wnd(tp, min_t(u64, win, U32_MAX));
+		new_win = tp->rcv_wnd;
 		tcp_update_max_rcv_wnd_seq(tp);
 
 		/* Make sure we do not exceed the maximum possible
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 0bd1ee860316..4ea95c9c0c7a 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -408,11 +408,19 @@ static inline int mptcp_space_from_win(const struct sock *sk, int win)
 	return __tcp_space_from_win(mptcp_sk(sk)->scaling_ratio, win);
 }
 
+/* MPTCP exposes window space from the mptcp-level receive queue, so it tracks
+ * a separate backlog counter from the subflow backlog embedded in struct sock.
+ */
+static inline int mptcp_rwnd_avail(const struct sock *sk)
+{
+	return READ_ONCE(sk->sk_rcvbuf) -
+	       READ_ONCE(mptcp_sk(sk)->backlog_len) -
+	       tcp_rmem_used(sk);
+}
+
 static inline int __mptcp_space(const struct sock *sk)
 {
-	return mptcp_win_from_space(sk, READ_ONCE(sk->sk_rcvbuf) -
-				    READ_ONCE(mptcp_sk(sk)->backlog_len) -
-				    sk_rmem_alloc_get(sk));
+	return mptcp_win_from_space(sk, mptcp_rwnd_avail(sk));
 }
 
 static inline struct mptcp_data_frag *mptcp_send_head(const struct sock *sk)
-- 
2.43.0

