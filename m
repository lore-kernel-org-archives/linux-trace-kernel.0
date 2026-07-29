Received: from mail-ej2-f3.google.com (mail-ej2-f3.google.com [74.125.228.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B31363AAF7F
	for <linux-trace-kernel@vger.kernel.org>; Wed, 29 Jul 2026 15:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785340075; cv=none; b=i8hRaTRZDvJs3BqIbyFEEVobr8FPMDDnrqPTK0uWO6VbZ9vIWVRbNQ1sZhf0Fl0DyW5EFFTcnS9aPqUb4dHkTk7OyncwVrQRHJ7c1Szgq+Ab43dVdBiNHM64ylgmTSUTcR7z/nlNehYyr1MnHZYIfw9YyTfvEID5VhZHQZxIDUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785340075; c=relaxed/simple;
	bh=EXhgVMS0NxlxE5f0pFtmC2iT2ieedzhRX+u7Ni9PIk8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dZ3tfrPuoihESsdzG17nmSg5soLi9Uc42nNwMwxMnjcxuzJpm8PTfLlC55P1pmIMuD7xAsgktwwTPU2G6fDIJYHs+HJ2zXF6J4ZcLd7Z7n4hxG55Nl2+5YUxwGllcV6Pg23KO+i8SBKWTvbYDMhZJdBAAf+o09fWrWY6/VZ4L1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=F2XQ1UHL; arc=none smtp.client-ip=74.125.228.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="F2XQ1UHL"
Received: by mail-ej2-f3.google.com with SMTP id a640c23a62f3a-c160e831693so43773566b.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 29 Jul 2026 08:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1785340072; x=1785944872; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8fldeuHlUZsSgbof6A4RukHGxb8EkbZ80+aaj64d3jk=;
        b=F2XQ1UHLgEDa/cL4YxnQlkbJaaz2I3QYZQnNdUzegHvjYgMJP5HQfmByr68wGfmXpX
         3IR4Lsuk+MBQt9ox4IIVyBYJZodAaXZBknBTHglm8ufGpvpce+WSFptknU7TueIasRMe
         axv5j58WYmzzQbGmy/j1//GEz/0/52fyb4VTI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785340072; x=1785944872;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=8fldeuHlUZsSgbof6A4RukHGxb8EkbZ80+aaj64d3jk=;
        b=PqeTvMiY0WfEOdbXSTbnzcMYLvi5huPEnp/qd27RTLVQW2sHSC9RFfmGDAksSLjgOg
         u0MZ8Aw4OSt26kfbLAq8KtI2MZswEboFuz4zRLZqyhuyNJZKMsbLbwLe0JcNhjoLjaSt
         duWb/2a+F1boFStbBydHiFaBPT9CvkRUL13jziTucb9XGq+2m16KSDYXf5w998jUorkA
         abyn07SP2/F8Hmr24pGzvEz7Ao+n1BT7RDQEdZZOAnCQwxR3dqXamlY7OvM20NQdwAxB
         /47H6ZhDzyF+K+fM1KKxGolFAycHNbzVZILjcCtC2UNFOqKxCD/z+5KkqqaDgPkJF+OI
         7i0A==
X-Forwarded-Encrypted: i=1; AHgh+Rr2R8Gja4+7wEIYKO2ki2BdlSNB0H6/5fiyVQRbvJN0qgBxVHD32onEVQYXha/KUkm68vi/XdxEgIMpq8clE4kHZHw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmrKs3oaQME9NF/oWfnFATb2zYJPk2bpvqNeM0JO53bPhe+/Aa
	ubpJyYH8Fj4epiHCHnMGt0jXseE+8ULbwjXyWTgEXx2+FGsLoZudtNo6nu0AW0a25t5BGFiD7Mj
	0qxqTqwTFnw==
X-Gm-Gg: AR+sD10VEjZGSuk+B+y1FQFTK3bGBg2jhWkB1BQgyhQDL8enby6GijMnmlvpSFAm5nK
	P8krY20bfwnOpngl4RmzClCEvq1wjHOiDA1n5zvbJTYYyP3339gromQbHczjUgMiKfXcILvtk+3
	cIVDaQxwxBLAKcKyWILcR0WtZtK2Tf6L1pEE1zLRr4Es8VYCMxYnkCHXEZTlnZI8xakfw5sos5e
	98vq6EuVqP2+eS6adIpb7PqCgB2G7hyd53+mhRL4Lv+y3hWROe9tjqsodjMW16oiwvVdvlxhwnw
	2mvcbYC9tSMjh+dOepwTF3lVqHHAE0AQnb9xSXJIe3fIvfVrBLpBqhfzPMyRNeVl/o7KAIVczfd
	mApeivFI0jojavuu8pABgb6HgIyjcqDqyKnlwxZzX+FjEKPE17sIk+2xNsvc5NqhhgINXiUhgGg
	jeyy/aoLkdvM/aEF462vOb+CF9sCbRF/9cAvhukd4sOmOQE4faRElKQ3bciZk9T/W9sN4FKFHgf
	VY8YPjxvXCW61SYsd0EMWOjgxXJaBqWARXzdw==
X-Received: by 2002:a17:907:180a:b0:bed:6e53:bb1a with SMTP id a640c23a62f3a-c1f7276621amr419568966b.48.1785340071916;
        Wed, 29 Jul 2026 08:47:51 -0700 (PDT)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com. [209.85.218.45])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1f83fab5ebsm129748966b.51.2026.07.29.08.47.51
        for <linux-trace-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jul 2026 08:47:51 -0700 (PDT)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c1c52d920b8so160247866b.2
        for <linux-trace-kernel@vger.kernel.org>; Wed, 29 Jul 2026 08:47:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RpF8xmMSLfey7yLp5TJomDIXN1qQbkJ1BEmGav5LGyc97ROhE/US/7YWJF8L4KLzrziavbY2TrrTuEsqi+YTrgxfCk=@vger.kernel.org
X-Received: by 2002:a17:906:fe47:b0:c15:bea2:d209 with SMTP id
 a640c23a62f3a-c1f7215dee1mr360497966b.4.1785340071289; Wed, 29 Jul 2026
 08:47:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260729005959.3853865-1-andrey.grodzovsky@crowdstrike.com>
 <20260729104114.04298a48@gandalf.local.home> <CAOu3gNgc0XHScgEf+yWF5Kr8sAm8Fsa4RBuwL0YE2EscSiBPrA@mail.gmail.com>
 <20260729113136.32af2a4d@gandalf.local.home>
In-Reply-To: <20260729113136.32af2a4d@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 29 Jul 2026 08:47:33 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjzHTuomhTegkD69veDVRxprX8NB=i7A+BEB2-v6v5n+g@mail.gmail.com>
X-Gm-Features: AUfX_mzh3d70XkZOQ8mPTBmYgVx50lGXSyciETgOqHmLrGk5Ua4q2GHqtff665s
Message-ID: <CAHk-=wjzHTuomhTegkD69veDVRxprX8NB=i7A+BEB2-v6v5n+g@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 0/3] ftrace, kprobes, bpf: mark
 trampoline/kprobe ftrace_ops permanent
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>, bpf@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, song@kernel.org, 
	jolsa@kernel.org, naveen@kernel.org, davem@davemloft.net, mhiramat@kernel.org, 
	stable@vger.kernel.org, linux-open-source@crowdstrike.com, mbenes@suse.cz
Content-Type: text/plain; charset="UTF-8"

On Wed, 29 Jul 2026 at 08:31, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> > > Honestly, I would love to get rid of it as today ftrace has proven to be
> > > rather stable. But as it is a user space ABI, I'm not sure what will break
> > > if we do. I wonder if we just make it a nop, and print a message to dmesg
> > > saying:
> > >
> > >   "ftrace_enabled no longer does anything. Please report if you need it to."
> > >
> > > ?
> >
> > Thanks Steven, if you and/or other community members would approve such
> > approach I would happily do this instead for a few reasons -
>
> It's actually if Linus is OK with this approach.

The rule is always the same, and I don't understand why there's any
discussion about it because it's been stated a million times: we can
try to make any ABI changes at all, and what matters is whether it
breaks somebodys setup.

If people rely on old behavior, it can't change. And if people don't,
nobody cares. It really is that simple. That is literally the
DEFINITION of "don't break user space".

Whether something is user-*VISIBLE* in theory is entirely immaterial
except in the sense of "be careful, this needs testing and may have to
be reverted". So user-visibility isn't a "don't do it", it's a "do it
carefully, and knowing that you may have to revert immediately if
somebody complains".

So changing user-visible things is potentially a lot of wasted effort,
and needs loving care and follow-up.

So everybody should typically avoid changing user-visible things
because it's potentially painful and developer-intensive, but not
because it can't be done.

All that matters is whether real user workloads regress.

And please make sure that any changed behaviour is really obvious, so
that people don't spend lots of time chasing down *why* something
broke. A kernel printk is generally way too subtle - and no, the
tracing "make the printk extra ugly with crazy ASCII barfics" model is
not an improvement.

It might be better to actually return an error to user space so that
users can see that setting ftrace_enabled to zero failed and it would
show up in user logs. kernel developers may think that kernel logs are
important, but users seldom even think about them. Of course, that can
then cause even worse regressions, so there's a balance here.

End result: don't do user visible changes unless you really really
care. And then you spend the extra effort.

               Linus
