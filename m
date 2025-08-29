Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F8B343209
	for <linux-trace-kernel@vger.kernel.org>; Fri, 29 Aug 2025 17:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756489180; cv=none; b=bsGyDSq/XjJ2XN/aw5zNq1GUMYMKe8fcWALrp/cMV7CvYQMRAny3aaX2raMrWDMfWENe4fXLc5Qw2dzghO5jSLYnOVwSOL0F2nccKyMtT1z/yQeC72AloDzynTUGL21s0vr/bygy300MH4AjSf3twVxTQ/AOUw0MOsqsqd7+vUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756489180; c=relaxed/simple;
	bh=0Iwk8kojSYVfnDLAmzrwi9KHqF0f7PplXnNwNjdrHA8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J4vVZZNmmlouxbTJci9SBdKtSDVUgFJhkY+zARIuAocNOo9qbieOaGfgSOj7AKnFY1hsts98J5D9NBO8mcNzV9G6OidNje6OEjNHXnLVpQX0mIwjm8I/FJEdyIyiiKJHieDgf1D3J0OR+BuKc1HycemgTyLqEGS7wVjLXubGB1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=I7siMDK0; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="I7siMDK0"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-afcb7ae31caso443618366b.3
        for <linux-trace-kernel@vger.kernel.org>; Fri, 29 Aug 2025 10:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1756489176; x=1757093976; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/JzHs6USaZca2JuAKnnFeoU743SczkPKj5+4UqlxGdQ=;
        b=I7siMDK0nVqBhg66tMVWyHS9rCi/M2tZZqEFjUBMi7mXI5AbTPBa4xbGtHOmh39Fj2
         tM+JmOyrB2GQbTUsmuUANsjgYL6pYoQ1Y0q48lo9UmdYtefDVdkifKdGn8P3FATpBwW+
         hm6G0uUIHwbrHWhYE8PrVwtSCWvUAsjwtjkLw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756489176; x=1757093976;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/JzHs6USaZca2JuAKnnFeoU743SczkPKj5+4UqlxGdQ=;
        b=BgWCiqkWFc6heYFxFYFOaIXfftxObV8QVgvsX7wa+oCPSLPki2zWFYIx5Q2A042s1a
         JjYe3/pS5eNPiK/+tkx1KEiz18w8RtWhcqE8Age3UE5Wxw1onmab9/B7JI1viwZMi7B+
         CWNY1InLpZCxExA0/zX7abyAUkDfTiE8Rqiyzpv1kTye5u3y/l0VDjqHID2E/ncDVM5k
         3ROioUoJGH/fuJCkhxR2St1lH9Ax8bH1D+NuUlMBSF9bm4/AdHbsgWSzWRbYNYiezN4Z
         +ZyAemShlG3ELi/5lV4i3IchyYiZmqqStqeTovz4x0VTBdOENj/yaPr9RPH2JKJAXyjv
         K3hg==
X-Forwarded-Encrypted: i=1; AJvYcCUhm6FDrVt1yZH7Ww/TVJ8JNAV+gsjlzRWGqerFhnSbJlkgSO1RtZPWWXwkZcOqv7Puj9FojmjyOz5JjyjOtMJOUMo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNAwMVdVPQhNjB2MuV/dd+b5CIgDcJ9IRSBxwHoKwtyQYN+7py
	6IaBbNHt4JxPdYXCgCgpbp5dT0Tg4fzAv9SI3lBsdyE1PC4uG2G4K7qFWnSfwjoJB6kLZa/trx+
	CMPSKay/Q4w==
X-Gm-Gg: ASbGncsFpQ61itGkEXn/23mMjA09+o0YURuGcksxcp+/fSDCmHv5eDbh5H9dchy+amf
	dRrqsBBn7HIS4A4v9o/j6r6OviFkGPVFKxxfRVxuolmX8hAlr75EVl/1G/GLgybkdFOHMeCMH3j
	h3PpGXC1mm+l+dlb+ohPuW82PQjYj8rzBTlvOV63VqGNZRCwdYN4pGzV0qOHUeeYhePpNvLnS6k
	17wAq4CkwyQUxGo+pmiprCbW4BWVKKPCf+66z46Qi0jl58kQhT2LHAgX24KRzy1gAyUtZEQ1KHq
	iUpEesBuGZqz3PEC80u11LoVI5cLDHul+BU8kzkLsMaw9Vj1G/EOOlraQX0x12QlGm8KhGQ0WI5
	RfTBG82fW2n4yc1zRdnf6F4eA3DkQRQE3LFFuZLkPJO+Te1BDyvLdjnzVDoLRN16Iw33KPDn3
X-Google-Smtp-Source: AGHT+IFrsYXj4GjrD99ySqfsIwNYoAisqZVBR+a7Im8HSIccaj8sN3fe8yzO6dMkDA5t+ufo86vlxg==
X-Received: by 2002:a17:906:478f:b0:af9:3589:68cb with SMTP id a640c23a62f3a-afe2974a001mr2780944666b.48.1756489176108;
        Fri, 29 Aug 2025 10:39:36 -0700 (PDT)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com. [209.85.208.43])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afefca3cce4sm243488966b.45.2025.08.29.10.39.35
        for <linux-trace-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Aug 2025 10:39:35 -0700 (PDT)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-61caa266828so4952642a12.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 29 Aug 2025 10:39:35 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWASf/oLTbgdXTBt/3UEtWLl/8g9r24HmCgABEGkqOXKxAgjSfkksUHAseti1QnmkJVPK9K9109Z8O+QrZ4yT7qANw=@vger.kernel.org
X-Received: by 2002:a17:907:7286:b0:afe:d24f:fd70 with SMTP id
 a640c23a62f3a-afed2500115mr854960366b.43.1756488835450; Fri, 29 Aug 2025
 10:33:55 -0700 (PDT)
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
 <20250829124922.6826cfe6@gandalf.local.home> <CAHk-=wid_71e2FQ-kZ-=aGTkBxDjLwtWqcsuNSxrarnU4ewFCg@mail.gmail.com>
 <6B146FF6-B84E-40A2-A4FA-ABD5576BF463@gmail.com>
In-Reply-To: <6B146FF6-B84E-40A2-A4FA-ABD5576BF463@gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 29 Aug 2025 10:33:38 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjgdKtBAAu10W04VTktRcgEMZu+92sf1PW-TV-cfZO3OQ@mail.gmail.com>
X-Gm-Features: Ac12FXy9v9IJY2LXrpDvJU9dj4Mt87wFmaIDhMj9zyTfDwA5B4n7cidgQycVydY
Message-ID: <CAHk-=wjgdKtBAAu10W04VTktRcgEMZu+92sf1PW-TV-cfZO3OQ@mail.gmail.com>
Subject: Re: [PATCH v6 5/6] tracing: Show inode and device major:minor in
 deferred user space stacktrace
To: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Steven Rostedt <rostedt@kernel.org>, 
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

On Fri, 29 Aug 2025 at 10:18, Arnaldo Carvalho de Melo
<arnaldo.melo@gmail.com> wrote:
>
> As long as we don't lose those mmap events due to memory pressure/lost
> events and we have timestamps to order it all before lookups, yeah
> should work.

The main reason to lose mmap events that I can see is that you start
tracing in the middle of running something (for example, tracing
systemd or some other "started at boot" thing).

Then you'd not have any record of an actual mmap at all because it
happened before you started tracing, even if there is no memory
pressure or other thing going on.

That is not necessarily a show-stopper: you could have some fairly
simple count for "how many times have I seen this hash", and add a
"mmap reminder" event (which would just be the exact same thing as the
regular mmap event).

You do it for the first time you see it, and every N times afterwards
(maybe by simply using a counter array that is indexed by the low bits
of the hash, and incrementing it for every hash you see, and if it was
zero modulo N you do that "mmap reminder" thing).

Yes, at that point you'd need to do that whole "generate path and
build ID", but if 'N' is a large enough number, it's pretty rare.
Maybe using a 16-bit counter would be sufficient (ie N would naturally
be 65536 when it becomes zero again).

That might be a good thing regardless just to have some guaranteed
limit of how far back in the trace you need to go to find the mmap
information for some hash. If you have long traces, maybe you don't
want to walk back billions of events.

But I wouldn't suggest doing that as a *first* implementation. I'm
just saying that it could be added if people find that it's a problem.

            Linus
