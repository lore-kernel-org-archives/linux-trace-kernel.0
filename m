Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DDFD1947D
	for <linux-trace-kernel@vger.kernel.org>; Sat, 24 Feb 2024 09:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708767078; cv=none; b=LuuPonqMA2kroTDi8VtZ/fVICURFfR3+tjE1OhWMNCoKYgMcrENbz/Hj1DhnRBBUCYSKQqkD54Xm2zNY1SPIRygGEUqG9NWEdLfl6cShh22t4iPdghg59neH6CHXxYxDVy7aY7ZeXVFeBf/ULY19D5TPFXeiEiRCNyYCREJ7QTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708767078; c=relaxed/simple;
	bh=y2+xsbNA7nJA5AJAIiiYtBIFp5DHt0sr/WcAwRB23LY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l39uawZLOTRiQcuFSzjzAX+uyu6c75aujOjVF39jZ+6wHkp5M7Q/6Hx/Dvd0KiWsbTQ02xCfHOJ23eEPlM8TZQHti/e2LVG3i+C6Hsp/sa0OGCdENuAdB/jasJRfQIcUMhdo1JCyMEaBjoRObW2BnIq8jEUagGkJfEVP8LkQfhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=y/e4ofWD; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="y/e4ofWD"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5650c27e352so6313a12.0
        for <linux-trace-kernel@vger.kernel.org>; Sat, 24 Feb 2024 01:31:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708767073; x=1709371873; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YmY5NkPyqyDzoEieFjYp7SW5hjVc2+Nb3/NQOzb8Ges=;
        b=y/e4ofWD20vd3a1URnY4gVNi+xSV3qazdgGof9LdTOzGjqTop0P6aPamki0ZqSqYfB
         8jzkcCaMNaIpmJ0G14woHpNmbJvu/21hSAOyxvWzlfcTyg1WSUuQxHDXvDvmN3lpxB02
         ej0DLMEvAf8S1YVFIb61w0mDWMR793YdZ3YIHn9a7t7ZxU/4A0DVieYSU4KYgccZtO8C
         W0d5MnLT7+WrmnZ9cJ135R76IUHgL2rqZSQ/h4LASdB8h2e0+uax9yjGIw31p4tuTRf1
         OxfMDNLFpY3POZ0yl9X2ouDzGJLcC0KIZ1CnYoVGT2/hTwVoeF9ZgNt8JRMldLkqinZc
         LK5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708767073; x=1709371873;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YmY5NkPyqyDzoEieFjYp7SW5hjVc2+Nb3/NQOzb8Ges=;
        b=OtUX4g6K6cp1b7ImCT32byDtTWwoaek1VA+eKTp89jfuMIy9p/YTzmUCMN2uXvforq
         H9raRpwIJjzQCrHGtxFr9EjOK9SS9WyD3v/+FPmzkuTy1vKHtPpqsNawHsJ4XOY0Maag
         9EJlPXx44/0wwxasFceYkGObZgOXzSB8vlFD0XxOLeG6xvYUiVCM0nKQKuMOWQ2f7kOh
         jT40mfBFrCrpkHToArf5ODZUZc2NRoAx6xOTro/7/3XSLvqV5R6rZCQaU59SVr1Tv52q
         lIP1AhRqeyH5a23rVVMbazynnWPJn6Be17/Jna7YGddMt551/NygLj8HmGGdF0f8nrzT
         NoMw==
X-Forwarded-Encrypted: i=1; AJvYcCWt2DMGcgqmloRwuZuc+w8NrWUisjOtxUJaFizbFniOomFR3n+7r8/HmzOvgta2rtPCLILSqS4TRnSoNO02mL/six8EamsHnYWcRt5FxChP8rTI
X-Gm-Message-State: AOJu0YyNyt3ahdsHsor+HJ90RKmHTv9xyFuRhFlXH8wHE+mqfqt+evfd
	I+k7C5ck+ImuDQvS7cCGiHnxRw2iZugy3FP6bwX/56gS8j8gsIEhlS1535+3GWkrL1hKt6lAeH8
	T2hQi0ORlbPIab6eW6/uTfSLfxrHXUn62ZGXJ
X-Google-Smtp-Source: AGHT+IGOZl/nBisuhQ6zD6jxD83U4XFWrPSRI4XTF0ONfj1DyW3nznVrpeMbXo6M+AY0O65iMMFktnvrm6rpep/W1WI=
X-Received: by 2002:a50:a6d7:0:b0:565:733d:2b30 with SMTP id
 f23-20020a50a6d7000000b00565733d2b30mr114515edc.4.1708767073364; Sat, 24 Feb
 2024 01:31:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240224-tcp-ao-tracepoints-v1-0-15f31b7f30a7@arista.com> <20240224-tcp-ao-tracepoints-v1-3-15f31b7f30a7@arista.com>
In-Reply-To: <20240224-tcp-ao-tracepoints-v1-3-15f31b7f30a7@arista.com>
From: Eric Dumazet <edumazet@google.com>
Date: Sat, 24 Feb 2024 10:30:59 +0100
Message-ID: <CANn89iKB3ov_rthyscWn=h4yxmhReXAJzHu9+dOdpzPA8F=C-w@mail.gmail.com>
Subject: Re: [PATCH net-next 03/10] net/tcp: Move tcp_inbound_hash() from headers
To: Dmitry Safonov <dima@arista.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, Dmitry Safonov <0x7f454c46@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 24, 2024 at 10:04=E2=80=AFAM Dmitry Safonov <dima@arista.com> w=
rote:
>
> Two reasons:
> 1. It's grown up enough
> 2. In order to not do header spaghetti by including
>    <trace/events/tcp.h>, which is necessary for TCP tracepoints.
>
> Signed-off-by: Dmitry Safonov <dima@arista.com>

Okay, but what about CONFIG_IPV6=3Dm ?

I do not see any EXPORT_SYMBOL() in this patch.
