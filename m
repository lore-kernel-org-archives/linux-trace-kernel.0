Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C32C7338F3C
	for <linux-trace-kernel@vger.kernel.org>; Fri, 29 Aug 2025 16:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756486784; cv=none; b=XqOEKTnG9W7QXkmJ8E7fpOoI9SIhTglwlJBXkWu+rdz8ABgbjHg/ZDouqC5S7BT6Ew0b1k6zBII4CVclqe0/437R5scHuLSq9wElamvQOE4aYVCQMfN05SbbJQS2Lcqf8Kyx9RTupwA0uF0wT+Unh/elGfOgzBdrTRWV6ERZju0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756486784; c=relaxed/simple;
	bh=SoJHOnBFCfoGCBXTsMVg+w/WiCD13CEgrKBCjixr8RU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KP7BwbTV7/BYNLXce2DD7hwUpnwjoN5t+CsSiZfBFEJRJIqZG3Ur1ANM/Z+6GA++iNcWaTD7goAlyz+R30UMxorVz3qw6tbBkP14KSH/HEQwd1BDhzYd37Kif9oHoiXn8/bH1l/fNGz+faz1N+UVkt6Y/8bnjb2wPKjSP0TJyJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=alX6dzvX; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="alX6dzvX"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-61cf429f4c2so3250450a12.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 29 Aug 2025 09:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1756486781; x=1757091581; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Mkhd78GreWWyO+3GVa0xKo1UMaxxdaoGBAEK0+06R70=;
        b=alX6dzvXcbyQNniAySs+9CvQdJiKS1roUgXjpKA8QqoxkWJjCnV1EIgVLggBZ/zraL
         6CBPIdW2MLqQnDSQa5aezCxf41K63dNWK4zNptEPlRrkSGx6mOQekd5mumZOLhAkESv2
         rlHIwSbIWuqqB9de1fKtMq1KvW9cMmTJoX92s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756486781; x=1757091581;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Mkhd78GreWWyO+3GVa0xKo1UMaxxdaoGBAEK0+06R70=;
        b=Nkt1tNYc/VfZ5RLmriVE1nTA7/3eSnuIfbATgCt5RMwscKavwJldoJD/m82jo4EsMj
         KfPBWgzAltUNV69NWfDJVlobaC1u+Auek7QM5GdtzzriANHs4wxjHlLiFw1XK2HmfH1I
         9GjPUAA3tDwaKGtlanI1SGEjaRNHkzluxBK3xoGDdrwCO0DLeM6Aivu/Uv2s5Tr215b7
         OB89mmKXgsL2qtc+F5t16MELQl6VGn4faL1nDgd1x6Tp2X+GcYqInSjDBpJZH72O3mzB
         110i3KS6arwsEezXQ5YZzA/V77QhlNzgvcb0NMyFFyuuoRcSYA9SCT4HNAeCemgZ/msl
         RjAg==
X-Forwarded-Encrypted: i=1; AJvYcCWDs30cOB4XI3kizyK8RbtTIeHJumHM5hw79I69vdp3KelEgPfTpl7cHQ40U8jUANwIa9v4+MwcCNvqsKVS4FIFAdM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1w3w0wFsrC6FnXaG5ioFfUei2wWkekZhyzTCfi83aYGDSyot+
	3dY5c4TOCB4Zgg9oQQVP5orrCD3gVEabEVQfLaKNYIpGijl7L+tvicEH4DX0bpdfAjeoL+0paTW
	FmSlo0hjroQ==
X-Gm-Gg: ASbGncuwE5V2C6+RlZ2rqSOjKMiq9EuCT+iPqFviTwfSWI6jJpnU2H6HfGfUM+K60VZ
	er1zzp1qKc1qmJ9O6jO+0Ry9k7vWwYPXbvhLbDXBwK1okYSr/8+PsSKmZd47kanQdMjFH+nW53b
	ejPtVZQK+X9zQIsAZ2Sju0ZTaN7eD98rD1ckfrnJAajlWMi/zN6L8LtaWwzS3Igejk5HxIW1opS
	+hAS10Xt6hNKChm6aTORvcTsqyuai6sriseTQ5EPl9xg0h9YTlvcK/3BU/2YfgayfJnBnnP9UwJ
	lmWcV1ZxbhecK/BLAJp5t7LCiFYS6eJqGsT1PauHchxKlKBfITyNOOm8A5NfqC/XXsDDAQDJ0rs
	geWTmGswWCwepOgTStOBIu6cCxXin229G0UnafL9FNkOUGCGA4R9imsTwCAxuUpMcsiVG4Qbyog
	DPZKJCe5Y=
X-Google-Smtp-Source: AGHT+IHgKWTvBKCg87hEqM8douFlOGGqDdCHM4+HwshBqBzCDSyf9hO1NBGIfm6G8UX0MlbGWZ3aQA==
X-Received: by 2002:a05:6402:5108:b0:61d:1d36:a7d5 with SMTP id 4fb4d7f45d1cf-61d1d36aa77mr551437a12.19.1756486780767;
        Fri, 29 Aug 2025 09:59:40 -0700 (PDT)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com. [209.85.218.46])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61cfc214bb7sm1991963a12.13.2025.08.29.09.59.38
        for <linux-trace-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Aug 2025 09:59:38 -0700 (PDT)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-afcb7322da8so429635866b.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 29 Aug 2025 09:59:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVPpvWnjli2RXnAkQeKkjyLw0vqXre4+0s3zYe1iw51OcrLfwmzybOnsQDDNILTVFiuYgFXpN/fZz3EcSbhNvxQoBo=@vger.kernel.org
X-Received: by 2002:a17:906:7306:b0:afe:f418:2294 with SMTP id
 a640c23a62f3a-afef4183758mr490846066b.49.1756486778196; Fri, 29 Aug 2025
 09:59:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250828180300.591225320@kernel.org> <20250828180357.223298134@kernel.org>
 <CAHk-=wi0EnrBacWYJoUesS0LXUprbLmSDY3ywDfGW94fuBDVJw@mail.gmail.com>
 <D7C36F69-23D6-4AD5-AED1-028119EAEE3F@gmail.com> <CAHk-=wiBUdyV9UdNYEeEP-1Nx3VUHxUb0FQUYSfxN1LZTuGVyg@mail.gmail.com>
 <20250828161718.77cb6e61@batman.local.home> <CAHk-=wiujYBqcZGyBgLOT+OWdY3cz7EhbZE0GidhJmLNd9VPOQ@mail.gmail.com>
 <20250828164819.51e300ec@batman.local.home> <CAHk-=wjRC0sRZio4TkqP8_S+Fr8LUypVucPDnmERrHVjWOABXw@mail.gmail.com>
 <20250828171748.07681a63@batman.local.home> <CAHk-=wh0LjoJmRPHF41eQ1ZRf085urz+rvQQ-rwp8dLQCdqohw@mail.gmail.com>
 <20250829110639.1cfc5dcc@gandalf.local.home> <CAHk-=wjeT3RKCTMDCcZzXznuvG2qf0fpKbHKCZuoPzxFYxVcQw@mail.gmail.com>
 <20250829121900.0e79673c@gandalf.local.home> <CAHk-=wj6+8vXfBQKoU4=8CSvgSEe1A++1KuQhXRZBHVvgFzzJg@mail.gmail.com>
 <20250829124922.6826cfe6@gandalf.local.home>
In-Reply-To: <20250829124922.6826cfe6@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 29 Aug 2025 09:59:21 -0700
X-Gmail-Original-Message-ID: <CAHk-=wid_71e2FQ-kZ-=aGTkBxDjLwtWqcsuNSxrarnU4ewFCg@mail.gmail.com>
X-Gm-Features: Ac12FXzoWvnofwTTj2JxozA4t3wVRQGACFrkZ3mDbu-fxUdeCzXWr6mKd0oudcA
Message-ID: <CAHk-=wid_71e2FQ-kZ-=aGTkBxDjLwtWqcsuNSxrarnU4ewFCg@mail.gmail.com>
Subject: Re: [PATCH v6 5/6] tracing: Show inode and device major:minor in
 deferred user space stacktrace
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Steven Rostedt <rostedt@kernel.org>, Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>, 
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

On Fri, 29 Aug 2025 at 09:49, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> What do I use to make the hash?

Literally just '(unsigned long)(vma->vm_file)'.

Nothing else.

> One thing this is trying to do is not have to look up the path name for
> every line of a stack trace.

That's the *opposite* of what I've been suggesting. I've literally
been talking about just saving off the hash of the file pointer.

(And I just suggested that what you actually save off isn't even the
hash - just the value - and that you can hash it later at a less
critical point in time)

Don't do *any* work at all at trace collection time. All you need is
to literally access three fields in the 'vma':

 - 'vm_start' and 'vm_pgoff' are needed to calculate the offset in the
file using the user space address

 - save off the value of 'vm_file' for later hashing

and I really think you're done.

Then, for the actual trace, you need two things:

 - you need the mmap trace event that has the 'file' value, and you
create a mmap event with that value hashed, and at that point you also
output the pathname and/or things like the build ID

 - for the stack trace events, you output the offset in the file, and
you hash and output the file value

now, in user space, you have all you need. All you do is match the
hashes. They are random numbers, and user space cannot know what they
are. They are just cookies as a mapping ID.

And look, now you have the pathname and the build ID - or whatever you
saved off in that mmap event. And at stack trace time, you needed to
do *nothing*.

And mmap is rare enough - and heavy enough - that doing that pathname
and build ID at *that* point is a non-issue.

See what I'm trying to say?

               Linus
