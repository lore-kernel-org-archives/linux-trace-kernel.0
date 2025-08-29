Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C782F9C3D
	for <linux-trace-kernel@vger.kernel.org>; Fri, 29 Aug 2025 16:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756484097; cv=none; b=AQSgEgJ7pBDj9I40WXBVVQpr6xNhJ55znx/Tn/9vF84eCwuSB22OBzLiH6HcuDVjw5QzIwpEBgXTh4Sngiyx82/fvr21C0PlMEhkueLrL+x+6Jc8Yfie91oAwDFL7JynJbliJ6gsTfQMlMhkHG/QouH8Lt1H4ECQM5PykIF9gE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756484097; c=relaxed/simple;
	bh=GGju3T7I+qI0JvmY68eODhYLvUvdUW9PaGUnZEXvJUE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TO/jjVdO05E23aHYgajobCuOY99wfZjPMhggVUrN+Huy1kKzpXYiv1n9+HCQ8T25cg36mUAjzTG3IM5wAyjoLptz3SFK7Mgayx3nkRnpRgUuJ/MWyUqw+KFMAyPnI2HkLl2qXnsi/I2hzLs/410mryzRXZYHBan3/Ark2rCdLTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=aqG1q7Su; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="aqG1q7Su"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-afeec747e60so279177866b.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 29 Aug 2025 09:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1756484093; x=1757088893; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TadHi9XEzabupVoGJRB+7wCRy98sUdfJOAZ174vFHr4=;
        b=aqG1q7SuAymKSij1ukQ5dYhB0ED03ARtUSriQClhCkbpAp7c9WAOv7Q1Q/+QRqBvUt
         SuzG8xw94aSHUeBejCvvBXen7W6nxHD5u/rlXJ7ydXvw7zOEpkVi+xBwFLxmW+09Ov1B
         SEgyCEAD0/10Wt/qYpRn/u9+Eyk4AD1pmlfuk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756484093; x=1757088893;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TadHi9XEzabupVoGJRB+7wCRy98sUdfJOAZ174vFHr4=;
        b=Rnxff7LsXqfVK5Kf3dMEYNCzsBoGrZO/UCngU1Bn2CeJBxoX2tLgSb8eUQH3UH6zTE
         UzPUHC6fOIBC3yn627mChBpkJVlFNvNPFJ7QqA2ixyqNjwPVDZF2WJAnQ3c1pgBu5Maa
         ItrZML3I2MojExhfkUUlzwE9bZvoxkY3+qNB5Hah3vPA9CTgqevVp7R6r0jryHm2Z164
         +g2OaQAzDkCdpU4gxg5+jJJix3pnbV8akkHg/O3KtoKUY8OtOwq7FQsjVeBBNg6p8Qn1
         zQfgp4+9qIZI+DfchQKoEok76O8B7gh/gxyg4WKslgqAf7FWjIXJ/ByOpHePXvgXkI3t
         k7hw==
X-Forwarded-Encrypted: i=1; AJvYcCWt0G11ZwO2YAZLO/YnSJEtRiuYR3ayIhgirH4jBuN27Djhq5k8nhrSOcxzIWQY8pp4XhhMXgrzkRU5/WNRYr5ixXk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyITpD4OAwfnwrCyNjBHVAqmpxyvMJdgKTpgLHiIrnK5QRzAUa1
	qHmRA9fe0K4x7bXm2eRHQNczV390RYsjGs70cWfkq88IWLQadR8A/ZiYl70zBJVnjI+skgFjxOR
	bc5X7+XHu2A==
X-Gm-Gg: ASbGncs42xfoz/7fLVmu9+OM08t9TOZZhWQp3onRPye2ix7Pc1D0kSs6r1j7qGdWTcX
	tObMJRwoCvfaPAikNuMJMIinQPZ4o1KPSC2B7XYAPGD2YAlGebEuPi+sVW9EC0xlC1MMxuOp2jL
	3ne1TOYa5mKWzB6KS9mNcSJ8fPGD9TGsKeCSPVIDQVMutfO4bV71558jQ10ys1PxXoKNHK4iVI9
	DsfYHzhAj7pF4dfUVvDutfD7zWRTrULsktv9uPECK0FPFQzm/SpqKfIIv7fj+0UcGcebK0dJoNh
	7Wyjs4qQSAbs/4dglosajiadB5ecUp1wDMdQq8Nvv6dL/9rzPwvqcx7fztz9dTBYneo8GkyFDrB
	iwAjsgqnDx9nF3ofE7L3w3FUr+MShc+1lXXRXeJm5jD/CJ2FmxFcMpbXQSeWq9CqPp6MJBMwW
X-Google-Smtp-Source: AGHT+IE6H22uWyvn8jSGor9g5O57TBK4LZ42mzPym5y5sDjn18YBZEvEtXhaLp9NWwjFW98EIjlC/g==
X-Received: by 2002:a17:906:4784:b0:af9:3f90:12a0 with SMTP id a640c23a62f3a-afe28fd3967mr2836475766b.16.1756484093302;
        Fri, 29 Aug 2025 09:14:53 -0700 (PDT)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afefca0a6c2sm228127766b.34.2025.08.29.09.14.52
        for <linux-trace-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Aug 2025 09:14:53 -0700 (PDT)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-61cb9e039d9so4329414a12.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 29 Aug 2025 09:14:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU3BOJ4BlU5h4UfknZGDZOHT3MUTZLLJJAIcXWJmE+pE63SKY71UfxM/G01PNXN9nyBDhXFffUAZDgYEyTVmbSwCwE=@vger.kernel.org
X-Received: by 2002:a17:907:dac:b0:af9:8064:21df with SMTP id
 a640c23a62f3a-afe29622961mr2710655466b.53.1756483694425; Fri, 29 Aug 2025
 09:08:14 -0700 (PDT)
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
In-Reply-To: <CAHk-=wjeT3RKCTMDCcZzXznuvG2qf0fpKbHKCZuoPzxFYxVcQw@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 29 Aug 2025 09:07:58 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjCOWCzXG7Z=wkbLYOOcqFbuZTXSdX2yqCCWWOvanugUg@mail.gmail.com>
X-Gm-Features: Ac12FXxmFqdib0IcSRzLnio3atIA7a6LSMhw2mK1t4gBHn8rvbJ5NNQPj8I4ad4
Message-ID: <CAHk-=wjCOWCzXG7Z=wkbLYOOcqFbuZTXSdX2yqCCWWOvanugUg@mail.gmail.com>
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

On Fri, 29 Aug 2025 at 08:47, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Anyway, the way to fix this is to not care about lifetimes at all:
> just treat the hash as the random number it is, and just accept the
> fact that the number gets actively reused and has no meaning.

Side note: the actual re-use of various pointers and/or inode numbers
is going to be very very random.

Classic old filesystems that live by inode numbers will use
'iget5_locked()' and will basically have the same 'struct inode *'
pointer too when they re-use an inode number.

And they likely also have a very simplistic inode allocation model and
a unlink followed by a file creation probably *will* re-use that same
inode number. So you can probably see 'struct inode *' get reused
quite quickly and reliably for entirely unrelated files just based on
file deletion/creation patterns.

The dentry pointer will typically stick around rather aggressively,
and will likely remain the same when you delete a file and create
another one with the same name, and the mnt pointer will stick around
too, so the contents of 'struct path' will be the exact same for two
completely different files across a delete/create event.

So hashing the path is very likely to stay the same as long as the
actual path stays the same, but would be fairly insensitive to the
underlying data changing. People might not care, particularly with
executables and libraries that simply don't get switched around much.

And, 'struct file *' will get reused randomly just based on memory
allocation issues, but I wouldn't be surprised if a close/open
sequence would get the same 'struct file *' pointer.

So these will all have various different 'value stays the same, but
the underlying data changed' patterns. I really think that you should
just treat the hash as a very random number, not assign it *any*
meaning at trace collection time, and the more random the better.

And then do all the "figure it out" work in user space when *looking*
at the traces. It might be a bit more work, and involve a bit more
data, but I _think_ it should be very straightforward to just do a
"what was the last mmap that had this hash"

               Linus
