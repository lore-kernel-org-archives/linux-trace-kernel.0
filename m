Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4798B13AA4C
	for <linux-trace-kernel@vger.kernel.org>; Thu,  6 Jun 2024 08:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717662044; cv=none; b=iu8t9egB+8DJOeTioduP1n5DmnapCbCDPNuBXua6Hm8kjtgo/EQ5MR86Q+K+MdwcnMHebwp/0gZ3eczx9wJw2IcdPICeX60kHkR8sxmhESTn9qu2dhRlXsz7wwsL8gMq+uEkLqzvxWV7USRTosTfd28GjB6GtNa4UEwXAxo2F+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717662044; c=relaxed/simple;
	bh=6kI2cdJDpABdMGmQl+txxxVa/ZELbED2IxOHszzsEmk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mz6lvxv5o+U7BMk3pn2/xxwANcevKhgqo5loyMazrxzYDpZnRFjT1FMQg0W/93xgw0cLlsstR3V5nDPs6HJr+F8TjRbN41kJsgtCNBGgjxUX8ZM3fPWTqrPESet7bgwkkk7wNnCRYCzH7ir1Q1vNo1uRkybbGZ9nt9SOBjwmcmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jXV68gK7; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jXV68gK7"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-57a1b122718so5658a12.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 06 Jun 2024 01:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717662041; x=1718266841; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6kI2cdJDpABdMGmQl+txxxVa/ZELbED2IxOHszzsEmk=;
        b=jXV68gK7mMgwgKeDRkbFu4NrxkaoE7Z4gZftN61kf3C+fVCUIaoNT6xHzbLI3gtk3G
         TUAY6hU2wBrMJmIATLrwJNTxRIGr5yB8wdc5jZPu2WYfGlt64EaC26a3nD4/WWe4AQ9A
         unfU1xIx4qo0+CY8svDtwE8JBh5YT56kKBhkaTuldEWroTeWn2RSb1aH1RWZjGnnVkex
         qFQeEknBkbjX2Nv8ccA2ZvTGhpWKUCcBggefw4bjhBkgcpowEwhrgMfPKZC5cJQ49QiQ
         2o+gS0ANXatvAMOYO1/6Q2+/YJdEZ9U0GmlTin9M81P2XSgaqn9KK+PwbKi6EtKQB5dS
         2Fdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717662041; x=1718266841;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6kI2cdJDpABdMGmQl+txxxVa/ZELbED2IxOHszzsEmk=;
        b=MDnzrJi050GGCaIF7nObhHoOsjbj8+6wRDe7ovS2FGJ8WjHp+WdqQM9dIUhAa8K3Yh
         09lfymYIcP/ULNO8YRSXs9o6cyvO2almEfHn29xgCHekluUhAcYJGHSBVpHm35kHbu7q
         brcdL1EshdSyp56d/u+q25UBmPMWW1wL9WPU5QlaJBhkFZJ38TYMgRbPRfVq13OfAC2c
         54+83lztPOjjjevFk4+u7Wf563EOlQbye/sXi1HH7Mxvr1jqKszeairVFjKMG5l2m1g/
         /lryz8gb91i8gws1QMdJev/s4iwbbNPJSRJPI9632nhA5ZohHQXNFpD4jNMx4btkzwgC
         2n1w==
X-Forwarded-Encrypted: i=1; AJvYcCUSgXNtxO0JgfmrP2UMonDC2Yp0alwX0ZkUu3LVZ+7thKggKaPvGvqxvSYZGqR4nlcxCAMG38GWQxoY/ZAh3R1a94mAu6vXNFE5jf7PCvR8Lx52
X-Gm-Message-State: AOJu0YxeMuMPslToEVn++mtVkOMwRy8mdT+Wux87/xK9+xeh4xJXXWjv
	yDjcNfQnyKSyI9nqRFPX/elPave/EbLRtSlj9NKNbRKFWwAI5AfiuLHA1sLHeDL5OeDNSAr0Rm1
	JFOORzYpFm9cfLvg1qVb66+Qjjz7Y6gqwpTRr
X-Google-Smtp-Source: AGHT+IFE9WmSo5OTxuoBZojQvoBTfkJrcVh029teBW5Jl+55BD7o3it5tXbtjBD7DlrKr7HlCiB/oFVBH9UKsTRUNSs=
X-Received: by 2002:a05:6402:180e:b0:57a:9ea1:f92a with SMTP id
 4fb4d7f45d1cf-57aad34e850mr99420a12.7.1717662039210; Thu, 06 Jun 2024
 01:20:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240606-tcp_ao-tracepoints-v3-0-13621988c09f@gmail.com> <20240606-tcp_ao-tracepoints-v3-2-13621988c09f@gmail.com>
In-Reply-To: <20240606-tcp_ao-tracepoints-v3-2-13621988c09f@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 6 Jun 2024 10:20:24 +0200
Message-ID: <CANn89i+D1mXLvTvQe+2ggdm_HZiMQcRP4+Tm0Cgo++oyd=zm3w@mail.gmail.com>
Subject: Re: [PATCH net-next v3 2/6] net/tcp: Add a helper tcp_ao_hdr_maclen()
To: 0x7f454c46@gmail.com
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Jonathan Corbet <corbet@lwn.net>, 
	Mohammad Nassiri <mnassiri@ciena.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 6, 2024 at 2:58=E2=80=AFAM Dmitry Safonov via B4 Relay
<devnull+0x7f454c46.gmail.com@kernel.org> wrote:
>
> From: Dmitry Safonov <0x7f454c46@gmail.com>
>
> It's going to be used more in TCP-AO tracepoints.
>
> Signed-off-by: Dmitry Safonov <0x7f454c46@gmail.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>
