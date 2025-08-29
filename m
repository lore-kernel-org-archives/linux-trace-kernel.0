Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0161A72626
	for <linux-trace-kernel@vger.kernel.org>; Fri, 29 Aug 2025 16:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756485745; cv=none; b=oPVd3AQG+rPZ7x1C7kkQRzTiFVcL1jAP20ioVL/MSd8uAhQh0fDmAjcUv0URcDlnkPEemvgHHq0MegCwB6m7kskMV6bz7J4X+IhR5TOM3Yb9ZaGTQgQFN36VrU/3z9sKe8dDVohCa6mRtVDqxAW08xCib9uti7RxVn1qOfIBFEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756485745; c=relaxed/simple;
	bh=upVsUuMpOdHRiGkETwVJlsIxvbf0n85rijqW3icJrTY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fzGbz1bJGxRMD0iIq48QboiKr3E0dmhaI4yTIf8UucOZJ6DPyFBJ2r6MiEkbMWS2zwOAGBaD7G4Xnu3YoQpmQHhu42P8HZOgFfGvZDUhXhiqibzffF52oLVRmrg0hJLgB8T7PdmnZr3lugYk2DNWIdODadbJ03x8wppiKBMOxT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=IzyDEmsP; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="IzyDEmsP"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-afcb7ae6ed0so325980666b.3
        for <linux-trace-kernel@vger.kernel.org>; Fri, 29 Aug 2025 09:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1756485741; x=1757090541; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pcseL9VLwiGrQMBX6gFapN6MvL8wsPhkJRSj/QHz9Rs=;
        b=IzyDEmsP8Wx0GgMVAkDSgVNa0wYZy1DI68rU/jpXhwCcnxGTNJ8kecW8VZ2aBFpoRr
         IM/eD7xkBHO7laL2HMa5JQAB5GbHW3cPMc5tIZlow5/EPLD71aq5CNyNwexu5cTysjyB
         JrUq3ioLNTO+RFHsp5AgRtFmOTJX+ipMGAR8o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756485741; x=1757090541;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pcseL9VLwiGrQMBX6gFapN6MvL8wsPhkJRSj/QHz9Rs=;
        b=bFB8mpUGotGrF4JKARV+TbtzbDs8pXJKgAFiroI4KsFQZ8HyOyjoUNdHzFgC8T9xvD
         85efpEE7jL1g1reacUpR6W/55RQng3Pt2tUqmZiLHGwEAE+BiRt80btyYIEF9Cy44qfb
         QKKYqb3UIq7s1WDoGZi4fY7nGeiN60uacWzeO6X6Dztr2qAlsXaw02mzC374npOZCEJ0
         +pXwQRsV/Yzd4wFhCIVE8+1FgyIIpre/m5bCxSTcstx8vlWtQFRBs0ban1L9Ir4zmO5/
         M2UWhrp/dcCxG4mY+CcqQ/bUbLZtaGAXyFqCkX9LGhpw5upb4hKvh/0KxeH+Np3CWQ60
         LDmg==
X-Forwarded-Encrypted: i=1; AJvYcCV6Ny4dKx2l73n5e0Dqx/GkK5XQ0SVnWRB9tYHq/TnvG3vi9ZxsHNGn8z2M057bNlsCt2CSrjJyCyxk2uC0P2BCXAU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwF/GTYaMIvRtnoprBHf0mdAw3rmKwg1f3ct2HAGz9JjObCRP68
	r7wKmtbNjt6OhueiRu5V+obCojMcPuY3WcEVNVsNGQgVtvhyvGQWUbG3JA6Vu0ovlb4Le6eS4vz
	mt+T53hParA==
X-Gm-Gg: ASbGncsOGpCTycLKnFqzYad7MI0SOhxZ10VUq89mIn52UJK5zhPkFC7EsILyu3S7N60
	yEvrm96V9gHfHkQK1H2/qIzhkb4aUufTnUvvOSJsHua8zY8aRJW8f4OLxt/Rqe0QmkIQArqBe4G
	DCPtz3CZZ52+4k/reSCkwV3En5eDbH8jXa2exbQ+BJKXhep2kQKMbMSEWjhMV9N0uudVEHprm0x
	MzqOA6EnFSAR8XfVX9dlepB+ZA+PmkCNv4liSnCo1IfMUtZEWE5KlBOoqGpQKQ2GzTT1vxKMz8q
	pK1McN4V+njH2OWT3xdMzXV6a1b3f2iXkB93lakrRHUcj8i8K90STGquMJvJLmF5Q+rqoookNQD
	8dHzDkJ5H9TprOt+cLsmCD/9OZT4EzRZl1dmetE8I1aPN1O5SjUg5BSDRgeI6HADeHK5A+LeK
X-Google-Smtp-Source: AGHT+IE6bpMWA4f55ObfWV/S/vBojxhaB+OlkkYIOTIsygGW4T1VikueAj5cXMmHdu7j8v2At2vI/Q==
X-Received: by 2002:a17:907:3ea7:b0:afe:bb6d:1caf with SMTP id a640c23a62f3a-afebb6d3f4dmr978760966b.62.1756485741242;
        Fri, 29 Aug 2025 09:42:21 -0700 (PDT)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com. [209.85.218.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b009ae4f2ddsm1357466b.82.2025.08.29.09.42.20
        for <linux-trace-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Aug 2025 09:42:21 -0700 (PDT)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-afcb78ead12so376612166b.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 29 Aug 2025 09:42:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUyAduPqAplMEowA/j1/XzCKqJqZF+SeRNCpSEDV4GDxEAm9D/AP/JVFVB+HLUEZX5SqIZFUudYCYhUi8wkd2ap7kc=@vger.kernel.org
X-Received: by 2002:a17:907:9405:b0:ad8:9c97:c2e5 with SMTP id
 a640c23a62f3a-afe2875bfdcmr2604625966b.0.1756485740538; Fri, 29 Aug 2025
 09:42:20 -0700 (PDT)
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
 <CAHk-=wjCOWCzXG7Z=wkbLYOOcqFbuZTXSdX2yqCCWWOvanugUg@mail.gmail.com> <20250829123321.63c9f525@gandalf.local.home>
In-Reply-To: <20250829123321.63c9f525@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 29 Aug 2025 09:42:03 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgv11k-3e8Ee-Vk_KHJMB0S9J1PwHqFUv2X-Z8eFWq8mg@mail.gmail.com>
X-Gm-Features: Ac12FXyxaMJRB_uNJ16NrW9PwMVmli5CdBpfhgymWkTxGXIEdjwFXvJ_jKjFZ2M
Message-ID: <CAHk-=wgv11k-3e8Ee-Vk_KHJMB0S9J1PwHqFUv2X-Z8eFWq8mg@mail.gmail.com>
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

On Fri, 29 Aug 2025 at 09:33, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> I just realized that I'm using the rhashtable as an "does this hash exist".

The question is still *why*?

Just use the hash. Don't do anything to it. Don't mess with it.

> I could get the content of the item that matches the hash and compare it to
> what was used to create the hash in the first place. If there's a reference
> counter or some other identifier I could use to know that the passed in vma
> is the same as what is in the hash table, I can use this to know if the
> hash needs to be updated with the new information or not.

No such information exists.

Sure, we have reference counts for everything: to a very close
approximation, any memory allocation with external visibility has to
be reference counted for correctness.

But those reference counts are never going to tell you whether they
are the *same* object that they were last time you looked at it, or
just a new allocation that happens to have the same pointer.

Don't even *TRY*.

You still haven't explained why you would care. Your patch that used
inode numbers didn't care. It just used the numbers.

SO JUST USE THE NUMBERS, for chissake! Don't make them mean anything.
Don't try to think they mean something.

The *reason* I htink hashing 'struct file *' is better than the
alternative is exactly that it *cannot* mean anything. It will get
re-used quite actively, even when nobody actually changes any of the
files. So you are forced to deal with this correctly, even though you
seem to be fighting dealing with it correctly tooth and nail.

And at no point have you explained why you can't just treat it as
meaningless numbers. The patch that started this all did exactly that.
It just used the *wrong* numbers, and I pointed out why they were
wrong, and why you shouldn't use those numbers.

          Linus
