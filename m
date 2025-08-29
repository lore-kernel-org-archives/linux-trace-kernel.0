Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03824346A10
	for <linux-trace-kernel@vger.kernel.org>; Fri, 29 Aug 2025 20:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756500875; cv=none; b=PcP4USGCKrZ/HKxIWcU+MCsUCJT3bVwkcyDVUlCAAoq/APzUHj5B+UMvSfSWRg1901AwQAg0EHu0vr4j5vtTuKAvHhVUeBZNXCiivDVy3o9y2e6TUAAhDr0s5rxk2UtTThLZYtP86Es8q88JVpCignQYqYhB/I7bayf4hBXcpIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756500875; c=relaxed/simple;
	bh=lm0u26OhekurXvbZmRAMXY3a04c03Jb12UfPOAKe1Ds=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FAzvqiJbC5RCbuHy8t5ujM3QDLd4/5+QmDT90FQ9O9o60DsWZTeysp3TcUvwHoU7Q6IXHO2FX0oQX7gCnEohFvdRh88s7PmgNwvjY/3mnJPxKBPrC5M8H+HxziN7aOhfmwDldQnm52qrokoNSOvWnE35ppAJCTfhTWvW4iSFXDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=KDUIYahu; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="KDUIYahu"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-afcb78fb04cso433033666b.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 29 Aug 2025 13:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1756500872; x=1757105672; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gtxiUTojkJryuwfS4utzOx7v5IFRnxmAU2q8IplphGo=;
        b=KDUIYahuS7FQ4LZHBi/IKtk3E6E8bl13+5SYpb1K4A1qy/ooPFWFcZ4S2Ov2kI320j
         24TiXxB6YeAZOmvyimMLcdHA8FS29+VQ0l09jSlic5kl168ssnjWUJCQHp8ech2fXip+
         BLwI/4qpHEOVqhyYkrZbgfY3GplIdlxUsy64M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756500872; x=1757105672;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gtxiUTojkJryuwfS4utzOx7v5IFRnxmAU2q8IplphGo=;
        b=THjgBJFGWFbzxMoHOLwAo3yatY5H0uO7R3h21iuAHo6exAR2w64h2tld0N/xU/QSYV
         3f71Jbajj/6QKZdaNyc/xJ60kBKMmYdbEIN8Oso+JR/kiG0Xhzwu89ZM/dZDK0uVspzQ
         YH3y04JQ7cYiVk/jnC/gckzH//I0jGLgwwJ/n3IMdROxp5OU2YdRiw+Bx/cZxIcOijJ/
         dvxTGwSmpOB/mtADjUnfaBblwY1OswUXOOyKh4gcWuVQ3gbx13Cj2iF8gbc30tj9xwNF
         IKD0O9Ju5msd9HWaL5UEF1ahoV9p98Pz96QUeQG5PBan0rfsPLkEmEBVODthnMGKhh6b
         YEMw==
X-Forwarded-Encrypted: i=1; AJvYcCUae9Xy9xVS5GQXthCXdH2cdgEoUhVmzxijqp0lGnJSEo82wWO0yz7yDPBu5vmOpsJRWBNQJTbouds9yBpkDsJe/iM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWR0r/+fyNSlWmROfAjzutCcvpp9vQaA5LMG/FySnXGNFlhgZS
	LUUGKYIwb/pz57xM46FJCkh5coCqDon87XoKJC0Pc9/wASwmjaVVgMXfcJdTe0zj5s3oNehr1TJ
	l8xpOKgBnpg==
X-Gm-Gg: ASbGncteNF1ncEPTj8+jgqtniZbmpQkUDOqWOAkOBv1AavZdTTTEUToplOJobkJbsHK
	BsFjCMux10cvfdYsutHWQAA4GMyBEdAitbSfYDRoAbzTGnlY3gvmOx8NBolWnH2GqgxdNfIIvN6
	p0vqZa7eOlCw1LzUe5WSojzVc5jslcZuOSgagKKF86cCx4fGTKBi6W3Md7bChF6+gUxY4a1Ba5h
	fRNSTLSHFJIh1KUTVJqGF4gSfKuOnwKACPTy51YCT6XqHPv5u1a9WWXabVnawPQL7U+iPWoQAHC
	PUhE6Xl2yh26dh0fsHJieYRik1UQ5YS3hLTcHyJj72EIYIpnUPFmVvSlTd9T+vLpGLg4m1CEqOM
	ZzXAL2K3m7FFW70L0nPnl9jQ95LARl4KDL75Oeulu5c7lfxCuqcSCMfxJ0zE5PnRM9y85bAZ+6y
	Z6Qyfcymx51ZX6FZg+QA==
X-Google-Smtp-Source: AGHT+IHnfNF4h2FCATGppcJiSXCxQtDOUqHHmIAfxwMdv/Lg/tZ1nrYcJppmo/ikYkydgUxwKlN8Ag==
X-Received: by 2002:a17:907:743:b0:afe:a2c7:78c with SMTP id a640c23a62f3a-b01d8a2f5bamr271666b.6.1756500872029;
        Fri, 29 Aug 2025 13:54:32 -0700 (PDT)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com. [209.85.218.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afefd072c58sm271150066b.87.2025.08.29.13.54.25
        for <linux-trace-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Aug 2025 13:54:26 -0700 (PDT)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-afeee20b7c0so315763666b.3
        for <linux-trace-kernel@vger.kernel.org>; Fri, 29 Aug 2025 13:54:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXZoaPitwdjpL7qFD7TZ54MjMkRY0msP7B6fOsq8XskLJjauQ8cp96TnqbLFj4z9J8B0MAoKp18wW1ysD//XpdOyZs=@vger.kernel.org
X-Received: by 2002:a17:907:804:b0:afe:ed3c:1f9a with SMTP id
 a640c23a62f3a-afeed3c33a9mr669079266b.38.1756500864690; Fri, 29 Aug 2025
 13:54:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250828180300.591225320@kernel.org> <D7C36F69-23D6-4AD5-AED1-028119EAEE3F@gmail.com>
 <CAHk-=wiBUdyV9UdNYEeEP-1Nx3VUHxUb0FQUYSfxN1LZTuGVyg@mail.gmail.com>
 <20250828161718.77cb6e61@batman.local.home> <CAHk-=wiujYBqcZGyBgLOT+OWdY3cz7EhbZE0GidhJmLNd9VPOQ@mail.gmail.com>
 <20250828164819.51e300ec@batman.local.home> <CAHk-=wjRC0sRZio4TkqP8_S+Fr8LUypVucPDnmERrHVjWOABXw@mail.gmail.com>
 <20250828171748.07681a63@batman.local.home> <CAHk-=wh0LjoJmRPHF41eQ1ZRf085urz+rvQQ-rwp8dLQCdqohw@mail.gmail.com>
 <20250829110639.1cfc5dcc@gandalf.local.home> <CAHk-=wjeT3RKCTMDCcZzXznuvG2qf0fpKbHKCZuoPzxFYxVcQw@mail.gmail.com>
 <20250829121900.0e79673c@gandalf.local.home> <CAHk-=wj6+8vXfBQKoU4=8CSvgSEe1A++1KuQhXRZBHVvgFzzJg@mail.gmail.com>
 <20250829124922.6826cfe6@gandalf.local.home> <CAHk-=wid_71e2FQ-kZ-=aGTkBxDjLwtWqcsuNSxrarnU4ewFCg@mail.gmail.com>
 <6B146FF6-B84E-40A2-A4FA-ABD5576BF463@gmail.com> <CAHk-=wjgdKtBAAu10W04VTktRcgEMZu+92sf1PW-TV-cfZO3OQ@mail.gmail.com>
 <20250829141142.3ffc8111@gandalf.local.home>
In-Reply-To: <20250829141142.3ffc8111@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 29 Aug 2025 13:54:08 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh8QVL4rb_17+6NfxW=AF-HS0WarMmq-nYm42akG0-Gbg@mail.gmail.com>
X-Gm-Features: Ac12FXxq3CT2Pra5MUu2kfheMZZZIqxJ8O9KYQ-_o6FJemvdl2_01eUe7c4e2AQ
Message-ID: <CAHk-=wh8QVL4rb_17+6NfxW=AF-HS0WarMmq-nYm42akG0-Gbg@mail.gmail.com>
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

On Fri, 29 Aug 2025 at 11:11, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> The idea is this (pseudo code):
>
>  user_stack_trace() {
>    foreach vma in each stack frame:
>        key = hash(vma->vm_file);
>        if (!lookup(key)) {
>            trace_file_map(key, generate_path(vma), generate_buildid(vma));
>            add_into_hash(key);
>        }
>    }

I see *zero* advantage to this. It's only doing stupid things that
cost extra, and only because you don't want to do the smart thing that
I've explained extensively that has *NONE* of these overheads.

Just do the parsing at parse time. End of story.

Or don't do this at all. Justy forget the whole thing entirely. Throw
the patch that started this all away, and just DON'T DO THIS.

              Linus
