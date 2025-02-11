Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9FA42206A2
	for <linux-trace-kernel@vger.kernel.org>; Tue, 11 Feb 2025 15:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739287209; cv=none; b=YoqcL02O5Wcc/jQTEG4xb+KIdO20gyRWZahQuR30DbqWe8dkHCOX3itVPJ62s5kqpYV3CIQErWzpLZcM2MVTPdG7YPIJcD0isqUXIUbjkbArbNycWFpRIaa8MhQlKOHEcn0fNDZzTeM0QhAC8fuL45kovU8RoLok5XGeSuWA05w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739287209; c=relaxed/simple;
	bh=TzaJxWcJKmUY5Ga5qo61EJCKNiAgvtpHLBzwKKn2UgY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sF1es/rBTkw/tIfAB0kdFxfHz3X/paWX3x3Y3CvnKKa54GyXiBcwW//9qovZY6ZDh4KQRCiCOGcocUCpBga3JSvRNKhQ/Kb8AZn3EZqjK4PO7idLHe0S7Q9Y4Bg0LFvNWwC3lk16oZVBBiixYYFoeVgv5tlhXBPCHh7HuwIrR1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pF+h16jW; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pF+h16jW"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5de6e26d4e4so5479209a12.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 11 Feb 2025 07:20:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739287206; x=1739892006; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TzaJxWcJKmUY5Ga5qo61EJCKNiAgvtpHLBzwKKn2UgY=;
        b=pF+h16jW7YgkccUVcLT2I+P10VVDUdyknUqP5DbXSsIl3jcR3YytOScD4xBmlnQOiy
         KeDLEGNZBvbaYlhl4vG835IDcODpILJ7kfQwfGHE2AdudXwMEfcQdVuFlUlCgH+E79cf
         lNQokdygOSmz0TD/KB+PH1xybcZ0vU3h+XonOCpy5eReO99TH6GDQG0qsXMscUMD0vl+
         avaBvCMknrrhhF02ZmwuWXVBIwM6CgoSPyjkbzZxoU74AVx6GTzfgkv8vVR27JXYsy3s
         yPUvLRUTr24BN30Q+mLho34krU6hCed+6KIDHNwZi1lY4G4daNUXbOlZ3VsjJRsgUqtT
         rAnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739287206; x=1739892006;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TzaJxWcJKmUY5Ga5qo61EJCKNiAgvtpHLBzwKKn2UgY=;
        b=YurO73e9Kglr1FR+W+dd/ppQ4KixEnwarU5CuzLWHcWyStZ+Tk9Kv5dooaZJwImX1/
         RMseb6jzrGVH1eapf/RcyBQIGV/JO7kdK5XvCz9r5QaEUrp5C03+DTqu1FnUsx1wn76u
         3w349a3Eyg20nA/HVTT3luGgih4jmJYuk1Vsfh1ocOYZaSjDXh2QsJGOmsyqmalc+uGS
         6xC82DVBBpXmkpozl408h6K7cpM+7MP35H0vt0sJWqM0lHeOw6FTNg1mR7Jv5To19He8
         St3M7sRFehVyD4lff6yPEwmrAnjSqQV5AgbTACNclG5d5wlHNKbjviubLNI8cU76ySAF
         uWZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUy2kjjpVbE5RgCR69t6+DhhLBsbOSUtLMTr9zqHy9LPGX6nQPWXbi9j+LvT895JCY3Ca+xHo2H3fGqp69vQMH0n78=@vger.kernel.org
X-Gm-Message-State: AOJu0YyX4bJIlVVRai8lSjXpzs1MvPbJBQ7gGKcfL4j9tlcknkjGCFPO
	/inllIuVp9CdKTcexwGf+d6RP49rNpw7GoVz0d2RqdfX87QaLEXwrV5xqVQsZ0jOf9VzQ9bAoCL
	izAPyT/cXqIovNHZlRTMjFDQ/NPso9U91yJ9i
X-Gm-Gg: ASbGnctLSzLOFJ/m0GeUpHSRL+ycjHPIRlKWPEWKqAKWZq0LkWLS/XCAvJvfljvDGHJ
	4W6xZPTXsJ3NZTZWA7l6ZOrJtLtRcnjKCGUmaJp5+zCwzeKR6rmSQ1Xno0Iy4iK74rU3TdHtLgg
	==
X-Google-Smtp-Source: AGHT+IEth4owsN2cD9rohcAARjd/9382+dkUD7t78PWGv1IE2yUnn9CnXi53JmFCuYO1txkt65Y7e8lsH/5TjgHniUg=
X-Received: by 2002:a05:6402:1e91:b0:5d0:81af:4a43 with SMTP id
 4fb4d7f45d1cf-5de44e5f276mr21275900a12.0.1739287205956; Tue, 11 Feb 2025
 07:20:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250207-cwnd_tracepoint-v1-1-13650f3ca96d@debian.org>
In-Reply-To: <20250207-cwnd_tracepoint-v1-1-13650f3ca96d@debian.org>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 11 Feb 2025 16:19:54 +0100
X-Gm-Features: AWEUYZmNEvQX4IUPNwHy7Y7XlqImzph57mMR2FKZX52SNCst07ZlNJorvgmWpUA
Message-ID: <CANn89iLMK5B-9LQtga2HEnEs3rS=ta6eOcxxXB2gCkYYApLM4w@mail.gmail.com>
Subject: Re: [PATCH net-next] trace: tcp: Add tracepoint for tcp_cwnd_reduction()
To: Breno Leitao <leitao@debian.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, "David S. Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 7, 2025 at 7:04=E2=80=AFPM Breno Leitao <leitao@debian.org> wro=
te:
>
> Add a lightweight tracepoint to monitor TCP congestion window
> adjustments via tcp_cwnd_reduction(). This tracepoint enables tracking
> of:
> - TCP window size fluctuations
> - Active socket behavior
> - Congestion window reduction events
>
> Meta has been using BPF programs to monitor this function for years.
> Adding a proper tracepoint provides a stable API for all users who need
> to monitor TCP congestion window behavior.
>
> Use DECLARE_TRACE instead of TRACE_EVENT to avoid creating trace event
> infrastructure and exporting to tracefs, keeping the implementation
> minimal. (Thanks Steven Rostedt)
>
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---

I can give my +2 on this patch, although I have no way of testing it.

I will trust Steven on this :)

Reviewed-by: Eric Dumazet <edumazet@google.com>
