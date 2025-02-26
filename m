Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A7F119A288
	for <linux-trace-kernel@vger.kernel.org>; Wed, 26 Feb 2025 18:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740594458; cv=none; b=Z6a8B+jA13BjzGzVitboR+lxBcF/dhnSHhga/vIPoIwRkHtsIzQb2NFYDFMztdWyfoEt2RRQlh62tvoeNWn2J3JM2fALmOTPRGQ7ttM2iSuU+8PVb5Z22kdDLIQIt65mEwUE+sqUwzWV+SuoL6XCryvl0ZSf6y09gYo5bUvUv0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740594458; c=relaxed/simple;
	bh=mDtSh+HotHwurwAnAYMDhlSrEAza9DEiUdKcOW4Tofc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jFnFz0gi0GnhMQA3FMZRozdnR0AIncSVxfzThFeCzujEf4jE8mvkULBOk7P44gIPxL+MM+87DjVzkmAFAMQ12H3zdfFhAzBKMHnORux6nxZgmSyvS86+wUyu3LuuU87cb98PkDWNMMtNECP/d++UvZL6rrwLHA1H1zXC12pptvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OO1aq1wo; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OO1aq1wo"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5e0939c6456so3467a12.3
        for <linux-trace-kernel@vger.kernel.org>; Wed, 26 Feb 2025 10:27:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740594455; x=1741199255; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wbGtNrkjyYgBwz5N4tw3xyPtem5v0qKByNJMW7ySY+w=;
        b=OO1aq1wopHfDM+lD8qGRFMqeZJ2sGH1q7obXwZno7UsWLKg5uHHPVSz3z0PhSdrokS
         Q+zU8R5DI45MB6sMckzr4pHmiXeFBPmeKD+Z8xcdBzXN190zFJ27BxW1e402nZThBWhb
         G1PZ0X0JbCVJSiq/p9xpPvLBxDOog7QQjXrt78NdCVfVx1ZBfMja76wuDdaKuJiuQqSJ
         03LQ+U7wpHoTcHrX8HHHcczS3tjNCbfpaGGPRTwB3avKZEtBSxPMGrNUdG0Mb0HBrUPX
         854L9Oiht+eVvPz17+oerc/NoIfbRy9WQwziL+JG/4Pm+qMMYrHui5qoc8RuVoYuGCC9
         Qo5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740594455; x=1741199255;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wbGtNrkjyYgBwz5N4tw3xyPtem5v0qKByNJMW7ySY+w=;
        b=KOuyxWWqrwknycQNCF/v3RxmuJzKItXbjOSsxEewSAg2h04lo3Ity/q2UTtuloiC9d
         UBQ9wHxZj42hPhJ2bfYb2saa/iRspCFHdm80z1AWRoKwwNc3Vc16hGIYWItj3FJE0RJC
         UJ6Fdnzdp9B2BgVou7ONqfWwbikEWEibXLPJlZ8e47jxnER2vS+mIQIaHj6dFO5awrFl
         PSMF5mD0x6+1Q+3SHSaROcEOfHJZDZQVmoauWJjj1poQe8BiNYpZEB60nEzZ6ZEWgZLL
         CxVDanuYyK2lptu4buWhRILX8rn0ww/I+k7jfmz+OOB+8qI0q6a8SCHjBI5WSoKJS/YI
         sdfQ==
X-Forwarded-Encrypted: i=1; AJvYcCVE2rM9gWxtIHDdOGXNxDuufXG6i70sUEjqYGP2swFyEVWOlcoXAbZYJDf5izLM19P1eQYgrB9fwTdAAMcAuplB1qc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFZfHu2JJQfPMalNsD61s+4NwN2BBBaQ2a4Xen8StNafuvsXQm
	0mHJIaSztJ9qOEqHdEBG5WWAKzi4kDWWlycZLikv/1M1eSJtV99koRVwVonS/e7wKpTZAYJGjsD
	wut/xp2abrkX31WECITAMO6vPLsFWq/xp0H6Q
X-Gm-Gg: ASbGnctSlp2Wrm3yT8zFDTtEPX86DjpNFAPMcBKX5fvcvFxWHeHlVUBQ4QwGTxB6vTD
	PmHePB0SjNNw+ZVbUmV4zgMcMM4Xp3TKOdR2HGaIkkoQyPesAchszDBVTsizgAs3JNenBpWx3NP
	sPYxAFeQ8=
X-Google-Smtp-Source: AGHT+IFZBOT6NZJ9lqdYQz9B0TtJE7SWPmI7w9k6cI2+KrhsOlofGrsGYOh36W2Hth5j++vVYOH1PeRrrnRFKS92TvY=
X-Received: by 2002:a05:6402:26d1:b0:5d4:4143:c06c with SMTP id
 4fb4d7f45d1cf-5e0b7222d3amr22842943a12.23.1740594455410; Wed, 26 Feb 2025
 10:27:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224-tcpsendmsg-v1-1-bac043c59cc8@debian.org>
 <CANn89iLybqJ22LVy00KUOVscRr8GQ88AcJ3Oy9MjBUgN=or0jA@mail.gmail.com>
 <559f3da9-4b3d-41c2-bf44-18329f76e937@kernel.org> <20250226-cunning-innocent-degu-d6c2fe@leitao>
 <7e148fd2-b4b7-49a1-958f-4b0838571245@kernel.org> <20250226-daft-inchworm-of-love-3a98c2@leitao>
In-Reply-To: <20250226-daft-inchworm-of-love-3a98c2@leitao>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 26 Feb 2025 19:27:23 +0100
X-Gm-Features: AQ5f1JpnOes8jn9vTB8ptmBjvNQ7ShU9fUjTVWe0lA4VmH95ahg0G8P5C9WLQq8
Message-ID: <CANn89iKwO6yiBS_AtcR-ymBaA83uLh8sCh6znWE__+a-tC=qhQ@mail.gmail.com>
Subject: Re: [PATCH net-next] trace: tcp: Add tracepoint for tcp_sendmsg()
To: Breno Leitao <leitao@debian.org>
Cc: David Ahern <dsahern@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, kernel-team@meta.com, 
	yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 26, 2025 at 7:18=E2=80=AFPM Breno Leitao <leitao@debian.org> wr=
ote:
>
> Hello David,
>
> On Wed, Feb 26, 2025 at 10:12:08AM -0700, David Ahern wrote:
> > On 2/26/25 9:10 AM, Breno Leitao wrote:
> > >> Also, if a tracepoint is added, inside of tcp_sendmsg_locked would c=
over
> > >> more use cases (see kernel references to it).
> > >
> > > Agree, this seems to provide more useful information
> > >
> > >> We have a patch for a couple years now with a tracepoint inside the
> > >
> > > Sorry, where do you have this patch? is it downstream?
> >
> > company tree. Attached. Where to put tracepoints and what arguments to
> > supply so that it is beneficial to multiple users is always a touchy
> > subject :-)
>
> Thanks. I would like to state that this would be useful for Meta as
> well.
>
> Right now, we (Meta) are using nasty `noinline` attribute in
> tcp_sendmsg() in order to make the API stable, and this tracepoint would
> solve this problem avoiding the `noinline` hack. So, at least two type
> of users would benefit from it.
>
> > so I have not tried to push the patch out. sock arg should
> > be added to it for example.
>
> True, if it becomes a tracepoint instead of a rawtracepoint, the sock
> arg might be useful.
>
> How would you recommend me proceeding in this case?

In 2022, Menglong Dong added __fix_address

Then later , Yafang Shao  added noinline_for_tracing .

Would one of them be sufficient ?
