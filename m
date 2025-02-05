Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B879D21D599
	for <linux-trace-kernel@vger.kernel.org>; Wed,  5 Feb 2025 05:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738732206; cv=none; b=hZVBtrdmNezyDCiWJ/FM1ofOmJs0v/35SOuFWyWrFaK0wzSzPmljNx3N7AIigWC/vP1Ypxq9LoMN7C1pVIleR9zhpdzS1eSbTR7Yb6Z91idovTaFenGicLboQuYQLGx9btiV4cR8jSHBOaeg3+6dJ3PvjSyzjn2vlQ3H3cvfDO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738732206; c=relaxed/simple;
	bh=I43GEoUdUiGceZ2YgYU3wXjGsWcqAiAEbQmD/Sf+KVY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dnYW7+Lk8rfpT8DOhnkL5K4VJwelrD4KkDZGDUwvdil8jVDLp/dF1qsivsFgnHchQznSfVCwhne6/vv5JPBp9U+8TYkZDpjnxqLt9+25OcXJL0RGdSRJCjX/1npO8ElqHj+W+rNQS71KeAojBElTvZdW7O3CiEotUuZQXmYLojc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=x7BCV0wR; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="x7BCV0wR"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-38daf156e97so754085f8f.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 04 Feb 2025 21:10:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1738732203; x=1739337003; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9RVlUXV2F+9kkfTiH5pod7Tr3MJ/WjVL+lpETWYFhSc=;
        b=x7BCV0wRGMuPWK7srBOI5LX+UtRbLKqISQgTyKlZwFF9ZGABCbvhOd9EIPqbAxfuKb
         zxjX05cv9fWUsVLC/OIn+GQ1d7xEs8NXFh7eXa/TrGiNdpMm9vwnp0utese2F8weWSfC
         5s2E7C5NuI1caqSYGajWhe0pP13CCjXPWg5Ow=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738732203; x=1739337003;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9RVlUXV2F+9kkfTiH5pod7Tr3MJ/WjVL+lpETWYFhSc=;
        b=wlGEWYHNStkq57SDDyDkW2WhFjO3lkTjukzBFySuEkyvt7QE40tgYVGz5UlZnMe5L2
         vjp4DbR1aW7tMQrTeWR51DSG9WPY2z7Z/qe/q+uVHybblPG9b+81fbdoSApjuHd2R8pJ
         0mvMlFw/pAkwSuDN3gylIjv8xyhGC66B/A6yO0LgxZtTcDw+yYjP6Kud4HbFLGawexEP
         aOdx5CvFbeRQJciJgb41k7tgaxFcaj1rHwv7Cbg8G5SIcxqeccc+QWOFhru2xdjkgheM
         W8u+JfJD/2VKftG5wQm/DZkTMGi3r8bJjAcjO4eNzftjy43mP+lL4BssL7ehzgv8Czt0
         Bs8g==
X-Forwarded-Encrypted: i=1; AJvYcCUscGK4tTLY5KBmMM2snY4C9vP8IUeFegecg7+m5vNARPBQ1VoFY394kFAecE+7HAKtdNf9ivJQHn10kd/e+ZW4IrY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwApNXWwqNSN7pHpOzQFNvDR3LxDuAsUxBAwCBrC0lf0tVCcjz3
	6Q10VqVCC0OzS5hY7QHauaWQLQNxmly4tyzwdGR6OdBpYDWg8Uz0Ce2V6l1OSClzOVtXwE+QUfM
	QO90orcyHCnhOYoEOzib5TfG5twpozFoiInJSpQ==
X-Gm-Gg: ASbGncv6BBTaky7wKlFODug8XMKEyHtEf7ICr8yFfX8F0a4dky33zVZsNvxtn31Obcm
	PQfv3wm2QXuanYKVoXptSDnV2ZmkGdENVdyiS+0tjXuBux5yUh6sommshnCfK7FbbtWAQmJhb9B
	U=
X-Google-Smtp-Source: AGHT+IHebXDnJj7nrVEowqtLpxuhsBRv87DxqjXGuMdO/PKznev/kvyagbD64f5kjLtxcpTukLwYXZ2sJHYB04z1738=
X-Received: by 2002:a5d:47af:0:b0:38c:1270:f964 with SMTP id
 ffacd0b85a97d-38db48dea2dmr654734f8f.47.1738732202866; Tue, 04 Feb 2025
 21:10:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <EC77D83D-DD17-4CCD-9EF6-C4C39FCE16E7@oracle.com>
 <9DA1FAE6-A008-4785-BDF9-541457E29807@joelfernandes.org> <20250204220418.35949317@gandalf.local.home>
In-Reply-To: <20250204220418.35949317@gandalf.local.home>
From: Joel Fernandes <joel@joelfernandes.org>
Date: Wed, 5 Feb 2025 00:09:51 -0500
X-Gm-Features: AWEUYZnm9OUMJi2qAun9rb8YUVPwuY0xD-pJcn3QN-FWYx3I5wXuquWtGR4fSJs
Message-ID: <CAEXW_YQxTi2y_hY_e4AjLSa6RwVVLn3DPj5d4Cfewq0js-0UTA@mail.gmail.com>
Subject: Re: [RFC][PATCH 1/2] sched: Extended scheduler time slice
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Prakash Sangappa <prakash.sangappa@oracle.com>, Peter Zijlstra <peterz@infradead.org>, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Thomas Gleixner <tglx@linutronix.de>, Ankur Arora <ankur.a.arora@oracle.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>, linux-mm@kvack.org, x86@kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, luto@kernel.org, bp@alien8.de, 
	dave.hansen@linux.intel.com, hpa@zytor.com, juri.lelli@redhat.com, 
	vincent.guittot@linaro.org, willy@infradead.org, mgorman@suse.de, 
	jon.grimm@amd.com, bharata@amd.com, raghavendra.kt@amd.com, 
	Boris Ostrovsky <boris.ostrovsky@oracle.com>, Konrad Wilk <konrad.wilk@oracle.com>, jgross@suse.com, 
	Andrew.Cooper3@citrix.com, Vineeth Pillai <vineethrp@google.com>, 
	Suleiman Souhlal <suleiman@google.com>, Ingo Molnar <mingo@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Clark Williams <clark.williams@gmail.com>, 
	bigeasy@linutronix.de, daniel.wagner@suse.com, 
	Joseph Salisbury <joseph.salisbury@oracle.com>, broonie@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 4, 2025 at 10:03=E2=80=AFPM Steven Rostedt <rostedt@goodmis.org=
> wrote:
>
> On Tue, 4 Feb 2025 19:56:09 -0500
> Joel Fernandes <joel@joelfernandes.org> wrote:
>
> > > Here is the RFC I had sent that Peter is referring
> >
> > FWIW, I second the idea of a new syscall for this than (ab)using rseq
> > and also independence from preemption method. I agree that something
> > generic is better than relying on preemption method.
>
> So you are for adding another user/kernel memory mapped section?

I don't personally mind that.

> And you are also OK with allowing any task to make an RT task wait longer=
?
>
> Putting my RT hat back on, I would definitely disable that on any system
> that requires RT.

Just so I understand, you are basically saying that you want this
feature only for FAIR tasks, and allowing RT tasks to extend time
slice might actually hurt the latency of (other) RT tasks on the
system right? This assumes PREEMPT_RT because the latency is 50us
right?

But in a poorly designed system, if you have RT tasks at higher
priority that preempt things lower in RT, that would already cause
latency anyway. Similarly, I would also consider any PREEMPT_RT system
that (mis)uses this API in an RT task as also a poorly designed
system. I think PREEMPT_RT systems generally require careful design
anyway.  So the fact that a system is poorly designed and thus causes
latency is not the kernel's problem IMO.

In any case, if you want this to only work on FAIR tasks and not RT
tasks, why is that only possible to do with rseq() + LAZY preemption
and not Prakash's new API + all preemption modes?

Also you can just ignore RT tasks (not that I'm saying that's a good
idea but..) in taskshrd_delay_resched() in that patch if you ever
wanted to do that.

I just feel the RT latency thing is a non-issue AFAICS.

thanks,

 - Joel
