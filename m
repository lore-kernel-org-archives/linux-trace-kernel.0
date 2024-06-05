Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3EF13A86A
	for <linux-trace-kernel@vger.kernel.org>; Wed,  5 Jun 2024 17:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717609048; cv=none; b=CP+B3nvTdA6EY1jDKT8UbRCj51OzwTvqJb0Mrd1A9q6ZmptRuHtR7TyvLq0i+Y9gsnPJKgGCn7/EUZsPN419ugiGjeqbUaIADVDQbF3dkNzhXdEVi42f8Z2GtKfIlIkFmry5MdAicLehW83FcCzMrQH617zkp6FWkIXTEV+5pOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717609048; c=relaxed/simple;
	bh=VNJYs+kGaMCopwBQ+lusDjSQTVikl64WzNj7Py69ocg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p+VC0JCYtjNNl5DkGYUKUBELeUacchuGorDBAjzpk1k01w5Aei0RCjbCoYWscz4m5/Cs+V5bF5sIted35P9s2w2/+BE25w4kW3IvrBLsT6h5lBzzWLDfui9wjGCZnDlPybSF59LI04jzMVXrhoZBr1iOdy6NJSPljLntRiZifKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=o8fGFWbU; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o8fGFWbU"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-57a16f4b8bfso1979a12.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 05 Jun 2024 10:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717609045; x=1718213845; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oRCudjCBZglMVEtFZ1wsBH2p78pn49xRBD8fZ6tyagE=;
        b=o8fGFWbUmy7sg+2z3zHDp5pvWOcu7rmIHx32kgsPC0MFw0eDEIV8vwMEUBhtJuRf+4
         YoTd1c4H8j7QPquPWy8HZ50oN2W6qDC9HC9XzC43YSjEyBgQaLmMH7d8jwduKAs+py50
         YudZjZ5+BInoKJPbYo94i2M5SkHeLF5D2TLLkcczl24PWlYRPGYf/liHqtNobHqNgTDf
         FJ1bqz0kJd94RLrgic7PYeqLtMpcnxmHfMJQ+muXnlSTHqnqkOZL3CAI/55oP4XlgyE5
         93Q8++M2ALq3HbOsroDVDU0lOj+FtXW9fBtutDAfnJU/ydbcZ2IAafFpMOhHVLT3zqu1
         oRCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717609045; x=1718213845;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oRCudjCBZglMVEtFZ1wsBH2p78pn49xRBD8fZ6tyagE=;
        b=YNFZYKXeABjjyKQ5nz3J6KA6StDN8t5qvXyX5twOhylz6bXYVAcSZmNCyg8/60+ALz
         4OVtD0h01dk7M1gO3ivGWw+DdYsNoRRQMPiaWVogDwjZWCmJxxL88jfEkv645iuquTTu
         RuMW6ZwYoUlOVCfgjSYc7hthOsoTpcz7aPw2hEeYzwqtcC/yIVOKZeDUZuVmMoSPGV+A
         0NkRXxJElzrNaCA1rJvCbpoKAMp5mWVt+Ju+Qku1SxWDT2pp+bqU65nMbbtpDjiNaePQ
         lTQd1FUI34n8LwtmJ0QS4EPNDdnh5a/N7Jce50vKeEIV3mIVJ6Xa5mn57VwZETZnT8yw
         T8zw==
X-Forwarded-Encrypted: i=1; AJvYcCUg6g64h5b4CHnJfPglKpgmSW8x7KWMkjgl1TLt+HyEEZHyT3aXoTyLRnnKiWOF2aXnkIiFKa4FGhTWfYorPJZkBY0nkFq63zBjK9NkaS7a2CZ3
X-Gm-Message-State: AOJu0Yz8n8sEWoIUZWSb9I9ccH/ayZ9+l8JrV8VuGI07eTSzkrt59q+w
	4taQYo6RcYGcckjv/MrwIrPXCZbqoyTcR+akQkHfXpJadgtpYdjnm7JS6kNBHHVkjyGb/ZmCGQd
	szwVq1+hh4OBLjQEhZQsjxNzag1E42YHsrkBP
X-Google-Smtp-Source: AGHT+IHLiZlAEQ5p636IbcSei3Znb9UHk7JIdf3DztS9vt2K+vDsJ7rJxBbdtw0ZDwKybVi2W25VMVlMGprcksXuuic=
X-Received: by 2002:aa7:d6c3:0:b0:578:4e12:8e55 with SMTP id
 4fb4d7f45d1cf-57aa6ead48bmr144a12.1.1717609044559; Wed, 05 Jun 2024 10:37:24
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240605-tcp_ao-tracepoints-v2-0-e91e161282ef@gmail.com>
 <20240605-tcp_ao-tracepoints-v2-3-e91e161282ef@gmail.com> <CANn89iLHGimJWRNcM8c=Ymec-+A3UG9rGy9Va_n7+eZ2WGHDiw@mail.gmail.com>
 <CAJwJo6YVtBaCn+iUEvC7OWa7k9LtC9yReHM=RmuiDUACFympRw@mail.gmail.com>
In-Reply-To: <CAJwJo6YVtBaCn+iUEvC7OWa7k9LtC9yReHM=RmuiDUACFympRw@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 5 Jun 2024 19:37:09 +0200
Message-ID: <CANn89i+em+sjuQE32bM2KWg=EFcf-jnfvzD=YekMviUSjARrnQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2 3/6] net/tcp: Move tcp_inbound_hash() from headers
To: Dmitry Safonov <0x7f454c46@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Jonathan Corbet <corbet@lwn.net>, 
	Mohammad Nassiri <mnassiri@ciena.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 5, 2024 at 7:35=E2=80=AFPM Dmitry Safonov <0x7f454c46@gmail.com=
> wrote:
>
> Hi Eric,
>
> Thanks for the review,
>
> On Wed, 5 Jun 2024 at 09:07, Eric Dumazet <edumazet@google.com> wrote:
> >
> > On Wed, Jun 5, 2024 at 4:20=E2=80=AFAM Dmitry Safonov via B4 Relay
> > <devnull+0x7f454c46.gmail.com@kernel.org> wrote:
> > >
> > > From: Dmitry Safonov <0x7f454c46@gmail.com>
> > >
> > > Two reasons:
> > > 1. It's grown up enough
> > > 2. In order to not do header spaghetti by including
> > >    <trace/events/tcp.h>, which is necessary for TCP tracepoints.
> > >
> > > Signed-off-by: Dmitry Safonov <0x7f454c46@gmail.com>
> >
> > Then we probably do not need EXPORT_SYMBOL(tcp_inbound_md5_hash); anymo=
re ?
>
> Certainly, my bad. I will remove that in v3.
>

No problem, also make it static, in case this was not clear from my comment=
.
