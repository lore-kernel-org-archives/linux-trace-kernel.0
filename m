Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D3C636492A
	for <linux-trace-kernel@vger.kernel.org>; Tue, 25 Aug 2026 18:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787682197; cv=pass; b=BroiL4zGfI95BKCghwUd4dLbULYC9wIV5QHFlEf7Fq+ACuQPHr+O9r0nAAmfBYusHYmVcHpTuu/IhuYTzzYBZtHmvkngjaz9D09UzmAObJdUx0Gpjk3y/JgyIGC5AqDzPxBClGNIOHKoHUMcuBXxo18uKwhUlBosb0wPoFT0M5Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787682197; c=relaxed/simple;
	bh=LHECQk2R2yAF+nk9WlWCgcipuNKlvtb34YmL2PVFd6s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qfU/ONRcIFpk5HRvr5yYDRold+oyuVWw6ExlrWoEtletKZ05qOpXFaw/1x1NnTB/PtjPEpDzkDChV89ddr7L4VWomMvVVk/PcNPmjVoXOSQqNrDWQ2Sx84PofxeqSLDCtsQ+OI6rtQyJt+KZxZ4P11GCWN1ZByMz2JKW1ecz/Ok=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b9s8mMdM; arc=pass smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b9s8mMdM"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-cbedf6a6fe8so32743a12.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 25 Aug 2026 11:23:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787682195; cv=none;
        d=google.com; s=arc-20260327;
        b=Yyn9ZDQxlWRF4tIKWqHaFzbZVpNOYDilXwN9RQr3RTs/2tnnUD3nC6SS4aG34K+47t
         iZ4VCKT8L3iY/L0DukYLAmu3+jhyUseCH5eyfCA4ZbIGOzQkWkoB/yQ7kTUxglJi9YrE
         zZ881IY7ZkoYoL4+2XpBC+sC8CP+92XeMElVOjzvCnSLLT+gwOVEpHlZZ3qsADdDjqxa
         JgCRd8tVy1zdb9jqdIZm1JquxZVoRn5RHXSyisYKnza4Pj1Mul3s9mOj1NaxnenTNWKE
         NVQM/K4WBK2PCdiiPE5+RGYBWujZrcLNds2hNV4AMCQ46nFdesn6gx+jydOeZHw+M0a9
         hY7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LHECQk2R2yAF+nk9WlWCgcipuNKlvtb34YmL2PVFd6s=;
        fh=yM/SIcTo4Q6JEejNRHrR0+5TojXgLagSqauALB7Arg0=;
        b=kWNS8FNAd3nX4iCP05bOUh4tkxNxHofPjZL3CZhTNQK1oIWg3PEffLMT0nJtPLNn1a
         P7rAjxpjey7+HuPbeRQdAyWfxwOj8FDtTMzy2eb/kB2v1xxXCG065SEi0gr1XCsvvw9x
         RypRiU7xwkTkrWeWo8pWVB+H+OYkTmDDdL6m2wugwMJ848MlE3kUXM5LQA9hkPuk0+cs
         StoCUx2ZY0o9AJHEZ5GIEqr4TpF8n7+d7vxb8u0kknPfIFvKvbItSkgj/d/30i7iUN5g
         Xy6DTx9wdFTT5hNodZUlFHd6ehi8HnV/t7Ak1u7IUS9pXauwQ2ULIoOS50Wst0Dha/pt
         2NLw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787682195; x=1788286995; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LHECQk2R2yAF+nk9WlWCgcipuNKlvtb34YmL2PVFd6s=;
        b=b9s8mMdMb0VRVoqJznv08VeLt4PToGgletWyExMa1lP5IFAIeBmwqYNFV+hdPUdOXH
         W0etCbBn8DeFqAJpe8ymMDHh9xcF6RJrVoVSY1JA3Db3XusICHolTCyM7FKnGeTNGRig
         cDOuyxQ4xvPxtQa1x4qPY1mQxrF20YLKie2a4WGUr/AS9ee42wMNJ2wSB/ZhFK67fvZg
         cONZybIxdTHjD2TPUrM+XvmhYcpd5YwRzudF9i6OlcusGeOUnWc5neikPqd/Y1JZHc10
         iO5rtly9gSTwBI57RGNFQl10WXh46fIi6x02IuCM7YnwESOrZsqL2Su+mh+7Lt9+Q5ht
         gB2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787682195; x=1788286995;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LHECQk2R2yAF+nk9WlWCgcipuNKlvtb34YmL2PVFd6s=;
        b=ZCWe0hlmjO1EJklDNOhXnAe9l7OGOf43WnTEkvJMIEfOhR09gfx/XN5hL6BhmeMt62
         nVPGLeUoXecWnsgpblZsV5xkkA76NAlDuABcjMK51HjJtWJ8GrTAyAVMON8MME+qrSW3
         1HCerJmgjFlvLHDtVF7ZMQlP0AUMjNjrTa34CJZcNcm451pEi+DSE9L+5syF48upkTiC
         X+VllPiLopmwB7XQxZjV1vFGNuZZuTbakDGUG/xu8pBsS1tvY7aGEfR2od1R7Ar8f8T1
         z5ou5aWdSlSXztSn4Xcv+MaD2tKQ9jnHfICoNIRU3/tRifM/PltUKXO7mnOMxS1/3pOn
         D1Wg==
X-Forwarded-Encrypted: i=1; AHgh+RrJkkhRbKLPozP+SW+d4enHB9vJ5azMBocy1wXYwnpke36wgqOI7Lijo/OmDPq3Jg/8seD4qKqxQP2rESrOSzXjyEk=@vger.kernel.org
X-Gm-Message-State: AFuF++lkWPqztMOm61lO6M+YToc2dvPAv4PIoubIeBlRMIEdfGflJntG
	3OALwmd1X1DsDWvWvZxsIvg9OJc6qPbUzyMTcNqefsYv+ONhb/5+O6/JCNHkZze77eFwO3ThBgC
	0pID60FvjTObAhGqA6Me5zm//IZMSRQg=
X-Gm-Gg: AR+sD10mfcwMXJmGEC0h1BdT+qA4rYgqAdbmFIKr1s2BZmSEPB7kyUIPV1cJKv9hLud
	kChTTdwPyemzJOYsOMIfrqlwvQrxKNZ+U/4BS70Oz3TuMIlnw/C6DYPAJJLCU665fEEUtv9+k+w
	ER2Q5Yck5J/ppDVnBGFr9uYS4hprytxCar6HbDLOWqYoX2LMgSRPwQjxlVX0my4Vd0WH8iWNl//
	eXoHyEgdQT4DqRj5DVPrSVtOGlizvjjbEeAPNN6poqEJBuzl2/j5Qzgawch1OjTkBDFu2EAN8QF
	1/JUvxa8LE8E5ruGQalkCI8Ldc674DXtpnC7mJRfafvx6B4739lSj87+Dh/lIUrXx73IAQNU3gB
	5kIFBz8ekUIv+8oe6En8EbP22yAgN27+pIMTJyLGeZA==
X-Received: by 2002:a05:6a20:6f03:b0:3cd:9f0b:f788 with SMTP id
 adf61e73a8af0-3cf83d1ef40mr670754637.12.1787682195222; Tue, 25 Aug 2026
 11:23:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260822054620.452262-1-ming.jvle@gmail.com> <aosT4H14zcowzU_7@redhat.com>
 <CABbwK50esft7xj6cPWXN7iHnqW6E30w1Cg5FMmE97gJ34SqtfA@mail.gmail.com>
 <aotM6tRUHI9Bo7gW@redhat.com> <CABbwK50istUW_xnFsjCA+MMgFCuBbY-Zs3QmJU=Fg7heqKdF6A@mail.gmail.com>
 <aoxp3Rcbp3fUuqS8@redhat.com> <CAEf4BzbUQWAB0JuEdXu32v4S_zMuv4de+kYv0mcY4tDPu8CA2Q@mail.gmail.com>
 <ao2KDQuBMNtONu0K@redhat.com> <CAEf4Bza0Hy_a4BpFBrsP2F5wvEDOyL6n2jK5FK8r-QyRFwvBPw@mail.gmail.com>
In-Reply-To: <CAEf4Bza0Hy_a4BpFBrsP2F5wvEDOyL6n2jK5FK8r-QyRFwvBPw@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 25 Aug 2026 11:23:00 -0700
X-Gm-Features: AcwNN1Ukv0tOVPmP2iBOudSXuYwiMIHO7YcnLC1DX5MhYH6wLfCTEN94bKtfCOE
Message-ID: <CAEf4BzZGQ50=B4S2NBZnqWN29YBgthMX8LsYGLq5rOsdGzpS3w@mail.gmail.com>
Subject: SIGILL and uretprobes, WAS: [PATCH] uprobes: Free utask on
 dup_return_instance() failure
To: Oleg Nesterov <oleg@redhat.com>
Cc: Keke Ming <ming.jvle@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	open list <linux-kernel@vger.kernel.org>, 
	Linux trace kernel <linux-trace-kernel@vger.kernel.org>, 
	"linux-perf-use." <linux-perf-users@vger.kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 25, 2026 at 9:38=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Tue, Aug 25, 2026 at 5:27=E2=80=AFAM Oleg Nesterov <oleg@redhat.com> w=
rote:
> >
> > On 08/24, Andrii Nakryiko wrote:
> > >
> > > On Mon, Aug 24, 2026 at 8:57=E2=80=AFAM Oleg Nesterov <oleg@redhat.co=
m> wrote:
> > > >
> > > > force_exit_sig(SIGILL) can't be ignored too. But I am fine either w=
ay.
> > >
> > > Current SIGILL sending is already pretty bad behavior that bites us
> > > periodically, instead of doubling down on killing the user space
> > > process because something about installing uprobe goes wrong, let's
> > > think about a bit less destructive way to do this. Mark uprobe for a
> > > particular process as defunct or "detaching it", or something along
> > > those lines. But not just kill innocent processes.
> >
> > Well. Yes, SIGILL sending acts as BUG_ON(), this is not nice and
>
> The problem is that this is actually not a bug but a very real and
> expected behavior with user-space using fibers or coroutines. Any
> suggestions how we can make this less violent, as it's actually quite
> dangerous and kills production applications when someone (unknowingly)
> tries to uretprobe trace them...
>

IIUC, this SIGILL and coroutines/fibers issue is due to
uprobe_handle_trampoline not finding utrask->return_instances, because
a bit earlier we threw out pending uretprobes due to
arch_uretprobe_is_alive() returned false due to that `regs->sp <=3D
ret->stack` check (for x86-64).

So the question I hope you can help reason about is a) should we just
ignore utask->return_instances =3D=3D NULL case and count it as uretprobe
miss and b) should we flip it around, and just not add a new pending
uretprobe if current stack doesn't satisfy this invariant.

In practice this would mean that with fibers we'll get some uretprobes
matched, others dropped, but at least this will be discoverable due to
misses and it won't be killing innocent applications.

And at any rate, we have a per-process limit on number of pending
uretprobes, so there is no risk of having unbounded amount of memory
taken by erratically behaving application breaking uretprobes.

WDYT?

> > probably we can improve the current code. And, just in case, as for
> > uprobe_copy_process() in particular I agree that Option B (make fork()
> > fail) is better.
> >
> > But what, say, uprobe_handle_trampoline() can do if ->return_instances
> > is NULL? Either we have a kernel bug, or the probed task does something
> > wrong. In both cases it is better to kill the task with pr_warn() and
> > generate the core dump.
>
> I don't remember all the code paths, but just shooting in the dark
> there, we can always poison a pointer to distinguish or something? or
> just assume kernel bugs do not happen and ignore NULL. Or something
> along those lines.
>
> >
> > Oleg.
> >
