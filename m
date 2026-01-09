Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70BAE3451D7
	for <linux-trace-kernel@vger.kernel.org>; Fri,  9 Jan 2026 22:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767997130; cv=none; b=LQEoVFa+cn66CgYUwobbptHXKzzrz24c4orEngnp7RaRt0wdbhCBr988DCb4b8O3Adou/6thY/yxCd/531x1ou9ymtpMKc5dedR/rdAIwivEjFVQa6hXbf71YLvt6xi/lHW8bkm5OMznFBuOZOgKSQJj8jjPislzKuGgiP5hgck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767997130; c=relaxed/simple;
	bh=7DP4SbOI7MwsA76pyuJXnkVQWxGL0svdQt3P6pE7d80=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZW5eDWGH+CPvbLOLOJ0+1uTxjGNGW4bG07oQdTapflx2mT4ID0TdBTFASu5ZPoaVpiPYPv+wDcUslSabERJTJt5SnOh4EzCntNpl4tCgd1oUvjGi3ZvzJ5Dx79YNTWfBLMZYnACKTpHmuF5aZXWy9sDqqv57Czg+M+WmiLzXbjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mTWgrUn6; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mTWgrUn6"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-432dc56951eso653837f8f.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 09 Jan 2026 14:18:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767997128; x=1768601928; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ItpKy8a2tRkPvLh65km1qhs/wsP1zsrKdWCpxLRhfMM=;
        b=mTWgrUn6smMIcsuwtJDCOqXxQYmRUJjzoCptza0aB9Go866hf25mfD+cx6QboMkD+v
         iVbKqqkJeP4nt8GYezTitpg0Rig0EN6HEGW8OGuu7/mz0Lcrp3rUzctUOIERiaBSRUYC
         Je/n7oNVRtB4cOzkDQAqtUxQA86Aw9ZkZmZafOsoN+F5xfBKpHpnHqOFAnKlv721Q3hY
         jm9yUTseoInScyLeCACJrrSR70G5S5qhXc1MwN8It2OFgkUoXezfdTxGAE9lt98Q4Mpj
         Ljcmf9dqGefL4oxikW3vGDuCfUHcIBF4IiUiCJwXZ7kZvH+g0IdnT3f8+05KUkjoB69o
         orwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767997128; x=1768601928;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ItpKy8a2tRkPvLh65km1qhs/wsP1zsrKdWCpxLRhfMM=;
        b=OzOErakTCCal9ToQr+/OchV7NnGyFmlD85bkVKETHyns6dssL3iUyXFUGFto4Sqage
         HWPVWtd4pWOpfDoXkYSxzUpt4CcomHayoLwKYOn9x+lykfMwpb1BHLl/t5ZNw45E7KoH
         DNHK97yKrA9gu8nzqYyP3DnBDmhNV7OvltNUId+lmDCEeX+NjlgDLc0Q7P4HmxBCHmQP
         ovoO/X1DaeS0J6t5BWmkR0NUdyTUxeC/qUQ5shqGL/qpWNYY1Z9bHgKkCx9T4kz3lLhu
         88KXIxyZ5GRny0JSZnNQwqF5wFRq1WDvJAiNBeiD31NItJba55qDhVfXQWeD8VYH0gPx
         7Tbw==
X-Forwarded-Encrypted: i=1; AJvYcCV9Na9n63Rsgj9syHITI8qUfjPero2faJ5Q/sKJQLAbiRrJv58VMbqui9zVXiR9uccDEl8J3y5RLV1V6IlvyXe6iww=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBNS1dSJ7s1cd2Rh592hadyCTZ5kOrE8EhbfI1VpTAfupMpHkA
	b2TMrzAd1sdcNC6CSNRZbSp2Ylh2fbJ4SfW+R/tHnJBpJIGvdBM24F+8fPcg6RRhfLxTRqN08t0
	2MxbU03H0t1QU0e3QhmstuCFKlgNuKGA=
X-Gm-Gg: AY/fxX67xEO3iNOQto2O/3rwGJrMVxH4aLrbWvSKAQ61NqMURS6I0uOnGN7ACW+Uqnp
	DtOHOVI5TNw2XRyxdnSWylXuqDiAD0MzT6Oeu42XqP/l5Iu7xzOMC3FT3ISMfGLKNJX9kpTgrUT
	EErZZF8ktnkehsxHBYbQodnxWlDQE++Kq/VtrWQAjqONW4MMXuEriS7hxmVuY8HeVnMbFvtUIOf
	o+2iw0mKx8tDIFBCaWmnlHNACL9GeBZ8Cu9k/P5ulrw4bXEgwL5oNXCTXOWZySXLOoHZ1IyV64m
	7yf4mgZs08iXyI/e3oRi3wK3tn+H
X-Google-Smtp-Source: AGHT+IFSRSeqxcL/83us6RFgsLWVachx5Pmr9hMA7/DUx04sE/951SBsyh1BOH6LVMtuWdNm7n+PADNSKu7yXoW1PrA=
X-Received: by 2002:a05:6000:607:b0:432:b956:663e with SMTP id
 ffacd0b85a97d-432c37d2eb4mr15663490f8f.52.1767997127603; Fri, 09 Jan 2026
 14:18:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260108220550.2f6638f3@fedora> <da261242-482f-4b47-81c6-b065c5a95c4b@efficios.com>
 <CAADnVQJMa+p_BcYxKUgve2=sqRBwSs3wLGAGhbA0r6hwFpJ+6Q@mail.gmail.com>
 <20260109141930.6deb2a0a@gandalf.local.home> <3c0df437-f6e5-47c6-aed5-f4cc26fe627a@efficios.com>
 <CAADnVQLeCLRhx1Oe5DdJCT0e+WWq4L3Rdee1Ky0JNNh3LdozeQ@mail.gmail.com> <20260109170028.0068a14d@fedora>
In-Reply-To: <20260109170028.0068a14d@fedora>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 9 Jan 2026 14:18:36 -0800
X-Gm-Features: AZwV_Qiapp_GS-K-9Img7XZ_91c4zgO8ElKLxz0cMYD6_cWQa82tpdZp3H3EH18
Message-ID: <CAADnVQKGm-t2SdN_vFVMn0tNiQ5Fs6FutD2Au-jO69aGdhKS7Q@mail.gmail.com>
Subject: Re: [PATCH v5] tracing: Guard __DECLARE_TRACE() use of
 __DO_TRACE_CALL() with SRCU-fast
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, LKML <linux-kernel@vger.kernel.org>, 
	Linux trace kernel <linux-trace-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 9, 2026 at 2:00=E2=80=AFPM Steven Rostedt <rostedt@goodmis.org>=
 wrote:
>
> On Fri, 9 Jan 2026 13:54:34 -0800
> Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
>
> > On Fri, Jan 9, 2026 at 12:21=E2=80=AFPM Mathieu Desnoyers
> > <mathieu.desnoyers@efficios.com> wrote:
> > >
> > >
> > > * preempt disable/enable pair:                                     1.=
1 ns
> > > * srcu-fast lock/unlock:                                           1.=
5 ns
> > >
> > > CONFIG_RCU_REF_SCALE_TEST=3Dy
> > > * migrate disable/enable pair:                                     3.=
0 ns
> >
> > .. and you're arguing that 3ns vs 1ns difference is so important
> > for your out-of-tree tracer that in-tree tracers need to do
> > some workarounds?! wtf
>
> This has nothing to do with out of tree tracers. The overhead of the
> 22ns is for any tracepoint in an in-tree module. That's because the
> rq->nr_pinned isn't exported for modules to use.

None of the driver's tracepoints are in the critical path.
You perfectly know that Mathieu argued about not slowing down lttng.
