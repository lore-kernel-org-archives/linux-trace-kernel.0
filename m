Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 401563D3B8
	for <linux-trace-kernel@vger.kernel.org>; Fri, 29 Mar 2024 09:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711703596; cv=none; b=O5tVOW7XRmVglYQCa1X2nOXr3f4zo6rU3ZCRcFpl3eTfmPyH3SZMfdiHVCSfxxuIrIc+FDWcpp5xAxLSsJEVBeTcD5PxsAp1H2LaDwhyxGfZoERt10iTeO2aiGTJhV+iseSl+MGEaonsHFfgk6U5IG9oEQ3AGltaEADaU8Il12Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711703596; c=relaxed/simple;
	bh=1zERkjtrtlC581CcROudIVVXpAA03k89ji5eS+5BuYo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GDSJ+x9e6BWc9R3zhU7xnxBaDf+Tw5/Y2DSaEtPa/A96e2QCZfzTo45B31V+5TxfMQP6KiYol0+GHbUmdZcuC0ZqMLccb2z5XlbY5W79nIrKRxxrA5lVVhj+/sPAAznG7GFRQGgjdSZFFqXBN8eJ3W4GTfQTsw4qerqZp5oWxb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KkPja7bJ; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KkPja7bJ"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-56c63f4a468so4011a12.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 29 Mar 2024 02:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711703593; x=1712308393; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VC/2DNYfpXPCFDeLwAU/UqglY0mCl+CZh+iTkFzj+Zw=;
        b=KkPja7bJsAG8stMGYJvce/yJ2ERbGd7/tikfhxIgHm2DkHD7w3lNMKhS+KBNfPqukk
         IAr7f0mSuCmeB96K2xfE9YJpbLpV14CeE8MKHzwtEN8onG+5mc0TZWMIRdDhfeLSzbMF
         ulmXak9u54Q9HHZElU9B/9OW0M+7vbmbsTQ3kxlDPaie9lRyFI3iTwtOxqb/dtDowf0V
         7vS9CwAb/+aCT2hQH5w7YVEqUIrvweJMAcSTq+Y9MRQN6jIz2DDmo/VRr0UIzPFnkqly
         4A1RFM9WR3nnvJQUQ55VRGeu6IbSCqGviwK29XacY4VVQ+3Ab3t1RJ1d+gMGndYDs2aD
         E6Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711703593; x=1712308393;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VC/2DNYfpXPCFDeLwAU/UqglY0mCl+CZh+iTkFzj+Zw=;
        b=lpTwrh+KYV9SpyUwlJXPCargp06dGeGFy09sd5MX/Sq+DjtF66P+UsGnZJsaUNSGKa
         ZPLifw9tqR6818r1M49yFd23Lq3ZmSGjL5JcIyLuhQUCbtnZhK1oQoqdv+DPrLADtdsU
         PeuZwwa3WP6wYyffw/fQrP3Xuj7lFw+GHiiGORm0XnYwRNgHTPKrxUubcCCuY682OdtP
         khFRC0IqI6OvlVfTRcPWDxddPJjVz9dUDPgIqYcFPRj6u8ZkHmxWCGwvFeB/1M+YvuIC
         RXba5pk3XpikjsxvqNYfSPTPZ9ZvHjBP+JFnR6tUFI04/Oib8scgiTWKCuU4LLDglIhB
         wuBw==
X-Forwarded-Encrypted: i=1; AJvYcCVOF6TrmJ23qOwPvhzLMkDzQi45biW79pQnDUiGy1jSU3VIgWFU1+echVBhwjK4Rnp7DmKyUxP+HZunP6kyTv5K+S4KBXzceNailEVGpBzPcgNa
X-Gm-Message-State: AOJu0YyJt/a3JDuCPnKBCZiBJ/SGMGoSLCNhTFqLoDAAe04x4c9U+LdB
	X8hGFneDgcjgvSU4ob0F2AjPjnOojD2JjmYSmi8R5XjzYQ3nVXdNLJHvw8K3zaYBa8sjx59AO1u
	DojXd8t9HVdyIzLGn9kfiagLgBZE4JMuFJ9Y2
X-Google-Smtp-Source: AGHT+IFlPhyvUlzfE7rTjsKrKisU2QouFz5YiSOmxPdDEKV0jtaMbzUzboFdcxhgTOLzWZAGDEUUIxfEqGpgqQOhzJQ=
X-Received: by 2002:aa7:d784:0:b0:56c:cd5:6e42 with SMTP id
 s4-20020aa7d784000000b0056c0cd56e42mr136121edq.6.1711703593362; Fri, 29 Mar
 2024 02:13:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240329034243.7929-1-kerneljasonxing@gmail.com> <20240329034243.7929-4-kerneljasonxing@gmail.com>
In-Reply-To: <20240329034243.7929-4-kerneljasonxing@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 29 Mar 2024 10:13:02 +0100
Message-ID: <CANn89iJw8x-LqgsWOeJQQvgVg6DnL5aBRLi10QN2WBdr+X4k=w@mail.gmail.com>
Subject: Re: [PATCH net-next v3 3/3] tcp: add location into reset trace process
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com, rostedt@goodmis.org, 
	kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net, 
	netdev@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 29, 2024 at 4:43=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> From: Jason Xing <kernelxing@tencent.com>
>
> In addition to knowing the 4-tuple of the flow which generates RST,
> the reason why it does so is very important because we have some
> cases where the RST should be sent and have no clue which one
> exactly.
>
> Adding location of reset process can help us more, like what
> trace_kfree_skb does.

Well, I would prefer a drop_reason here, even if there is no 'dropped' pack=
et.

This would be more stable than something based on function names that
could be changed.

tracepoints do not have to get ugly, we can easily get stack traces if need=
ed.

perf record -a -g  -e tcp:tcp_send_reset ...
