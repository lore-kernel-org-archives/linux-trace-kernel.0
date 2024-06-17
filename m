Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98DBF194A41
	for <linux-trace-kernel@vger.kernel.org>; Mon, 17 Jun 2024 18:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718647759; cv=none; b=OcYDcCOZRBW2HyWrDkgZKm28k4eTMN/EMZTnD1iyOnXhy57BH5V1X1IGKBg/8RDeYHT/ApXXsWxU7/JrCDl7hMR9T+lfyj9GXBSSI//d6ZQH68pYk4o+WDh53/Mb7Zq4YzdIZsj9XihVOryvryaTG5893wEJnN875bYVRq7XBhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718647759; c=relaxed/simple;
	bh=jkzjDY7vnEB8DqdbcGuw7ABHpoGpOOOicO2KkYgqYYM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LgKBq0TfufooDU4qk+Z6bY+FvsFt0V2Soo5dFGN+fBejwbDR1e4D2WF69L7V3NsobMj8ZD6C91qdWhyNoDHSruWC9PrkACVlyxf/66yOE7ej4vHGbPh2X45GNMrGFVIPM3rSHRhrEo6OMX0uLIkgfrvaSifR0xZKyBNkOtIReqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=AyjlJJjM; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="AyjlJJjM"
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-24c9f91242dso1929066fac.2
        for <linux-trace-kernel@vger.kernel.org>; Mon, 17 Jun 2024 11:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1718647757; x=1719252557; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZokBvFXzTLhgVv1PaHNF9XfQX0m9YCf5c4LTRhvqEjE=;
        b=AyjlJJjMuCTss17dXusUKoTYEDWSp0HAR3ZdAeM8FocAgabfaBpc/FSzc2qUjbNUZZ
         rl9d8Vctd8As8S4n4zB9arrM05FqBknpY173AbxW1hqEiDbok8Bzyh/I65PE/Sr4wnxz
         pdv1u3ZSmMeXGyIB8u1xRMWUXXL4IHIhyb8U+BrBYNGavHlBaeANXJLt3Zd0Rt27kVt+
         viaVLxo849aD+ZWcj9S1WnPVYIkWrl1j4a0WIWAmnbY5zCPnWE94aPrWacUrLjRd1gYn
         UuTPyf9t9h3X6N9UoFRE1WJ8EgjVcQL1eVs0n2+82665i0CK+VpWpy79JKGGVAiE3XKt
         fCLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718647757; x=1719252557;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZokBvFXzTLhgVv1PaHNF9XfQX0m9YCf5c4LTRhvqEjE=;
        b=iXQ/sQB8KoqKTkpPOU1I1iQQPXubHr6/s0d+Voyvkdlkq0UQu3w7NIRMr5bV42U6yC
         us4rZEsGXPGgtyapXrk74NOalfhuFbiJbhxGcf6W2vSrOrzwTf2+soSCzUY1bhNmPN8c
         0SkiO0xSIA7EOj0Y/mTzDOeKvit8f193H9lNX9UYK4H5asv/aaXiwxOzq0PJnyyv4Bop
         CKVdPS1Kb+3B6Qd6tTK9Nn95rtagPPLJnj2hMGGsd3MmCw/ob1pCvOFBWeAuQZxKDqe3
         0//R8+UiprAFkLhvDfnL0yVun8latvKnopztp5pYh67Uv5p3G9oCQs4q/qoPdn5OxEXD
         2QBQ==
X-Forwarded-Encrypted: i=1; AJvYcCWj19d8rcy2uEhdl9gz1+iCuwU8JCBIwbI//iMSLi/E3+TsqLP3DHK/b12LUkbGqSieAPtLzTaVxKJN2RIWvDmH+giSGFervu6X26lsaX0Ta3iR
X-Gm-Message-State: AOJu0YyXNdgw79wWQ+NFBvo2w5wwqkDXRk6t643X0CyQLZwg0oeNqP54
	5r02EE9x/Qwz2Cp86kyMMChwnu14vyCy7UulR0ZCzi+4KeUPsZylBaRJTuWVTA8=
X-Google-Smtp-Source: AGHT+IFFC2G/bSVkCKnhdhy6XgDtxqeArS3o3uSF0Inup/+kbVo1ad1TRgDLl5euVpsu7c0aiEjQlw==
X-Received: by 2002:a05:6870:584:b0:254:6eb5:ab2f with SMTP id 586e51a60fabf-258428976b3mr12669126fac.6.1718647756618;
        Mon, 17 Jun 2024 11:09:16 -0700 (PDT)
Received: from debian.debian ([2a09:bac5:7a49:f9b::18e:164])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-798aaecce85sm451625885a.41.2024.06.17.11.09.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 11:09:15 -0700 (PDT)
Date: Mon, 17 Jun 2024 11:09:13 -0700
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
Subject: [PATCH net-next v5 3/7] ping: use sk_skb_reason_drop to free rx
 packets
Message-ID: <3b6f00440b880559fa3918504d85521702921e3b.1718642328.git.yan@cloudflare.com>
References: <cover.1718642328.git.yan@cloudflare.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1718642328.git.yan@cloudflare.com>

Replace kfree_skb_reason with sk_skb_reason_drop and pass the receiving
socket to the tracepoint.

Signed-off-by: Yan Zhai <yan@cloudflare.com>
---
 net/ipv4/ping.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/ping.c b/net/ipv4/ping.c
index 823306487a82..619ddc087957 100644
--- a/net/ipv4/ping.c
+++ b/net/ipv4/ping.c
@@ -946,7 +946,7 @@ static enum skb_drop_reason __ping_queue_rcv_skb(struct sock *sk,
 	pr_debug("ping_queue_rcv_skb(sk=%p,sk->num=%d,skb=%p)\n",
 		 inet_sk(sk), inet_sk(sk)->inet_num, skb);
 	if (sock_queue_rcv_skb_reason(sk, skb, &reason) < 0) {
-		kfree_skb_reason(skb, reason);
+		sk_skb_reason_drop(sk, skb, reason);
 		pr_debug("ping_queue_rcv_skb -> failed\n");
 		return reason;
 	}
-- 
2.30.2


