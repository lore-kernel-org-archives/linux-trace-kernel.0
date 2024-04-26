Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B3A213AD33
	for <linux-trace-kernel@vger.kernel.org>; Fri, 26 Apr 2024 07:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714115404; cv=none; b=qB26jWq8OuSA8dHVRpGZwTeoGxxssj88A5ZPKfMobHn+aw0AV+vH4UkdtIHgonL1EPPDXvxi8r6w2If6thLXSwLut3/cSiaoY+4+yxha6yCH+9ZN4CSsJuWdHUxhth1rgNp8zBCZgVDK4xeWpQ6yUj7dkOmYWy3m7OLdseCosKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714115404; c=relaxed/simple;
	bh=p61/qeqHYLy5frKEp02v40mvBebGAAq99s5Dtut/6mA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u0whJatkKYh4FdR6Si1oBr5dGCH/ry7GpJ21WX4CeJfuTTa1AfJYXJigg1HlbZ4f06JqgYD+9b+o1h7dV0g72E67ZTNiKxAQNanTwWxTt1MkNMmMRNmY45vc5NmxdR1tsVI4wnDjTSpZepglHPvJurScfMkYpHXaT4ctOXbK9Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oa5yA3XN; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oa5yA3XN"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5724736770cso4958a12.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 26 Apr 2024 00:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714115401; x=1714720201; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p61/qeqHYLy5frKEp02v40mvBebGAAq99s5Dtut/6mA=;
        b=oa5yA3XNGEA7/sp6v1ZzotNVaGdxYHzAPJzWY5OpKCQY14XYljYQ5c7TXHJaR0eQBa
         UsVv0v2t9JIGbcIfxyH+UaJrt7R3H4WzQ8cobxVkA+3yNeI1/QbMbu1Kjojwg8lGYrT4
         u+ip1l2VPztZC1rjyC/n3ylajs2+xu+w7bjTrVajuFYkNwPQqjw3XqyBqUxImG1hMGTR
         FZ/ptVr/+ZUzi/yW43m8CNtTOjJ2qwmtD4aAgM8SD9l0G2a7ktU/rUaw9yDNAALTiDcq
         va5kddr4+8EdNLhij1Qwyw+HzgnZTI7lPK9sPmYzEFbBF88+JBCIZCCbpOVEKjDBcG6I
         u0PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714115401; x=1714720201;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p61/qeqHYLy5frKEp02v40mvBebGAAq99s5Dtut/6mA=;
        b=PvMV4IMod7who6yJLU3GkZm7ukPzJWqE5SvRhKzzDC0m+lJRvDhG7RjScjTe0EtWIL
         gI+jyAeU9coUp/UYWbdTmPqzFSLsjt3ZkLAE7AzaEgU/PWzwIZPQhqe1oeG1SSmG5suA
         BhkjXaRwHGfhiEy2UJRaGXsC4Tl+vz660aLi3TgNnIC3YmIo6TapmDLT3to4/wt+eoAN
         dV1IX/zfsZmjrBg3T5lmyTJKF6qm74GYSnFxEgWX8cZ7gZSvn6OCyQ3DsSAj+a0wB2jE
         TVoqOVXvh4kE4+rh38K5Dh1iWY8aznvycFso2wJLalsdKhzBiRTPzWrad5qnrSPAUHyP
         TYnw==
X-Forwarded-Encrypted: i=1; AJvYcCWn1JCdTMLfs5IAlW7yEtvQQzy4bV1ACcM5L8UR4IqLMB6sCsunm03rTGdZ4lMeW/wRsYwzLfU1y/QadwxOGpwOylErkkMWQaFDv6mdzaagAvEL
X-Gm-Message-State: AOJu0YzcGoS4BlTN6jFEc4UAVxoPOhRrRY5fPdvaYi3i9Y3T4mSTyYwJ
	TEv1IYtq1/xPs80asncPeMdQrW0+UPCSCqeCZqbMXytFwiSXk1K35EY5QZgzTZkQNRMKK90H8+r
	Oq56psWi9IwbPjkBNShVL4Q2XGhTsEmpzEvdV
X-Google-Smtp-Source: AGHT+IHuNHcmCc7KkZwueD0UdUaftzjxD3dk9jc98IZkb4WuQLZFgdRK+7VjwnLqz6wusyhUrr1e/xc5Q7Ih/J9/ANA=
X-Received: by 2002:a05:6402:c6:b0:571:fee3:594c with SMTP id
 i6-20020a05640200c600b00571fee3594cmr83432edu.4.1714115400548; Fri, 26 Apr
 2024 00:10:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240425031340.46946-1-kerneljasonxing@gmail.com> <20240425031340.46946-2-kerneljasonxing@gmail.com>
In-Reply-To: <20240425031340.46946-2-kerneljasonxing@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 26 Apr 2024 09:09:46 +0200
Message-ID: <CANn89iJywTXfRdGLi1oMPwz4dVYbA5TewZC8-GiG=b7dNv9FOg@mail.gmail.com>
Subject: Re: [PATCH net-next v9 1/7] net: introduce rstreason to detect why
 the RST is sent
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: dsahern@kernel.org, matttbe@kernel.org, martineau@kernel.org, 
	geliang@kernel.org, kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net, 
	rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	atenart@kernel.org, horms@kernel.org, mptcp@lists.linux.dev, 
	netdev@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 25, 2024 at 5:13=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> From: Jason Xing <kernelxing@tencent.com>
>
> Add a new standalone file for the easy future extension to support
> both active reset and passive reset in the TCP/DCCP/MPTCP protocols.
>
> This patch only does the preparations for reset reason mechanism,
> nothing else changes.
>
> The reset reasons are divided into three parts:
> 1) reuse drop reasons for passive reset in TCP
> 2) our own independent reasons which aren't relying on other reasons at a=
ll
> 3) reuse MP_TCPRST option for MPTCP
>
> The benefits of a standalone reset reason are listed here:
> 1) it can cover more than one case, such as reset reasons in MPTCP,
> active reset reasons.
> 2) people can easily/fastly understand and maintain this mechanism.
> 3) we get unified format of output with prefix stripped.
> 4) more new reset reasons are on the way
> ...
>
> I will implement the basic codes of active/passive reset reason in
> those three protocols, which are not complete for this moment. For
> passive reset part in TCP, I only introduce the NO_SOCKET common case
> which could be set as an example.
>
> After this series applied, it will have the ability to open a new
> gate to let other people contribute more reasons into it :)
>
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> Acked-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

Reviewed-by: Eric Dumazet <edumazet@google.com>
