Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB5223AE87
	for <linux-trace-kernel@vger.kernel.org>; Mon,  8 Sep 2025 23:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757374034; cv=none; b=ravK2PkJ7fbWU0kmN4ieEPu8joGqYdv5oln3egY1vWvHhcuwf8/dVT+zddaTyUU63sDqsx45AvQeXZYBQRKWFVfu0t0NGISuf8PNBuZcO+aZfFLquDL0hPCEV/jwlx9M5v+bW9M4AoZoSvyDaFgoM27iIzIqddac+Iegx+pjm0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757374034; c=relaxed/simple;
	bh=9j1F9Hlgq0izFEcvkNVfyEGzv++lE2ro3SvVkZ0AdfI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XEilcauVulo4/77HtV82yTEhYRVhxJ0JoWYwG5XG3w5OjLrKatMG3m6ZenvCaMm+Av1TIgNzEfexIGSiQadRnjFzFVsWcPXNLmmbmG5yoEELC8AbiEEXSv9aIS7KXtVptcenDngXn9n/zydm2tPbIr0C2fJXqRDhxdviG2LoKL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=DDTDe3M7; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="DDTDe3M7"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b04b55d5a2cso457907466b.2
        for <linux-trace-kernel@vger.kernel.org>; Mon, 08 Sep 2025 16:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1757374030; x=1757978830; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Bsrp6f7rC2KY8hXQre2m5AM/+TH/nwxi0ROAfuOjXMY=;
        b=DDTDe3M70UhExHay50xJFwDQ25pd4rJc6eM0GeFnHyqdln+Np1zTWQ5VoSImdaVSDo
         EI/9BgaucrHhb37xC9CgyJgVOhRt53IGMhUQQFYpRdm7wI389mOi+ZKSjjYEEounDsSZ
         hucCKBDkSD50njoB/n2A2V7bwuZPSu1e1u+JQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757374030; x=1757978830;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bsrp6f7rC2KY8hXQre2m5AM/+TH/nwxi0ROAfuOjXMY=;
        b=TOITkYUpG+3nU6Izcvd5qrzEZ7irr+UP+Q8MDDDqiEepfxwEaaQD5kdaK/pPw26lMT
         BwLcI2xAYtRgiDmqMDwAOWyMhBkdDjkq34akvKBotxGo5EoTaJtYXSD4NzdiMpFIixvX
         CK8It/c5/wqMZzGKEf+BIROm9TFfQpdyVI9siyrlIHD3UClmdeRxYizCNsK7DgCBnEu0
         FRvyD2sThoGJaTWR2djdxKkaAvswXOuNUuwcz2NOC/43BUVj6/LcrAe3Wlpd8nzBNWo/
         sfxA+qt0Jd0TaVYR4H5E0vSXlkJbUNIk5xNyT9sqItvYtlQ+4yx+gBiBOP55DupZR2Kv
         h7og==
X-Forwarded-Encrypted: i=1; AJvYcCXCBd5co8ZIdmoEYGxUISI3HWq7n9CH/C7QyJs4YGO4SXVgccoofbJKqodmlPjrflEWmLHW/E1Z1FrkuYf5Esl4SpQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYc0dOhd29EeLblPTWnEo7w7t+BDTzkvFvswmVvP102/5Ss4tB
	gRCnqm4EnFbp8O+8GsJMKWWZRLPBg0knRsME+3LNYj7Vu7EEgvzN/lWSde8eStSUcLuMrr30z9E
	p+cx1GY4=
X-Gm-Gg: ASbGncuVFTOuCBYUhdBSBZrX1R0WlIGNjEUA2K0bjFSfkLc92iVfzHsJtGGZ/zRaew+
	XpY8dSisbRHfjWN0kV4xIwJgZKKy9L7rOmTDmVkTpUIzNWrB2MNQdv9wFKFj0y/elccKhTVHzmD
	kUPUk30Dhb3hoYjLEp8eCqSJ37qq6tGp8W/oR/0aPX/du9SLOrl8cFK0kSRUIBNJk/dTHZF44fT
	M9VGGWC3A/YrK1hV85BNdgIrrX+osgKAbZaf4g4Uf9zEy8EedHqqhGkRkMe3Cy5VTx5J+YdmiV6
	zcf7bXjQgiuK1icweHBFIXMbEvKZKOueHRZE0HpE4pio0WKahQLJhPMnAVZi8AQhyr3QyAZDHnH
	g+3qBIT2YiyqIX0Jx/op+fp7M7YeXwcoSZ1+ldF4gYS6W6Q2usUQoSxRYtIRgYhNnB0oU3NfN
X-Google-Smtp-Source: AGHT+IHvoJuojuU6yBzU4Gb+hyQAkrzRj/TLwt0i3vx1k0d38m1XEYaQrg2hsuixkLNriyG5+/CJsg==
X-Received: by 2002:a17:907:7f8f:b0:b04:36bb:545 with SMTP id a640c23a62f3a-b04b16dd7bcmr1063233066b.48.1757374030565;
        Mon, 08 Sep 2025 16:27:10 -0700 (PDT)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com. [209.85.218.43])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aff9918dbd2sm2380083666b.103.2025.09.08.16.27.07
        for <linux-trace-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Sep 2025 16:27:07 -0700 (PDT)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b04b55d5a2cso457899166b.2
        for <linux-trace-kernel@vger.kernel.org>; Mon, 08 Sep 2025 16:27:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXIWLcsbCv+20kIGiaJQi42i+Pzwom1KuTRX+wmRJC9Tp+oHY6hSLhC4xlvvOQcxvr0TDtdIfcGxVNYS5hE0b3+2lk=@vger.kernel.org
X-Received: by 2002:a17:906:f597:b0:b04:ad1c:59e4 with SMTP id
 a640c23a62f3a-b04b13cfa09mr966785466b.12.1757374027292; Mon, 08 Sep 2025
 16:27:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250828180300.591225320@kernel.org> <20250829110639.1cfc5dcc@gandalf.local.home>
 <CAHk-=wjeT3RKCTMDCcZzXznuvG2qf0fpKbHKCZuoPzxFYxVcQw@mail.gmail.com>
 <20250829121900.0e79673c@gandalf.local.home> <CAHk-=wj6+8vXfBQKoU4=8CSvgSEe1A++1KuQhXRZBHVvgFzzJg@mail.gmail.com>
 <20250829124922.6826cfe6@gandalf.local.home> <CAHk-=wid_71e2FQ-kZ-=aGTkBxDjLwtWqcsuNSxrarnU4ewFCg@mail.gmail.com>
 <6B146FF6-B84E-40A2-A4FA-ABD5576BF463@gmail.com> <CAHk-=wjgdKtBAAu10W04VTktRcgEMZu+92sf1PW-TV-cfZO3OQ@mail.gmail.com>
 <20250829141142.3ffc8111@gandalf.local.home> <CAHk-=wh8QVL4rb_17+6NfxW=AF-HS0WarMmq-nYm42akG0-Gbg@mail.gmail.com>
 <20250829171855.64f2cbfc@gandalf.local.home> <CAHk-=wj7rL47QetC+e70y7pgyH4v7Q2vcSZatRsCk+Z6urA3hw@mail.gmail.com>
 <20250829190935.7e014820@gandalf.local.home> <CAHk-=wgNeu8_=kPnKwFpwMUC=o-uh=KjJWePR9ujk=7F9yNXDQ@mail.gmail.com>
 <20250830143114.395ed246@batman.local.home> <CAHk-=wjgXGuJVaOmftxnwrS6FafwrLL+yHrH6-sgbBRB-iLn8w@mail.gmail.com>
 <20250908174235.29a57e62@gandalf.local.home> <CAHk-=wiEL-5f96NbRtm4JJVi6u=3Edto9-ZABgpOc6WAj=gX=w@mail.gmail.com>
In-Reply-To: <CAHk-=wiEL-5f96NbRtm4JJVi6u=3Edto9-ZABgpOc6WAj=gX=w@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 8 Sep 2025 16:26:50 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgyry=1=gabJ0iw_HbqrHkg84gCvKQXi5Qg5u6pq=vwzg@mail.gmail.com>
X-Gm-Features: Ac12FXw_TEqw3uAfoUb6rds-8PBZlK9wEtfwraJcwLFCTgjp6oxAH2_abLFrQqY
Message-ID: <CAHk-=wgyry=1=gabJ0iw_HbqrHkg84gCvKQXi5Qg5u6pq=vwzg@mail.gmail.com>
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

On Mon, 8 Sept 2025 at 16:09, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Make the "give me the expensive output" be a dynamic flag, so that you
> don't do it by default, but if you have some model where you are
> scripting things with shell-script rather than doing 'perf record', at
> least you get good output.

Side note: you could make that dynamic flag be basically "per-target",
by having the *tracer* open the files that it wants to match against,
and guaranteeing that the dentry stays around by virtue of having
opened the files.

Then - I'm handwaving a bit here - you could have some "hash the
dentry pointer" model.

In that model,  you couldn't use the 'struct file' hash, because now
you're matching against different 'open()' cases: the tracer that uses
sysfs would open the executable and the libraries it knows it is going
to trace, and keep them open for the duration of the trace in order to
have stable hashes for those files.

All the tracer would need is some simple interface to "give me the
hash for the file I just opened", and then it could easily match that
against any hashes it sees in sysfs stack traces.

The advantage of this model is that now the tracer not only has the
hash, and controls the lifetime, it means that the tracer also can
decide to look up build IDs etc if it wants to.

The disadvantage is obvious, though: this requires that the tracer
know what the files in question are. Of course, that's usually not
that hard. You might literally just know it a-priori (ie just from
what you are tracing along with having run 'ldd' etc), but for the
'I'm tracing a running process' you can use that /proc/<pid>/maps file
to start populating your hash information.

I'm *not* claiming this is a wonderful interface, but it's at least a
*fairly* straightforward way to give some kind of cheap hash ID for
the user space traces, and it puts the burden of "hash lifetime"
clearly on user space, not on the kernel having to try to maintain
some kind of hash map.

In other words: if user space wants to get good information, maybe
user space needs to work at it a bit.  The kernel side shouldn't be
made complicated or be expected to bend over backwards.

          Linus
