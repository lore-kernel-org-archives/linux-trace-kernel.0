Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49DE03B9D85
	for <linux-trace-kernel@vger.kernel.org>; Wed, 11 Mar 2026 07:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773215801; cv=none; b=uNEHfRlHZ4xb03SY0ZFkFUTHUqJPM9Bd30qnHwuDoiuSV/b/neyOUp67Ksxc4EGyh1IkO/2bFdSmNMd6KU25QOPbAk0+/pEw0DNw3jAsTtfuQjyoElMwOfkke6WubT1RM7C9C9sw2fZFiPxCQhZH3V1cSv3EmcZIHaG77yUGwQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773215801; c=relaxed/simple;
	bh=FWYsgoyKVIUupg0joGsjXBrmnww52mswGSTqsNgSq3U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VS46AlyGU1HHjqGSPZIk1dmJWFVxuqxdJJ8wzV9IDdw2i2TTvHzs3adfhWYXBPjdPoON2gZXzGyoi8ZZjwzkQrFtNpySLRt1muTSTYI8s3WHepgsaPnAGTXyoUMj/Kx4BqHQLWkkarT1uzey3Jre5xGvC8frSVEPKkKRPixr1Lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H/2YPI1C; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H/2YPI1C"
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-67ba5b0e00dso1067226eaf.2
        for <linux-trace-kernel@vger.kernel.org>; Wed, 11 Mar 2026 00:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773215795; x=1773820595; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DWRaO2kk43skP87kgk2P1rc0roOMtr/hXw08wzU1czs=;
        b=H/2YPI1Cgww1qLF8X73k6RMOlAtgpK/tDCvVe+qwTWtv1lCqP/9Fz45QU3JjxC8vrb
         KrI/fsEV4RvZpfe88/9Cwo/YMKi35uyvLHUFKDak3gowGawOrR3bOjUjQ3v6IgOmR/9L
         FYLTBlILCke4UkUMknw1uBgIO5NQE+pfMPuzCDz+CnIWsyP7Hkf22Ya8+euYwzq9rU4Y
         +bIc4n7aEXDhyF8zB00n5LgY89TGa4cFLqoLjmdsa67XhchiL3Zu+1D7GOGzgbGmzERY
         0igkVYqDe1yoW9f/vGObwMv1JwybRSSMh3KeQl5KIPum6s8beGt543tmJSEwsJMkvkWu
         AR+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773215795; x=1773820595;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DWRaO2kk43skP87kgk2P1rc0roOMtr/hXw08wzU1czs=;
        b=egI8WbAM7eDhEijcLG4k0UXUqpy1yX8WjD3ijHJqWXTGZnzzax4ED+vqYG6SlO7a8c
         qPkPsTMUc2WfH6OJihMj5GqmdYQR3QruiJMCRy+G6GbZBnzMEHN9oiz5dIjVCiejnVf4
         73PopFjrtJxrO0gj8kVg7kTz7z6YUsO/n3SVH7bVcs7BtObKmgxfrOYMoN0aeJwaceAv
         b/zxUfmwmgHH+3jiRoOehwYuQ/xJeNNjKFWl1QY9KnAlUy7e/1SywdtVsL+mtbjm6nPv
         YovOxaMuH7viULGgmLovmbJdLhQ3P7MfEGSo8ayEAkjOABBykmf2iUfNzdKuWQPSYL2I
         NW5g==
X-Forwarded-Encrypted: i=1; AJvYcCVLf4gSM5UG7vsZwTf6NwLEJSt0agrcWusEeQSiCgK4vjmqxMNWk3WIYJliEZ36S/dLMNUcO7P3bXUywWf1PPxwi9k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzK5SZMehOqk1NWiMUmseqPisvs8hvGxJXMTdLRhCRIwm0LWE9E
	yppFTPxmXPiYKA1wUk/aQ13xdShFQyv2F4JCSvgkYahjDkc+ZVG4/hEY
X-Gm-Gg: ATEYQzzQbDOBmWJQh0rbpTZp+IB9g2VoFvozV4JTbJ1q+Qc5QWhTHit480q+YNQvTqo
	1F22Jz+dKiewQRn2JaIrKG8NTwdfo2Hnh5FfvVkK7nSIU0dlMv+7P4/hd2DUUUNxm4GKgxe6NRU
	qpNm2ixNOWhspfyKt7HXUtEEEQuLsq1xYHAcNnKy2uVEULL+N5cHJ6pFlhLPDKTK0iAqVhQONtQ
	na5UeywC0xGiNZHU4urHUUUjJNJU8AMpNVBjjwZm8mRpp+GqdGoWc0J8Xl7dylwxUnzhwp5EO3t
	g0S9ZOmf46Q6TiqnMN0D0WlTMkuH8p1Mf0jqwguLVQrElHAFx1N76Kgv4N0QCUY7q4av6kRpJpG
	Pjy8KmTDL0z/ZHVjxc6dCW4ISPD1GAUjbw0fUeYHwMMZjwammpmp7Cre4fr4GuhMCr7Thj0+Mwu
	1/L0VVxIPT99NM4/aBlE1BRuc2z+rCs8hw7cm1NNp0xAhR7fHEMtjshaBIVzB9InpkMqjldgams
	SfGBfnRfUhlgcq4yk6eQldc5O5czGwSFFyCb4HBIL0G+U+o
X-Received: by 2002:a05:6820:4deb:b0:679:e889:dde1 with SMTP id 006d021491bc7-67bc8877e83mr927920eaf.6.1773215795085;
        Wed, 11 Mar 2026 00:56:35 -0700 (PDT)
Received: from localhost.localdomain (108-212-132-20.lightspeed.irvnca.sbcglobal.net. [108.212.132.20])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4177e6ae0e3sm1568938fac.16.2026.03.11.00.56.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 00:56:34 -0700 (PDT)
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
Subject: [PATCH net 4/7] tcp: extend TCP_REPAIR_WINDOW with receive-window scaling snapshot
Date: Wed, 11 Mar 2026 01:55:57 -0600
Message-Id: <20260311075600.948413-5-atwellwea@gmail.com>
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

The paired receive-window state is now part of the live TCP socket
semantics, so repair and restore need a way to preserve it.

Extend TCP_REPAIR_WINDOW with the advertise-time scaling snapshot while
keeping old userspace working. The kernel now accepts exactly the legacy
layout and the extended layout. Legacy restore leaves the snapshot
unknown so the socket falls back safely until a fresh local window
advertisement refreshes the pair, while the extended layout restores the
exact snapshot.

Signed-off-by: Wesley Atwell <atwellwea@gmail.com>
---
 include/uapi/linux/tcp.h |  1 +
 net/ipv4/tcp.c           | 34 ++++++++++++++++++++++++++++------
 2 files changed, 29 insertions(+), 6 deletions(-)

diff --git a/include/uapi/linux/tcp.h b/include/uapi/linux/tcp.h
index 03772dd4d399..3a799f4c0e1e 100644
--- a/include/uapi/linux/tcp.h
+++ b/include/uapi/linux/tcp.h
@@ -159,6 +159,7 @@ struct tcp_repair_window {
 
 	__u32	rcv_wnd;
 	__u32	rcv_wup;
+	__u32	rcv_wnd_scaling_ratio; /* 0 means advertise-time basis unknown */
 };
 
 enum {
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index cec9ae1bf875..dd2b4fe61bd8 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -3551,17 +3551,25 @@ static inline bool tcp_can_repair_sock(const struct sock *sk)
 		(sk->sk_state != TCP_LISTEN);
 }
 
+/* Keep accepting the pre-extension TCP_REPAIR_WINDOW layout so legacy
+ * userspace can restore sockets without fabricating a snapshot basis.
+ */
+static inline int tcp_repair_window_legacy_size(void)
+{
+	return offsetof(struct tcp_repair_window, rcv_wnd_scaling_ratio);
+}
+
 static int tcp_repair_set_window(struct tcp_sock *tp, sockptr_t optbuf, int len)
 {
-	struct tcp_repair_window opt;
+	struct tcp_repair_window opt = {};
 
 	if (!tp->repair)
 		return -EPERM;
 
-	if (len != sizeof(opt))
+	if (len != tcp_repair_window_legacy_size() && len != sizeof(opt))
 		return -EINVAL;
 
-	if (copy_from_sockptr(&opt, optbuf, sizeof(opt)))
+	if (copy_from_sockptr(&opt, optbuf, len))
 		return -EFAULT;
 
 	if (opt.max_window < opt.snd_wnd)
@@ -3577,7 +3585,20 @@ static int tcp_repair_set_window(struct tcp_sock *tp, sockptr_t optbuf, int len)
 	tp->snd_wnd	= opt.snd_wnd;
 	tp->max_window	= opt.max_window;
 
-	tp->rcv_wnd	= opt.rcv_wnd;
+	if (len == tcp_repair_window_legacy_size()) {
+		/* Legacy repair UAPI has no advertise-time basis for tp->rcv_wnd.
+		 * Mark the snapshot unknown until a fresh local advertisement
+		 * re-establishes the pair.
+		 */
+		tcp_set_rcv_wnd_unknown(tp, opt.rcv_wnd);
+		tp->rcv_wup	= opt.rcv_wup;
+		return 0;
+	}
+
+	if (opt.rcv_wnd_scaling_ratio > U8_MAX)
+		return -EINVAL;
+
+	tcp_set_rcv_wnd_snapshot(tp, opt.rcv_wnd, opt.rcv_wnd_scaling_ratio);
 	tp->rcv_wup	= opt.rcv_wup;
 
 	return 0;
@@ -4667,12 +4688,12 @@ int do_tcp_getsockopt(struct sock *sk, int level,
 		break;
 
 	case TCP_REPAIR_WINDOW: {
-		struct tcp_repair_window opt;
+		struct tcp_repair_window opt = {};
 
 		if (copy_from_sockptr(&len, optlen, sizeof(int)))
 			return -EFAULT;
 
-		if (len != sizeof(opt))
+		if (len != tcp_repair_window_legacy_size() && len != sizeof(opt))
 			return -EINVAL;
 
 		if (!tp->repair)
@@ -4683,6 +4704,7 @@ int do_tcp_getsockopt(struct sock *sk, int level,
 		opt.max_window	= tp->max_window;
 		opt.rcv_wnd	= tp->rcv_wnd;
 		opt.rcv_wup	= tp->rcv_wup;
+		opt.rcv_wnd_scaling_ratio = tp->rcv_wnd_scaling_ratio;
 
 		if (copy_to_sockptr(optval, &opt, len))
 			return -EFAULT;
-- 
2.34.1

