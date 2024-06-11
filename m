Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA14153505
	for <linux-trace-kernel@vger.kernel.org>; Tue, 11 Jun 2024 20:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718136694; cv=none; b=sa6ajTda6ZgPV/C4h13yf18LSWxEaAlE34q8LRMbjyyqItSCaCZnCF/ebYldVXM85uy8KQvdDp8iQ6F25u7S8W8AezDSFKpt1G5xr3dTawikOSMCrGSaNF6NtKjBwXG0eeNAie3vz0Zw2MTgFn2nnbJPnJ7Gfe/DUY/EuLAslVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718136694; c=relaxed/simple;
	bh=Gs30pldD4IYhwgM9Z2RPF0lE51iD4CooDjoR4sEXvh0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OJdhrPEk6lxAeJRMhxwsNPy2xIERoyOx1K6pmRCZtKxhik9Lmo6n3nLYHpIKvVi31mhDmuaM86ky+n+lAV4bCsb/HBDCqgaGkJzCaZJsJpg1jIUmExo3IdhFgGGr5MLMG6E3gZMKJDJQQZioJBGwinMX1rJ1MYggv/9bcpDPWWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=cq+xKo32; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="cq+xKo32"
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3cabac56b38so3623922b6e.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 11 Jun 2024 13:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1718136691; x=1718741491; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8Z9GdxrPO2MLCd8f731wHDlufWSwkyCPNseSHb6h3wQ=;
        b=cq+xKo32LLjjWpIql/Z4G+sZy0UsMtXDJhx9/MGdgONfciRiOxEZMTfz18OiSqNAM0
         MloqM+RMn2CeYWTR5kMTdB76tlVQ/uI3cyktsWmv9bBa5zvCeOgMxIfDcMXar1P/pPbC
         +KHsjGuVxi9iW4O9SvLL0H5c5vk4llxclH6UJUYyJ2j4dmo14nmPbm/XnQEV7KRAd/vU
         deguuyPWsZxjZALd3U2T5qWe7o71QYekV2rxMMoTijydZHQNr7/zd4qg62Jvk91AvuoU
         xM8VjeORQtiWGF4VzSAzuvm9/6/hVvCZHPG0tpb486ZJ2XjSvcr4jzIxmvL48/9KJ4zy
         n70Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718136691; x=1718741491;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Z9GdxrPO2MLCd8f731wHDlufWSwkyCPNseSHb6h3wQ=;
        b=lRN4R2z4pubPRhEhnwUu5KFUVq3ysPC05QuFD0xZFqAch4dJDEnXeUfzpLPnnKx0YT
         TpTvv95L7xs7Yr7Hs2T7vpZZ1jsImhDn54tI9rZjNVsPtPjJTIE9vy9/W80ZOmDDZ/1M
         whuKG+4MolDeHYZZxtuD1mHAK/AWUaYw07L8ecs1ReVzNkyR/WZxlhgjQl2lVZfZpO1e
         hOA+wPyl8ps1eBZVfgdOs7Xxy3DP0aDatjJXufGDeGBctLufIqpKTsDlSBtTjdVNomCO
         cjFWRmwERndXueox1hDTjuHRIuaTl41IIfbaWb5lidimoi+wh0XS8m172w1Lpn1LrGaT
         BnTQ==
X-Forwarded-Encrypted: i=1; AJvYcCUISEfNzsU/vptocWgmbJOV7RZ5v4NolUweVeAr+9gBVQVzCTeVQ8TuCOJUY7Qevs73kN5yjHQ3T2xAgDya28zd83o6ugyJZXPJThRObjwMpIEv
X-Gm-Message-State: AOJu0Yw0NS5Xy33CM5NWXs3kHtc3Dlixg4gfOjl3UgvSY0RzTAM6eEmE
	w0gdDpSQJ4rdpm3HZzEbfH5mmubflgRreluvEY0FLB0N6Y3gipayutCmv4iOVGM=
X-Google-Smtp-Source: AGHT+IFJP4zNmeqrkkMtxprNnhjyaW8BD6jY1LNk4cFHEerqHQKxd78N0bcr8httHKTFrx++YRgKUQ==
X-Received: by 2002:a05:6808:3085:b0:3d2:3dba:f599 with SMTP id 5614622812f47-3d23dbafceemr56055b6e.11.1718136691331;
        Tue, 11 Jun 2024 13:11:31 -0700 (PDT)
Received: from debian.debian ([2a09:bac5:7a49:f9b::18e:1c])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-440ee9ca87esm21560111cf.23.2024.06.11.13.11.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 13:11:30 -0700 (PDT)
Date: Tue, 11 Jun 2024 13:11:27 -0700
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
Subject: [PATCH v4 net-next 2/7] net: introduce sk_skb_reason_drop function
Message-ID: <4dffb0fb7b26f803c7fcf6dfdbcd76489615c4de.1718136376.git.yan@cloudflare.com>
References: <cover.1718136376.git.yan@cloudflare.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1718136376.git.yan@cloudflare.com>

Long used destructors kfree_skb and kfree_skb_reason do not pass
receiving socket to packet drop tracepoints trace_kfree_skb.
This makes it hard to track packet drops of a certain netns (container)
or a socket (user application).

The naming of these destructors are also not consistent with most sk/skb
operating functions, i.e. functions named "sk_xxx" or "skb_xxx".
Introduce a new functions sk_skb_reason_drop as drop-in replacement for
kfree_skb_reason on local receiving path. Callers can now pass receiving
sockets to the tracepoints.

kfree_skb and kfree_skb_reason are still usable but they are now just
inline helpers that call sk_skb_reason_drop.

Note it is not feasible to do the same to consume_skb. Packets not
dropped can flow through multiple receive handlers, and have multiple
receiving sockets. Leave it untouched for now.

Suggested-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Yan Zhai <yan@cloudflare.com>
---
v1->v2: changes function names to be more consistent with common sk/skb
operations
---
 include/linux/skbuff.h | 10 ++++++++--
 net/core/skbuff.c      | 22 ++++++++++++----------
 2 files changed, 20 insertions(+), 12 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index fe7d8dbef77e..c479a2515a62 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -1251,8 +1251,14 @@ static inline bool skb_data_unref(const struct sk_buff *skb,
 	return true;
 }
 
-void __fix_address
-kfree_skb_reason(struct sk_buff *skb, enum skb_drop_reason reason);
+void __fix_address sk_skb_reason_drop(struct sock *sk, struct sk_buff *skb,
+				      enum skb_drop_reason reason);
+
+static inline void
+kfree_skb_reason(struct sk_buff *skb, enum skb_drop_reason reason)
+{
+	sk_skb_reason_drop(NULL, skb, reason);
+}
 
 /**
  *	kfree_skb - free an sk_buff with 'NOT_SPECIFIED' reason
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 2854afdd713f..9def11fe42c4 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -1190,7 +1190,8 @@ void __kfree_skb(struct sk_buff *skb)
 EXPORT_SYMBOL(__kfree_skb);
 
 static __always_inline
-bool __kfree_skb_reason(struct sk_buff *skb, enum skb_drop_reason reason)
+bool __sk_skb_reason_drop(struct sock *sk, struct sk_buff *skb,
+			  enum skb_drop_reason reason)
 {
 	if (unlikely(!skb_unref(skb)))
 		return false;
@@ -1203,26 +1204,27 @@ bool __kfree_skb_reason(struct sk_buff *skb, enum skb_drop_reason reason)
 	if (reason == SKB_CONSUMED)
 		trace_consume_skb(skb, __builtin_return_address(0));
 	else
-		trace_kfree_skb(skb, __builtin_return_address(0), reason, NULL);
+		trace_kfree_skb(skb, __builtin_return_address(0), reason, sk);
 	return true;
 }
 
 /**
- *	kfree_skb_reason - free an sk_buff with special reason
+ *	sk_skb_reason_drop - free an sk_buff with special reason
+ *	@sk: the socket to receive @skb, or NULL if not applicable
  *	@skb: buffer to free
  *	@reason: reason why this skb is dropped
  *
- *	Drop a reference to the buffer and free it if the usage count has
- *	hit zero. Meanwhile, pass the drop reason to 'kfree_skb'
- *	tracepoint.
+ *	Drop a reference to the buffer and free it if the usage count has hit
+ *	zero. Meanwhile, pass the receiving socket and drop reason to
+ *	'kfree_skb' tracepoint.
  */
 void __fix_address
-kfree_skb_reason(struct sk_buff *skb, enum skb_drop_reason reason)
+sk_skb_reason_drop(struct sock *sk, struct sk_buff *skb, enum skb_drop_reason reason)
 {
-	if (__kfree_skb_reason(skb, reason))
+	if (__sk_skb_reason_drop(sk, skb, reason))
 		__kfree_skb(skb);
 }
-EXPORT_SYMBOL(kfree_skb_reason);
+EXPORT_SYMBOL(sk_skb_reason_drop);
 
 #define KFREE_SKB_BULK_SIZE	16
 
@@ -1261,7 +1263,7 @@ kfree_skb_list_reason(struct sk_buff *segs, enum skb_drop_reason reason)
 	while (segs) {
 		struct sk_buff *next = segs->next;
 
-		if (__kfree_skb_reason(segs, reason)) {
+		if (__sk_skb_reason_drop(NULL, segs, reason)) {
 			skb_poison_list(segs);
 			kfree_skb_add_bulk(segs, &sa, reason);
 		}
-- 
2.30.2


