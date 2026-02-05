Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D28C542B736
	for <linux-trace-kernel@vger.kernel.org>; Thu,  5 Feb 2026 15:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770306933; cv=pass; b=LGCpW670xrZknh5zok2PU2+S0pTIBWqBC31U0Q7t36yoGKfc57jZBgkWI/xnR1rDv5iUOgic5x/dhP/zVhwFDauLIhj0A3zydBWW2wYBGPDgnfh0OPWLSbCayjs5uEk1EU7vgWEQcSFOtvw6Qy/yQbnclzK9LGgb+x5a3xfDz5s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770306933; c=relaxed/simple;
	bh=ikZuoZwFDu6wsRXMDSCtLv45mAIw9IwBWA66ewbZQ8s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e69zfa7ao3iKLttnAh1bz9e4A2jM5GLXiY7TMugIdTldP1yLdlnq1n3PnFFmdGM16I6dM3k9M5h274sC2JQEC3QR6DGn9nK5UHJQ8jidP7U3lkeL0pmKO/3ohJVsh+9/IQpb0tD0p7EI2/lXUo293SXG6k3j2L4yg1TRgQWGqBM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cg8VkZZZ; arc=pass smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cg8VkZZZ"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-432da746749so749884f8f.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 05 Feb 2026 07:55:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770306931; cv=none;
        d=google.com; s=arc-20240605;
        b=Hb9fpf1Hx8i8bmksJ7fY8jf2ztwdgehXunKAHXgvJOqntsokxv3H3RBmpo+uG/JLFd
         PQJsvfdL2nYTM0EW1rwJ//mTQ8ee9SOPRVFOjR/2axSYP57E7KI3dYbvOHJT0Hwutgri
         ajAIP9YlFp6ppAueu/TMGW+nao+U/WsL3HtjtdFsvfTr5jbFsNOoLy0pM4YESkuHjgfY
         dIUIg6kySTwDm+fNGAiAhCKX9NGYcKidJAGJvZDwzZsX7oNlM6RxpMtyHhRx6aj6n9Wq
         hG5gyROdd0ehh5XXn4QpTFyuXU4hteRPWC76cwwYBWpzT2EJs0F9AGdrJX10hXc70fcT
         HC+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Td5+tdEPVS1cr2PW4mwhRLoRhiYDMTcwTL8PbM8B30E=;
        fh=td3250EDVp7Os+z0vxDOfklfUexidKEnNbmSCUsqfLc=;
        b=jgCldvTkkpFIwwW3EplcLHktjb6pBbyGACwxhRCpjqI/rDLveQONt4V8bT5fvPP7Sa
         mqPB3H7fvd2c1nA75ONxO/S6sIDm3a0FsIzqQuCOpz4mSlyuz/b5FEggB1rdYiequHEF
         VWNesK1qQDQpHH7NzYW7SMLp0G2ShegCoFAqiII2jWxjTotE0qLT+Crxo7w4HqmY1deL
         1LBeyTdl/tPymf6ifgkMJ5uA9Xl/v6ilRAJgmZXrB/Ub6qCMdbZAGrliper0CcBJMWsg
         m8QsLIoo3xaeoKrqPFyLh6kRt5URYmDQFkKqCnV6weg7DEi8yW6qWVj5S2EFKbEafWqu
         X0+g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770306931; x=1770911731; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Td5+tdEPVS1cr2PW4mwhRLoRhiYDMTcwTL8PbM8B30E=;
        b=Cg8VkZZZ8KKR5i5RLrYiB7h5RVRwxjwuyMBSb+Uisu5vhTkgyDBAFapaia9X+kSg2i
         uPrG0o0Smf4oXwlInRE4T4KngEYQy9G3Wf7qNj8hs5MaxyjrVU2iOjv11t1aWhoqhm4s
         76CVf9aUFUzSecqzVWM6VO3ax46vziBQvbJzB/zGwxZV6TupLJ8SqR+Rx32ogr+6JfsN
         4Np5ECYV2DLMlfBopK9+e0bJyxMJkESN8Imcx9anlCRzwQtfJEjqx2YNE4j65GhQkLlm
         VPDeFXYLCC712tKT2rLwuHUayCFUG6pb3O34ot/mwN6QXCbDCO+cDmLIptjRlxlQbWSu
         jvmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770306931; x=1770911731;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Td5+tdEPVS1cr2PW4mwhRLoRhiYDMTcwTL8PbM8B30E=;
        b=abpL36QvNz921jn35B+QL4CCJxxiTH/fjBGtSD4i/rBoytWsInyCn5ISh1mD86Fg4v
         fC6Y21LpAOagG/e5NI0IO42T3o02sphfogTsMkCHbxC2p/4pdmtz1Ar50kZbH+TVOq24
         1/dPSLRIwJV9aPs0n7ItxtcDYxZEzWfQmf99IBf+EzWkK7qCQKTdiG0xp1Q33huWh2hH
         p4GqsQ3gVCDH7Q11ivT7Tu3p1AgPqQ5fS9qXJSj1MMAqDavOe+aO2YR4QypZ+I6t8AME
         rJGbRFb7CJZva1S+LC9NjAAdcwhCoLAqs37/fmDFOr41IQ1ReE7Jb4vOTZxsA4WC3osj
         Grkw==
X-Forwarded-Encrypted: i=1; AJvYcCWoVPJtOpZvsljP1J1bz7ZYAP2Y2FeIeXuZqHIjZm7HvJ5fst5Cm3+cHosezVk+WaJluL4IuTvy0q/faw3VSDDB4aQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTStolvOOIjdGKNuVF4m9gMmYLhc6pvOdd3DNMTXJGflLAJrNe
	h5PohOu3lktK2JLK+Z4IqQTaVjzYfKiJTTEC2NdXrEx5/JVOjSJx/VQO8ej99hJYHHmYjTlEIFm
	zAqiLYRiK2c8Gwjby65zEgxYmLde+Qag=
X-Gm-Gg: AZuq6aJmbrUkvVFKNyt8gE74s6zkebJMs4jrFLrsnR7LeL2khXtR6dPEScuawzdjrTE
	Zxxwb6CX1nhC7kg7xS9rpm69oeBJjnSF5U3wtsgb2QBI/mdMajT3gLWphmmIPWzci+4GfHc2+Xa
	8pyOxJke+Bm9STXjk1N6qb4qdcPnAh0Qz3K8u0QSWMxly87pV+vGrr5ykmdbxpM9egfmHN9X7Il
	cT8yE8qeb/uO//2qETFvKQBjI1TUgm7PM+gtGGATqfhPKdN/itAgCrnJhhsBcaXd61d/4HJ6I1q
	q6Ey3hE4lDPbL/7+WrQfrLTITGyqrseJ8svYWKKQzvHuDFlnv6gCk2u32tTUa1khFLFvU5qu
X-Received: by 2002:a5d:5d0d:0:b0:435:e3bd:5838 with SMTP id
 ffacd0b85a97d-43617e3c9bemr9065339f8f.25.1770306930875; Thu, 05 Feb 2026
 07:55:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260203093819.2105105-1-jolsa@kernel.org> <CAADnVQ+EU_f4LVDQkqkB0Q+QYMBH5ynXU3+rGZA2XCGmYMcFqg@mail.gmail.com>
 <aYM9YUl6xf9I2x4c@krava> <CAADnVQJPbnVEDYAAy4mUP7NmsGkUmeV9B73V+Bc=LYb8r8Zrow@mail.gmail.com>
 <aYRa_CDL1RqIR_8S@krava>
In-Reply-To: <aYRa_CDL1RqIR_8S@krava>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 5 Feb 2026 07:55:19 -0800
X-Gm-Features: AZwV_QipOgBLes70nSxscZOrEJXWlHyMrHEfcwSShz27Cvyr7P8AKnGRdBjQF7A
Message-ID: <CAADnVQLJJn=bSDvQrjNyyeNdLOZABKDjjR_3j6DG3pgbsJ+JXA@mail.gmail.com>
Subject: Re: [RFC bpf-next 00/12] bpf: tracing_multi link
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, Martin KaFai Lau <kafai@fb.com>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	Menglong Dong <menglong8.dong@gmail.com>, Steven Rostedt <rostedt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 5, 2026 at 12:55=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wrot=
e:
>
> On Wed, Feb 04, 2026 at 08:06:50AM -0800, Alexei Starovoitov wrote:
> > On Wed, Feb 4, 2026 at 4:36=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> w=
rote:
> > >
> > > On Tue, Feb 03, 2026 at 03:17:05PM -0800, Alexei Starovoitov wrote:
> > > > On Tue, Feb 3, 2026 at 1:38=E2=80=AFAM Jiri Olsa <jolsa@kernel.org>=
 wrote:
> > > > >
> > > > > hi,
> > > > > as an option to Meglong's change [1] I'm sending proposal for tra=
cing_multi
> > > > > link that does not add static trampoline but attaches program to =
all needed
> > > > > trampolines.
> > > > >
> > > > > This approach keeps the same performance but has some drawbacks:
> > > > >
> > > > >  - when attaching 20k functions we allocate and attach 20k trampo=
lines
> > > > >  - during attachment we hold each trampoline mutex, so for above
> > > > >    20k functions we will hold 20k mutexes during the attachment,
> > > > >    should be very prone to deadlock, but haven't hit it yet
> > > >
> > > > If you check that it's sorted and always take them in the same orde=
r
> > > > then there will be no deadlock.
> > > > Or just grab one global mutex first and then grab trampolines mutex=
es
> > > > next in any order. The global one will serialize this attach operat=
ion.
> > > >
> > > > > It looks the trampoline allocations/generation might not be big a=
 problem
> > > > > and I'll try to find a solution for holding that many mutexes. If=
 there's
> > > > > no better solution I think having one read/write mutex for tracin=
g multi
> > > > > link attach/detach should work.
> > > >
> > > > If you mean to have one global mutex as I proposed above then I don=
't see
> > > > a downside. It only serializes multiple libbpf calls.
> > >
> > > we also need to serialize it with standard single trampoline attach,
> > > because the direct ftrace update is now done under trampoline->mutex:
> > >
> > >   bpf_trampoline_link_prog(tr)
> > >   {
> > >     mutex_lock(&tr->mutex);
> > >     ...
> > >     update_ftrace_direct_*
> > >     ...
> > >     mutex_unlock(&tr->mutex);
> > >   }
> > >
> > > for tracing_multi we would link the program first (with tr->mutex)
> > > and do the bulk ftrace update later (without tr->mutex)
> > >
> > >   {
> > >     for each involved trampoline:
> > >       bpf_trampoline_link_prog
> > >
> > >     --> and here we could race with some other thread doing single
> > >         trampoline attach
> > >
> > >     update_ftrace_direct_*
> > >   }
> > >
> > > note the current version locks all tr->mutex instances all the way
> > > through the update_ftrace_direct_* update
> > >
> > > I think we could use global rwsem and take read lock on single
> > > trampoline attach path and write lock on tracing_multi attach,
> > >
> > > I thought we could take direct_mutex early, but that would mean
> > > different order with trampoline mutex than we already have in
> > > single attach path
> >
> > I feel we're talking past each other.
> > I meant:
> >
> > For multi:
> > 1. take some global mutex
> > 2. take N tramp mutexes in any order
> >
> > For single:
> > 1. take that 1 specific tramp mutex.
>
> ah ok, I understand, it's to prevent the lockup but keep holding all
> the trampolines locks.. the rwsem I mentioned was for the 'fix', where
> we do not take all the trampolines locks

I don't understand how rwsem would help.
All the operations on trampoline are protected by mutex.
Switching to rw makes sense only if we can designate certain
operations as "read" and others as "write" and number of "reads"
dominate. This won't be the case with multi-fentry.
And we still need to take all of them as "write" to update trampoline.
