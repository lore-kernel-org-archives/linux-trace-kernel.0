Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D34E913B798
	for <linux-trace-kernel@vger.kernel.org>; Fri, 26 Apr 2024 07:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714115563; cv=none; b=uu/iTd3cchFIRSBFvtMPKEjIwXwIlO66xZ7CAX+xyOxYNJjnX7h3XakA9TyKunvmm88MSnn7LdcKXhpANzF7VcEv9+3VOHtjsibWkGhIXu4W5q2BsssvXN8wX7bDgiju0mnrV3BKiDChxNO5QE9hYAJ0Jc7LHmFpoMx+pOLYsks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714115563; c=relaxed/simple;
	bh=4seAV79ridn4oK7nRaqYqUH8RKW5l/spsnmRvibRiNs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rzLf6eXaF5UZ+FQnZePp2ltd1axmEtyRHQlMZdObBoJ6tW+SQc7gYsnkMjPnbvHi66f0MgIREdqDJneqR2R3a3KKqP1SL/Yzcbykn4YwYawtMzJjlS3wA3WMCz6OZqYU0ldoCPt1uJy2qkPwM3O8V57C2HtfgVrlEgO5a2PoozM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GI+gF8vv; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GI+gF8vv"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-571e13cd856so9079a12.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 26 Apr 2024 00:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714115559; x=1714720359; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4seAV79ridn4oK7nRaqYqUH8RKW5l/spsnmRvibRiNs=;
        b=GI+gF8vv/xhzBvU7ySvStn6LV0WkJml2LcVgOsLWDd6W/rxZEGYLnbAvC1cuuDHRrJ
         wtcSGZg00sW/HPnlc5xUsdMfsWYCGw9p+Q0nyw0uvQLUlDfkys64cbgoe02DH4yiRmij
         YFnnI365rem5AC3FVB26+APkkhLPqtWwCGHuNWwGt/oHCiiIkPjsXwtuZABPcG9t/Vkf
         QoDF/v+m/dxbdyY/sMAzi7e+pNckBGh3MCICvxiW1itTMw9a/J8Mc3lksHWlkhiFvgul
         M9C8znWyndq0jng6YTWaUv2P4oKLroHOsmezaxDDQ/lmWmUqbBtOxoNww2byOy4Rod0p
         ditg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714115559; x=1714720359;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4seAV79ridn4oK7nRaqYqUH8RKW5l/spsnmRvibRiNs=;
        b=UWUgBxRNJHrfoxQD8yRirH4+/T6Fz7x9ObReVQWfb/g7NkhuvMUzD/UzVwNLb6CUo+
         64DjiOzwvWk4U/uCpgXTdhL6c7ENpI+cZQlkWM+GW6Wl0QOv5ocFTwnOH58APpsvFsRL
         wq+4upatxU9m641QizxRrGgz1AJMVbWMi/L0Ze3EhCG0iNoqrdZcVWVDmavrCHH8ULjv
         xSvbv941oeimE8aWv/X0bj3AJT0WsA411ucfo2l95XBS5/ApHGeDMdbygmygSjjMRTG7
         OT1FnhAvLAB2jfm2Xqp4xYAVZUOUp61Si2uLppfkXlZUggpmFLkMl8YddjJszuluYKvc
         2QUw==
X-Forwarded-Encrypted: i=1; AJvYcCW6mn9pmbelArg1lub/EwWgnntTtyeAm5bxlzG3DbMRe2xZde1KGKUDwTEHA6e3lsmDTTOWhgDmCHYqLGEPlRZw2WT0TMgGuhxb1qbSwygIkxRX
X-Gm-Message-State: AOJu0Yw3zILnZqjzuZXAG6YpihbbJhXUWJAcKP85wjRiIYRTkAJ1gqaj
	EpNdX1BmC/gcSqRlDJyFLeuZJPhK+QfA90v3xalfuaegCwjRRRVOxibs6LswY6kfAGJN6jmZJ0C
	b8QybeqSDQLt8KVcZVpjcidhEWpOAaxdhAoZk
X-Google-Smtp-Source: AGHT+IExI6r1PzLpwM+kdZrqejtoIV/lrdCRc9hPnUboYdDZk61WahQ3oh9IdCqM9A4jm4HWv8p1C4wk/G0gLyWVjh0=
X-Received: by 2002:a05:6402:26cc:b0:572:57d8:4516 with SMTP id
 x12-20020a05640226cc00b0057257d84516mr44282edd.2.1714115558737; Fri, 26 Apr
 2024 00:12:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240425031340.46946-1-kerneljasonxing@gmail.com> <20240425031340.46946-8-kerneljasonxing@gmail.com>
In-Reply-To: <20240425031340.46946-8-kerneljasonxing@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 26 Apr 2024 09:12:27 +0200
Message-ID: <CANn89i+oyLS8goc0oVEpDW+PR35q+BcSph0s31q3Lj-RwSRFVQ@mail.gmail.com>
Subject: Re: [PATCH net-next v9 7/7] rstreason: make it work in trace world
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: dsahern@kernel.org, matttbe@kernel.org, martineau@kernel.org, 
	geliang@kernel.org, kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net, 
	rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	atenart@kernel.org, horms@kernel.org, mptcp@lists.linux.dev, 
	netdev@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 25, 2024 at 5:14=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> From: Jason Xing <kernelxing@tencent.com>
>
> At last, we should let it work by introducing this reset reason in
> trace world.
>
> One of the possible expected outputs is:
> ... tcp_send_reset: skbaddr=3Dxxx skaddr=3Dxxx src=3Dxxx dest=3Dxxx
> state=3DTCP_ESTABLISHED reason=3DNOT_SPECIFIED
>
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---

Reviewed-by: Eric Dumazet <edumazet@google.com>
