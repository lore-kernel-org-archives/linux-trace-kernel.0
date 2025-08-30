Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A805922FDFF
	for <linux-trace-kernel@vger.kernel.org>; Sat, 30 Aug 2025 19:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756580655; cv=none; b=j7cJTrNtUp22YmIK9z10q6KeRfmfkPn04N8M5encNyCg/22vlbk4qMUkcx55KUJcOZObXZuWD9xrYEbJP3wU6Z1PSZADbP1E7Vkm5UkdWSTqk3Cf/USTjWYis3FtK/mpD8k5Zx9NiYHp3SlJE+ibkPwB3ehhvJVC1+BzTUC2MBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756580655; c=relaxed/simple;
	bh=APZRD3R5mQMFLWqOyeRR80xS4Xl7AJEaecu1Pv4PsOA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RpyKmYvk1P4tCpX/8S7op3mCsYw3eLQU+8G57K0USHi/U9XjBpXuyrJ8/dxMq1yRGRn7z8vFu6Oof51KO1ATHlypF5YUymyi298jCl7sqVoO1XNaY3U83KwvQs6K8sz3f6zstTUYarrOs/H291AgNscytHN9SvaiofLiBwXgqfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=N9xjW2FA; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="N9xjW2FA"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-61cd1046d42so3809078a12.3
        for <linux-trace-kernel@vger.kernel.org>; Sat, 30 Aug 2025 12:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1756580652; x=1757185452; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7C7HDDF1V0ye1jSQLTEXSfhzx7+YOYStSyUtu7nMWFg=;
        b=N9xjW2FAZLWTnANDMuuUTurweSJVg+W+cMkhqkeQ+jIvV0MqgoK9mCVkCwb2WM7+sx
         2bpgNSOQrLMtF9ygUXM3HIJU7oWNS+pTyBzHJeCPmJwRug+jAV2IHOxXTbg7w5SIVw64
         e6hqg0dPcFO5a55Fokww6K2l5rqiHJbdhK4As=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756580652; x=1757185452;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7C7HDDF1V0ye1jSQLTEXSfhzx7+YOYStSyUtu7nMWFg=;
        b=SfVHzc1xH6T8TczZrfA5UsPJJWA9/9UEFoQmM7EJtqJ1O7qkCvYjK8MDkttEZU0Ll2
         tjWUgMPujnroflr2Lekwuekt/WdQKPnNJPRZ6Gn6IKa1uIUouDBSu504AwCscUcIaJVV
         2kDifAo0C5HsesMJgAu+IeCRny/T3W0X9Rdqa6SuySKsSkdN7QY0jU9sprt5jqMkOlVU
         kj3u2OZZHssQySViZwJ1ZS2URhmk9wGEqqgMhSTEcxUKNjgQnF7NmS/0DTwHI5CHwnaD
         H5H3IGkIhgbxyz6ZvKZraXPwnyAmy4Z1d24YOSr7GiZ7ow7NP3ZYA1yGe68yUlIbCZfT
         gTuA==
X-Forwarded-Encrypted: i=1; AJvYcCVmRmEQvWEfRu93e2se+FLlRNs0PnXRAK7sy9+zqHaO7yXU9rS1SWnyeXGRhsGzxIWLShU2Q9QbOf7PHN/MRLs/bVY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUVt6rXum3UdhuIrKN/+sjTcDBmOTWyvK/WILo/Bj+FaTKmJVp
	KOBWch1X/gS/ZuLMWgj5dqGWdbvFSDW5ABGlPQHA0EUO53db0kbl1YTgJQN4YN0l7DbjElgP0d5
	ucVYLOQYPpA==
X-Gm-Gg: ASbGncujUte8jU2GW1gjtTYEnFNO7kxg5mlLCy81bqOra7+oLQao1T2vXVC+bcSv4Ed
	ZQLbLWVN/gnsY/8R3//VH8OObxnQHWwG/RleVpcXn1U6fRR6TN4MXFjoJsnWGzeSXi4garEvDPo
	U1vUbcAYo+WSRCq65Gu8RtxfndIyfkHY26YuXHOZSoRjP8Nck4V0I/aKpdbPeBoR0LryxwhkyRK
	tYaqgBZj4tIxKz7dcHMJUBas43E7ZhCvX9cb606wdAirggGnyv9bwe+YzNxW0ECylrDBZ2jF3dJ
	nnsKI9WHFgYKMDzr9k1k9jTDsTjrGKdeY8kU89pqOr5xXDXVZhR7jLwu/6VkYNRiL9vts71jK2K
	7xt69ZP9EMAVUelczNcE7w3m3FZg+3YIAKFve/vOTwRprYzR+WPmqMRV/4VN4TH61S1FfQmWr
X-Google-Smtp-Source: AGHT+IE6SJ7yIyqrg5AUPTVvtwxAK/8vgWEDL+aW8ypKXrLJGh0QMvZ7zKc5Bfci1QdTTjcrYSQQBg==
X-Received: by 2002:a05:6402:2747:b0:615:9d94:2934 with SMTP id 4fb4d7f45d1cf-61d2689310emr2619571a12.10.1756580651721;
        Sat, 30 Aug 2025 12:04:11 -0700 (PDT)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com. [209.85.208.45])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61cfc4bbd09sm4068874a12.33.2025.08.30.12.04.10
        for <linux-trace-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Aug 2025 12:04:10 -0700 (PDT)
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-61cd1046d42so3809058a12.3
        for <linux-trace-kernel@vger.kernel.org>; Sat, 30 Aug 2025 12:04:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVgmjdNleL3KgrfGgXe0Ab1AL1oOTTHJrh5GofADfSIZONeFgKiKBYF6BwLVYTpotgu0dsbfDFp3uN6pYUI8WEZDNA=@vger.kernel.org
X-Received: by 2002:a05:6402:26c4:b0:61d:1cbf:bb4a with SMTP id
 4fb4d7f45d1cf-61d26d7904amr2319235a12.29.1756580650360; Sat, 30 Aug 2025
 12:04:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250828180300.591225320@kernel.org> <20250828171748.07681a63@batman.local.home>
 <CAHk-=wh0LjoJmRPHF41eQ1ZRf085urz+rvQQ-rwp8dLQCdqohw@mail.gmail.com>
 <20250829110639.1cfc5dcc@gandalf.local.home> <CAHk-=wjeT3RKCTMDCcZzXznuvG2qf0fpKbHKCZuoPzxFYxVcQw@mail.gmail.com>
 <20250829121900.0e79673c@gandalf.local.home> <CAHk-=wj6+8vXfBQKoU4=8CSvgSEe1A++1KuQhXRZBHVvgFzzJg@mail.gmail.com>
 <20250829124922.6826cfe6@gandalf.local.home> <CAHk-=wid_71e2FQ-kZ-=aGTkBxDjLwtWqcsuNSxrarnU4ewFCg@mail.gmail.com>
 <6B146FF6-B84E-40A2-A4FA-ABD5576BF463@gmail.com> <CAHk-=wjgdKtBAAu10W04VTktRcgEMZu+92sf1PW-TV-cfZO3OQ@mail.gmail.com>
 <20250829141142.3ffc8111@gandalf.local.home> <CAHk-=wh8QVL4rb_17+6NfxW=AF-HS0WarMmq-nYm42akG0-Gbg@mail.gmail.com>
 <20250829171855.64f2cbfc@gandalf.local.home> <CAHk-=wj7rL47QetC+e70y7pgyH4v7Q2vcSZatRsCk+Z6urA3hw@mail.gmail.com>
 <20250829190935.7e014820@gandalf.local.home> <CAHk-=wgNeu8_=kPnKwFpwMUC=o-uh=KjJWePR9ujk=7F9yNXDQ@mail.gmail.com>
 <20250830143114.395ed246@batman.local.home>
In-Reply-To: <20250830143114.395ed246@batman.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 30 Aug 2025 12:03:53 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjgXGuJVaOmftxnwrS6FafwrLL+yHrH6-sgbBRB-iLn8w@mail.gmail.com>
X-Gm-Features: Ac12FXyz3WKCTj4mxXVo4xp6AMniUURUWjQ5DeVA017M_IaQp-7QOD-FOUdEOvk
Message-ID: <CAHk-=wjgXGuJVaOmftxnwrS6FafwrLL+yHrH6-sgbBRB-iLn8w@mail.gmail.com>
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

On Sat, 30 Aug 2025 at 11:31, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> If we are going to rely on mmap, then we might as well get rid of the
> vma_lookup() altogether. The mmap event will have the mapping of the
> file to the actual virtual address.

It actually won't - not unless you also track every mremap etc.

Which is certainly doable, but I'd argue that it's a lot of complexity.

All you really want is an ID for the file mapping, and yes, I agree
that it's very very annoying that we don't have anything that can then
be correlated to user space any other way than also having a stage
that tracks mmap.

I've slept on it and tried to come up with something, and I can't. As
mentioned, the inode->i_ino isn't actually exposed to user space as
such at all for some common filesystems, so while it's very
traditional, it really doesn't actually work. It's also almost
impossible to turn into a path, which is what you often would want for
many cases.

That said, having slept on it, I'm starting to come around to the
inode number model, not because I think it's a good model - it really
isn't - but because it's a very historical mistake.

And in particular, it's the same mistake we made in /proc/<xyz>/maps.

So I think it's very very wrong, but it does have the advantage that
it's a number that we already do export.

But the inode we expose that way isn't actually the
'vma->vm_file->f_inode' as you'd think, it's actually

        inode = file_user_inode(vma->vm_file);

which is subtly different for the backing inode case (ie overlayfs).

Oh, how I dislike that thing, but using the same thing as
/proc/<xyz>/maps does avoid some problems.

                Linus
