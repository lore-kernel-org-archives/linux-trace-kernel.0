Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 545E93E477
	for <linux-trace-kernel@vger.kernel.org>; Wed, 31 Jan 2024 06:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706682046; cv=none; b=WL3P43VLaUUG+ATdtvfas9eresCaiACT34LhAHYSj4THYhgx/CS7gQ7+XCWEpEiT7WRC0xYLHa8uCmK8Di397qSi1VMkAyvjbkYPsJq7Ry+yqHQy/soAQ9nlo1qWuQOB+cJKpqWGBgjED0eFSAY0Y62pOu+oCArOWnrj6CH3UME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706682046; c=relaxed/simple;
	bh=+zWGDHOSR4R5OOmwVA7CGTmxtDB5Gw1dsrxc8qUmklk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kAuJpZYb/gCeQ6n9FSHCz1/42qdzuqQnbL7nmeB6Kkyq6ewYyJoJG6eBsP6F93eeZgmt2uFVIs76YN6nCfOrYgovDbJ8lYZ0eA96DVzKVOxOIkdf8InJmw0sUOolLSicmvkKzBbmz13fTouNVJgHNpVnKKPScc4Aj3xCbqEKt3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=UQ7vj8Ur; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="UQ7vj8Ur"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a3510d79ae9so539183966b.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 30 Jan 2024 22:20:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1706682042; x=1707286842; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/QwJEx8MXhmC+sPURjCY02TNwn5uuUuexxSfNKMHGWI=;
        b=UQ7vj8Ur8svCWcmt18FTO2KdP40TACm8O97D1qaXClLbKgif4NnSiRc77uXhgSg9Xr
         Nn17Mc5s4Z8YPTBMkocZC+dVOyJYfTXjpBgcy85MWl4arrh1Lfr1H4ueZINU0Nu+VSGP
         p/JuwPyhwKmylb/atiS9qntjnhlXvnF7XM2kw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706682042; x=1707286842;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/QwJEx8MXhmC+sPURjCY02TNwn5uuUuexxSfNKMHGWI=;
        b=s47nZkgMwBpPHC7oRKgPNLZp6x294GPsrpoBzf7RFVi/3wAb7sCscnGM2kzMeMWprO
         ORdh9lEa/lA6esSZSuwsqTZjdiu1P+Lzv9C3No1xiyqbH2maqJqxnbsMQmy9nHH26d/G
         zRPb46iByFfpZlb5b4t71SJBcs7I36wxRehme+8OK9xhCP9CXa64vrCJdGIB8BaOMpzd
         iomxytQAqE2mRnN1ByI1SXOumd4HMIf6Bfm5Bcw7nO+m2gdWxofeyD31oHv8aLthvZWV
         Zik/whkSgLmVf10qj0+1ZmB718LDPALPyHM+VoUh6J/E27WrLZiCBOmutmid8LwCMT1p
         x0yQ==
X-Gm-Message-State: AOJu0YzvwAhIBQw8iXI/N9TgOcDqo+/N0Qgf4cRxjFqDXuoHa3C04Mvz
	2ApoJFgmwZMY3r0+I+FkZ1LMImLGE5xRcstkjdg76GANY97poO2J0GBRyqsnzwC5Xnu9ISW1O/1
	r4FFsLQ==
X-Google-Smtp-Source: AGHT+IFmIe2NY5k3LjpmrcNFcnefkwS11YaFFRhnEMJTXOPEsOJCMpY3Rcv3tPms5SAIbyFGbCK3cA==
X-Received: by 2002:a17:906:a883:b0:a36:5079:d6c9 with SMTP id ha3-20020a170906a88300b00a365079d6c9mr355810ejb.76.1706682042056;
        Tue, 30 Jan 2024 22:20:42 -0800 (PST)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com. [209.85.208.49])
        by smtp.gmail.com with ESMTPSA id l14-20020a170906a40e00b00a35de0619dbsm2430321ejz.200.2024.01.30.22.20.41
        for <linux-trace-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jan 2024 22:20:41 -0800 (PST)
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-55c2cf644f3so4917542a12.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 30 Jan 2024 22:20:41 -0800 (PST)
X-Received: by 2002:a05:6402:2211:b0:55f:1728:3b33 with SMTP id
 cq17-20020a056402221100b0055f17283b33mr291889edb.40.1706682041262; Tue, 30
 Jan 2024 22:20:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240130190355.11486-1-torvalds@linux-foundation.org>
 <20240130190355.11486-5-torvalds@linux-foundation.org> <20240131000956.3dbc0fc0@gandalf.local.home>
 <CAHk-=wjH+k47je4YbP=D+KOiNYp8cJh8C_gZFzSOa8HPDm=AQw@mail.gmail.com>
 <20240131003317.7a63e799@gandalf.local.home> <CAHk-=wg69FE2826EokkCbSKHZvCG-cM5t=9SMFLcfpNu8Yvwqw@mail.gmail.com>
In-Reply-To: <CAHk-=wg69FE2826EokkCbSKHZvCG-cM5t=9SMFLcfpNu8Yvwqw@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 30 Jan 2024 22:20:24 -0800
X-Gmail-Original-Message-ID: <CAHk-=whSse54d+X361K2Uw6jO2SvrO-U0LHLBTLnqHaA+406Fw@mail.gmail.com>
Message-ID: <CAHk-=whSse54d+X361K2Uw6jO2SvrO-U0LHLBTLnqHaA+406Fw@mail.gmail.com>
Subject: Re: [PATCH 5/6] eventfs: get rid of dentry pointers without refcounts
To: Steven Rostedt <rostedt@goodmis.org>, Al Viro <viro@zeniv.linux.org.uk>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 30 Jan 2024 at 21:57, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Ugh.

Oh, and double-ugh on that tracefs_syscall_mkdir/rmdir(). I hate how
it does that "unlock and re-lock inode" thing.

It's a disease, and no, it's not an acceptable response to "lockdep
shows there's a locking problem".

The comment says "It is up to the individual mkdir routine to handle
races" but that's *completely* bogus and shows a fundamental
misunderstanding of locking.

Dropping the lock in the middle of a locked section does NOT affect
just the section that you dropped the lock around.

It affects the *caller*, who took the lock in the first place, and who
may well assume that the lock protects things for the whole duration
of the lock.

And so dropping the lock in the middle of an operation is a bad BAD
*BAD* thing to do.

Honestly, I had only been looking at the eventfs_inode.c lookup code.
But now that I started looking at mkdir/rmdir, I'm seeing the same
signs of horrible mistakes there too.

And yes, it might be a real problem. For example, for the rmdir case,
the actual lock was taken by 'vfs_rmdir()', and it does *not* protect
only the ->rmdir() call itself.

It also, for example, is supposed to make the ->rmdir be atomic wrt things like

        dentry->d_inode->i_flags |= S_DEAD;

and

        dont_mount(dentry);
        detach_mounts(dentry);

but now because the inode lock was dropped in the middle, for all we
know a "mkdir()" could come in on the same name, and make a mockery of
the whole inode locking.

The inode lock on that directory that is getting removed is also what
is supposed to make it impossible to add new files to the directory
while the rmdir is going on.

Again, dropping the lock violates those kinds of guarantees.

"git blame" actually fingers Al for that "unlock and relock", but
that's because Al did a search-and-replace on
"mutex_[un]lock(&inode->i_mutex)" and replaced it with
"inode_[un]lock(inode)" back in 2016.

The real culprit is you, and that sh*t-show goes back to commit
277ba04461c2 ("tracing: Add interface to allow multiple trace
buffers").

Christ. Now I guess I need to start looking if there is anything else
horrid lurking in that mkdir/rmdir path.

I doubt the inode locking problem ends up mattering in this situation.
Mostly since this is only tracefs, and normal users shouldn't be able
to access these things anyway. And I think (hope?) that you only
accept mkdir/rmdir in specific places.

But this really is another case of "This code smells *fundamentally* wrong".

Adding Al, in the hopes that he will take a look at this too.

            Linus
