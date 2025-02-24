Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E421A83E7
	for <linux-trace-kernel@vger.kernel.org>; Mon, 24 Feb 2025 19:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740423853; cv=none; b=kXkc9EfPrNITN4I383yfnZ5oeLfV0ToFecUl6uP7TfisU/KGIPge0Zw7F9L8ljI39KuhTLXd4AjFSQUVZuSvPDieD0tEZ6RJEvEFNqHho0/xtz1LUT/SIb/rqdyerK1feWGnGj2GKUgQn85SqxKizPjqB1BlafwCObtEwJmrYiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740423853; c=relaxed/simple;
	bh=a7KIxKD7aoeoZOqCkxW8MiXflXZAnlr6LQmmaXMfXYE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R2ve4s79VehvS004frG5KnkHshje5Z2zRRyPZyY4BrN3hYJchlzZjkooKREALUZkzY/vtmzgCxagqjNiyPVrkqp/aujKhWp7a5XHpe1w/S9I33AKwq2BzX72oc04KoAUb1UALitdxioxXtH51LQJGHeXjqRjt5Xfk570PLqGKVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1yyjpECE; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1yyjpECE"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5debbced002so8677462a12.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 24 Feb 2025 11:04:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740423849; x=1741028649; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4nSSnIUgykCsOJjoRoPgBIV/Do11WjZXMG8oFwcXmD8=;
        b=1yyjpECEC4FwpamKSMT98G/jqqz0XOq+OwoJdHIsFjHqkj4Lo+y22qQdFqgBX+0T46
         CUL89o4mvo8J28S+iULL5fNo8DgpecmGspw7puUVQ4Z5rmtzZk4rtuQ9F4rCxqZyscTc
         jgSg2n8WzivwS/HTvHS9bdhpW0WU7oZzlLMEU8+qWsPM3OHGMcct6Yk1japA5v3cT5Wx
         s70mLRm047ZAW2urgoRQ/XZJVw0y9LeBSvmz2J5P3DQDMOh71LFMwI+NvPrxzGFWvhye
         GsL4eX6LSTe+vfXwtMaJXXiRLYFPDtw8qnFxpD10o2e7qP6y75BCflNhfSzYLJroZdfS
         T+lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740423849; x=1741028649;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4nSSnIUgykCsOJjoRoPgBIV/Do11WjZXMG8oFwcXmD8=;
        b=AxANFMSL8vBeIjBpAbiJ73wdvOahQHv1RrM2hrLfvMPuJul/il3d7Nd4jSVL5U9AOZ
         hi+FJn3lINX4r6gQD9Z726IA9+tlD8noZRhN58nRdL7fLBepIEF9qTpxey4ekRAEV8Lr
         wQlYant7BEubIxupoy9w/QhxkpER+x8ail8rtr1mcHBpJXrluS+eVN/bV8rOX0ysjtvp
         iSPXyOgZeIXqGA3GlfQTL7yhlRkOFnz6YqqBs7a0WWwQuoOYB7cLvrCvu8LrOxldTU7t
         piicvKgS28V7k58l0txxss58OCAfX/ghEzSSb4BxIP/Vpvrs+JoqctU0c6RAhsIIL2M4
         NCVw==
X-Forwarded-Encrypted: i=1; AJvYcCVaPGUi80UFbLv447Wu6CMbwHO7stTr5QSGkk5UQSyz33OGROWB98GdCdmghJ0CSI+6ETSCLECYz9xzfDl5gPrIzT4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjO1RBTdRgM0wCFNT//z1y4dT7pzG4viXFeSAoXHIWbxS0OrnD
	YldToulpYxfO/PTDDfmgGc/xcv+KXFbkFT1sz+vbr4oxpBQQSblOr2r3hUjUxYDZZ1OxdMd7Hr5
	iNa77Wk0D0zZFWZsXsarsV+5G43rF4JEKvMzb
X-Gm-Gg: ASbGncuT3nWeug5G8mPs2ITiW6Rw2jqqYQBSchTbfTM2QPJGw0t8WWaVY5Um9Ye+zsn
	/BdD2WBnMfXPimax6aDSf4Mw0xlVGjfU2ryA8rk+8G8FzttTSTHFYbkm8XG5ymhcZkXfD7QDVhu
	1bY4eodQ==
X-Google-Smtp-Source: AGHT+IGgQflHbqJ4UhoDf/fk2E5dvSe6cFNlfrPYK7uSbM45dr7J0xkIHLkRgPNbQ8e5rSTMONtTWGu2Ja+QKsZlfN8=
X-Received: by 2002:a05:6402:26d1:b0:5de:572c:72cf with SMTP id
 4fb4d7f45d1cf-5e0a12b7c27mr19854821a12.10.1740423848811; Mon, 24 Feb 2025
 11:04:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224-tcpsendmsg-v1-1-bac043c59cc8@debian.org>
In-Reply-To: <20250224-tcpsendmsg-v1-1-bac043c59cc8@debian.org>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 24 Feb 2025 20:03:57 +0100
X-Gm-Features: AWEUYZnNdis7E0SVF0S-h6-AU7K1RTAWbc2V10Km6GwZSmwi5zbMocT2Sf-WWMY
Message-ID: <CANn89iLybqJ22LVy00KUOVscRr8GQ88AcJ3Oy9MjBUgN=or0jA@mail.gmail.com>
Subject: Re: [PATCH net-next] trace: tcp: Add tracepoint for tcp_sendmsg()
To: Breno Leitao <leitao@debian.org>
Cc: Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, "David S. Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, kernel-team@meta.com, 
	yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 24, 2025 at 7:24=E2=80=AFPM Breno Leitao <leitao@debian.org> wr=
ote:
>
> Add a lightweight tracepoint to monitor TCP sendmsg operations, enabling
> the tracing of TCP messages being sent.
>
> Meta has been using BPF programs to monitor this function for years,
> indicating significant interest in observing this important
> functionality. Adding a proper tracepoint provides a stable API for all
> users who need visibility into TCP message transmission.
>
> The implementation uses DECLARE_TRACE instead of TRACE_EVENT to avoid
> creating unnecessary trace event infrastructure and tracefs exports,
> keeping the implementation minimal while stabilizing the API.
>
> Given that this patch creates a rawtracepoint, you could hook into it
> using regular tooling, like bpftrace, using regular rawtracepoint
> infrastructure, such as:
>
>         rawtracepoint:tcp_sendmsg_tp {
>                 ....
>         }

I would expect tcp_sendmsg() being stable enough ?

kprobe:tcp_sendmsg {
}
