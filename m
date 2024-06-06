Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5035E13AA4C
	for <linux-trace-kernel@vger.kernel.org>; Thu,  6 Jun 2024 08:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717662102; cv=none; b=pndZMx+CPhKXOVHvPNTJBqCT2FL+QWagiBDw5pXF4xtG6QPXdKujRPauSbAZjs8r6v5fG+LyhTS3OCG/jD9SEIBF/32WIfLJmQ8G8+h36HS5IgRpG28ImR2+1vfl5tPkAgm+V8ebPdaXKpdzeHK/gAHDSQzbY/DnPBdZLdpPq9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717662102; c=relaxed/simple;
	bh=aeK3bnvjs8VEJFtu6HdqB8LOAkT/9yDIQ2qbTFkOBF8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FjrF6IM8wGiQ8s3fXm5rxbqo2ZSvBeylR/mChyxkGkLNggaL3AF96w4k8v/Yy2P5hncP6M4Bzc9j2LP1bcsc3wOHyLtAtzGVnpNFRGxjH/oA/EFTgdNsJTlIaKvqaQCRTUee6c1PYtyS4rfv57PaL05OSWMId1ee4fT9Hp04YKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HbeIZ23h; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HbeIZ23h"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-57a16f4b8bfso13015a12.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 06 Jun 2024 01:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717662099; x=1718266899; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NHvKEz5JKdCznxSqHezsMu71OI+px6uSS61YT0rHfuU=;
        b=HbeIZ23hH4Ka6f0sKo4cmwfPcRDkIuYnzfJ4YYdcdFAdHOyVlJHRQ7Q4GwCIFGS9NI
         0zKVt0qSorWejr5JOpr9BSHR7kBSLdfnqh/4T/C7zP13ReUl4P/GOyqWnW+qCo8iucL0
         EGB6lh8oVGUTv/lIM6LlrGL4xBsQm3mwP4EcqgXURRUpbTsgyJGaVyxKzl2tnJBPKLsH
         zllNASFbBpxhLY+MGdzZqfjiNeWps8qQHAWmWUmW0Sn5obRn1M4ji++dLAHPh96iTAGA
         2kxdX0wwhJXQAIy130emN5Oom2w3OQ1VsAVVLW5MJGIw0wnQFAp7QZQZ1wALR3UdCA35
         lQ3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717662099; x=1718266899;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NHvKEz5JKdCznxSqHezsMu71OI+px6uSS61YT0rHfuU=;
        b=fuyiaBnxSKLc/hLIsUIU3LUkOV38lk7qp4O4OjNoe+G3TZs1xqmhFB4+OjdpWv3yQJ
         IjK+u2i1gWZ78la0S8K1+gRtBM+Gq/rp+McgRObJ5gbKxyAEFvtUTR5veYFv/tAfHoZY
         0Fctv5NP6J7MdU89kEwuwwLlISomOArN5PkIzTmaMABZgEsgZ/3k9VhRC9mt60lzkQjM
         Qqo6ZtpNzGBAuNt1Dm9r4R2/1EAQ9Duu28x+Zl1i1znmrMuQFctd9advao40iq/sBglk
         ZNGaWVtQ45SOmGr2fygpKz2eAt+nFWXlks9UqsTYg9U1GUjSS65F3tOKECiIDx2XeRvF
         yZhA==
X-Forwarded-Encrypted: i=1; AJvYcCVuDP2IWycPJFatDM05pAxO58kvt2+d648OBv5pVWvClLmWolDcrO2hUMd/Z57ZwCFe1VX3f5uAALxjjjWWr6HjwBsibzEN7XZyUuX4iwRstN6F
X-Gm-Message-State: AOJu0YxWDefIl+m8cwqNtNmnbmPYAzOIUN0vQTyIc8D5aQXJoJp49SH/
	NZM4837Bdw1qEUhnr6pK7e9hwcjwfV3Terix3VGoUNp8/j1+4MFERx8mDaE2jjbf+LOee4OyHdU
	odsQZAyX7HDxnRwcxfejyP0a1GdrPBERQ8yiL
X-Google-Smtp-Source: AGHT+IHh2yQO2i7W4TVOkZXhb8V7bKamRBQUc7Lc+uRHNVgFKKNhugjLVTkGob22mKGuMH+YwFRJbIKAat4YiCfDe/0=
X-Received: by 2002:a05:6402:180e:b0:57a:9ea1:f92a with SMTP id
 4fb4d7f45d1cf-57aad34e850mr99772a12.7.1717662098423; Thu, 06 Jun 2024
 01:21:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240606-tcp_ao-tracepoints-v3-0-13621988c09f@gmail.com> <20240606-tcp_ao-tracepoints-v3-3-13621988c09f@gmail.com>
In-Reply-To: <20240606-tcp_ao-tracepoints-v3-3-13621988c09f@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 6 Jun 2024 10:21:26 +0200
Message-ID: <CANn89iJyKWuZ4DtegJR99jYaSf-kbhr0gSosw_XGxjiaGT=00Q@mail.gmail.com>
Subject: Re: [PATCH net-next v3 3/6] net/tcp: Move tcp_inbound_hash() from headers
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

On Thu, Jun 6, 2024 at 2:58=E2=80=AFAM Dmitry Safonov via B4 Relay
<devnull+0x7f454c46.gmail.com@kernel.org> wrote:
>
> From: Dmitry Safonov <0x7f454c46@gmail.com>
>
> Two reasons:
> 1. It's grown up enough
> 2. In order to not do header spaghetti by including
>    <trace/events/tcp.h>, which is necessary for TCP tracepoints.
>
> While at it, unexport and make static tcp_inbound_ao_hash().
>
> Signed-off-by: Dmitry Safonov <0x7f454c46@gmail.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>
