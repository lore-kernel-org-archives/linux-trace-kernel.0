Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D4F274402
	for <linux-trace-kernel@vger.kernel.org>; Tue, 26 Mar 2024 13:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711459139; cv=none; b=ra87Z3ealYDUX89RZmq16Xcmc+RzOPZO7g9mjKFHeztYNw+NSa3vCFAtlemqCzPj79XHsyPVIB+22WXt1Nv99AccQcT6FyHimZ6c1JVbqinNSGMs7SX+tJs7Rv6oPJDwquNW1ws5HILSyvDyBQCCFMwxr8XEMvjWDl/tHCfOYVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711459139; c=relaxed/simple;
	bh=GkNJWEH5CqftlvwkYmOjBPCjRnY/1N8DRLYtCKkFu+Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pmC8PijXbuHclIF8BwxXxOyBXGaomnWM306WwF3jCjqEPJmc4uePpdTlatzQV/+PDpISsDXANhLQenirTadMcvJw3ic7HvfC/AA8A0E2sZPGWboNTGM7C/pfoFZ/PvrMuit6tnkAz+BmjXspFyv4IU604v0L0Q0l6UheJM6uCQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Wxul+hoR; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Wxul+hoR"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-56c2cfdd728so4738a12.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 26 Mar 2024 06:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711459136; x=1712063936; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GkNJWEH5CqftlvwkYmOjBPCjRnY/1N8DRLYtCKkFu+Q=;
        b=Wxul+hoRqE3FDD6i4OiwYYohB0HVZbma/AWfcafgcreu8szkK3zyQyd7bpWNR1UvkP
         pjUAv+zdGnut0KLAxuw1J7/PlShWJzfOgnroQlWAGykKBMrXMsStA14KgZOBdSEz/hDi
         PSeVd/EPjAMtoio7CabUOoof54h1tjoE8zS4YAP4KVLxB+HlsUAQrxu35VhPLrK1QdhK
         QC4q3yxlD3XfLvJDnOiO023nxK2U3mBm/v7+J5kZBaJX+k83VESq7zSU1Qg7von2lu7m
         0aoH+H8+uFr232/ue3YZcHjyOaC23JHIFNL+lmAceaF506sKssKzLeCf/0NCxv0DzyXJ
         v07w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711459136; x=1712063936;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GkNJWEH5CqftlvwkYmOjBPCjRnY/1N8DRLYtCKkFu+Q=;
        b=N7dmYwX3ASOSzDuOhTToIUTzCN+HUQuSvgbVEhzDZJcR1OeNmbbHmAAFLx7oHaHDXY
         iT8Jk7b2fAUFQaZSBhgYAEQuCiugJz+KHIu9Lgpo1ctZMr+lsIwFl5fz3Z41x6PYivjY
         fuLXT4XBD//VJ1/b8RHU+cfnAfJgB2u46A5/AlX3HxbjkauDuZZDb59cqS2S6Aedzz7y
         2ZdePsiLZMasx1einurbxqiRe9mkQ9yN+83xIeuzXpFlgNEdArAGyvuN5sQmxBpQ+KVx
         aJkJltz3zJ1EmX2iq9q1Nnajtk2ND+xOvdzGJrsEsKGvtB2NaQ4jMDZENe9KLgtL2Ci1
         7t9g==
X-Forwarded-Encrypted: i=1; AJvYcCV+Y80id40qqglHfCo+lBEMiTbx+L4y87KWOSs1VdoVNgkLEZWYr+MbewtxdOA3PbGxtxJrzrTVd48+BvBEAtPGGjmbZgb4u9XNBNZI8wN+R43G
X-Gm-Message-State: AOJu0YwVlG0jLjbjCf1hSYzJfFjWssTYLmwEU/dTT1viOIz9cEca7zqi
	D88NEB4IClS+4LcVekUPq7IACjoJJ3JCOhdw2hcY+w2VZ1EaM7Tw6xSxG4ug7DNP9nL5GsP8Ayn
	whlzr/Z7SwLs1lSWQQpcuriqTZ6qve2n0X6SL
X-Google-Smtp-Source: AGHT+IHi8Prjn/pM5ByDmdywvVWKS0LKIb81JDGzPnk4MzG+yQ1Dkqp91W2gUekWaLabtcx1vUU3ZCVd8ljiN7a/sBs=
X-Received: by 2002:aa7:d951:0:b0:56c:303b:f4d4 with SMTP id
 l17-20020aa7d951000000b0056c303bf4d4mr23008eds.1.1711459136081; Tue, 26 Mar
 2024 06:18:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240325034347.19522-1-kerneljasonxing@gmail.com>
 <CAL+tcoAb3Q13hXnEhukCUwBL0Q1W9qC7LuWyzXYGcDzEM56LqA@mail.gmail.com>
 <b84992bf3953da59e597883e018a79233a09a0bb.camel@redhat.com> <CAL+tcoAW6YxrW7M8io_JHaNm3-VfY_sWZFBg=6XVmYyPAb1Nag@mail.gmail.com>
In-Reply-To: <CAL+tcoAW6YxrW7M8io_JHaNm3-VfY_sWZFBg=6XVmYyPAb1Nag@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 26 Mar 2024 14:18:42 +0100
Message-ID: <CANn89iKK-qPhQ91Sq8rR_=KDWajnY2=Et2bUjDsgoQK4wxFOHw@mail.gmail.com>
Subject: Re: [PATCH net-next 0/3] trace: use TP_STORE_ADDRS macro
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: Paolo Abeni <pabeni@redhat.com>, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	rostedt@goodmis.org, kuba@kernel.org, davem@davemloft.net, 
	netdev@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 26, 2024 at 11:44=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.=
com> wrote:

> Well, it's a pity that it seems that we are about to abandon this
> method but it's not that friendly to the users who are unable to
> deploy BPF...

It is a pity these tracepoint patches are consuming a lot of reviewer
time, just because
some people 'can not deploy BPF'

Well, I came up with more ideas about how to improve the
> trace function in recent days. The motivation of doing this is that I
> encountered some issues which could be traced/diagnosed by using trace
> effortlessly without writing some bpftrace codes again and again. The
> status of trace seems not active but many people are still using it, I
> believe.

'Writing bpftrace codes again and again' is not a good reason to add
maintenance costs
to linux networking stack.
