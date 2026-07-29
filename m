Received: from mx0b-00206402.pphosted.com (mx0b-00206402.pphosted.com [148.163.152.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BBDD4A13A4
	for <linux-trace-kernel@vger.kernel.org>; Wed, 29 Jul 2026 18:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=148.163.152.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785349248; cv=pass; b=Okb5GPIRZ2WwEqVrvBKblWPQ3OgZSrdEiMUS2wGNt5F2R+FEW9JoO0Yo1BOHsnWSWjn51paH9MSTZSC+AF8N4Uz21jR4j8gx+STvNd1dL/P9mmUAyv8Ydu2vcCmnQw3xCZWcIjac7F5fBU5cafhFWSzVMgo3vc0bi/CJWkGeK+E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785349248; c=relaxed/simple;
	bh=n4u6Lkyyb3K0KXlI8hsKysRf1EtEUR4qmTh5L+rzGD0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iSVxzuLedASy5JRAJo9HKqcMZJtovVj4yDsTB73R2JSlLKOoq+jcYoA6lAiu2t/D4dcTDYQ7tQ/2Nxnmi4vHpu3qE8+JyxqzxZrh88GoY1xkC4PWbgjEaN7X6O/A3KIc+XPSKMIt7jfF9z2PnSiseqk5f/gmtCUssgNHHx5nBfg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=iHY8BRF0; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=Seqce8dK; arc=pass smtp.client-ip=148.163.152.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="iHY8BRF0";
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="Seqce8dK"
Received: from pps.filterd (m0354655.ppops.net [127.0.0.1])
	by mx0b-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66THGhAJ2179018
	for <linux-trace-kernel@vger.kernel.org>; Wed, 29 Jul 2026 18:20:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=PzM3c/AUdHEP/V1SQKl0uANVAZmgdR90jTajOWlVlhY=; b=iHY8
	BRF02H3ThfZf4HVBVFgcPMlLqm5MGMZ/VZQjSZBartJjCLg5o3zKCU5pw7m7TrEw
	9VsI3Vy/NUmtyVwR3vZpdSUIehqLxpvOyZwYBeBD/h4BcSPl4p8/dQ6iwoy+vdae
	7yXAkfVZvzLvZXDQTgjV8oGyZl+5A6wspnTXis57RqgBPs6AVOWXuqsBj5xAiIMl
	bsaVMPcPMCIhjJSmO3Ba/WZ8pKzJ4fTq9J1HawGG4ILIgjY8VeylAEv80pPLsDRX
	rNWKBmbO/wyvivi/YzVQPIwjHE3kLPmXylMyhJKMYNOdrXaTnxU68x8B06cT7QVK
	WMH3m8LPZ+VMJvJiiA==
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com [209.85.128.198])
	by mx0b-00206402.pphosted.com (PPS) with ESMTPS id 4fqn288gsk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-trace-kernel@vger.kernel.org>; Wed, 29 Jul 2026 18:20:31 +0000 (GMT)
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-81eb7dc4e28so45531787b3.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 29 Jul 2026 11:20:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785349231; cv=none;
        d=google.com; s=arc-20260327;
        b=C3TYdFxyKtV/J9tJhDUyMI/ur2w9mtAasEqAOTvkrndrgKw5T3IFLo22vYcqdgV4gs
         7nePDnAxk2s1sll5TTNklurFILzvskKaejxLcZVW++QhrSg3qRoBKGoq5LTP2iG0g2ZQ
         4zHZoT8tttQyOspeGQRjpsykcha5ueGJZFYnm9+jut+cNznPvvm8YR/S4ie3TTER/vso
         kXtTpQbWTDC++V4jubY0iqiw/8WENSKI1PilgNHLQ5Gh2WHf8iPpgZIiQTITBsRFI7SW
         33m95HeGIJqpVMqsnbTGyk5AgR3gUPiHhmD1AwgHUsGP+JerycB4nSLeprYw6rUkkWC3
         ZRmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PzM3c/AUdHEP/V1SQKl0uANVAZmgdR90jTajOWlVlhY=;
        fh=BacOO4AbBzwxjq0WFgq6DQEoH0PDrRd0Qr5rIld6LJw=;
        b=JNblQozEINrAPWT8EP2SisW6eEqUenwq9U/uMQr/A9+b8SX7fG1NdT6OfWKTh+mv3+
         XjAafwTjI6o5929DwhtSRXYLy5/I50VxxIAvFDR7YHMuW7PbIa4bqav/H7ed4sDw3snN
         B90zrRDTN57Yv1n16/73IHCk+2RvEbL+Q9lK5OGqqW+tYWJrjUfXySddkCvvfVU+fH+Z
         FfsxxFM99UaBwOV2110rUJ9dbzW+kTapxObnrX4/ODvI+t5+h/o32hViXAPdZq0KvcXy
         FYMHVc0re1yvLGkXxga719K6+wc/xXmKCAhYYTfCBnoWlNQ2JSwscY4UAU6yDyQBS/Dy
         ERzg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crowdstrike.com; s=google; t=1785349231; x=1785954031; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PzM3c/AUdHEP/V1SQKl0uANVAZmgdR90jTajOWlVlhY=;
        b=Seqce8dK1T1KrK1jY26btQ3NXgi3a/+1e44dJBu0R9V8vxn7LBGN6DRCzawL/mVzsH
         W+KD4ZBS7AJBN1J+c9Z+zRbOssWFG+EGb0hjcZOIE/hXpPeWwvzGq8uYKQGdlSPS02OH
         XojDu0BjyfM7G7kGexnIFXXNusHsecPJatK5oEaLO+wm1PcgbBZ0pPATsrdt9TBASNZL
         NDFUgFt59QWrPVN8ATChrnd8hARdx8oI6+Fi5u0fLNjmMbTajSOkASH8R7Csykinnzfa
         IlbQ5bIACf5vQNR1zGu8IP0WpcxrQenoYyqvGLakcyYrppzPJ6jIFGuiPvJmve2Jb0E/
         gwig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785349231; x=1785954031;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PzM3c/AUdHEP/V1SQKl0uANVAZmgdR90jTajOWlVlhY=;
        b=FNAtShImd9vpVMc2lYGMGCMKvkUgbblSb+e6nANiXQkSJjNRX5PBIx6Cis4hULXvWx
         DEhpEcJrOrBrXf7EQUcOq2Y/4iKcnmdg0tYxRfLGaqMtGE/K/CXY8klT/2HQegj+YmSm
         uHrDEhpzLi+c7GYqbpp0ra7loSn4Cv2iBzeWYot7PS2vJpUGX+iezcn4Rd+Es/ozeIW8
         vQW3ztYiuRC1aLwhOa07nL29Zr/7ZRiaErx7CO4WF+gHPGGasHoyPb79Kh1GQ4hT12vV
         ugLlAifqfDGVfHlFSWPgK1aB7Tz42nlFaFqstrJ8zHH0V28L5I5KvPK4T28lLHllZfPh
         kuDg==
X-Forwarded-Encrypted: i=1; AHgh+RoywEYPkntoXDq5FABCvvnQNHmQWaDIQ6Kc55gX5TSxh7wZXnY65DvfOd41QFlroYOL0UXuRYU2w/jX152XW52k2iM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJkGnG6nPhz2jQo7NHaNQXO4vCbxKdX+sfpcRn8nnNj6iRH7PH
	Vjdq4zfFWz43lRixWkNPZtYePUjfFtu8u/5rxTXU5AsDEdXuDlE5l3DIJaPAZB6XAiHR7yaeb8b
	SADwi3xLVQHKNgJEBIr+1ihY/gqbbH3VyHWqM2+XK9HndJ93IFH9smJMfjdMtvY6UqdkoCVcPLG
	RvkpZH73u5zoWoCepB2tJzBppP+PC12vB7rW9t2dfnYCEiiBcq
X-Gm-Gg: AR+sD12TmUdZDl0nxwb9XgzfArBz8Ylt5Q5dGQ+6gLdnxu+OhEz4KI2G/8QhRyMfGVZ
	XPdDgWb41fenUo0pqzeu+tr7YJQYcAAVgv7iCQpe1338JvhBwNQFmsVQxbydo+9DbaKazM4D5PA
	FE84K1omxuchDvNhW5KFcF30IzIWz1Ru/PpIceiO9kwIJhoqQ43OazDePX
X-Received: by 2002:a05:690c:9b08:b0:806:5a1c:d892 with SMTP id 00721157ae682-81f99362200mr38160707b3.47.1785349230841;
        Wed, 29 Jul 2026 11:20:30 -0700 (PDT)
X-Received: by 2002:a05:690c:9b08:b0:806:5a1c:d892 with SMTP id
 00721157ae682-81f99362200mr38160237b3.47.1785349230082; Wed, 29 Jul 2026
 11:20:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260729005959.3853865-1-andrey.grodzovsky@crowdstrike.com>
 <20260729104114.04298a48@gandalf.local.home> <CAOu3gNgc0XHScgEf+yWF5Kr8sAm8Fsa4RBuwL0YE2EscSiBPrA@mail.gmail.com>
 <20260729113136.32af2a4d@gandalf.local.home> <CAHk-=wjzHTuomhTegkD69veDVRxprX8NB=i7A+BEB2-v6v5n+g@mail.gmail.com>
 <20260729133232.1e6c79eb@gandalf.local.home>
In-Reply-To: <20260729133232.1e6c79eb@gandalf.local.home>
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
Date: Wed, 29 Jul 2026 14:20:17 -0400
X-Gm-Features: AUfX_mylfstO_nr2YAMR0KtoaEUkuyIT32SLYOev--K7OVQlRoslcyNqTeL-jhE
Message-ID: <CAOu3gNg6kNYp-Sc9Eme6yW7Nu7wV6hZ9=CG0eptROfhQ-H8nFA@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 0/3] ftrace, kprobes, bpf: mark
 trampoline/kprobe ftrace_ops permanent
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, bpf@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        song@kernel.org, jolsa@kernel.org, naveen@kernel.org,
        davem@davemloft.net, mhiramat@kernel.org, stable@vger.kernel.org,
        linux-open-source@crowdstrike.com, mbenes@suse.cz
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDE0MSBTYWx0ZWRfX+lnV+4opGMqP
 JtT/dI5hgxx8sLNXuFQSGx1tK831Ln1zEWUnHnWlrWTDWZB2W9qLUuLy6DoDTgygkeFnQ5BngVL
 x349QJDaBJbWERqcsJSALtU0laoUCPqMVTGj7ykXlNcSOEceznbB
X-Proofpoint-GUID: DKtxYhkHkiFhjDDSIawYUF-cpXBzE7pk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDE0MSBTYWx0ZWRfX+uaeLs80S3Kl
 UBrF8BpKGjio5l6ClbEIg6bMmtEvG1v7A9tiu2wwfhGFSfzZrIqx/+l+Vz6B/NmKy5T0W3anVF2
 11YGWirl3VljRgdOmyNT2T9dKyE5r92h0XL2wT/dYccwQPDT+Quni1qqmRtklydn+oINc0IKTmz
 tIrriRlTDmFgBicByGTxrifnAbMsBiV4X2sWTD/IQuntWP+Z3m934T/wtpVl3vT8u8VQ2CMLu4U
 9zl3xGNaP8ygUJDGXFB6uf2kRmEBs0yA0w85TlLjh8Upaq+QhxxRVTBEMXDUZV26fSPw1aZzi/C
 WXnjphfioJeiGd0l0p2W5DSi1MdlIz6ahq8Px9h7a2bVO69z7wVSHXsaHK8DKYTE/sTA2p2qokq
 gh0HyniwjJ/Jk25IUl7J6bsmQSsNSmR2UnazgQW1Zu/Fwhexgs/obgbMj9Ol8Jym0Tj2OuyeJ2n
 1zyjQ8H2WAU4rvcp6tA==
X-Authority-Analysis: v=2.4 cv=baRbluPB c=1 sm=1 tr=0 ts=6a6a446f cx=c_pps
 a=g1v0Z557R90hA0UpD/5Yag==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=KZhmPCYDdY0A:10 a=VkNPw1HP01LnGYTKEx00:22 a=T2KQ53IYiC3MXPrxx8bB:22
 a=vDKVRhTs-M86Ea50iKLw:22 a=meVymXHHAAAA:8 a=Z4Rwk6OoAAAA:8
 a=LEQXHG-ZodL2_mGlm5IA:9 a=QEXdDO2ut3YA:10 a=MFSWADHSvvjO3QEy5MdX:22
 a=2JgSa4NbpEOStq-L5dxp:22 a=HkZW87K1Qel5hWWM3VKY:22
X-Proofpoint-ORIG-GUID: DKtxYhkHkiFhjDDSIawYUF-cpXBzE7pk
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11859
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 phishscore=0 impostorscore=0 suspectscore=0 spamscore=0 adultscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607290141

On Wed, Jul 29, 2026 at 1:32=E2=80=AFPM Steven Rostedt <rostedt@goodmis.org=
> wrote:
>
> On Wed, 29 Jul 2026 08:47:33 -0700
> Linus Torvalds <torvalds@linux-foundation.org> wrote:
>
> > On Wed, 29 Jul 2026 at 08:31, Steven Rostedt <rostedt@goodmis.org> wrot=
e:
> > >
> > > > > Honestly, I would love to get rid of it as today ftrace has prove=
n to be
> > > > > rather stable. But as it is a user space ABI, I'm not sure what w=
ill break
> > > > > if we do. I wonder if we just make it a nop, and print a message =
to dmesg
> > > > > saying:
> > > > >
> > > > >   "ftrace_enabled no longer does anything. Please report if you n=
eed it to."
> > > > >
> > > > > ?
> > > >
> > > > Thanks Steven, if you and/or other community members would approve =
such
> > > > approach I would happily do this instead for a few reasons -
> > >
> > > It's actually if Linus is OK with this approach.
> >
> > The rule is always the same, and I don't understand why there's any
> > discussion about it because it's been stated a million times: we can
> > try to make any ABI changes at all, and what matters is whether it
> > breaks somebodys setup.
> >
> > If people rely on old behavior, it can't change. And if people don't,
> > nobody cares. It really is that simple. That is literally the
> > DEFINITION of "don't break user space".
>
> That's basically what I said. I was just restating it and not asking if I
> was correct. I added you more for the below information you added.
>
> >
> > Whether something is user-*VISIBLE* in theory is entirely immaterial
> > except in the sense of "be careful, this needs testing and may have to
> > be reverted". So user-visibility isn't a "don't do it", it's a "do it
> > carefully, and knowing that you may have to revert immediately if
> > somebody complains".
>
> Totally agree.
>
> >
> > So changing user-visible things is potentially a lot of wasted effort,
> > and needs loving care and follow-up.
> >
> > So everybody should typically avoid changing user-visible things
> > because it's potentially painful and developer-intensive, but not
> > because it can't be done.
> >
> > All that matters is whether real user workloads regress.
> >
> > And please make sure that any changed behaviour is really obvious, so
> > that people don't spend lots of time chasing down *why* something
> > broke. A kernel printk is generally way too subtle - and no, the
> > tracing "make the printk extra ugly with crazy ASCII barfics" model is
> > not an improvement.
> >
> > It might be better to actually return an error to user space so that
> > users can see that setting ftrace_enabled to zero failed and it would
> > show up in user logs. kernel developers may think that kernel logs are
> > important, but users seldom even think about them. Of course, that can
> > then cause even worse regressions, so there's a balance here.
> >
> > End result: don't do user visible changes unless you really really
> > care. And then you spend the extra effort.
>
> Honestly, I don't know of any tooling that would use this kill-switch or
> any reason to do so. For live kernel patching and for BPF, it doesn't eve=
n
> work. Hasn't for some time. It's now a "kill some ftrace but not all".
>
> Hence, again, the switch itself is rather useless.
>
> It now is starting to cause a burden, as there's internal code depending =
on
> ftrace functionality to always be working and can cause some nasty
> undefined behavior if someone were to set that kill switch to zero. The
> solution is to either play whack-a-mole and make sure all those use cases
> have the PERMANENT flag set so the kill-switch does not affect them. Or w=
e
> simply disable the kill-switch.
>
> But I like your idea about it returning -ENOSUP if someone tries to set i=
t
> to zero. Doing that and the printk should let people know why it didn't
> work if they do care.
>
> And yes, we need to be ready to revert it if someone does come back and s=
ay
> their tooling broke because of it.
>
> Andrey, care to make a patch to do that?
>
> Have setting it to zero return -ENOSUP and print a message saying:
>
>  "The ftrace_enabled file is deprecated and no longer disables ftrace"
>
> -- Steve

Gladly! As BPF users we can attest that this switch causes pain and
handling complications.

Should I also clean up the entire PERMANENT flag logic we now have and
drop the flag itself?

Thanks,
Andrey
