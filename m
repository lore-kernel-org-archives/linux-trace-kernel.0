Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00B231E5704
	for <linux-trace-kernel@vger.kernel.org>; Wed,  9 Oct 2024 15:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728489191; cv=none; b=Nrvrxm0qLZDo8xL/gEZp8pbbY7PaVsi4uetwHPTSHqIZ2uSBUZgpBLm5vW3eFsnJA6AU7W4Zr/gyDqcukbynojL1juJMkBp0qpngNQmzd448P2isU/9EYLBSvQ5LSYJzhPX2ESDS1BgXv+ryQIjFoYS7vbCZDlkMtddMDrSkYMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728489191; c=relaxed/simple;
	bh=qY3+Z+3Bq6ZOCLy/wmsIjJJC3n70MViMpYQ5o+VGqBU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lc7UUVX/1M9dhoirt2CubNZ86LaEqLBm8gJ2MIn3CaDFCu3qUoSXaElp+rHmSEurdFGCahQ2S1Gi66kpOd7HQPBdvEbjxvh9/AfFZlJaor3fw7G56lpOpU0PMY0qISmrVxsle3K/rHFukEL+zDtl95gBaUDmy/cBiEDvDfAd6lU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FEjdEXiZ; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FEjdEXiZ"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5c8967dd2c7so8652894a12.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 09 Oct 2024 08:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728489187; x=1729093987; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qY3+Z+3Bq6ZOCLy/wmsIjJJC3n70MViMpYQ5o+VGqBU=;
        b=FEjdEXiZVKFh5ePrG+OLjHRd9heDbh9wOtMVIWoM3fr3aNs3b839XsmlCR7lzfSODO
         b3Z6sq9FNLjTt1GFSGf4MRu4Hm8T7z/CvqyJhtfszd7QSPgFoYdEWMoca9QN4Dg0nu+M
         ozaV2FA2IV2yhDXWsTdjuhIoKNPvIpcJkN3sjBXFaBzvv+eHfBqyK6VUv37yfrOIzopz
         Mu8kzkw0TxQvzNyWZmLI37DRurqvMaavKxG4OkJXHOH7U3mMYsqZLitHDzy+Ia+TS08w
         ZxUtjBe6mRi6yKtajsAUz1vuNCuCxqt8NLUX84sSfuC6X8e0PjEGu28tU8pp/HekL5VV
         NwnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728489187; x=1729093987;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qY3+Z+3Bq6ZOCLy/wmsIjJJC3n70MViMpYQ5o+VGqBU=;
        b=ldLJPRXfOq0FlUYUAPpSvvR9I1R46XdysDw7UdiYhIHJ7Xnl9t20JzFGPBF4p0YeFB
         IepHWKCcXw2ueXThnd9HOfmtuQG+5lXHpxPAZG+JD0pfANdflyWwDDwYJdwE4kdjIvr0
         /+84AkNL8JymU4S+oWr7CgCUAzSLL4fPvABqHhXfOzyyAvmNAXY1vhew+t/8zBQEl2dY
         zjKzY7BP3m+qxnhmUlAcz7AXjQc52hL1/9xj8KhUKq30zqHgO6B9BEDp+Anb9C6qTutf
         9C3QEXOBhBaMntgcyNnz8AIQn2jhUosX4Ygo6vcSmrLghkqUcamMdzEINkcnDEUoYEjj
         L8dA==
X-Forwarded-Encrypted: i=1; AJvYcCUpWN7c7/ReoHA2fRRRHKMAviPJg4fK2LgrEVAxCqiwNSOCNDzRM5P0zzPVqOReEEppuh6jtG/X8GhVUvRtmoIh6rI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVnLRetN2EdCLA2NLseJ2/6rnA9gMH1pc/fmF4auhlG9ZpOHB2
	v3yiEYUoOx2JZ/x3auVXXmpelqf9NVMPoDwmXuAMpL5hqfli7UVPYINyouVhxl9fFZITVnaS/3p
	0EbPRjkiV+oa1JA9TcC9dRceWQGe3h/rZlUzs
X-Google-Smtp-Source: AGHT+IEQV7nAbPoM6W+RrSQoV1u726+qXXT1p852mGQFg9Gw4itkSxdL7eXhWxwSO/6myLTg4/DgHQkXtgpF3yoCFr4=
X-Received: by 2002:a05:6402:4414:b0:5c8:84b2:6ddc with SMTP id
 4fb4d7f45d1cf-5c91d68c9c1mr2454867a12.33.1728489187004; Wed, 09 Oct 2024
 08:53:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241009121705.850222-1-dongml2@chinatelecom.cn>
In-Reply-To: <20241009121705.850222-1-dongml2@chinatelecom.cn>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 9 Oct 2024 17:52:55 +0200
Message-ID: <CANn89iLKVh0_wkgZ-a2+Dr9xz6wOs58CE8PpwzZEH8ZHMn=jsA@mail.gmail.com>
Subject: Re: [PATCH net-next] net: tcp: add tracepoint skb_latency for latency monitor
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: kuba@kernel.org, davem@davemloft.net, pabeni@redhat.com, 
	rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	dsahern@kernel.org, yan@cloudflare.com, dongml2@chinatelecom.cn, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 9, 2024 at 2:17=E2=80=AFPM Menglong Dong <menglong8.dong@gmail.=
com> wrote:
>
> In this commit, we introduce a new tracepoint "skb_latency", which is
> used to trace the latency on sending or receiving packet. For now, only
> TCP is supported. Maybe we should call it "tcp_latency"?
>
> There are 6 stages are introduced in this commit to trace the networking
> latency.
>
> The existing SO_TIMESTAMPING and MSG_TSTAMP_* can obtain the timestamping
> of sending and receiving packet, but it's not convenient.
>
> First, most applications didn't use this function when implement, and we
> can't make them implement it right now when networking latency happens.
>
> Second, it's inefficient, as it need to get the timestamping from the
> error queue with syscalls.
>
> Third, the timestamping it offers is not enough to analyse the latency
> on sending or receiving packet.
>
> As for me, the main usage of this tracepoint is to be hooked by my BPF
> program, and do some filter, and capture the latency that I interested
> in.
>
> Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> ---

Big NACK from my side.

Adding tcp_mstamp_refresh() all over the place is not what I call 'tracing'=
.
