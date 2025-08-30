Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D5A221CC63
	for <linux-trace-kernel@vger.kernel.org>; Sat, 30 Aug 2025 00:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756514764; cv=none; b=jfxsGnmpSw8gOvLeD6an06iAd9wkK2+iq5PDFGVuKDsLXt/QhNjoyrke44zo5EGsJugE1Ji81wtKxR7CURN+zz40DTzQafzMmqH7OoM/2Ipmx5mYo+cvZVdqyx3ypJlr1OW1/QfZE7RLAh+/ztKt5R4kGNjYQz53QCQl6hdHiSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756514764; c=relaxed/simple;
	bh=8mek4otXRSBa5jdsIR7RcX9metPdhjWZ8Su46YZiXvk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qtYxg2JPmfzZVETEMGiF3cIUBHUVkI6pmlxJZoE1Gq8jnRiW1bKPwzAF94v/D8Dwi1Ms4t8B6j6UMkpnDlx8V/Mgn8oCRok/GXMN6n+HfUJdWeS1mAq/6jVqRTMkrPrzryMW9Qtjez+7phoLfGesJ4TgDBfclhHnb53avzchuDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=D8KmP39l; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="D8KmP39l"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-61d28950476so177821a12.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 29 Aug 2025 17:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1756514759; x=1757119559; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Jh/LOKtbCFYx6ow3+8rmdtjbSkdbgBd5ekJbYw0X8HI=;
        b=D8KmP39l1oqhww3ld4r41pcWqW5FIL7tx46pJOWnKJ4hL11LmuLWPFvBLYlqAB/ceM
         YuzvmZ6mj+3s5JXYNKJeI1XUmkWBQVVDmR0MiqdJL+Tk8qcXt2DqtxI50of2MpDQXc7B
         Svd9vIwWlcNqW9VUXTaRwV2kW5YvFFotEm0+g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756514759; x=1757119559;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jh/LOKtbCFYx6ow3+8rmdtjbSkdbgBd5ekJbYw0X8HI=;
        b=g0YNOkGfID2RRIjjOswZiRutljDws3H1fb33VYST3DSs8/a6QhBTFbIdN0qLZR0HY+
         0NVEw5lpOfyCTq492JEi9kA/eb92y3yxDuW2m2V5fDpLdZSTgGzNb5YZP+1sVPFGCX9s
         crh0b7BkR7AHOIg68M7u2EREnpws2SvcXo55pX4YQ71jDTNprf8UjfFGa2H7A++tZhCX
         rfD9GnHnTXwXKAPB+n/Entf/WmxW2NUic4X9wPT1TxOGz1eop8sMf2LJNtnOcASkW03J
         rvwivGKCBkG1BGNH9cLWxucKqWs2Kh8IW638pMX3WQZiVOpmvzs9m/Xzt9oP6XG10Vu8
         o6xw==
X-Forwarded-Encrypted: i=1; AJvYcCXWbjOE5ZsajFFNmVbbNomdnIYIV7GtwOMXL8KfK+43ztNw+6XxOsMdFlc3MUJxv1Win2vVghkrpxDFZ8QD1qZKpVY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy76jNKoDEZg97/bZlOccFrvg+Hn7c5xiD5yzqL4hsholyWTZj8
	g9SbdzCe4Jtnccwd78JGWMBSYTNhi//yB4iCS6keL8anFx+ZHuuljVQ9BaRwPymP4YOqeoIZq6W
	Kr38Z01Wccw==
X-Gm-Gg: ASbGncvuOAM3qLtSqtf1sd5XGW7LJgI/iSTSKAmLIk/DoubIeA7QA31qA0jg2tU/ZwS
	YhWi7T6ErdjnBRaYk13UTqE+Xstl+mSxmeJkgn91NkJZKhOrgD54WanmRRMnT17zsFwvGPiSYoW
	pFmPaHIco35vSQ5rSfLSbjphBXj5lLxdNjzrKDuj3a9GTbBglrm40jtjmMf6xUix6u2X53j5tFK
	FddmjCeKycJXD6rivg856ZknYxq4UAsp4b6AfZzTbNze7KiqCswWQfII8I5bSIEKoGkk+/WCB7w
	4+bXb/6z9ljjwwRF3+p+Ttdiig5t5pAMz1rfn9v9no8gEdnAH91VT3V2gkw+SWAXBt2GOUkpRSk
	m5C+VPgFm/KyVtAxR2JC7UifMjOlXXPsMnksxlXTMX9r0LAB6JQGQ4q+Jhau12xA4zrOloK5FI3
	0rUMtuDBk=
X-Google-Smtp-Source: AGHT+IF2HIn3ma9AlhtAd8PRzSXKKyEo6W4dg2c5piuBmoixh2TOz6HNGTe/0Idg4oSqZiLJvbQYaw==
X-Received: by 2002:a17:907:6ea7:b0:afe:8e27:603d with SMTP id a640c23a62f3a-b01d976e7c5mr40630266b.45.1756514759272;
        Fri, 29 Aug 2025 17:45:59 -0700 (PDT)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com. [209.85.218.53])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aff0cb2cb07sm206036666b.16.2025.08.29.17.45.56
        for <linux-trace-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Aug 2025 17:45:56 -0700 (PDT)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-afead3cf280so346375866b.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 29 Aug 2025 17:45:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUME678hz8RZIOiLWk5bYIQsuIaAi1iSb5EtMKvaNBHl32jOIMVFN8Ma4hB3onItiv/ogwC8/ZjCpquqIakWOPb30g=@vger.kernel.org
X-Received: by 2002:a17:907:7289:b0:ade:c108:c5bf with SMTP id
 a640c23a62f3a-b01d976d963mr49768666b.43.1756514756264; Fri, 29 Aug 2025
 17:45:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250828180300.591225320@kernel.org> <20250828164819.51e300ec@batman.local.home>
 <CAHk-=wjRC0sRZio4TkqP8_S+Fr8LUypVucPDnmERrHVjWOABXw@mail.gmail.com>
 <20250828171748.07681a63@batman.local.home> <CAHk-=wh0LjoJmRPHF41eQ1ZRf085urz+rvQQ-rwp8dLQCdqohw@mail.gmail.com>
 <20250829110639.1cfc5dcc@gandalf.local.home> <CAHk-=wjeT3RKCTMDCcZzXznuvG2qf0fpKbHKCZuoPzxFYxVcQw@mail.gmail.com>
 <20250829121900.0e79673c@gandalf.local.home> <CAHk-=wj6+8vXfBQKoU4=8CSvgSEe1A++1KuQhXRZBHVvgFzzJg@mail.gmail.com>
 <20250829124922.6826cfe6@gandalf.local.home> <CAHk-=wid_71e2FQ-kZ-=aGTkBxDjLwtWqcsuNSxrarnU4ewFCg@mail.gmail.com>
 <6B146FF6-B84E-40A2-A4FA-ABD5576BF463@gmail.com> <CAHk-=wjgdKtBAAu10W04VTktRcgEMZu+92sf1PW-TV-cfZO3OQ@mail.gmail.com>
 <20250829141142.3ffc8111@gandalf.local.home> <CAHk-=wh8QVL4rb_17+6NfxW=AF-HS0WarMmq-nYm42akG0-Gbg@mail.gmail.com>
 <20250829171855.64f2cbfc@gandalf.local.home> <CAHk-=wj7rL47QetC+e70y7pgyH4v7Q2vcSZatRsCk+Z6urA3hw@mail.gmail.com>
 <20250829190935.7e014820@gandalf.local.home>
In-Reply-To: <20250829190935.7e014820@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 29 Aug 2025 17:45:39 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgNeu8_=kPnKwFpwMUC=o-uh=KjJWePR9ujk=7F9yNXDQ@mail.gmail.com>
X-Gm-Features: Ac12FXzHUWBAlxqQk5ohlyV44LW67utXZUBljhzh_p3civTAmgJnlakeCHnJEkU
Message-ID: <CAHk-=wgNeu8_=kPnKwFpwMUC=o-uh=KjJWePR9ujk=7F9yNXDQ@mail.gmail.com>
Subject: Re: [PATCH v6 5/6] tracing: Show inode and device major:minor in
 deferred user space stacktrace
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>, Steven Rostedt <rostedt@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, x86@kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Andrii Nakryiko <andrii@kernel.org>, 
	Indu Bhagat <indu.bhagat@oracle.com>, "Jose E. Marchesi" <jemarch@gnu.org>, 
	Beau Belgrave <beaub@linux.microsoft.com>, Jens Remus <jremus@linux.ibm.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Florian Weimer <fweimer@redhat.com>, 
	Sam James <sam@gentoo.org>, Kees Cook <kees@kernel.org>, "Carlos O'Donell" <codonell@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 29 Aug 2025 at 16:09, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> Perf does do things differently, as I believe it processes the events as it
> reads from the kernel (Arnaldo correct me if I'm wrong).
>
> For the tracefs code, the raw data gets saved directly into a file, and the
> processing happens after the fact. If a tool is recording, it still needs a
> way to know what those hash values mean, after the tracing is complete.

But the data IS ALL THERE.

Really. That's the point.

It's there in the same file, it just needs those mmap events that
whoever pasrses it - whether it be perf, or somebody reading some
tracefs code - sees the mmap data, sees the cookies (hash values) that
implies, and then matches those cookies with the subsequent trace
entry cookies.

But what it does *NOT* need is munmap() events.

What it does *NOT* need is translating each hash value for each entry
by the kernel, when whoever treads the file can just remember and
re-create it in user space.

I'm done arguing. You're not listening, so I'll just let you know that
I'm not pulling garbage. I've had enough garbage in tracefs, I'm still
smarting from having to fix up the horrendous VFS interfaces, I'm not
going to pull anything that messes up this too.

        Linus
