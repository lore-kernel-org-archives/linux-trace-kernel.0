Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 958B4191483
	for <linux-trace-kernel@vger.kernel.org>; Wed,  5 Jun 2024 07:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717573797; cv=none; b=ZXrbJYAXbt9GNSL/2q7y9k2DdO1wktsLTLsVKHO3HpbRpw014nTUEYKpAWXwGNO0/D1SoTUPI+Iu4WC1qGvcOKBugBjQXnq/l4MsSOBwmhU9H1fGNOWEvEdhTrQq2NPq65dZ50nUuslPf/uZiF0bjIw89fUegp02Ds3BgYp22UY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717573797; c=relaxed/simple;
	bh=FE42yrx9mX2aAvYx08lkJboDb101vHDGkEUhaTj4lJ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UwWl4zwyeflOe+Xm9IAiVfUKrG2gDNZbu7tqCzW3IdkApwu0tdDyrbJMuV6IW/5o5fhExbtO9XwQ0UkC/ZyDuSh1cqgjUrK5m4FHef9VGoKJJz0Ng3XUB8E8rgrKLM7uIbBPno0GnyaYDfol2cvRGM/79zXWMVAf98TMY8nEUDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Zo0OKjyH; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Zo0OKjyH"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-57a22af919cso5696a12.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 05 Jun 2024 00:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717573794; x=1718178594; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FE42yrx9mX2aAvYx08lkJboDb101vHDGkEUhaTj4lJ0=;
        b=Zo0OKjyHOWyak4iKzhzb/hikUeH+VVrIsCk5lH8dHes06k36NykNFew7GCgzLAp3wB
         w11ve/gH0LYcDQnSox6EtBUj0Q4d/aYWoGJSuZaj7DSkZdc0vFApY55WyYPAJp/dQ/rd
         MXq6y4L1qDelhx+oot7lb3Fz/g0sd2jNOl0pn//WD870oKsO75ZaQ1/tpihCyeUiqph1
         rfoqh3M55m+rEsj+2tg6Z2JmnjrkM8WDm/PFrNcyrCS44dHdylE2Gs600Lyz3Oa2FZiU
         DMMXP7TP8i0Ba1hgUTnNrIZFmuXyqjnpOrdX6B2bxatxN13Dsj02m7+yX5iVngEcSdJk
         whJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717573794; x=1718178594;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FE42yrx9mX2aAvYx08lkJboDb101vHDGkEUhaTj4lJ0=;
        b=rVqde8rFOj5zJGPkLkiwcgXm+Tw9DYcTxH7/BBC2aNAURDRGvQqbB3KjbLUuIB4M/4
         psuANAffxzg9vaP0/Oh2N/r1LwlfU4lKYrgxHnI1xH57XTMAK8vQsXnNjuNCgpjO9qt8
         0qRZ0RQshWcG0F6upnK50ZaewqqENRZA65RO0/sgJHkupAx2sXNa5P4UR557v4a55VQd
         8hJO6u88bgi0iBFOoFJ9CQI0XtxM47Qd8irM9/tNU/vuW2WsAcx8Ydsd5jtJCWNXK5yP
         W+Hig096DB9lUbvPjhHs8VuCjysoIpl0YZwwX9MFEIFCBE96kDhu2KB3domwLs5EAUfJ
         PNTg==
X-Forwarded-Encrypted: i=1; AJvYcCW2QgFgIIRrp5DviDw2LiBuGEr1XOVT0KFfajB31DZGjlbYJTfaSbkG2FIrwKlzklUlc6oBH4GTb/o7apSvVxZrxcUU3HAG7H0TVqrbmLm+zNpr
X-Gm-Message-State: AOJu0YxQJWx4HhQN8jVlXEc0SmSeZVCRHphdzQk/WRS3TytFML9gKKmI
	S1dKbD3Kj14R+wdfD4id+TN7y3FTHesHgVnY0j9W2C7GEfVbdLyqKevIX9fi8NBQUyRFxXfqh0O
	3+Pj459jUBBiEjIpkevNLpcYL3jWJQ9/h12QY
X-Google-Smtp-Source: AGHT+IGik7WgbEwjTVgo9/fdJG7UMvJVLbNXpxM0I5UfVI/IX9afeT3W28dWzu7Du/gl9ewBx6vSxtl2TQVra+z+mLE=
X-Received: by 2002:a05:6402:288:b0:57a:22c8:2d3c with SMTP id
 4fb4d7f45d1cf-57a8d8de8bamr135300a12.0.1717573793552; Wed, 05 Jun 2024
 00:49:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240605-tcp_ao-tracepoints-v2-0-e91e161282ef@gmail.com> <20240605-tcp_ao-tracepoints-v2-1-e91e161282ef@gmail.com>
In-Reply-To: <20240605-tcp_ao-tracepoints-v2-1-e91e161282ef@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 5 Jun 2024 09:49:39 +0200
Message-ID: <CANn89i+BB1oZD-NScsfm-Stt7ykMNGij0b0dJYvit=PxyFOV8A@mail.gmail.com>
Subject: Re: [PATCH net-next v2 1/6] net/tcp: Use static_branch_tcp_{md5,ao}
 to drop ifdefs
To: 0x7f454c46@gmail.com
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Jonathan Corbet <corbet@lwn.net>, 
	Mohammad Nassiri <mnassiri@ciena.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 5, 2024 at 4:20=E2=80=AFAM Dmitry Safonov via B4 Relay
<devnull+0x7f454c46.gmail.com@kernel.org> wrote:
>
> From: Dmitry Safonov <0x7f454c46@gmail.com>
>
> It's possible to clean-up some ifdefs by hiding that
> tcp_{md5,ao}_needed static branch is defined and compiled only
> under related configs, since commit 4c8530dc7d7d ("net/tcp: Only produce
> AO/MD5 logs if there are any keys").
>
> Signed-off-by: Dmitry Safonov <0x7f454c46@gmail.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>
