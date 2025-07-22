Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9EFA157A67
	for <linux-trace-kernel@vger.kernel.org>; Tue, 22 Jul 2025 06:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753166562; cv=none; b=QUx9vzfmKreWqy/vqqXdlOCkc28yGrf0REZ4PSAgHouJIQyAMrf/KkBmSd3ivAR+/ZZBYB5Lw2XEdh/uUSQyQvvA61y7IkDDKLcmuVws+LlcrIWDTwDoOud+IbpheCgb93gEy/yztPpyjsbVK5OouXnYkWUGpWftpM7GGvtW1Ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753166562; c=relaxed/simple;
	bh=NA36uYIdstJH2uG8YyMNqBz92Za5P96z2ySsI/waiio=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Asr90yu7bkvp+C86BhMK/YcbH8n332YNMh4wpvtp8ApMXJ4g+m7kwqdYgQvjz8rNHknZs/NtGGoya25KURV/dI24/4glGAE9n5nABuyL7e188EY/ATEg0vo5HkpvWwDbLyRQDZJKanA2NUUBIz/xLGDPsldXg/9CT+mPVRyASGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Mq0rGbOd; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Mq0rGbOd"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4ab9ba884c6so65412751cf.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 21 Jul 2025 23:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753166559; x=1753771359; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B6h6Sd7T3RH+CtFzxBNwU/jmY2fsZCbhu4Ru+TS9LQU=;
        b=Mq0rGbOddATFeDVt307i6mnV9+enmyRYIjBG5zBCwgcKLzZg1HkHWmOib3Hp+rNYhE
         O+uxTDhwKi2aEAzVfz1ohFJ0BpKLqkkJbhSpbojcexnPN3qxWIaddYeASJBc/Teg3exX
         hsOXJiyUaN7V7v6EWOCl3+KbsMCPykTEIL0e70lHrBfyD8xNhMWBw+wWEtzQOeJPEy1f
         vv32XBsRj9NA0JO/yMhS+4K42w5mp6Irl/73k5+8wB53bzNvw1BbnAwXWsap2ouxnQ+A
         qDXNBGKfSuXDNEAoRCHe0NeCexaHhLKM4Lcx61jOwUR6k9oiQz22vNMyULmouX17PL7R
         Q1Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753166559; x=1753771359;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B6h6Sd7T3RH+CtFzxBNwU/jmY2fsZCbhu4Ru+TS9LQU=;
        b=QlEQO8juH5q1bywLCktv+90t0vMMbLeZTHJ99WBeLqKtB3fEQqJ9CC6TrrAGwjmy/f
         VzEXIHiQ0sHVLzVbd7fX0XkQWHeb/6ekTRD1E71rmNaqw8wKV9cQj1uANE00oOIJ6mWF
         RFPB8lb7Ta+2fsmv3nvopPsDqF7qfyhybX+ltwKAAVnwlcF2fxBkm1C6nxoaqdxmjekz
         N0MHc3ZZEPQUaymKzNMCxXGWvq4SjBbniYUqk4acJL3QWhicUyJq8YKjA4ryhFV8AeCJ
         VnW4OfjSkUHN1kY1CnHgEutZdaUeCeq2FdlXQF5e/4CHkCCK+gvkhCMPN1wJE8aJ7R9h
         bJHA==
X-Forwarded-Encrypted: i=1; AJvYcCV7Tugpzsenq+DsSb+Tfi0SGJdq62OzPI6kegOY07v3wAtGfFLePUTKceK4czCO0+yJIO3AofDJCkIxtjqJ9iZTvFI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyJ+lC3BZ8yGbezBkWbdCNZgJZkDpvj1Mvcho6Zr+O/ZbU5J/d
	+5gJXi8V++5G8xmdMRvaEBsdRn86ob8hmNhegIEvUbtukt74sToD5Jlre/EToDBcFyj2xb6sjHM
	Sn4RdYy4ruAIFdoRWv6GK6k1FfpzneeNYEgvSjdU1
X-Gm-Gg: ASbGncvHwsh86SbfkX8PuEu/fizGwdFB60Hwnr6TGwb8eG0OiBT2Je7ix9vn3I9ZZf3
	tby4Uhdo4Jx+MlDJ8KwM+4nSCN8mGAni6yU+/FPopGgvhY+WD6YzsGWuY3zNErsgZVW3fHx6YNV
	ajNNuXTOEDlWnMwPz55RZSN1p7FgYOurRzWcm42O0TzCoLZWZsOT7wbMsCbry4X5T69MX6vDZAb
	eV8Tw==
X-Google-Smtp-Source: AGHT+IFE18i3ZNkbmsrw1BuD3fHiD6gRMvLpTbu/niAOFe34mLrrmfHvaIzaR08VQ8lZs6la4mlmVt+dTDNJFyAXP1Y=
X-Received: by 2002:a05:622a:4acb:b0:4ab:41a7:18da with SMTP id
 d75a77b69052e-4ae5b99f102mr36129921cf.26.1753166559335; Mon, 21 Jul 2025
 23:42:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250721111607626_BDnIJB0ywk6FghN63bor@zte.com.cn>
In-Reply-To: <20250721111607626_BDnIJB0ywk6FghN63bor@zte.com.cn>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 21 Jul 2025 23:42:27 -0700
X-Gm-Features: Ac12FXywVAz49IpEFRm5TGn9QbbuypsOmwnVNfzN6cH9wGhw3rlyrS0T17qYW08
Message-ID: <CANn89iJiLC6ZRXqJU82vsH0Lu+-o-GP_1WAK=2bcfdGmu7nKrg@mail.gmail.com>
Subject: Re: [PATCH net-next v7 RESEND] tcp: trace retransmit failures in tcp_retransmit_skb
To: fan.yu9@zte.com.cn
Cc: kuba@kernel.org, ncardwell@google.com, davem@davemloft.net, 
	dsahern@kernel.org, pabeni@redhat.com, horms@kernel.org, kuniyu@google.com, 
	rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, yang.yang29@zte.com.cn, 
	xu.xin16@zte.com.cn, tu.qiang35@zte.com.cn, jiang.kun2@zte.com.cn, 
	qiu.yutan@zte.com.cn, wang.yaxin@zte.com.cn, he.peilin@zte.com.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 20, 2025 at 8:16=E2=80=AFPM <fan.yu9@zte.com.cn> wrote:
>
> From: Fan Yu <fan.yu9@zte.com.cn>
>
> Background
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> When TCP retransmits a packet due to missing ACKs, the
> retransmission may fail for various reasons (e.g., packets
> stuck in driver queues, receiver zero windows, or routing issues).
>
> The original tcp_retransmit_skb tracepoint:
>
>   'commit e086101b150a ("tcp: add a tracepoint for tcp retransmission")'
>
> lacks visibility into these failure causes, making production
> diagnostics difficult.
>
>

> Suggested-by: Jakub Kicinski <kuba@kernel.org>
> Suggested-by: Eric Dumazet <edumazet@google.com>
> Co-developed-by: xu xin <xu.xin16@zte.com.cn>
> Signed-off-by: xu xin <xu.xin16@zte.com.cn>
> Signed-off-by: Fan Yu <fan.yu9@zte.com.cn>
> Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

Please do not add a Suggested-by tag when the original idea did not
come from someone else.

I only made suggestions to make your patch better.

Reviewed-by: Eric Dumazet <edumazet@google.com>
