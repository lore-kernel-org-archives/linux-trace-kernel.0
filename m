Received: from mail-yx1-f67.google.com (mail-yx1-f67.google.com [74.125.224.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 791B92EE612
	for <linux-trace-kernel@vger.kernel.org>; Tue, 18 Nov 2025 06:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763448411; cv=none; b=RKrnTJANAi00g4LkV9FTPCfnZ5J1xNKDuDkB5JS97PKTvERKZI4gwqyYRyTlz60JHLpNAei4Gz74J4fcQA9kt9C7HSyoj6arYlAKh2lxCEHYS5ncIpN3HEC/AFYiTqi0FiI8L4SiRviQUWZxcWsjNgO5vETqbg+hQbEIUxqYLUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763448411; c=relaxed/simple;
	bh=ZM509TdrsMVvZUG9fElgf0TFKBHZxtBr2Zr0So5v7j8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pNyAKPZR/cDQzoFCBCsPbTij38ccp5J9cGfKbpyNGs9lGXi8dZ0Zwyt6yFx+iWVnjky2JqmDPl4eGo/n4RLfX3E4PxWMmfX+EckL3rm/ul/Bfj7OYbUfjj6mXm+g4echNE6dgpw7MnUc5mlxbpTo0Me9wn3dQloVAqwEY22cBFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sd6Dw0h3; arc=none smtp.client-ip=74.125.224.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sd6Dw0h3"
Received: by mail-yx1-f67.google.com with SMTP id 956f58d0204a3-63e16fbdd50so4657291d50.2
        for <linux-trace-kernel@vger.kernel.org>; Mon, 17 Nov 2025 22:46:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763448408; x=1764053208; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZM509TdrsMVvZUG9fElgf0TFKBHZxtBr2Zr0So5v7j8=;
        b=Sd6Dw0h3W3PKcpO5TQf+rT6GUj+ybFzGSJXUc4TOJx6B64w/VD+Fy9ubH330am00Up
         JzktrEM3pWOtulAGm/xT7ujXlbtgWz3SHPyfCE+Hk0jaiB3i/TIa0U9yrJ/mHTvfasdK
         DVAyAS+IJVz0Ip8QjXnQOBLRpR2YgG5smuWXjCabHqV7w+LaRVOG9PDohGQoR5OUYhpg
         DKYHb7WXPA3FWA/xHUjBsHXi+xHpbx6HOyq1SjB1Y0FigeGcn5cc96OC+DGorrFrDB4S
         lAuvWMAqxZKqcNITq//vQ/vxwK9Q5MiHBuV+5lCffnZtHZp0BjzQexWF05pMJOBVFOTx
         RHww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763448408; x=1764053208;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZM509TdrsMVvZUG9fElgf0TFKBHZxtBr2Zr0So5v7j8=;
        b=jV+1UN3RaPnA6wnwTBKotbDa0EmG4iBmMtuajRB6TMz9jjrq5i9URe3Te/tADHChps
         /HHd6GKA7Caw8clOqm4l5+WbqrR/bBq+ETXy9yFxvavsO5/Z2fpCz59p3iDL8Vws17xt
         aFZxsRJ/Gah6MoSvl39aRDRWkzqUR1TAgZm4WrrMiqtkRzc99D/WlN+ZBfXJsdJUblnC
         MMd/Paqx2RAdZni7dzSxdBYper+sD5EJHDGmixkO+ANlAYq8Loov/88prRuh045BZJyc
         OifZR2Rufa4wG7QgI3M8o/fy1I3dQ+vj1x7m1l/W6TTOi1uKWtWkN4O6J7Gp1eUkwUu2
         kEgw==
X-Forwarded-Encrypted: i=1; AJvYcCVqdYHQefD8uX5lXLJPgK97luO7KT99elP1WuE9trYKBoRZayz2Gy5zlKNJedg/FSZ40+FIASn5x3ydNgzx/QAxCUk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGOZW947FDrclRrDr19MSac17Ve/fP7BOODmAJh5VdkU1CHgvo
	nZXX4xfpc7TX5cr16rPcwhbpwCkyWBacTG5JDcSdeAB/7Vf8+baQkecLAf3t5S4cEz2bKqkmaEu
	40vOl+nyXRjPjdqE8soN/41+Tx0Es/cU=
X-Gm-Gg: ASbGncsyFcP7Fhygs8Xwl0H4P3xNpu+zi4HjX0VKhYC1lTpvC387GGJFJFvfd7u2bRQ
	h5XvVl46u7crFDRC4aJvXUPQYfb4jSoshlF8hMkFMR8CzwP1r2C3aVk7bf+DZCpJ+JnJM9PzMdn
	mFgABik1Ef6oogKwTmbPXdIZk8De1rQyld5vw+/sU8UbSZVKPQcOyfWxFMuZzTcqoqmoWPWN5pl
	t3YppBEYiqDh/yJjInq/hQQSDgAvJLmYlaCdvtcS8A68GfITUCux2CgYCQuiIsak8Huc+mMQS4=
X-Google-Smtp-Source: AGHT+IHLcI+E2oqP8RTXSR9gKpQj6lng7eOpifagmigD8t0VvN1gPgUYZt3oPg+e3+Nyw9tka5+bLcD5C52s3FnpePk=
X-Received: by 2002:a05:690e:d8b:b0:63f:b68b:1eb8 with SMTP id
 956f58d0204a3-641e749e64dmr12659196d50.7.1763448408436; Mon, 17 Nov 2025
 22:46:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251117034906.32036-1-dongml2@chinatelecom.cn>
 <CAADnVQK5U28Wv2tSkymZY6ixCoUrSDoohB5wJmpyZL7t-Czk4w@mail.gmail.com>
 <5027922.GXAFRqVoOG@7950hx> <CAADnVQJtm3pHFxYD=_FPJFiMNXwo-scj5CoNL5jHbUn+E0zvrQ@mail.gmail.com>
In-Reply-To: <CAADnVQJtm3pHFxYD=_FPJFiMNXwo-scj5CoNL5jHbUn+E0zvrQ@mail.gmail.com>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Tue, 18 Nov 2025 14:46:37 +0800
X-Gm-Features: AWmQ_bnvSsuwJpY8HWZKRpDxkydy9SP5F24xKqUthKJdjXwO_Hh2R_aqfSKmGpU
Message-ID: <CADxym3bsfSzFXEbEX7FTnuD-J7Xqbyq8Oeg7nhOjvgcVmu0mMg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 0/6] bpf trampoline support "jmp" mode
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Menglong Dong <menglong.dong@linux.dev>, Alexei Starovoitov <ast@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, jiang.biao@linux.dev, 
	bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 18, 2025 at 2:41=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, Nov 17, 2025 at 10:34=E2=80=AFPM Menglong Dong <menglong.dong@lin=
ux.dev> wrote:
> >
> > On 2025/11/18 14:31, Alexei Starovoitov wrote:
> > > On Sun, Nov 16, 2025 at 7:49=E2=80=AFPM Menglong Dong <menglong8.dong=
@gmail.com> wrote:
> > > >
> > > > For now, the bpf trampoline is called by the "call" instruction. Ho=
wever,
> > > > it break the RSB and introduce extra overhead in x86_64 arch.
> > >
> > > Please include performance numbers in the cover letter when you respi=
n.
> >
> > Hmm...I included a little performance, do you mean more performance
> > data? Current description:
> >
> > As we can see above, the RSB is totally balanced. After the modificatio=
n,
> > the performance of fexit increases from 76M/s to 130M/s.
>
> I saw that. I meant full comparison with fentry and fmodret.
> I suspect fmodret improved as well, right?
> And include the command line that you used to measure.
> selftests/bpf/bench...
> so there is a way to reproduce what patchset claims.

I see. "fmodret" improved too, and all the BPF prog that based on
bpf trampoline origin call have a performance improvement.

I'll add the full comparison results in the next version.

Thanks!
Menglong Dong
