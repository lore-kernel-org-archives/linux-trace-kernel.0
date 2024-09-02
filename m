Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB77D19CC02
	for <linux-trace-kernel@vger.kernel.org>; Mon,  2 Sep 2024 18:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725301126; cv=none; b=ZiXI/wVl7klAwxl4RQq/m0gQe5ZjOwQr/7aWykko7XT5QERLkm/MY5+QbCjD+j7duLxIzoCbge84BapqaLJqZGyrANQBRzZz3D7UsjDIetj4GAme3udOmNy9q3FbuTzrLZP24MnT6C8lNfHk9eBPkxOCmrIUSHza0dqc7kqMhXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725301126; c=relaxed/simple;
	bh=HgOn/3IiUVhbrjJvM1lNiNzrymo/kFrhHrJKVu/yhaE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ByFYWhJ/6WOhON76CtIJZYbRVjrXciIE1kQFOFZotf9Xe4iLrqv/XFqogDqfIp8tQdy2eHjGC6rh8oQHWipCvNP+2fjqrOFxL+n5YrDVd1zO4yKpwbJ80hYaEl11iPE3JhUWxE1Naxjzos6abfHCoisEFrjRdl719MKVuC6+V5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=aaUqXuwn; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="aaUqXuwn"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2f3f0a31ab2so51521851fa.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 02 Sep 2024 11:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1725301122; x=1725905922; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7tKnOa4A90IoF/EoF6/zH6Ks3lMs+xeYBCb2/giypxQ=;
        b=aaUqXuwnjd9Fci6F9eBXpyNA1BbS7hhPEV75PL8lHLCbaRVbWuXDUfpxSpcJCLQQmU
         yBDsIAOSXUEdlXhmaaH21g2oO+0fk6I7F0yWwbMCIfKgSpucfoiYnIrgMbuoMTmazhwx
         XMqHe8VerUGif8URyvTPqYJfNv3uY72J4tzzA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725301122; x=1725905922;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7tKnOa4A90IoF/EoF6/zH6Ks3lMs+xeYBCb2/giypxQ=;
        b=mb6hx9+aU4wN2JqnOVa58C71nHsamW0hdIoFDqyAg63deRD/cm30f5Nczm097kpxo5
         OopEyhF2tK2gykxzcJzZGB5wj2FhKvOQ+BCfw0FeB7LZzjxxCyxX1CCrr/TbraprWTkN
         CoLRD6fPWd8yLu7qGj5NYutHoff3NYNMH+Xkeccvormd0Ya2310Mpice2enJJ2QRbaLM
         vuTK7SJ03zZTWPI0i6TQv+F7/HPCcDtnDEhwhiTNgY6O+h5jFsbyQyIeQn9mKNxVvPhQ
         0OvqjOiolDZHAMzr1eOurMOEFzoc/KqsLi872ieoWrYdG5pNtx0OwKaKIV6LQaPNcSEH
         AcoA==
X-Forwarded-Encrypted: i=1; AJvYcCWcJr5SBzksDSEUGIew5FPwwqA3l2L9vThCdnTYnfOm7ytKKISG2zhmu/cIfYgAJraj3h8edHfGKrB/P/N2o1cLHR4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdUlsmGCxmeuVhSb02HA5CnYhl1h8NNtnEEEx/Gr0lOwHF3NiZ
	8AOWJ28g4mFRPOXs6pE+/LovBPuSqwlRHZG5183TuN/7bXr2S7NKKFNQTzjEIDTg5DqU9PW8XTY
	zIrA=
X-Google-Smtp-Source: AGHT+IFstJ+bqsxwMSdOmI2ohBy155uYUCZ2vX3hJvP7wB0eAc8esZ00CrPaG2o+9B1wkgFwIGzjUA==
X-Received: by 2002:a05:651c:198d:b0:2f3:e2f0:fa8 with SMTP id 38308e7fff4ca-2f61038c68amr120235351fa.9.1725301121813;
        Mon, 02 Sep 2024 11:18:41 -0700 (PDT)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f614f38ce5sm18077901fa.68.2024.09.02.11.18.41
        for <linux-trace-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Sep 2024 11:18:41 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2f3f07ac2dcso50006831fa.2
        for <linux-trace-kernel@vger.kernel.org>; Mon, 02 Sep 2024 11:18:41 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXC/jXFsxWVw/KJnYoxv7QQivokOfkZmibvnbMKpRNDaIFotyibofJP0waRJglhUVY4uyxTvZvBUQ7tj8jdJHowOjA=@vger.kernel.org
X-Received: by 2002:a05:6402:3595:b0:5c2:50a2:98a2 with SMTP id
 4fb4d7f45d1cf-5c250a38f97mr4049161a12.6.1725300629265; Mon, 02 Sep 2024
 11:10:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240828143719.828968-1-mathieu.desnoyers@efficios.com>
 <20240828143719.828968-3-mathieu.desnoyers@efficios.com> <20240902154334.GH4723@noisy.programming.kicks-ass.net>
In-Reply-To: <20240902154334.GH4723@noisy.programming.kicks-ass.net>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 2 Sep 2024 11:10:12 -0700
X-Gmail-Original-Message-ID: <CAHk-=whef03dn8OWJ01L08hShVHCieVz7Rrzr1HJQOriVBvaDg@mail.gmail.com>
Message-ID: <CAHk-=whef03dn8OWJ01L08hShVHCieVz7Rrzr1HJQOriVBvaDg@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] cleanup.h: Introduce DEFINE_INACTIVE_GUARD and activate_guard
To: Peter Zijlstra <peterz@infradead.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Ingo Molnar <mingo@redhat.com>, 
	linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>, 
	Greg KH <gregkh@linuxfoundation.org>, Sean Christopherson <seanjc@google.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Yonghong Song <yhs@fb.com>, "Paul E . McKenney" <paulmck@kernel.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>, 
	bpf@vger.kernel.org, Joel Fernandes <joel@joelfernandes.org>, 
	linux-trace-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 2 Sept 2024 at 08:43, Peter Zijlstra <peterz@infradead.org> wrote:
>
> and Linus took objection to similar patterns. But perhaps my naming
> wasn't right.

Well, more of a "this stuff is new, let's start very limited and very clear".

I'm not loving the inactive guard, but I did try to think of a better
model for it, and I can't.  I absolutely hate the *example*, though:

  void func(bool a)
  {
        DEFINE_INACTIVE_GUARD(preempt_notrace, myguard);

        [...]
        if (a) {
                might_sleep();
                activate_guard(preempt_notrace, myguard)();
        }
        [ protected code ]
  }

because that "protected code" obviously is *NOT* protected code. It's
conditionally protected only in one situation.

Honestly, I still think the guard macros are new enough that we should
strive to avoid them in complicated cases like this. And this *is*
complicated. It *looks* simple, but when even the example that was
given was pure and utter garbage, it's clearly not *actually* simple.

Once some code is sometimes protected, and sometimes isn't, and you
have magic compiler stuff that *hides* it, I'm not sure we should use
the magic compiler stuff.

                Linus
