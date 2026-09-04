Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D33953BE620
	for <linux-trace-kernel@vger.kernel.org>; Fri,  4 Sep 2026 03:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788492633; cv=pass; b=QhgghTtl4I5qRbGt2ZovEeQqD86wMk/gJ25eYcwz7L7M4D8s9FDTJU9qDDrt1r/t1SLcSzu3JdBc1CtV+iIsGUOQaF0xFfj+PdjWpZuisr2FyAtrSOQ5waQWBbyP/cJOgMMe+9mWzyEW5hMQbEUDs/mSj7Nw6oZbVXGN7HEyU4I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788492633; c=relaxed/simple;
	bh=89OZ28yLXrgIx5/x+Z6isXYU+LEYVlikGayjBJlRd0o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MquSGRVI5SW1W+dT7rPlIx9LcL51AyvnTPzwSbDeVLabQX2DPFpMwEvGHALb4uANOXweUn01EkymEV0B+ApV9v0QL2DMsi7F59chAsVLBlLzjjV0TjEldBgwNL8yfi5QQ8oF9ncFjTQ0edRNn1pGAjyh6dLx330k7VoW8ucE9X8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DScELcuC; arc=pass smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DScELcuC"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-85339ed040aso400314b3a.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 03 Sep 2026 20:30:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788492631; cv=none;
        d=google.com; s=arc-20260327;
        b=pUDWq2v4vTw68p6fw2ajDLiW6LUU1LD6vDXwRSJ0/3dyvuvmud90jdzsz1lAD+YPwR
         PbXK6TUyB0v5lKmjjHRxfTK8ycTSddPYXmDz+d45QiBhq5xtI78Hc2PyktulcUTywE2P
         YlqgVvY9zPdKuJAy/zOtzpmKnzzgwaqtU9jJ063ddYAkUW+tbjHU+Pa5CQ47gvtnAAy+
         w8UqPDarwxAve/3qEY3RMbWrTk4Izwd7gMdQFyF7qZVuFXhgES6pEwJ2txvXfOdyR1oY
         joLr8S1ZqiPtqXjbQuiDH3l2lEy+BJib5V3MlVLM7sWWw6VNOR2CikOCTbGW2HqIPXqm
         PhmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=89OZ28yLXrgIx5/x+Z6isXYU+LEYVlikGayjBJlRd0o=;
        fh=P2rzoquj2sF4tCx3pVrgebhthHa1CK++ZIdguCvw2NI=;
        b=fGW0+pjfHd1mmimhv1XwGBnxS7o9DqgLI1a0DcpgupzjOzIgMDr/LERctWU63Eum1J
         0twWSP+HbEPCfo23+I/kgFCP6f04+ReQtb37w7OODgnlQmNViipw/K7vGNEF6aUlDFgs
         jSh05FY6jz1TkpLTCMp2bG6JKOt75MIkL+NedHvgpUrO3uHkOOLXWMFoPBbdwfAfHH9l
         yP4d7f5l+jkpJ9WzGozKFk3A/gefCjfOqjhm5DBbUe/66qYqLZesfrdB4FSaoJQZoS9K
         QeAPWOC6ND7e0FvLFwxsYgLBBLsNozYL2qDDyhbhrtwl+Ivx6q2bRt60klqdDI03dWxJ
         IqAA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788492631; x=1789097431; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=89OZ28yLXrgIx5/x+Z6isXYU+LEYVlikGayjBJlRd0o=;
        b=DScELcuCtb9njzxK1FBbOSv40paWPLLE1GjOOkMorvsNbq84XSpo7TZu9tzsRDFEfd
         m4SnWnVQYv0Qv73p9Zts2mnoDB1GQmzVgnH7XAzwGZ5+r4MEY9jys8kRFkhkHeS++nVb
         fzRxtWsZqIDZ6E4vCoeBLXQWdM6R0mmarOqSgy1LofWrnJeqprtr3sVfzGUJeKFUWCB8
         etZt294N1SZHavEsg1D04JvYSX/vQ5FcXoT+f8S6PHe1hy/ZXTQyacttti+ddHRYz0DM
         tOx2Yo5D+RnJAV8dfsiFyk6Ia9D4eKhLmlgy7wG9fN6g7VfdY4RKJK5fqyYh+aozjMw7
         hfRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788492631; x=1789097431;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=89OZ28yLXrgIx5/x+Z6isXYU+LEYVlikGayjBJlRd0o=;
        b=h0e0d3Hp6O2HjteTk2bHzevuR2KheSFwyHqmnkhh3UGKVQMkFZI8sZzV1FAx/O4Kcs
         nvHqAtgk1kGGpkaNg1v1Q+ngMtUfBJiRKtSTQ8i2o1stN32zUKql/LDSJoQ/6wEM2qTW
         IADkQDbGIAITIlpQi2eDhBNmMkOda3Im1MUThjDyd6FF7KvDsMq6VXhCzbYYV52+YPMh
         dILVGj1ksYTHBonzwaM2kx6gNgs3kOt8Ca02PtognyIZhpEP5s8P92Fr9YWN12KX4MBH
         YPrVJdQ6O+r5m9M9oVDfmUA5VHHeJ1wkT5SUFkFOKf07O8xpcB8TytL8JPMrMI9g8cBa
         6MTA==
X-Forwarded-Encrypted: i=1; AKwUvByn31XND5a5j7AK3DBoS7Bj4s7EP9PkWVqjt2A1x1Y4bmX9IkHEGGYoGb69d3XoaGk7KC3/IdDTF6Yag65hqUKmAlA=@vger.kernel.org
X-Gm-Message-State: AFuF++mdkAS0xr9psxL1ha6GnlydYMeXMPrzJ9/VuHyDAcLLxq7rgr3f
	N/zsHMjrC52oE8TdZrZJT+IxlZr4hv/sWjkvpzehJVPksBO6yBdybrjSZxvZdTVIsXODTV7JE0U
	Fd4dOQMH85MbLdDUD472M5eR8UTgcBXyEXA==
X-Gm-Gg: AYBFou0EGXqOlqV8TeeHL7FYTsTc54gnIMbT5wcKMoX5wveiFhaZ7pFRw/AXjXCFv2Z
	4+Q61oQ2ju7ve2KCpol7voLNGtGiOo/YUJ5vR6Lw8uq7rGCA916zBam1zKzYR/kt9uSThrY9SC/
	DJwef/bNB+FBzWTRs2aJ88pbK8noehcWOf8rV5X8Vq0S9EdlG5XuBFXL79zdxsTZMh8msVtjm6z
	+vXWrUPgjo5QM40Yr2koTfWUmzn+7VX9bqCU8n7guHsPx2+eNr1c7b+ywbizs+yCXnezxtOLFlt
	s9nyk5qct6vMH1gNB2YDAQSwCRyP8vIOyy9uIAyeyX4RuAiBuNfaAdgG4PRlHQU+PcU2vH/H+ZX
	yrqWWLl2Gk8FiDSSem66n/EJVoV4DQpF6d/Dk0O0=
X-Received: by 2002:a05:6a20:e607:b0:3d3:adbf:777f with SMTP id
 adf61e73a8af0-3da3a16a54cmr4369460637.20.1788492631017; Thu, 03 Sep 2026
 20:30:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260831090524.106845-1-gmonaco@redhat.com> <87se3sakgi.fsf@yellow.woof>
 <df6e9168cb06c35e21db7f9d17cfbca6bd87005b.camel@redhat.com>
 <DL5B40CU17WD.3KD75URQZ6RRR@gmail.com> <eb3dd8158942d663ec8ad4c529eacd666c5f96d9.camel@redhat.com>
 <20260903090211.50d15220@gandalf.local.home>
In-Reply-To: <20260903090211.50d15220@gandalf.local.home>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 3 Sep 2026 20:30:19 -0700
X-Gm-Features: AcwNN1WyvVt58Liz16r7F9vxR4fcT-OGFxVmu7RBiJk3u4EIptgNFRgcOxI3zUE
Message-ID: <CAADnVQK8e1Qp9rf1zThZxb3vr4Gc_bpo0nqpEO2LdnEwHdKokA@mail.gmail.com>
Subject: Re: [RFC PATCH 00/20] rv: Add support for BPF monitors
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Gabriele Monaco <gmonaco@redhat.com>, Nam Cao <namcao@linutronix.de>, 
	LKML <linux-kernel@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	Wen Yang <wen.yang@linux.dev>, Tobias Schaffner <tobias.schaffner@siemens.com>, 
	Viktor Malik <vmalik@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 3, 2026 at 6:01=E2=80=AFAM Steven Rostedt <rostedt@goodmis.org>=
 wrote:
>
> On Thu, 03 Sep 2026 09:21:18 +0200
> Gabriele Monaco <gmonaco@redhat.com> wrote:
>
> > On Wed, 2026-09-02 at 18:57 -0700, Alexei Starovoitov wrote:
> > > I don't think bpf fits here. I haven't seen active use of RV and even=
 less
> > > so of any request from people who want this kind of programmability.
> > >
> > > So Nack for now. Sorry.
> >
> > Thanks for your opinion, however it sounds a bit harsh to me.
> >
> > RV is clearly not a popular tool, but I wouldn't say it doesn't have ac=
tive use:
> > we're actively using it to validate the deadline scheduler/server chang=
es and it
> > already found a number of issues (e.g. [1], [2]).
> > The RTapp monitors are used to validate if userspace real-time applicat=
ions
> > interact with the kernel in the best way for predictability, as far as =
I'm aware
> > that's regularly used [3].
> >
> > In my eyes, the missing piece of RV is in fact this programmability. Ad=
ding a
> > monitor now requires to write in-tree built-in kernel code.
> >
> > There are strong use cases for domain-specific rules that aren't genera=
l enough
> > to belong in the kernel tree:
> > * stricter RTapp rules that may not apply to all use-cases
> > * verify some exotic system within Linux (e.g. a co-kernel [4])
> > * modelling for functional safety certification process (used for in-ve=
hicle
> > OSes like RHIVOS)
> >
> > BPF seems the natural tool for the job to me. Mind that RV monitors wou=
ld be
> > simple users of BPF, requiring only modifications in the RV subsystem b=
ut using
> > standard BPF facilities.
> >
>
> As RV would simply be a user of BPF and not modifying BPF infrastructure,
> I'm not so sure you have the jurisdiction to NAK it. It would be like me
> NAKing how you create a trace event.
>
> RV monitors are a very good way to make sure the system is preforming
> properly. This looks exactly like a perfect use case for using BPF instea=
d
> of having to install modules.
>
> Either BPF is a tool for the kernel or it isn't. You can't judge where BP=
F
> gets used. You can only judge on modifications to BFP.

Ok.
Please add
Nacked-by: Alexei Starovoitov <ast@kernel.org>

when you submit it to Linus.
Let him decide whether bpf maintainers have an authority
to say where bpf is used in the kernel.
