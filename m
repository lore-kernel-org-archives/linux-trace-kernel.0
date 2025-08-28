Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B03248F7D
	for <linux-trace-kernel@vger.kernel.org>; Thu, 28 Aug 2025 19:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756408739; cv=none; b=pHAJ712ffM8lN/mO2o852wf/39qA3IoB2vXuWgOJ0EOsrU97XMuCOlzahqI0YsiKaVAcVyzqn8NBOKfJ4knuxA9z+QIMwEpjsITzI3xHSXyqn436F70burJlPnNej0lUE3q6SvaVHDsz3YsPle7sGxjrvUPMyEgs2cqzYg6F6PY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756408739; c=relaxed/simple;
	bh=2IF4LwSznkIAWKigu6MO3g12tp2YjOkonuilJ4MG6gc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ME3EUc9WuC662jZjQ6caR/yJbD3jTdU/X1bMCTDWW/m0AxHK79zSsCVKtFSBjOpDlJWQL+ry1P6BbgUtWtZFCi+lTHKrhYH8TzNSsGl9iLaiIDz3BtPZlUI2hYlXFisv9SCFtVpYnnoQgMmK7sTZeWsq1RLmo55hn+KkGhvc1ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=SZ7gLaOy; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="SZ7gLaOy"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-afebe21a1c0so205471766b.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 28 Aug 2025 12:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1756408736; x=1757013536; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=a9FvOgSym4EqR03gYaZF038ABDYjvh3jMsW76/lQsV0=;
        b=SZ7gLaOyE94Z7+REmfmjJVMP+S9/oTH+B9y4F75j9jMxbHe8u6sEQ93TYbCunwikO4
         YON7nRrTRzJa7gDkqWl3dmzu474grZa9D/LDjawdj1eFVcPG6EJ1r99NHkF+dNC3p3P4
         yVqxKO2CK9LgZKJrjd1R71OYPGBUeOzMBzAK8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756408736; x=1757013536;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a9FvOgSym4EqR03gYaZF038ABDYjvh3jMsW76/lQsV0=;
        b=VrB/wOr0wWZps/qDxCtEBaLt708z8sb3kPnSGM6bvA2kE7TWXRQNUfh2cZbgiKMWzu
         6VqiaiHsulXaSZaYW+Qa2zAIMsGMe+OvgOt47dkwe256hbfShdIjIY/ZGMVkORy2uR2q
         q/EcaxxM9ga1uAH4rTNIipEw3JWA4jMfQy51OWHGJjobaMmtI4XI9MBnF3NNVmra0oBd
         mEKGo3+msyqgdj52DAiR9+IX29w7GsC6SYJAdKK9r9hMC5X4AF62f4R8PpfmjTonpj7L
         QcgsOrzFg0noNt/SH/+crwRxVEeWNBAfiDLHJ4WoRQ9jHt+jYNzfna47vH5nVVSeW46l
         xLtg==
X-Forwarded-Encrypted: i=1; AJvYcCXkhgIIN6dgZCmGhNS5uNq0uza+/iVzjgYx8IqxpCwkM8A0W0JKsxFo2NfItgRYs/TZ1vuSbmFXce+FJ/XzE+1NPM8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDQus8ubr/pG9w1aBOx8R6wZ/3mV5a1aaHlmdHkvLWl/2U7gv7
	TqAc9e/Q2t+jZO+VkV3LqQ+KhOiDxau3OT0NTEReLOlFOJUXEFz0MJUg5Srmyw7M31G+ySlePqa
	gjQN8G+4=
X-Gm-Gg: ASbGncuTvZ9i08PSwDZCeaonj1fOX8WB5nFYTaziiJ6cPdd4Z/WDOSbuGEn3tpNtfvy
	ADgzWxgsjX1N6BPBXW1XNeBipToK9J8+Ns1bErRUSPCrkLnrs50OCIPYSlYbY9SYT+TxjV4wqNW
	ysEGY04RzUNXMvWFHIxQJnHpw8uaZ3FtlMii+rdKYHgP4UtuNDfPDY3s7W50hutXLFAq5PEwiJ/
	JulkPAwLAarX9mqSTjrPbPIvuEkw8fhauI4LJFIHAlt122VENmaXlntnGxhSeecRaSbROp1JIXw
	zGTVvSiIRIFQa09Pnv0jKM8UmujE8VH/XZU12UF3KBwtqTqTFNPXoEbi0FgEmkAGOUxXgH8ris7
	lO4ITfw6u2kNrotgOrtjpVBhn7qQ9O4J0GqWwnv4UI0/QCTNFYLrK2rJs2jL0dYkAZHlBsbji
X-Google-Smtp-Source: AGHT+IG4DhaKX9Z+auTVo7vgLXakfjKpUDejaDo7dhCuNiJWdehqML9p0m8V4Ph/i3lqHuHPek2iBw==
X-Received: by 2002:a17:907:6d0b:b0:afe:da1c:8809 with SMTP id a640c23a62f3a-afeda1c8ac0mr392521766b.29.1756408736085;
        Thu, 28 Aug 2025 12:18:56 -0700 (PDT)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com. [209.85.218.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afefca090f6sm23074666b.36.2025.08.28.12.18.55
        for <linux-trace-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Aug 2025 12:18:55 -0700 (PDT)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-afec5651966so236431766b.2
        for <linux-trace-kernel@vger.kernel.org>; Thu, 28 Aug 2025 12:18:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWqQNue6RtfnZ8IthJRN1myAwgdZ9f9ICP52bHqNoQXPJl3/5HIvZ0bjh8BIkzIqVAOVrsIaXVoHFeXOQ59DVlndM8=@vger.kernel.org
X-Received: by 2002:a17:907:7242:b0:afe:9f26:5819 with SMTP id
 a640c23a62f3a-afe9f265912mr1037393266b.28.1756408735434; Thu, 28 Aug 2025
 12:18:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250828180300.591225320@kernel.org> <20250828180357.223298134@kernel.org>
 <CAHk-=wi0EnrBacWYJoUesS0LXUprbLmSDY3ywDfGW94fuBDVJw@mail.gmail.com> <D7C36F69-23D6-4AD5-AED1-028119EAEE3F@gmail.com>
In-Reply-To: <D7C36F69-23D6-4AD5-AED1-028119EAEE3F@gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 28 Aug 2025 12:18:39 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiBUdyV9UdNYEeEP-1Nx3VUHxUb0FQUYSfxN1LZTuGVyg@mail.gmail.com>
X-Gm-Features: Ac12FXyRk9o0Zpd1fgIo8tAfxDzyblfn9y2Gh_4SDmM8oOmqSsm_2faftGdE2CA
Message-ID: <CAHk-=wiBUdyV9UdNYEeEP-1Nx3VUHxUb0FQUYSfxN1LZTuGVyg@mail.gmail.com>
Subject: Re: [PATCH v6 5/6] tracing: Show inode and device major:minor in
 deferred user space stacktrace
To: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc: Steven Rostedt <rostedt@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org, x86@kernel.org, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Andrii Nakryiko <andrii@kernel.org>, 
	Indu Bhagat <indu.bhagat@oracle.com>, "Jose E. Marchesi" <jemarch@gnu.org>, 
	Beau Belgrave <beaub@linux.microsoft.com>, Jens Remus <jremus@linux.ibm.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Florian Weimer <fweimer@redhat.com>, 
	Sam James <sam@gentoo.org>, Kees Cook <kees@kernel.org>, "Carlos O'Donell" <codonell@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 28 Aug 2025 at 11:58, Arnaldo Carvalho de Melo
<arnaldo.melo@gmail.com> wrote:
> >
> >Give the damn thing an actual filename or something *useful*, not a
> >number that user space can't even necessarily match up to anything.
>
> A build ID?

I think that's a better thing than the disgusting inode number, yes.

That said, I think they are problematic too, in that I don't think
they are universally available, so if you want to trace some
executable without build ids - and there are good reasons to do that -
you might hate being limited that way.

So I think you'd be much better off with just actual pathnames.

Are there no trace events for "mmap this path"? Create a good u64 hash
from the contents of a 'struct path' (which is just two pointers: the
dentry and the mnt) when mmap'ing the file, and then you can just
associate the stack trace entry with that hash.

That should be simple and straightforward, and hashing two pointers
should be simple and straightforward.

And then matching that hash against the mmap event where the actual
path was saved off gives you an actual *pathname*. Which is *so* much
better than those horrific inode numbers.

And yes, yes, obviously filenames can go away and aren't some kind of
long-term stable thing. But inode numbers can be re-used too, so
that's no different.

With the "create a hash of 'struct path' contents" you basically have
an ID that can be associated with whatever the file name was at the
time it was mmap'ed into the thing you are tracing, which is I think
what you really want anyway.

Now, what would be even simpler is to not create a hash at all, but
simply just create the whole pathname when the stack trace entry is
created. But it would probably waste too much space, since you'd
probably want to have at least 32 bytes (as opposed to just 64 bits)
for a (truncated) pathname.

And it would be more expensive than just hashing the dentry/mnt
pointers, although '%pD' isn't actually *that* expensive. But probably
expensive enough to not really be acceptable. I'm just throwing it out
as a stupid idea that at least generates much more usable output than
the inode numbers do.

          Linus
