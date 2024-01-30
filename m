Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E13364A5
	for <linux-trace-kernel@vger.kernel.org>; Tue, 30 Jan 2024 01:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706579460; cv=none; b=VlqVz0iSeNh4D0b9PY5ciezjnIll65W6Yl6abJdwFS9dKGO3W46hvXMlXuAKwtTwPNQ9AaCg5iJziEZIgB86UwEGpoPr8SHSvJtPnn4SYx05OQMR3owxq9cYxHLv1fPyxWQvhn3Cctg2DS8TCz2/B/MGE0Ynioe7cf/64nlSm3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706579460; c=relaxed/simple;
	bh=zyDZ08Jamx3NYeGqhVvbunwn56jBnGzJ3cGlRkrcSRg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EU90xOn6dHCroyaalnGWCQcY/mFgAKDTR8ubKytYxUSbkUa+00GZb2n/Gpod0EAsTKoygFwN+h7qwNjBxu4RLKhzXuYxk6T8B1alpqm9Og5//vszJ/8NB95HFBlgGxQU3ztd6kskUdxUxeCmRfXGEaa4Kzvy4IijdG6ZWboUryM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=bVF17mhD; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="bVF17mhD"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-55a5e7fa471so3335953a12.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 29 Jan 2024 17:50:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1706579457; x=1707184257; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4JiXyOYVlI6BSEdoNtzDGECSezeX6jIOydJh3gzKSfA=;
        b=bVF17mhDhNj6ABQr/QpFyJm3YAMJnklVu0o1QMOB3EK/5WiPsGI8mG7iKNTRDJp5DA
         vf62jU9sn+GbH3yFbJF9hn+lTjKMoF9EpjIEQcMHnO8cI9Z7py61CloaAHv28kW1Xeba
         bPh9AT6/N/7Ue9rXxEAi49YnTKGjvbv3ih9ds=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706579457; x=1707184257;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4JiXyOYVlI6BSEdoNtzDGECSezeX6jIOydJh3gzKSfA=;
        b=TXtF7d700CbR+PqguNBuNt4w8lCVSJ3DvKGyJZssv7aVvLAxjhqEEUwYr9jj5O8MXT
         XOgvWjvthNhhVlosunPsXWtmkwskjnpsDe4cQWzDkwYkJxKC3AQaXagJX/94YTfJAxeI
         HUfvU6bnw5vfdQBcIOgh2+wDXeRrmaJCTdsUKOtongEkL8GM/eA1ug030ky8ZFioFCwK
         kytBBvAWvkpogNROrIuRTC6QNP7M+dzHDD4Nzo8x+ot2HiCCzoUJz+nQHmnbJhHjJdjV
         KKcoxuAMkOqh5k+Tg4vgmlOzOuU5FjCERRqOO6584y2M1CQNc8CZbwH2Z1Jvf7S6miPj
         qG/w==
X-Gm-Message-State: AOJu0YyTkxWlsFKC8cN4L8lbbE42/AQYrWsCV/IIUTNClKS0zxD2qg7z
	Lk1gy4eSQBkEtjeeIXIxGHoy9mNEGwzRgotNU1SL6dy8H2slPJgFdwM22PX2/poJ8X7JFIGHTvt
	vnizGPw==
X-Google-Smtp-Source: AGHT+IG9VgIYsxhNsCbwa0CA6FmYsqng1Hf1TjVjUrWJStpSQqwMQLv8ia4UcURbDmuquG/ugt8Q3g==
X-Received: by 2002:a05:6402:5207:b0:55e:ef2d:952e with SMTP id s7-20020a056402520700b0055eef2d952emr3987475edd.36.1706579457061;
        Mon, 29 Jan 2024 17:50:57 -0800 (PST)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com. [209.85.208.42])
        by smtp.gmail.com with ESMTPSA id j17-20020aa7c351000000b0055c4a251205sm4284162edr.90.2024.01.29.17.50.55
        for <linux-trace-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jan 2024 17:50:55 -0800 (PST)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-55817a12ad8so3348116a12.2
        for <linux-trace-kernel@vger.kernel.org>; Mon, 29 Jan 2024 17:50:55 -0800 (PST)
X-Received: by 2002:a05:6402:3514:b0:55e:e22c:c1fd with SMTP id
 b20-20020a056402351400b0055ee22cc1fdmr4283813edd.4.1706579455285; Mon, 29 Jan
 2024 17:50:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202401291043.e62e89dc-oliver.sang@intel.com> <CAHk-=wh0M=e8R=ZXxa4vesLTtvGmYWJ-w1VmXxW5Mva=Nimk4Q@mail.gmail.com>
 <20240129120125.605e97af@gandalf.local.home> <CAHk-=wghx8Abyx_jcSrCDuNj96SuWS0NvNMhfU8VjFGg9bgm_g@mail.gmail.com>
 <CAHk-=whb91PWEaEJpRGsuWaQpYZGj98ji8HC2vvHD4xb_TqhJw@mail.gmail.com>
 <CAHk-=wgp7UkG31=cCcbSdhMv6-vBJ=orktUOUdiLzw4tQ4gDLg@mail.gmail.com>
 <20240129152600.7587d1aa@gandalf.local.home> <CAHk-=wghobf5qCqNUsafkQzNAZBJiS0=7CRjNXNChpoAvTbvUw@mail.gmail.com>
 <20240129172200.1725f01b@gandalf.local.home> <CAHk-=wjV6+U1FQ8wzQ5ASmqGgby+GZ6wpdh0NrJgA43mc+TEwA@mail.gmail.com>
 <CAHk-=wgOxTeTi02C=kOXsHzuD6XCrV0L1zk1XP9t+a4Wx--xvA@mail.gmail.com>
 <20240129174950.5a17a86c@gandalf.local.home> <CAHk-=wjbzw3=nwR5zGH9jqXgB8jj03wxWfdFDn=oAVCoymQQJg@mail.gmail.com>
 <20240129193549.265f32c8@gandalf.local.home>
In-Reply-To: <20240129193549.265f32c8@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 29 Jan 2024 17:50:38 -0800
X-Gmail-Original-Message-ID: <CAHk-=whRxcmjvGNBKi9_x59cAedh8SO8wsNDNrEQbAQfM5A8CQ@mail.gmail.com>
Message-ID: <CAHk-=whRxcmjvGNBKi9_x59cAedh8SO8wsNDNrEQbAQfM5A8CQ@mail.gmail.com>
Subject: Re: [linus:master] [eventfs] 852e46e239: BUG:unable_to_handle_page_fault_for_address
To: Steven Rostedt <rostedt@goodmis.org>
Cc: kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev, lkp@intel.com, 
	linux-kernel@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Ajay Kaher <ajay.kaher@broadcom.com>, linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 29 Jan 2024 at 16:35, Steven Rostedt <rostedt@goodmis.org> wrote:
>
>  # echo 'p:sched schedule' >> /sys/kernel/tracing/kprobe_events
>  # ls -l events/kprobes/
> ls: cannot access 'events/kprobes/': No such file or directory
>
> Where it should now exist but doesn't. But the lookup code never triggered.
>
> If the lookup fails, does it cache the result?

I think you end up still having negative dentries around.

The old code then tried to compensate for that by trying to remember
the old dentry with 'ei->dentry' and 'ei->d_children[]', and would at
lookup time try to use the *old* dentry instead of the new one.

And because dentries are just caches and can go away, it then had that
odd dance with '.d_iput', so that when a dentry was removed, it would
be removed from the 'ei->dentry' and 'ei->d_children[]' array too.

Except that d_iput() of an old dentry isn't actually serialized with
->d_lookup() in any way, so you end up with the whole race that I
already talked about earlier, where you could still have an
'ei->dentry' that pointed to something that had already been unhashed,
but d_iput() hadn't been called *yet*, so d_lookup() is called with a
new dentry, but the tracefs code then desperately tries to use the old
dentry pointer that just isn't _valid_ any more, but it doesn't know
that because d_iput() hasn't been called yet...

And as I *also* pointed out when I described that originally, you'll
practically never hit this race, because you just need to be *very*
unlucky with the whole "dentry is freed due to memory pressure".

But basically, this is why I absolutely *HATE* that "ei->dentry"
backpointer. It's truly fundamentally broken.

You can't reference-count it, since the whole point of your current
tracefs scheme is to *not* keep dentries and inodes around forever,
and doing a "dget()" on that 'ei->dentry' would thus fundamentally
screw that up.

But you also cannot keep it in sync with dentries being released due
to memory pressure, because of the above thing.

See why I've tried to tell you that the back-pointer is basically a
100% sign of a bug.

The *only* time you can have a valid dentry pointer is when you have
also taken a ref to it with dget(), and you can't do that.

So then you have all that completely broken code that _tries_ to
maintain consistency with ->d_children[] etc, and it works 99.9% in
practice, because the race is just so hard to hit because dentries
only normally get evicted either synchronously (which you do under the
eventfs_mutex) or under memory pressure (which is basically never
going to be something you can test).

And yes, my lookup patch removed all the band-aids for "if I have an
ei->dentry, I'll reuse it". So I think it ends up exposing all the
previous bugs that the old "let's reuse the old dentry" code tried to
hide.

But, as mentioned, that ei->dentry pointer really REALLY is broken.

NBow, having looked at this a lot, I think I have a way forward.
Because there is actually *one* case where you actually *do* do the
whole "dget()" to get a stable dentry pointer. And that's exactly the
"events" directory creation (ie eventfs_create_events_dir()).

So what I propose is that

 - ei->dentry and ei->d_children[] need to die. Really. They are
buggy. There is no way to save them. There never was.

 - but we *can* introduce a new 'ei->events_dir' pointer that is
*only* set by eventfs_create_events_dir(), and which is stable exactly
because that function also does a dget() on it, so now the dentry will
actually continue to exist reliably

I think that works. The only thing that actually *needs* the existing
'ei->dentry' is literally the eventfs_remove_events_dir() that gets
rid of the stable events directory. It's undoing
eventfs_create_events_dir(), and it will do the final dput() too.

I will try to make a patch for this. I do think it means that every
time we do that

    dentry->d_fsdata = ei;

we need to also do proper reference counting of said 'ei'. Because we
can't release 'ei' early when we have dentries that point to it.

Let me see how painful this will be.

             Linus
