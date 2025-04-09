Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7F3254868
	for <linux-trace-kernel@vger.kernel.org>; Wed,  9 Apr 2025 07:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744182847; cv=none; b=LK20DmR4IIbLMlA0enhHKHmb1xuwab9fExkeOBdCn7GLSwo5aTY3ZbFGtuX2dGpj0XQ/lH6d42+FkdUwsLIfd12BoCmdYJKJEYmE/w/vqCMcp5lTlmNU6Cx1PtFIynkopNZGAOyAYM3GR924v20cT0QC9PzIYw5isY33kcxLgQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744182847; c=relaxed/simple;
	bh=o4u22On0K74aCLxCe4KHlANGFU1KZOeJn9PZNDHqBII=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MVc43Jg1dA0uCgcLvXYYhnZMb1YgWsZgVNdhWan3CEi0FBN1pog8gA8qoXGDHg7spfN5PT7ABoUyYqfqBu1rjyo9VUxWioo7XBbBc7YA89l3sGEWAmm8AgEQFHadEbIuyLfdAe7kV+xIZq03oBgTWt+9JYcBKXKWS+wVB/HnejE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ekCQmfKE; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ekCQmfKE"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-476964b2c1dso106040061cf.3
        for <linux-trace-kernel@vger.kernel.org>; Wed, 09 Apr 2025 00:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744182845; x=1744787645; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o4u22On0K74aCLxCe4KHlANGFU1KZOeJn9PZNDHqBII=;
        b=ekCQmfKEB0bLWZzXtd7R2oH2sSK14iQ2pma12G0EcIvhTlGB5SzYD+FgtuHYRw2Ziv
         omL2HXb+4fJjfL/p/Xo6SNAkjcTaoFkU1s6RAPZ+TM0i75czBtd9YFBdwfmbDCGnS9R6
         N/uMZVezf3JMPZb38v+Zbn5iTlPumqS+2SSWkdwnYavt6JFgEUiv+wc9xB+eJEZypHh9
         gMjWJpEyz556pzyVvs43uDl82DSSbFZ7XDTR3exeKDf0t5BFnsw1LMoZo/e1RdvRzZ9r
         OXkD0+UHehK8C0/iex+frri3vn2aEBBt3adjC5LInhzD4JrYmcCKSJU4HS2lwnw66Ows
         jbaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744182845; x=1744787645;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o4u22On0K74aCLxCe4KHlANGFU1KZOeJn9PZNDHqBII=;
        b=TtiWdb+dJKWcxMz9F3Xar5ohIz6pIZi6F6wreTHaAqclb3YryfPtQARn0sJlOFwhae
         /4QEAfaN7w5May/O2DAfBkI+SEGXJCCs7ahWEr9dCxQiLd9r7bln3JfzyZkEuhpO8tp4
         UqQQh4lDxFSeQANWHjekydOqLcs3bG4IjW1zaPp+bIW4C+25YeK8bTNUT9FzseV4iTcP
         xb/PsgzRJsOSD5XZlQT3MU+I2LnS1N9S9uYkqKLzpPIHiNgDzsa+tOmgwFXG7dfQRHNP
         7ytKELOnnly2pWTMWXkMBbqbz7vQ3FUBJJ2Wj79Z4skj4hDXH26JJmi8B8weZsIZMJil
         Tg+g==
X-Forwarded-Encrypted: i=1; AJvYcCUMmCHIcBrrO9tVO6XsxzJlPqueh+RdBEF+RFAq4p1yNF762FBqqLBWaPcNRFhxow0K/Anrs7mZlyc3DvGolReOteY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKei+yU3upzxCWc2Xp7uYVQYlh9NEvJYN7AOduZ22hFwKJJb7V
	7YMhgF7fHItHUmdVPoIvS5Ao3MkIbq362kPvgxD3NytAiHLGetxWUMhUXpDkfz5d9oDJq8hKZvc
	axMnClbDjxIknVlTRlxVni7ok4QjNOYS316up
X-Gm-Gg: ASbGncs0yKNduHb3Ifn2L1io09Qe1s8pEtwsZr0AnU/UZEVlTgJky8eqHRb3hYw3Y+p
	BzIluOUxHVuNGE91oUAERBvEig7AOK7cCNYUsfQbgJs3xYMaMED4doCNug/ouYN/TqTXbFGQy0L
	t5lGAF1nmtyAMn2Jo7K8Aoxw==
X-Google-Smtp-Source: AGHT+IEPf+bMOSyPAyRRT5FnYt/dQDrDJkP7fgIqSBGifSkvX0GxrGH6i7XdUzqfrW17ujqWAY4wjqbjwcnaYpM00XA=
X-Received: by 2002:a05:622a:1209:b0:475:ce:3c59 with SMTP id
 d75a77b69052e-479600c94ffmr21204371cf.30.1744182844448; Wed, 09 Apr 2025
 00:14:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250408-tcpsendmsg-v3-0-208b87064c28@debian.org> <20250408-tcpsendmsg-v3-2-208b87064c28@debian.org>
In-Reply-To: <20250408-tcpsendmsg-v3-2-208b87064c28@debian.org>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 9 Apr 2025 09:13:53 +0200
X-Gm-Features: ATxdqUExgIlhI5h9g1kuJu6S49AR43PpGh5RclwAbpAXHtSKJ9IcrrdS9kYyTqQ
Message-ID: <CANn89iKr2kfCakou8id62C5ic95HF5RCps9a2cUv5FL3yjAGdg@mail.gmail.com>
Subject: Re: [PATCH net-next v3 2/2] trace: tcp: Add tracepoint for tcp_sendmsg_locked()
To: Breno Leitao <leitao@debian.org>
Cc: David Ahern <dsahern@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 8, 2025 at 8:32=E2=80=AFPM Breno Leitao <leitao@debian.org> wro=
te:
>
> Add a tracepoint to monitor TCP send operations, enabling detailed
> visibility into TCP message transmission.
>
> Create a new tracepoint within the tcp_sendmsg_locked function,
> capturing traditional fields along with size_goal, which indicates the
> optimal data size for a single TCP segment. Additionally, a reference to
> the struct sock sk is passed, allowing direct access for BPF programs.
> The implementation is largely based on David's patch[1] and suggestions.
>
> Link: https://lore.kernel.org/all/70168c8f-bf52-4279-b4c4-be64527aa1ac@ke=
rnel.org/ [1]
> Signed-off-by: Breno Leitao <leitao@debian.org>

Reviewed-by: Eric Dumazet <edumazet@google.com>
