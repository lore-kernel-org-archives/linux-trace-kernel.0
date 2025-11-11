Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C34234EEFA
	for <linux-trace-kernel@vger.kernel.org>; Tue, 11 Nov 2025 10:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762857538; cv=none; b=lLjB9yrzQOpDeUP+5TiPijnGlhvXOVO0EzLBHqApoEABwY7PMvrq16xdFIaOuGyDSmmR6O2XVI5l6g/K2vKa7Wj7Ksl+WBScXaN/62WUNwa5IlhmCnvaDRqUGlFh1+PiEwwVx9NgDb8POaTafwblynwpN/CLGdkR/fRG3/9NQvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762857538; c=relaxed/simple;
	bh=O5hSvrZ5NtQmMb20B6inDgRRpZm/LjVqfNIdDi6Qrsk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bbwSD/Ypec8zQ4zZHjLtCt4wfqeHhIMR01YnQX+dMAi38dufDkSzsgbr7htDdYXHS3yHrsyEHU9v+oiioME0bmh89EBhUd+li9DxdYdQg+jmZ7Ph7STjk2F9cTH5qWVtNEh/VEZt57Yl32EwRmpgP1XpCgMdWLplBj4YjO2Pld0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i/Wl7g0p; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i/Wl7g0p"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b7272012d30so748072566b.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 11 Nov 2025 02:38:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762857535; x=1763462335; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gWaDqifCzTUEmxDcL1a0AAX24KjwxYVqnZdZsggRtpA=;
        b=i/Wl7g0pcNEVlGX4HB+Ak8Xpp1X3y+T+lTAkUX/mvG73vyyOabpbe/LuzC3mJaaHDd
         bgwLlloCnh65FbkxV0YJUdDv2s4Np9y12CtHeweyWNUVVgkmDak8uFmcN8FLl1XXzeV1
         oWqrDcOIcKkymD/IMmumXtgpeEyw0XqORJ3bM9cVqBRVBX/yjz7nWD6fyV7Gx8lR0qob
         P/z/hMS46KVRTWtXiJ+rfLqUvScA0XS5zdShX0PSlD1Vw9724Xunutj9gQj31RQc8V/5
         rjpGnm2XIuo0PmyNdUzAB1nFmNAcu7pOz0mfJWgXFSZKv23bBsVWAQBehdE1bfGIsOtk
         RMCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762857535; x=1763462335;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gWaDqifCzTUEmxDcL1a0AAX24KjwxYVqnZdZsggRtpA=;
        b=ewkYmXeVNoWqtyMtbi1GVblftaARI2lwIjfxHVL9aCtpaEw3yDYdvys7yc0utpLPUf
         TzOfdrpRjMqROTvgUXRQ8UpauU2tYLdeRcg7Y9jfE+I21caLgOgR3Z2ba53jUnmtuPZv
         SV9fGMZGo82n3SmYUfc+8II5+VH6I4B49bHTLbimFLZs/927DhFFyaoCgdes/XVTppVX
         dtFXisC6Vg/7R5UDcw+RgUXuW3/xvbrPy2RNsxvTfryhB0qwleKyhvtYxqr+Dp7vaXB6
         qaBNAtzao5PQ4jJfiw8odQ+WW/Qz5OA/tIn6BYk8nEvvuc2wgyZBKTnNtdnkB32rQ3Ax
         E9sg==
X-Forwarded-Encrypted: i=1; AJvYcCWgeDgZlXApxLjs9w36JSiN8RLB0fmWA51gakNIHKoMgVIRsn1UlZQ++4lyhKE+xJTjxTS8K/5hM8NEEcqeR1Jbmys=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzv897qicqbRu8Dhmbhyepb2N6BonyZGADDvyVirEiM2wDYa35E
	UIb2F6ZThO4BYoBUj4wLKDD/Fdq1Pv9j+uweYU6kahluisD3HLvxfmxhy+3Iw7H+WFdZ2NkpcAF
	2eQ3/sTiGki/q5/4r2rXE3oW/l1NAaxc=
X-Gm-Gg: ASbGncsUwPyq796uuZsV7RLS7LuSp760+3oJV336NoUw5bDAsoJl9CyxLakiP/ZvQCB
	zkUERdZzht+LHpPdXVtw8yOFdFWlKpJ4aF0XQGHbMp0tUP4lNJZE4E1hJngMmHEJT4icaReB3Og
	HZndDIjKJG9WG2NHE79NH9f2YcLFaqiBnm3aTjkMKkaTXjrSj7Y4DMu+y4qkao+wEJsjSXDdPbf
	JLhg8gayXupjMUzo1qrXzDP8T1ZSVilS3llbx9WntCB5g+eFg5jUhO0Drg0OflfIOsMb0sGuA==
X-Google-Smtp-Source: AGHT+IEMIpryibnM9iQKFE02l5VsRmIUq6YWhbumv4J4Nbo9bRfNm0UoT3YpV34bphX68kVePuRIljgGzakkrpjrPEs=
X-Received: by 2002:a17:907:7ba4:b0:b73:2bc4:ebf with SMTP id
 a640c23a62f3a-b732bc41087mr12957966b.2.1762857534366; Tue, 11 Nov 2025
 02:38:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251015114952.4014352-1-leonylgao@gmail.com> <20251110183854.48b33b50@gandalf.local.home>
 <20251111081314.j8CFfAD6@linutronix.de>
In-Reply-To: <20251111081314.j8CFfAD6@linutronix.de>
From: Yongliang Gao <leonylgao@gmail.com>
Date: Tue, 11 Nov 2025 18:38:43 +0800
X-Gm-Features: AWmQ_bkXTkkKFQDSYB12CftXRz5KwgLvgCm2SiXmqDL3Wvm20hSm1tBdpgZSm1E
Message-ID: <CAJxhyqD1kUmraC-FxvkyMssKWdyX4BkpKoH7Agm7c2FYTd6EjQ@mail.gmail.com>
Subject: Re: [PATCH] trace/pid_list: optimize pid_list->lock contention
To: Steven Rostedt <rostedt@goodmis.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Yongliang Gao <leonylgao@tencent.com>, Huang Cun <cunhuang@tencent.com>, frankjpliu@tencent.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Steven, Sebastian,

Thank you for your review and explanation.
You are absolutely right. I overlooked the case of PREEMPT_RT. I will
look into other possible optimization methods later.

Best regards,
Yongliang

On Tue, Nov 11, 2025 at 4:13=E2=80=AFPM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> On 2025-11-10 18:38:54 [-0500], Steven Rostedt wrote:
> > On Wed, 15 Oct 2025 19:49:52 +0800
> > Yongliang Gao <leonylgao@gmail.com> wrote:
> >
> > > diff --git a/kernel/trace/pid_list.c b/kernel/trace/pid_list.c
> > > index 090bb5ea4a19..62082a4f60db 100644
> > > --- a/kernel/trace/pid_list.c
> > > +++ b/kernel/trace/pid_list.c
> > > @@ -138,14 +138,14 @@ bool trace_pid_list_is_set(struct trace_pid_lis=
t *pid_list, unsigned int pid)
> > >     if (pid_split(pid, &upper1, &upper2, &lower) < 0)
> > >             return false;
> > >
> > > -   raw_spin_lock_irqsave(&pid_list->lock, flags);
> > > +   read_lock_irqsave(&pid_list->lock, flags);
> > >     upper_chunk =3D pid_list->upper[upper1];
> > >     if (upper_chunk) {
> > >             lower_chunk =3D upper_chunk->data[upper2];
> > >             if (lower_chunk)
> > >                     ret =3D test_bit(lower, lower_chunk->data);
> > >     }
> > > -   raw_spin_unlock_irqrestore(&pid_list->lock, flags);
> > > +   read_unlock_irqrestore(&pid_list->lock, flags);
> > >
> > >     return ret;
> > >  }
> >
> > Unfortunately you cannot do this because this is called while holding t=
he
> > task pi_lock and rq locks. In PREEMPT_RT() the read/write_lock_* turn i=
nto
> > mutexes.
> >
> > Sebastian, is there any equivalent of raw_read/write_locks() that can b=
e
> > used?
>
> Nope, no read-write lock that can be used in atomic sections. Well,
> there is RCU.
>
> > -- Steve
>
> Sebastian
