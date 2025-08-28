Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E10B285042
	for <linux-trace-kernel@vger.kernel.org>; Thu, 28 Aug 2025 21:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756415689; cv=none; b=eJoK2XYNT7ldTn7CXHn9PqlH/X/3jlcdqmqJqABG1hBUoUIm9FdNC7hIRoBR6r8b1qb5j/tO9795arPZEeih6pL1+5dPEhIPAY+FMON3dQMLHh8PaLT0pKy220UWfVh8dSooYOB88rN7mmJlNM2JF2CON5AjPmgLJEwl1DlZ/O0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756415689; c=relaxed/simple;
	bh=cWHgJuZ/T8lTpVPF9prtZYdk90QnV1fPX724zcPnR98=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R2fEmETHQpkrFn2Z/XSwkcGxow3sO2dF3DkWMToCwmAZ+AqMMEgcWQEBjQEuQi/kzQuzZQrplhNe1m/HtHgjDlZV8G1e1zHGgIcuLgJpc8PBJnjx8MJ2szoyfdKWevxcuSQUQTCn9UUg8kTgO8RNVdiWQmO+0KagruLq/gCMwrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Ux06G9sQ; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Ux06G9sQ"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-61cd1046d42so1855290a12.3
        for <linux-trace-kernel@vger.kernel.org>; Thu, 28 Aug 2025 14:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1756415685; x=1757020485; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5t8lKSzWiJZ7o8aEHR2Vpuj8q+DwYY+2z0chiLgF/uA=;
        b=Ux06G9sQm4agK8vaGZjQqe6iXpUfGj8PvnUG4iY2lEgtKte8PRntHtSj4YhkJQjPt2
         xOF+6mKeD6bysvrX4PnrjXQwAvAwc5YKgwb/LPdW6PDv86t88qOBw0QA37k0TpC27Mrw
         MnQIhY0X82C78IpY8KyOxsQIAK6/96rhdQzZE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756415685; x=1757020485;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5t8lKSzWiJZ7o8aEHR2Vpuj8q+DwYY+2z0chiLgF/uA=;
        b=icZhly42kiDViqmMXS9NtyM5dXDS/d8hLpntjMUDgl6AGiUU/hUzv9j4i0bsQMb+ur
         XHawlOQ8oDncZhOvypRpq1o12cFauTL8O5e3gRV62MModHikDvnRJ5QsEHuLwWAWOzPc
         e3eKUFFBd2mTp967M5c8e/DDz5SshC/3t95PJXcwA3FcAYWBpbypnz+V/K6QZncBA9Mb
         a0BMz7mLP196IMiWRzZL/yf9O6oaRcdFSk9YlwJT3FYE7hzI7dMvuCjiIoshcFMPjrFm
         NvhaC1E1Xh+533Z3FsrMqk+AzZkqrWzo2EUidRrM0a8oe4gINZbQLLp6ensott4c72Io
         zkLg==
X-Forwarded-Encrypted: i=1; AJvYcCVVMIPRcjqfchuLUfpJxLNG0J3Ixg0UdPv91UndldFl+r3lUGHpiEmWha/ZsvNy8mlLenmoCie171R7F1Jg2b4r87Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXHm2r6dWy8is4VJ8AHOdbhzvkKheAXfYdJ2qnyoNkSDKsgkcd
	Wm5D96DmnZ01Px6sC+Fi5ExB7r4KNJHYByEMZegsyZy8QBG84hy9UnZmorX2q5FWrjxA2u7UMFO
	F8TRmC+9QFg==
X-Gm-Gg: ASbGnct4EpfUfO7bjosiPFMzNi7E6iv+urxI7xtI3CIFVvC6QyfdwqRyOWDzdPlmwEf
	d8ECMU+uUt3JU4D/lG+fa1wn99Be4o6tg+/55PdhRzN9Oau5FwcMxqyy44UrFPZwM7Yjh+7VrxZ
	7W1NrmPE36J+uMfQDCWCjnlhoqK8vHhEEjx1oxIfa3+BWFiGqNIM/7mEkFjn1Z0T0UI4VGXGMfu
	1OzPfZI8WJ0iuYpkC1EflKImolhfuPLmbljcIxUgM/D40bdwz1ivNR59FJ/N8oPxDsW6Et6yii1
	SW4CaELa226kXm3nSowsCGfju06K8i2WFg0EQmF+KK3Xe9+7NT+9WSS3xGk8v/JY/qi2AfK7FfC
	nltvidpunicFhaS6UbF6wLH4d08R8ZWY6hmQAOcnvMLHU2gZBXIbgIAi64IpO0MdRAeQTJuT9sf
	YA7EPLAaA=
X-Google-Smtp-Source: AGHT+IFQXhuJCcUXVviE3sYcrScL5SAG5+CNtC9NAHy8PFzTAQaBl1VbtgPXAjXy3iGfF2WjCjmM9g==
X-Received: by 2002:a05:6402:26d0:b0:61c:5474:ffbf with SMTP id 4fb4d7f45d1cf-61c5474ffdamr14231722a12.33.1756415685558;
        Thu, 28 Aug 2025 14:14:45 -0700 (PDT)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com. [209.85.128.44])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61cfc214ec8sm380370a12.17.2025.08.28.14.14.45
        for <linux-trace-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Aug 2025 14:14:45 -0700 (PDT)
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-45b7d497abaso5699295e9.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 28 Aug 2025 14:14:45 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWWkTSFo//YR9tUhNqoy+MGROUdLrPBmpZHqZF9ITc9kfsvwyjPhQifRwlxS9aEWXYbgfdH836vaDoyE6Sh/mo1jHc=@vger.kernel.org
X-Received: by 2002:a17:907:9813:b0:af9:6bfb:58b7 with SMTP id
 a640c23a62f3a-afe28fd4320mr2202132466b.5.1756415216712; Thu, 28 Aug 2025
 14:06:56 -0700 (PDT)
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
 <20250828164819.51e300ec@batman.local.home>
In-Reply-To: <20250828164819.51e300ec@batman.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 28 Aug 2025 14:06:39 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjRC0sRZio4TkqP8_S+Fr8LUypVucPDnmERrHVjWOABXw@mail.gmail.com>
X-Gm-Features: Ac12FXyJjA2H7p5DkIaJHtdRMPBRP_-Unlm26ZIlq61PFiwHqxH_2EVP3LfoiLk
Message-ID: <CAHk-=wjRC0sRZio4TkqP8_S+Fr8LUypVucPDnmERrHVjWOABXw@mail.gmail.com>
Subject: Re: [PATCH v6 5/6] tracing: Show inode and device major:minor in
 deferred user space stacktrace
To: Steven Rostedt <rostedt@kernel.org>
Cc: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>, linux-kernel@vger.kernel.org, 
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

On Thu, 28 Aug 2025 at 13:48, Steven Rostedt <rostedt@kernel.org> wrote:
>
> I could run it through the same hash algorithm that "%p" goes through so
> that it's not a real memory address.

For '%p', people can't easily trigger lots of different cases, and you
can't force kernel printouts from user space.

For something like tracing, user space *does* control the output, and
you shouldn't give people visibility into the hashing that '%p' does.

So you can certainly use siphash for hashing, but make sure to not use
the same secret key that the printing does.

As to the ID to hash, I actually think a 'struct file *' might be the
best thing to use - that's directly in the vma, no need to follow any
other pointers for it.

               Linus
