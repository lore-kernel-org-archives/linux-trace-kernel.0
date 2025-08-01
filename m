Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 001B419F13F
	for <linux-trace-kernel@vger.kernel.org>; Fri,  1 Aug 2025 13:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754053567; cv=none; b=lzG67H3WjL8BrTaPgDE6PyiQQyJYqXwSES8HUR5UkjFyw74XHjncOGZJ4CLVXhzL06wvsnGtASaMxpX3RKIRuZLKb+sM6YZE40I451BbLGWUBPPl2RB9/yPgLW9YCYm4b9YJgAbE3rJyrCnkFqVsVliW3qTo9BGB7F3Fuqk6FrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754053567; c=relaxed/simple;
	bh=X+6e/IdlOphMsOvvEV8Ay2A0t6/Mh3wGQRWB5DbzH7Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=saEEAnegAIlL/dKPmY1J4WZdKH5dK7DTwDnJkfQ6z/Ix4cCyEvDBNjX6Scgq4eDyWDXPvMmcNe6hi1NenGQ1A5QDp8PyjyVAfTs+vsnaMbUy64UjwHb+U5heI47nFkcvOgyXkpf+JQF0YRxqcplztkHRfCzizDlk/JqnO8upJiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DDfjwnhF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DDfjwnhF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754053565;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X+6e/IdlOphMsOvvEV8Ay2A0t6/Mh3wGQRWB5DbzH7Y=;
	b=DDfjwnhFNfhDwKWp/8Dn5uhkv6n2YABUxw/Li8t6gHRDaV1/uV2/PWYKUcBJnP7QQPDGmZ
	YaagZs5qyKyYkM8+GWMNW7ybn5Lq2EloWnIBHrUfCnRbO2l+/DGh0m/bBozIxbIDKuZwdL
	n925pTYhzOR+WJwxG8I8N0t+6pDE1Rk=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-259-Cyt5NguXPoCUUj_n3VfyEA-1; Fri, 01 Aug 2025 09:06:04 -0400
X-MC-Unique: Cyt5NguXPoCUUj_n3VfyEA-1
X-Mimecast-MFC-AGG-ID: Cyt5NguXPoCUUj_n3VfyEA_1754053563
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-3322b98b1a6so7991521fa.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 01 Aug 2025 06:06:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754053562; x=1754658362;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X+6e/IdlOphMsOvvEV8Ay2A0t6/Mh3wGQRWB5DbzH7Y=;
        b=oMftvsXQ2DwvjipSFGmkrE6un838wnmQRn8MsQvwAu7Y3jGHu9HWerd+43/jz1Eudm
         05G0gAplNbtn43FvD46LAOkT1U1Gzdd+4dcLYw9gfFvrWPrM2FAQjPfxQoOfvqsKGwDN
         rX6BJ/dB3kC96jRajJLuoo+bI9NpGuuoO5aJXQTFoiYFue8rMeRIhP2Ljdlj8PaNejKI
         RuqE6YLaeFwjsX9GLcxz2867oRrQjUfHrOA7cqCdvr1NVYnYUvflH4I/RG47RMtNEx1K
         ZF1+VMo6IOArVbOJQafWhNFIRDWSuX6kevLY9hyCM9/2gQ+Y+m1jrfwxuZsnLrNZOL60
         bc5g==
X-Forwarded-Encrypted: i=1; AJvYcCUYErMCaCS/WIxkmqa2ZBLaDFWgfk81ZYeIkoK58OlaONNjnhuJD2B4QsWv0D8MN/11yUhv6Fa+NY0fpzLLSRINK0A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGvV5aDtvaoI0M0e7TFvmn+a+fRsh0aixs0yPgUDlikBVrrL//
	4HWO33Tqg31VXPv/MQatJGYcP8h0sOaP/8049rWei46AAH6jMozhQlUlkPPuD6yUC3ol3XWY2Aq
	6B0oj/C8PKqhoaWcJOqCVsRvtxiUriowEOR9X/RQRSn9XhAeoeVjGpxBjPOutnGJA/FpXsUWiYS
	qxMCSv5vYtziThYecOpnf5RGOWn0o7aSK/sK2Z+C8TYpmCjcCk4Dflg3s24ms=
X-Gm-Gg: ASbGncsewjyfa/1YgSi6bgEyhB/GEiffGtQb3qR02NaCSDhtywzPO98R96ZZ+No0fZD
	Qa79utZOH/Iqi4xmkgwAnOoabBmnKCqYhhwHozCkgQ4tlOJf32yYBIiYTuwVjimiMaaweFrvAIS
	njOM+VmkuVIBdC+XOv8J6z
X-Received: by 2002:a05:651c:54c:b0:332:32cd:3030 with SMTP id 38308e7fff4ca-33232cd322fmr23013601fa.30.1754053561991;
        Fri, 01 Aug 2025 06:06:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFwPekJyaRBrU4XHAaPoLUYuXzoYjPAsppCTKKhF9uqbOBME0quueqtHalfWUF3r20fmIamlMzDLhps4jDkaZQ=
X-Received: by 2002:a05:651c:54c:b0:332:32cd:3030 with SMTP id
 38308e7fff4ca-33232cd322fmr23013331fa.30.1754053561509; Fri, 01 Aug 2025
 06:06:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250704170748.97632-1-wander@redhat.com> <20250704170748.97632-3-wander@redhat.com>
 <20250707112622.GZ1613376@noisy.programming.kicks-ass.net>
 <ppdduzdqnd3kwourcmocfi35i7wcbuagmzqgtgmyr55aps774t@37wucnoii7o3> <20250708184656.GB477119@noisy.programming.kicks-ass.net>
In-Reply-To: <20250708184656.GB477119@noisy.programming.kicks-ass.net>
From: Wander Lairson Costa <wander@redhat.com>
Date: Fri, 1 Aug 2025 10:05:50 -0300
X-Gm-Features: Ac12FXyz6W_OFFg15W09K4lkzCr3Pdj1iLkCY-v9uSyvK6uNsriEI0u894aKnQk
Message-ID: <CAAq0SUkdvA7SKsM_a5z+_Dx8wAEdyw2KKgE=VnyQ7Q-ocZHq4g@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] tracing/preemptirq: Optimize preempt_disable/enable()
 tracepoint overhead
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, David Woodhouse <dwmw@amazon.co.uk>, 
	Thomas Gleixner <tglx@linutronix.de>, Boqun Feng <boqun.feng@gmail.com>, 
	open list <linux-kernel@vger.kernel.org>, 
	"open list:TRACING" <linux-trace-kernel@vger.kernel.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Clark Williams <williams@redhat.com>, 
	Gabriele Monaco <gmonaco@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: L00IvsKnm_b3s9bdnEq5wPoltkVRkZ_FxzHE4NjpXDo_1754053563
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 8, 2025 at 3:47=E2=80=AFPM Peter Zijlstra <peterz@infradead.org=
> wrote:
>
Sorry for the late reply. A mix of PTO + higher priority backlog items.

> On Tue, Jul 08, 2025 at 10:09:45AM -0300, Wander Lairson Costa wrote:
> > On Mon, Jul 07, 2025 at 01:26:22PM +0200, Peter Zijlstra wrote:
> > > On Fri, Jul 04, 2025 at 02:07:43PM -0300, Wander Lairson Costa wrote:
> > > > +#if defined(CONFIG_DEBUG_PREEMPT) || defined(CONFIG_TRACE_PREEMPT_=
TOGGLE)
> > > > +#define preempt_count_dec_and_test() \
> > > > + ({ preempt_count_sub(1); should_resched(0); })
> > > > +#endif
> > >
> > > Also this is terrible. Surely you can do better.
> > >
> >
> > Thank you for pointing this out. I'm not sure I've fully understood the
> > concern here. My understanding was that this logic was pre-existing and
> > my patch only reorganized it.
> >
> > I'm clearly missing something. Could you please elaborate a bit on the
> > issue you've spotted?
>
> The normal (!DEBUG) case uses __preempt_count_dec_and_test(), which is
> significantly better.
>
Maybe I am missing something, but my understanding is that this behavior di=
dn't
change. When DEBUG_PREEMPT and TRACE_PREEMPT_TOGGLE are not defined,
__preempt_count_dec_and_test() is used.

