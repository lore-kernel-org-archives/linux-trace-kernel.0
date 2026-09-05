Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57ECD175A6D
	for <linux-trace-kernel@vger.kernel.org>; Sat,  5 Sep 2026 00:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788567734; cv=pass; b=cLoOjcgX//rJH706GdlRCz0HLnxczgTiiecn1cgKXrzfM2JWBatlEmj8dsl3klnxOVPCUu1cMZ0LlT6y1J/xmjyo/Z/MLNXJt00pDgbj4PQp9LNEYanzAIRuoDy6NzQ9lFhXMk+tqWTKRq0hzFwYhccQiI8sFCs1MkwaqMuWVUg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788567734; c=relaxed/simple;
	bh=5onHwot6PankN+uVkGS5JVOApEBlu2xFYDhZufrfQes=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qv3WzzjIV/SmqMje5NtHT70NxTrt2Krge9ciIrExTXBYa5JqGJ0Ee+HiLV3mPeYRmsz7bU7eMGWfzT0VRnann/k/8um72M1i+YoPONuVfoIZD3MUOnheJM2mguc586jb5AedgfTjc3QgM2c+ZEMzCAEnG9KLptBWxcXssolNf9k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d9KOmB57; arc=pass smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d9KOmB57"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-85339ed040aso1325852b3a.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 04 Sep 2026 17:22:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788567733; cv=none;
        d=google.com; s=arc-20260327;
        b=D7m2SMJI5tYfao7LRS2Q9PaiOMDsrh+srdQdlxRZISmG1X9IbGgHjZAXveRY1OtEFu
         g4tN+FPi5v43gfJprEyt0Ldlfxwp4JYiyx3TOl7RjLEM+qzMH7bRDhVTt+Pn7p7V5JYG
         EnmlxBis1J+PoYJp+FZiM1lzx0LCm6Wpszcm+wldMeHZex96G/8LvgiCEJqVLmwwHIqt
         GA4rQgG+x7TfI+bvqVKkx6M9/FDb8b4Wjt3I11PpAAavtiLPad3acT1T6IbctqA5vuLK
         PjTSRDAbAnlrhlKptdqsm8wA5TlY9xr0DLLt0dLUi/dIoc13QbvFrF+bOZGJw13vNqYu
         2Sww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5onHwot6PankN+uVkGS5JVOApEBlu2xFYDhZufrfQes=;
        fh=VvDFRrI+tRW9FF8W3PRcX18hsB3eSNhFQTHZFaokH6M=;
        b=SAgAXmWomBha7bhoC85u7K4WBwWr5KlHmz/aejv9nf5LvM/qX6eoJmPVpwlLFCOC4H
         DW3/sJ2PH3MsbfGMkavdn9doUYui6Em/T79HLnN76DQkHmkwb8dqKxKYaXN+yVZNcahb
         s5ge9kZh32XugjuAOBXEcrUbQOwVmo7YbCwRrR2gIXIneS85tViZPBe98t/q+0MjJICn
         /HXb2ZBk7wzhfgWUAdFXefu3js4O/N+Dbvy90YVCR6VG6aDl0L6S/VHiLcY3Py+fJqE/
         iQ3abkTuaAF2wR6PdKJ+Yupdt3MdQr8D6rqqdjumV1PWtVoJymP0hmwZasMrGltiIgGJ
         Mc6w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788567733; x=1789172533; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5onHwot6PankN+uVkGS5JVOApEBlu2xFYDhZufrfQes=;
        b=d9KOmB57cXDp23+e/Mms8T5ixxs3rsAGpJzBPhHAL51p9cBPw1nc2Uk+hI6ktVgL9R
         poL6fi0p5cXySrdDklp8CMD56OFk6baOPZJrvMAI2Mk70C/iIrK40MQOvffGOzJ9ZXFS
         VzoK/tmWcrsBXr2ThUHm2jnY0r8JNqFRZcmp8NCk1+xTF65DGCDKNKtjsWyH8o4ZjrZe
         /SDqa7p3r55rnX1Ve9QOym1ZOjb1+MmzSQwxXjw6O2midzOJ+sCLWiSZUXBNyMGw1mEf
         TZy1ch63F6WkbM0yyq/6/7LTniyvLirSHFJ9osUClYkjNCwLjS7p/zo9SM/PLHa/wJ27
         GcHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788567733; x=1789172533;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5onHwot6PankN+uVkGS5JVOApEBlu2xFYDhZufrfQes=;
        b=dOJyqeZ531Y0Ix5wjVY2TIn6rCuL//9Zse4puH8Urd/Cqz6bCh+2CIEcLfgPHCvGbg
         wrnMJcKkozjALRcQ5KNPt6FA1GVJKeGVrsZDAHRtmw1TxaH0/njhej0AeHsUduAoxFlW
         PEynt7dGoZr47CqnIezTK2Mng9a37Tni4/iP0ahsR10crQ9x5CLNIMgHDjeX36bheWgR
         UnmzRct65T7VrADqKATxmx/+0i2zv9ILQiu2V9aSV0klsRfuDMrvBkJgv27FahvndO0j
         G91NwN+gGaqXZdMYB5PEziLo0Q8JUvozYozY9N7e+NhP08K5Yir+HxUs3qPZ6GdirGSS
         ZCCg==
X-Forwarded-Encrypted: i=1; AKwUvBz19xYq+MrO+tfTysx99mXcRBtF650Qs/5pDFJADVUO+8nCcsoUgURyfYs/m2d4YEWUCpYMBBNftxmIeMMIiqlHvfY=@vger.kernel.org
X-Gm-Message-State: AFuF++lQn8VvVzaL9g9tyLLcMNN4drvRT6eOVcDwWosL5eBO3kLt9Whj
	8LA62adnzU9gnMnjFKbvDtkEKo4w9jdZCLG0Dp2MVSl349CKYGr2/G4K+3DvRkIb5hX1db2pg7R
	A30JFlEkfhvZiLRBSfoj7EV3X2thxEHw=
X-Gm-Gg: AYBFou19Eh6Gsa6d5+qAvuNXHSMQRm/GqsAAWS1Ga/zd+dvaOb9am6PeNAeBj4tKsWh
	jMA+NnL8Qvgtyxdh040mKpUNQ+E8RWpCnZNapG1e/MvSriRyNqRC7F4QiqD5KFSO+DREJ33VnX7
	M63P9Y5pqAK9ijN1IbK/hsegESm29+/ik/2i87OAzlgbDEje9Z8INVvl3SgRAfuXlaY1U58Vcfz
	lENUs3LkL4PnmK3CyxK2KzG+UtW2IgP7KgUz2pZFOYmJkbzQzuzcewN93SJp0gyLWkz2vkNqAnW
	LnTxTDlyCsp9dhXahP0pPPAuJBkkc3EIWoOV2PGKM7wWR2mp+jVf7Ou2x+wW3gS1SbKRPnbIStO
	LxqOS1je5FF81ojcG4SbgNZYgauXr
X-Received: by 2002:a05:6a00:2183:b0:857:7384:b5f9 with SMTP id
 d2e1a72fcca58-86169974910mr12096926b3a.21.1788567732659; Fri, 04 Sep 2026
 17:22:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260831090524.106845-1-gmonaco@redhat.com> <87se3sakgi.fsf@yellow.woof>
 <df6e9168cb06c35e21db7f9d17cfbca6bd87005b.camel@redhat.com>
 <DL5B40CU17WD.3KD75URQZ6RRR@gmail.com> <eb3dd8158942d663ec8ad4c529eacd666c5f96d9.camel@redhat.com>
 <20260903090211.50d15220@gandalf.local.home> <CAADnVQK8e1Qp9rf1zThZxb3vr4Gc_bpo0nqpEO2LdnEwHdKokA@mail.gmail.com>
 <20260904074317.01b2c0e1@robin> <DL6O0KLPXLTA.2HJJUXQUVCP5@gmail.com>
 <20260904123108.1fa1d815@gandalf.local.home> <20260904132421.111c0279@gandalf.local.home>
 <DL6XBKITK7ZT.3RXK9YGGUYZZE@gmail.com> <20260904194620.0c7a8363@gandalf.local.home>
 <CAADnVQJH1SYR_GN6gewF3w_z_Sex9HFE1T1oXkQe6+v18bDTWA@mail.gmail.com> <20260904201741.2986efca@gandalf.local.home>
In-Reply-To: <20260904201741.2986efca@gandalf.local.home>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 4 Sep 2026 17:22:01 -0700
X-Gm-Features: AcwNN1X-0VTNjdRrTUxdMQ1ugj5hag_YepmKhEpgX0sankiyuCcGLwirKWItB5Q
Message-ID: <CAADnVQ+x4iRNXOg69nUmuJ53pB3-JtroePcyoReATy9+V1aRPg@mail.gmail.com>
Subject: Re: [RFC PATCH 00/20] rv: Add support for BPF monitors
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Gabriele Monaco <gmonaco@redhat.com>, Nam Cao <namcao@linutronix.de>, 
	LKML <linux-kernel@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	Wen Yang <wen.yang@linux.dev>, Tobias Schaffner <tobias.schaffner@siemens.com>, 
	Viktor Malik <vmalik@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 4, 2026 at 5:16=E2=80=AFPM Steven Rostedt <rostedt@goodmis.org>=
 wrote:
>
> On Fri, 4 Sep 2026 16:48:55 -0700
> Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
>
> > On Fri, Sep 4, 2026 at 4:45=E2=80=AFPM Steven Rostedt <rostedt@goodmis.=
org> wrote:
> > >
> > > On Fri, 04 Sep 2026 16:34:00 -0700
> > > "Alexei Starovoitov" <alexei.starovoitov@gmail.com> wrote:
> > >
> > > > bpf in 2022 was surely less capable then it is today.
> > > > It took us 2 years of bpf core development to statisfy sched-ext de=
mands
> > > > and we're still adding new features for sched-ext needs.
> > > > If you're trully willing to remove 90% of kernel/trace/rv/ and refa=
ctor
> > > > it into tiny shim where all of the core pieces are bpf driven we ca=
n
> > > > certainly work together (like we did with sched-ext) and add whatev=
er
> > > > is missing on bpf side. Then all existing monitors will become bpf =
programs.
> > > > But adding bpf as another 'monitor', sorry but hard NO.
> > > > If hardcoded monitors was a mistake then admit it and fix it by del=
eting it,
> > > > if it's not a mistake then keep adding hardcoded monitors.
> > >
> > > Regardless of whether or not BPF can replace "hardcoded monitors" tod=
ay, it
> > > wasn't a mistake back then if BPF wasn't able to do it when they were=
 first
> > > being added. sched_ext wanted to use BPF for scheduling as module plu=
gins
> > > were nack'd by the scheduler maintainers for a long time. BPF program=
s to
> > > handle scheduling was the work-around to that, and basically the only=
 way
> > > forward. And it still required special hooks into the scheduler.
> > >
> > > The rv monitors only needed to use tracepoints for hooks. A module wa=
s the
> > > easiest way to get there, as BPF at the time wasn't an option.
> > >
> > > If you want to use hostile language like "admit you made a mistake" t=
hen it
> > > makes it harder to collaborate.
> >
> > If you're offended by the word "mistake" then ok. There is no path forw=
ard.
> > Keep adding hardcoded stuff.
>
> I'm not offended by the words, I'm offended by your tone. As BPF was
> insufficient when RV started, it obviously wasn't a mistake that we didn'=
t
> use it. If you are just going to say it was a mistake because we didn't
> modify BPF to suite our needs (which I highly doubt you would have wanted
> to help us, as you already stated that you don't care about this project)=
,
> then you are obviously biased against us.
>
> Your response was fine until you through in that last sentence. As making=
 a
> mistake means that the other non-mistake option was viable at the item. I=
t
> wasn't.
>
> Look, if BPF has changed so much that it could be re-evaluated to see if =
it
> suits the needs of RV, then sure. We could look into doing that. Perhaps =
it
> can replace the hard-coded monitors. But what we have been doing has not
> been a mistake. Saying so is a bit disrespectful to the project and a
> direct insult to Daniel.

I respectfully disagree. Let's stop here.
