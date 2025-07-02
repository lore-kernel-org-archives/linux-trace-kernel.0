Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ECB32E0415
	for <linux-trace-kernel@vger.kernel.org>; Wed,  2 Jul 2025 16:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751475423; cv=none; b=hQ53EbJI6qMY015ZNyAMo+fKu1oaqWDlrqHn0FWq6MVsdcq5ccOAB3wKzWXwS5fXzHL3ZQ6AlToValHZqU8LixzXmPhgKkO8S5PnAsEWNolC5+zH7EuegOjw3xKNiVl1+twEmlp2LO84pLx0A8vhPYEqpDt0EDiE/xDJEh4QWNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751475423; c=relaxed/simple;
	bh=7SlooTOK9TfIj1SqgbI4JXV35XGMr7m8t7eSmUpMnIw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dsnS3xUIRDqAWCSMXV5Z4nBtUgiFVDU1DyOWYntihWJi+PTaoiiMXbAGVcPDyF+Y9FYVZ1YVgMThXLqIVJMg9Kc+1lF9waXHdUNA0N0R9nRqd8t/5FhG5/70GaVN+mPREvonRV6HydklkcbydXKatfRzLi5Qf9c3cv/Pgm1DjGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=BEoBHYOC; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="BEoBHYOC"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-60bf5a08729so9532894a12.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 02 Jul 2025 09:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1751475419; x=1752080219; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=e8/uvlPqD4CZgTZ4reU0BZKjR48ea3dcbDn19W3W2ng=;
        b=BEoBHYOCtbdmUt9EdLXmU+53OK+u+9zECcbYjWhiqVuWhlYWxhDP8dMJwvMQdqtASe
         mhWTuMp+HORMUGTtUfZo+wc4IfIv/dMo7hpDr5ems2H4lbANvF1zQZQc1dI50RQ/JwMz
         i0qtmaHArCmld+hUiiNVj39XH8UUVpJpWona4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751475419; x=1752080219;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e8/uvlPqD4CZgTZ4reU0BZKjR48ea3dcbDn19W3W2ng=;
        b=cA+VymNtQAtYlQNJw2Jff15BZpX0MPsCV2L3xZwBnWl0VU2LwDvbxQqixjXoEjWKNh
         zEelmUv2PZwtNIuvEO6axQ11mM4F97b3l0UBu+5h2KggEDV675WBVr0CaWf4pf0h35hA
         lp6MjbQe+y6J/P1cKypm3GDtrbFfQzv7K6ZiZdC3QxKlU+jVXzIbxe9J82PmFaSSxJUL
         OuXTM5YDOo5AqiekuxsTZOSv+nRHZgOLy1cS/20c0EoPppmkiDxsqsGYvHLrtFQRlcPD
         FxVKSpI8FX2OmXNt0wx9nBiCx2xuxh+K1kGXBSZPFloMH27TnmT4XzAcCMVJteU2aojf
         VdlA==
X-Forwarded-Encrypted: i=1; AJvYcCWHbHS0O+wjfWfeJhCbvf0uxZa4Bb6xcxdgjPRK/8/tkcqe3dc8Ej95ap+vqbo9TgEAwPuHEWt1enOUQ1xAXQfuafM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyzAQHhGMrm5dX35TzaA3CnZx0sqv3aTa1piEXhnpzT6i6QhOh
	F2EHbSgXPLTwcP7hlITMEOh1AnUnIh8KAkf7nk0Ea6XFBXSiLm7osajVwJI56J8HO1flbTrl6vq
	5pHlx3lQ=
X-Gm-Gg: ASbGncvsGAUjodTCu4+2tAJns1tWmWFV71UeUwwdA7L4dLmMHgXPqM8p/Aw/Fnp1YiO
	tF6ZxIA1R1RpjusUjV973CmfDLTs19yrCbYXH0+rghkW/FOdTfflZ4WUIH3vy5gpsdsJycOmyf9
	td0blmthS8Wd7p2pMBGl5POrEdaQUmpIf22lRPwtFKxE4Kz75JXjOrJo1H7EUP+kYIsdQC8dPxK
	61P/1f9rAcUEmA7cU1JqupD9JW66mAwlCjXEXAAew7HC9F4h5G3RQo+9+bKoZZ3GyN9bgTeosmf
	/IsjkQw9VDIQRGTnCoBiFmbxIMKUk2fSTmZ6sO5UlUTFRvArt4N9kDL5S2yt9prvRuQp9qMAs7q
	6R8EIqyUMKXb4pTdoPS+XBX+QuzfO8hmXoLDD
X-Google-Smtp-Source: AGHT+IG3C0vO3mKPgoybPHQrEhE8cp37hucQIYxiiOHbbbqWJrTGNU5p56THMB3fTO+CkcybDlvTwQ==
X-Received: by 2002:a17:907:3f28:b0:ae0:b717:746b with SMTP id a640c23a62f3a-ae3c2d53677mr345568966b.61.1751475419303;
        Wed, 02 Jul 2025 09:56:59 -0700 (PDT)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae353ca170fsm1107018266b.156.2025.07.02.09.56.56
        for <linux-trace-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Jul 2025 09:56:56 -0700 (PDT)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-60bf5a08729so9532813a12.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 02 Jul 2025 09:56:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVJZ0PGnx1cdDCjWWEAoKh3xvI3ijoXv8wl0tl3mTcmGEZM2uUtkZ4RJZzcm1lgdgmTxIPM+/I2UjddUN/9nFvBrTw=@vger.kernel.org
X-Received: by 2002:a05:6402:3550:b0:609:aa85:8d78 with SMTP id
 4fb4d7f45d1cf-60e52cc4800mr3206129a12.8.1751475416392; Wed, 02 Jul 2025
 09:56:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250701005321.942306427@goodmis.org> <20250701005451.571473750@goodmis.org>
 <20250702163609.GR1613200@noisy.programming.kicks-ass.net> <20250702124216.4668826a@batman.local.home>
In-Reply-To: <20250702124216.4668826a@batman.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 2 Jul 2025 09:56:39 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiXjrvif6ZdunRV3OT0YTrY=5Oiw1xU_F1L93iGLGUdhQ@mail.gmail.com>
X-Gm-Features: Ac12FXw4HRUmsY26ZzTIlgUFVvvKfSBHwdgpc89cjL9awvQELp5EmXGzK0yXAsM
Message-ID: <CAHk-=wiXjrvif6ZdunRV3OT0YTrY=5Oiw1xU_F1L93iGLGUdhQ@mail.gmail.com>
Subject: Re: [PATCH v12 06/14] unwind_user/deferred: Add deferred unwinding interface
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org, x86@kernel.org, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Andrii Nakryiko <andrii@kernel.org>, Indu Bhagat <indu.bhagat@oracle.com>, 
	"Jose E. Marchesi" <jemarch@gnu.org>, Beau Belgrave <beaub@linux.microsoft.com>, 
	Jens Remus <jremus@linux.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Jens Axboe <axboe@kernel.dk>, Florian Weimer <fweimer@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 2 Jul 2025 at 09:42, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> As the timestamp is likely not going to be as useful as it is with
> Microsoft as there's no guarantee that the timestamp counter used is
> the same as the timestamp used by the tracer asking for this, the cookie
> approach may indeed be better.

I think having just a percpu counter is probably the safest thing to
do, since the main reason just seems to be "correlate with the user
event". Using some kind of "real time" for correlation purposes seems
like a bad idea from any portability standpoint, considering just how
many broken timers we've seen across pretty much every architecture
out there.

Also, does it actually have to be entirely unique? IOW, a 32-bit
counter (or even less) might be sufficient if there's some guarantee
that processing happens before the counter wraps around? Again - for
correlation purposes, just *how* many outstanding events can you have
that aren't ordered by other things too?

I'm sure people want to also get some kind of rough time idea, but
don't most perf events have them simply because people want time
information for _informatioal_ reasons, rather than to correlate two
events?

               Linus
