Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8279622B5AC
	for <linux-trace-kernel@vger.kernel.org>; Sat, 26 Jul 2025 23:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753573074; cv=none; b=E8mO+EK36gdE7C5LwUs4yTEG2qMMjoHEDKkKuJKrcK997TjnwJE6E3lxobcSW5vaypv3zo9xPeBEGPD4gi7qQPfx5arI3C996MHwr4RqIvQrXOJT0us1o57NFUdhpPV/Kl6MYVxLkF0WFRBSxutWf5lsXor96lhiIt417GYyNYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753573074; c=relaxed/simple;
	bh=7B24QJDsbG9O9xyrIOj7H/k5Wjt7NkdzQ2ZYcADPiko=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KQbknXTmRx1uIsMnN9F2yOMbFt/xCfVDPe/f7IFhSehY470K1nXPAqoA2PCHZU8TxjCjB+LtI2L5GkVFN3SLJ+hZJM8yxNDv1J6Lhq5CE+VoAjvUx+acpGwwMmW2noyytiHIfBJR2q7UqWTfcy5ab3pNgSUcSeYgArWbX3I0O8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=eTLtIXgT; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="eTLtIXgT"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ae0de0c03e9so486980666b.2
        for <linux-trace-kernel@vger.kernel.org>; Sat, 26 Jul 2025 16:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1753573071; x=1754177871; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1tHg+Y1g27jBmEKsSCwCSS49UstWUnsuEvPhc+oks0Q=;
        b=eTLtIXgT0zbAfXDRgiRTBv4ioN1hvrP4L3ImXMowXnQYMmK1QSZmAjXbhCEFTdXOl/
         /GJmCRliQD056zT9kndf+Rp2cdmHgFIk32h6uXtxTqC/K9PediVqd7r8GY/V6vitgVWM
         7Vin2WRj12D5Zz7ws8u9Cb9vHk6ehzko0+1HI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753573071; x=1754177871;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1tHg+Y1g27jBmEKsSCwCSS49UstWUnsuEvPhc+oks0Q=;
        b=qeT3+Jrzm4I+NOtXtSlVPv1uu85Zmmevy306PEYPxneDU8f0gkXJzjEfk++rzXVLN9
         YJ8o06lrk9k3AODQfCFCgh6A7LI0qx1r3ucwmpMiXm+y4CwWv9NPJCMLc4w56LdzLkZp
         +Xt3C2ZR2KjZCoBTk66EzO+IWgYoZrQVimTQIdw7p4n98QZCATPqTV+/UG56YR/Z4HL9
         H9dgaT+aAdkoZghoOGQ1dqe+GTQhtxox2jyK7IO4JY+2p7VMnnV224k0uvUbgNptfWKD
         2lYuDL4J/4Qg7+DJePBVqOAzVdwy4AMxKe/pDOB/MwXf8tPqGh1mWEXrCJ22sthNt+5x
         17Ww==
X-Forwarded-Encrypted: i=1; AJvYcCV9hADFY+5YSA3tb4M19fQ9gyH6zW7VQQgUxsBWOjdrH5xs1rAs3iOGTLyK3maUgTF9wZMIv6WCb3/Or6Fzi25rgko=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgjNR5OXrDVzakUJiT5mO2+UWetjxrnUfYYsAIdB+4/Ovn9zyG
	y6Ou8szlGnC2PlXOHtKsdm1J7G18mD9JUSPTY993dPYVMwDB/mKne1jBPBQOwjdN5Cen9ke+nDZ
	ZY7jYUc2k0w==
X-Gm-Gg: ASbGncsCrj2bATGEjNNm/AhobXOl5oPHJsvtD0/ioF5M0MOlG4SqzvYTZ5fH+Jn6CfO
	F5LVJgY/Z6BF2zfqq+7x1XIMQ0BCu6DWvXT+JP41DUzGk++VxRuFNvv9cGIzLeA3+NLJFgiAQ0E
	E1EgDybrys6TzUTQNOGD+J4aF6skHOcMxBg0chOyzTzpzXJFk9Nlc4/B9D6InHafXQVROxnGfaY
	T2WLNYHKUP8kyAbCrcmgr/E5Wd8D9D4CWLlWAzxMKvh2cDXCGuakqK8d7NqMvkI8+AFb07wiA6a
	mOdA5+Wd6N3fHPt5hxYvwfe4UADxZubJJNKsdFoB06Ht/TglIUEopbNWr4cHvSsNKk/9d6G0XRU
	htoN0gOhRbs5gauh7DglXl7U5y5HWS9pa9GUhesm9Ai/B8SGPgZjtw/KmYF0j+IqXcWX4YAwt
X-Google-Smtp-Source: AGHT+IGcDNA3NZMOOrlivUXJEBBffLFSLJH3K2zhc/Iqn0z/Yrm2iom3akp6YAoJYpq2yX8sJ6vR0A==
X-Received: by 2002:a17:907:fdca:b0:ae3:6cc8:e431 with SMTP id a640c23a62f3a-af61ec1148dmr978867466b.57.1753573070794;
        Sat, 26 Jul 2025 16:37:50 -0700 (PDT)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com. [209.85.208.52])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af635a65fffsm203923466b.76.2025.07.26.16.37.50
        for <linux-trace-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Jul 2025 16:37:50 -0700 (PDT)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-60c60f7eeaaso5286896a12.0
        for <linux-trace-kernel@vger.kernel.org>; Sat, 26 Jul 2025 16:37:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVmGZiA6ExRCvxbE6W2HiyxFOnJHssGQ/TH1sM5cR54gPsPpkWgZXrsF2DhvfedMj9MWoh2IG5lHWhC19PuxND/BcE=@vger.kernel.org
X-Received: by 2002:a05:6402:483:b0:611:f4b2:379c with SMTP id
 4fb4d7f45d1cf-614f1dced8amr5514831a12.20.1753573070075; Sat, 26 Jul 2025
 16:37:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250724123612.206110-1-bhupesh@igalia.com> <20250724123612.206110-3-bhupesh@igalia.com>
 <202507241640.572BF86C70@keescook> <CAHk-=wi5c=_-FBGo_88CowJd_F-Gi6Ud9d=TALm65ReN7YjrMw@mail.gmail.com>
 <B9C50D0B-DCD9-41A2-895D-4899728AF605@kernel.org>
In-Reply-To: <B9C50D0B-DCD9-41A2-895D-4899728AF605@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 26 Jul 2025 16:37:33 -0700
X-Gmail-Original-Message-ID: <CAHk-=wixR7ZR+aebFsWX4qWZ84tMTmyNWLUPmTy3YvaNJGqd-Q@mail.gmail.com>
X-Gm-Features: Ac12FXwLhT2VoOEv9kNeOdgouvN4zZ9YLvHzVMPIsLMuRmQFnkSkLFn13r5tjO0
Message-ID: <CAHk-=wixR7ZR+aebFsWX4qWZ84tMTmyNWLUPmTy3YvaNJGqd-Q@mail.gmail.com>
Subject: Re: [PATCH v6 2/3] treewide: Switch memcpy() users of 'task->comm' to
 a more safer implementation
To: Kees Cook <kees@kernel.org>
Cc: Bhupesh <bhupesh@igalia.com>, akpm@linux-foundation.org, kernel-dev@igalia.com, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, oliver.sang@intel.com, lkp@intel.com, 
	laoar.shao@gmail.com, pmladek@suse.com, rostedt@goodmis.org, 
	mathieu.desnoyers@efficios.com, arnaldo.melo@gmail.com, 
	alexei.starovoitov@gmail.com, andrii.nakryiko@gmail.com, 
	mirq-linux@rere.qmqm.pl, peterz@infradead.org, willy@infradead.org, 
	david@redhat.com, viro@zeniv.linux.org.uk, ebiederm@xmission.com, 
	brauner@kernel.org, jack@suse.cz, mingo@redhat.com, juri.lelli@redhat.com, 
	bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 26 Jul 2025 at 16:19, Kees Cook <kees@kernel.org> wrote:
>
> That works for me! I just get twitchy around seeing memcpy used for strings. :) if we're gonna NUL after the memcpy, just use strscpy_pad().

I do worry a tiny bit about performance.

Because 'memcpy+set last byte to NUL' really is just a couple of
instructions when we're talking small constant-sized arrays.

strscpy_pad() isn't horrible, but it's still at another level. And
most of the cost is that "return the length" which people often don't
care about.

Dang, I wish we had some compiler trick to say "if the value isn't
used, do X, if it _is_ used do Y".

It's such a trivial thing in the compiler itself, and the information
is there, but I don't think it is exposed in any useful way.

In fact, it *is* exposed in one way I can think of:

   __attribute__((__warn_unused_result__))

but not in a useful form for actually generating different code.

Some kind of "__builtin_if_used(x,y)" where it picks 'x' if the value
is used, and 'y' if it isn't would be lovely for this.

Then you could do things like

    #define my_helper(x) \
        __builtin_if_used( \
                full_semantics(x), \
                simpler_version(x))

when having a return value means extra work and most people don't care.

Maybe it exists in some form that I haven't thought of?

Any compiler people around?

                 Linus
