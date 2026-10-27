Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793123182;
	b=riNgcEdvgtZ4qOCaRjXui9xXJhZSQglhRUppeCAMNmdA9KNJz67divvcfLnk5olo7Rhj
	 Nnz0V4wh5VqhGt7QL45gwvchVDCRrDy9iOWSeCdeiwZ0x7RMssVtBdDTk3B6nxpvQheqs
	 Z58qht1ozI7C+XfmyvORIpxOcZ4IzKRG28Q2XPtFkk/wPLd9h8OaaqPuwbrIdV5beqCHK
	 bMfjfsiIe5I0POq0vMDMNvDbkCDytdf0NhpbB6znlX7q8iWY0e2wOggkdkUwmRH8C7iuv
	 rohLTbmH+jnrAB8t94K6mify6+VxiQJSM9EsfvaMu9u6pkHyVqoXaGNM8S5JsCJO7NA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793123182;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=zJVDlsrsrfYz550OKB/3hdZdazvfDU9t83gGSE4oBec=;
	b=0+E8GHZLgDjxvq/UPP0sazeGOENTM0XC0Lr6VFYVZcFipUo+iiLnihWvD/hRIfJy9+Ux
	 BpIjlLatmllET2XlN/6Sy3c/6WeWFTvh0ExP2f8W4SatpMQpI6hGLQgdcFokGCshhVaeB
	 Dsja6TPlfrC3VSWlvJwpqO8ohtDgXkt+IS1CzMv1AAGnd63kGSH9cGsVvLEOTlyzx6Kvw
	 DCSZ7kYrP36EXN8A1EaitivcCprtn5mzZGFwOmzNfSzDE9kh+YJDZnAQLneG07VLxckLI
	 w5sHXdVvjlB85Z5DwzqAPKc8vk/Yo0wtBSLRSUeBwbhND34lGR339KUVOlUfBBN2gXw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=evKXogKr;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.53
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA4D606A31A
	for <linux-trace-kernel@vger.kernel.org>; Tue, 27 Oct 2026 17:46:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2FA4D606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=evKXogKr
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c4550d8ab15so10971766b.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 27 Oct 2026 10:46:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793123180; cv=none;
        d=google.com; s=arc-20260327;
        b=cB2Nt1BrD8Lr42jGkIsFvxcfWXCjUi5XAfjGnOlHVyilca7BzfQ5bWFIQFBzoQ4Dki
         ANoBWffTAZaIqXhaCqCdCr/cr6rYDPJdW86yx4dC6qPNt6WZ/N3NHIZASkWIKUn3gRzp
         XPxwnyb8RCaevsmWZu9klBylXp5QTzRxfkfQQosGBIGK9Y8zZ/60igyg0ydHAwE7ZFzs
         hbiAXIj9DpNc5fOd2d5IuJBQGABDYGJKKgr8XxIwZGlLYEHty7poUDi3c1i4KusJuoNZ
         NIpX2uv5Zqdl1XOp+r4qHWGIkVjlu/19D/sPDA/OYcWYKFxVzlVZFIWl7By0cOiPwuHo
         e+2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zJVDlsrsrfYz550OKB/3hdZdazvfDU9t83gGSE4oBec=;
        fh=SbD/0vqXhhMMIbN392Ny2PVm0X5tCA1LfWjr26c2Gbs=;
        b=G9z4yVLbLvw3Uqv6AdaK/gzKdvHFDpf7mQXRPA2VmZVjt7Ow4H+gDMr0naSXWZwhLK
         MLWzNSqiPSM6NcUbWGMEPmK6eJmr1aSDzch4+NkJp+hWJtoYGbVIjP1dMfQIwlq1CSyy
         mbNlpD1iShi8ObRS37QWENDKEPYlxzK7b7BAV3xt0aHg75Ubh4xrMu0ZupK6iO+9e2O+
         OfKt+Cubt1jUZGQyFy59b0gLexh5/1nuxOCJ24ttsdSra58AWJ8ZoI2gzx03krKLNE1P
         YHqq9Tlug9GoKoEDL+AYtCNiH42MMpzeXLRl9tKxxmkMBKSyeAT7dl4BcTehRCHnldM2
         oaAQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793123180; x=1793727980; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zJVDlsrsrfYz550OKB/3hdZdazvfDU9t83gGSE4oBec=;
        b=evKXogKrv4QLmHYqCokY6eoxjCFUmFkxFngkD+J5pd+U8PqGflJnjYXElfwUyBFmzF
         qV4wiic+wqbW2dbP2pY/QKOyX8Swo34I5YK8mrIPfmquTi4YHY3KtxS9Y4oCL4EYN8+b
         gZgC3px2HQD2ClUQ58JAFPuTSuRNsxHfG7Ksla9B2okECXJvEvGeRLEkfL0w1iLCQuRf
         XY+TtQ6+OqXyzAWBWKoLnCli9E1dJ9okU3IZtHsHGFSJ7oI+uUVEKLZVuggzNHkBO8bv
         MIwH/ZO2fAiLc7nxHKiQCb/8R1CLEajO8mjY8W0wf+4Jx9ahNvsdYjka3DkvChZTYg8P
         y67A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793123180; x=1793727980;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zJVDlsrsrfYz550OKB/3hdZdazvfDU9t83gGSE4oBec=;
        b=mJFhnFwltvAigtM3SiGAtNQ7Fu9PX0ir9/iT6hNdtCHAZL/JqaobfZAya3cozrRTDn
         TbqGs2/N8CuybEQCfzuDS5fh4vmaWKBpqT8uV90B0KMLkxIXIL3XfRkBJB2SarD4wIll
         w1Hk5TthzOpMaTr2hsxBKuOcJrZN3MAI53lfVyuXj/J5Oj+JOohbgYBAyrHXMvl17iIC
         SMChoKHUE8imKIo6+UOJRnhKyjjjH3Eyh6JoFrgvJuWhFDAoqsYLHUsvS0VFTnRAel3C
         PNMpVZ6XlvFFey9cW8rSumWJ53xrPOwIqpUAK229EycBc1vWtEwwkQobK5SnBfvVEF9F
         66NQ==
X-Forwarded-Encrypted: i=1; AKwUvBzglBkJ2LhlUDtaqCqyxjTxI300XFZszYMlOgstrxreuxa3vsM/iREei43TsqPbSMze1hKiu6eViTxdIS0QlVWwqX0=@vger.kernel.org
X-Gm-Message-State: AFq9FYK/QRPsZHkekgSwq9IqIqvT8Bnzh+jiOv8sfn9L8oAo6OcVxlc5
	JZXuQqFVjftn0pppiaOvn3c2H2JeGWFJfJ87HQ5Qh/z0mMsq6pNAcw8EiKEUqDpM1j21pXr23tD
	EHN5isw8SSCdBh5X7c5L8wmM+iL8lEAU/Ii6yyMfl
X-Gm-Gg: AYBFou1Nj9++xXiQmfCcADWyo1lt6ZE4ihZOfdH+kWsPQxU5G7DvxKGVZNjUnqe4++L
	9YLSLUIKQWcahj8CysAi5xRpCOwWGQf4MCS3Ekq3JAUlO++PwQbtxjpMlmHpqE1t7wMF9XjaoGW
	TtEwybpdpcXdtzsw7dq+NGWM2PjTjP5xH5jHPl8cARkZyrud85/S/VFfxvXvTnLzba8is0JnzVk
	d0uwfTRlPP0I0jsJtv1Uj6+6Ijfv25qMublovI7BUKVYbOsiydks2BhSXEWTCW8ZtGqFwhpy1Ct
	F3B3IxdfXfM0xh2d2BaMoBQTCTNquFgzj+wORAHCTFx46OSdRqnHMde8dgPBQocn14mChRiMlmq
	HEgAV5rmIi9zUq7f5hddf8cFqugwc+hSK0UFt14AThX8i8vYm/jULlT1AvhEWcqxIHaZHfeHpcp
	/rtqhqLUy9USJYBBWo/NeZ4EFlbJjvEWvuKnVDedY3BYH6efN/+TA2J+OTbebs1td/h6lZunUX1
	bXM0sLsiHCMxEFVxk7HUPjslnHsMAFgFw==
X-Received: by 2002:a17:907:7b9e:b0:c41:b94c:4538 with SMTP id
 a640c23a62f3a-c46bdec03f8mr1197886866b.47.1793123179946; Tue, 27 Oct 2026
 10:46:19 -0700 (PDT)
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261026215226.3713941-1-jthoughton@google.com>
 <20261026215226.3713941-6-jthoughton@google.com> <20261027110948.GI2668564@noisy.programming.kicks-ass.net>
In-Reply-To: <20261027110948.GI2668564@noisy.programming.kicks-ass.net>
From: James Houghton <jthoughton@google.com>
Date: Tue, 27 Oct 2026 10:45:43 -0700
X-Gm-Features: AclHuK-GDZyG6m8BFpUMWxfSIBXFJlvlZbCjTm5c1oLpEFzow0OEe9cdwDWWw7s
Message-ID: <CADrL8HXtBxf=qixBZV5-iz1sqfZAqSrMR4ZsJTFXS0N84G+nkw@mail.gmail.com>
Subject: Re: [RFC PATCH 05/10] perf/core: Don't unwind the user stack without
 an mm
To: Peter Zijlstra <peterz@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Thomas Gleixner <tglx@kernel.org>, Kees Cook <kees@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Jim Mattson <jmattson@google.com>, Jens Axboe <axboe@kernel.dk>, 
	Pavel Begunkov <asml.silence@gmail.com>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
	"Martin K. Petersen" <mkp@kernel.org>, David Sterba <dsterba@suse.com>, Chris Mason <mason@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, kvm@vger.kernel.org, io-uring@vger.kernel.org, 
	linux-scsi@vger.kernel.org, linux-btrfs@vger.kernel.org, bpf@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 27, 2026 at 4:09=E2=80=AFAM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Mon, Oct 26, 2026 at 09:52:21PM +0000, James Houghton wrote:
> > get_perf_callchain() only checks is_user_task(current) when the regs it
> > is given aren't user mode regs. However, BPF's bpf_get_task_stack() (an=
d
> > bpf_get_task_stack_sleepable()) pass task_pt_regs(current) when called =
on
> > the current task, which are user mode regs for a user task, even if tha=
t
> > task has already gone through exit_mm(), e.g. when called from a progra=
m
> > attached to exit_files() or to the dying task's final sched_switch.
> >
> > perf_callchain_user() then unwinds the user stack without an mm. That
> > access does not reliably fail: the user half of the address space
> > belongs to whatever mm happens to be lazily loaded, if any, so the
> > unwinder may read another task's memory. This affects e.g. arm64,
> > riscv, loongarch and csky, whose perf_callchain_user() doesn't check
> > current->mm itself. perf events themselves are not affected, as
> > perf_callchain() already clears the user callchain request when
> > current is not a user task with an mm.
> >
> > Check is_user_task(current) regardless of the regs' mode.
> >
> > Fixes: fa28dcb82a38 ("bpf: Introduce helper bpf_get_task_stack()")
> > Signed-off-by: James Houghton <jthoughton@google.com>
> > ---
> >  kernel/events/callchain.c | 12 ++++++++----
> >  1 file changed, 8 insertions(+), 4 deletions(-)
> >
> > diff --git a/kernel/events/callchain.c b/kernel/events/callchain.c
> > index 9d24b6e0c91f..a451ca2a5573 100644
> > --- a/kernel/events/callchain.c
> > +++ b/kernel/events/callchain.c
> > @@ -245,11 +245,15 @@ get_perf_callchain(struct pt_regs *regs, bool ker=
nel, bool user,
> >       }
> >
> >       if (user && !crosstask) {
> > -             if (!user_mode(regs)) {
> > -                     if (!is_user_task(current))
> > -                             goto exit_put;
> > +             /*
> > +              * Even if @regs are user mode regs, e.g. task_pt_regs(cu=
rrent)
> > +              * passed in by bpf_get_task_stack(), current may already=
 have
> > +              * gone through exit_mm().
> > +              */
> > +             if (!is_user_task(current))
> > +                     goto exit_put;
> > +             if (!user_mode(regs))
> >                       regs =3D task_pt_regs(current);
> > -             }
> >
> >               if (defer_cookie) {
> >                       /*
>
> We have perf_event_exit_task() before exit_mm().
>
> Still, it doesn't hurt to be cautious. So no real objection, but perhaps
> adjust the Changelog?

Right, perf events can't get here, since perf_event_exit_task() runs
before exit_mm() (and CPU-wide events go through perf_callchain()'s
is_user_task() check).

The case this fixes is BPF: bpf_get_task_stack() calls
get_perf_callchain() directly with task_pt_regs(current), so a program
attached to e.g. exit_files() or the task's final sched_switch would
unwind the user stack without an mm.

I've added this paragraph to the start of the changelog to make it a
little clearer that the perf event case isn't the interesting one:

  get_perf_callchain() only checks is_user_task(current) when the regs it
  is given aren't user mode regs. That's fine for perf events: a task's
  own events are torn down by perf_event_exit_task() before exit_mm(), and
  samples from CPU-wide events go through perf_callchain(), which already
  skips the user callchain if current isn't a user task with an mm.

Are you happy with that?

Thanks for the feedback. :)
