Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8978B60B9F
	for <linux-trace-kernel@vger.kernel.org>; Tue, 30 Jan 2024 08:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706604247; cv=none; b=W3B/leRJ7z8/CPNn+aNuXpkjgGnM4d149V2vmvZTLYCWVyAwzVslMQPEU0k/xuFijx5OhT0KqIZN0suyr5ff2juM0KMo2QwqP5h3BwGJ/rAZVGeoPTCYMc3YYaWMQKAAxfM0swDuo0WIRT/2Pl4B+BQ7aZjdm/vrLn/WDzkzST4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706604247; c=relaxed/simple;
	bh=fh3Oobbo3ozn7qKP0JOFPHWneqBQFpX8St5WanXUNXo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CdXtEb2I0RQ5iTSDlMBMfGf4GjBgSQkxP6uUyt7mMc9DdYRIoSMXIE+v9UpLdUgvhujj66ourbWFJFhmdH2oEP+XYjLa10pNpuKj7EjOGt/ANxF8EOJIqih3S/LLWlh9ccz3epnBNEHnPty9MEAhd6FrCVz5Tw5OOaSChWWaYO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Y3lnMCoU; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Y3lnMCoU"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5102bbe87afso3023730e87.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 30 Jan 2024 00:44:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1706604243; x=1707209043; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IQ+AzAqTf7hVYM2GdeV6bNXU4qpra1WyPgLqP0lu0rA=;
        b=Y3lnMCoU9RhnkxVUn3s32tkfMTSg4fCmLZlJ7LW1BYYf5lpCQ66+sAk2yfHea7pU4m
         8+K8f+te9vwXW/c9bIGuJsxQZ/mKAXSueKjdIgomXXaXjJNcjVyihi+lVEjZuNb9MPx8
         gZnd+mTx8pd9xRV+4zwVDx6oFxPDj42bMJi6E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706604243; x=1707209043;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IQ+AzAqTf7hVYM2GdeV6bNXU4qpra1WyPgLqP0lu0rA=;
        b=rdlhHScpMGc4xjLJyrj879ye6WRsT4NNSBpxo2/hh/Zvbth7XaEb3Zu4eLNlZMNNo4
         GKc0UKA46XprQZ7fS+K2wXgP3Kvm6kj/AX8yOqoOmvbYGO/agC0gqZmMMo8BgcCGP/gC
         IWgjCL0NGcSCexuxnfRWq6P5eN4gi712wE8UFXwDPPIfH+1ojFMIGBfLeX2n/Mdn14G9
         Pd3o+WNx1W37NhUjn0SH2Y3FCu8mIWnqIb694r7dMbgKRsyQleTx9PE+GuL8Ubmwkqsr
         betv6kags0Yn5p6cMCznUwXMV3UUm/Px4JVuo6iDSOky7z+FhcczNHUTjs6nBUDJjvQN
         AMpw==
X-Gm-Message-State: AOJu0Yz8W8VlDCofgjsTcYuaoqSnVpKrrQXZitbIZ3x2XcJWbnBmnbbP
	m7TnKYZGhoL2CDEN1uJSe+JdYeRWF3P3E0UhBTcO2qVrAEC6SF4FHZiMkedevn4xDKivHOC46f+
	jxEY=
X-Google-Smtp-Source: AGHT+IEqz9C5aBidNPClX8VgBrD1Te8xmWyXryZU4JqDSWxtv66ZIsZ9/zPt+JRPLWZftGHwSu2PAA==
X-Received: by 2002:ac2:4899:0:b0:50e:50ac:2c84 with SMTP id x25-20020ac24899000000b0050e50ac2c84mr4725468lfc.51.1706604243121;
        Tue, 30 Jan 2024 00:44:03 -0800 (PST)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id n28-20020a056512311c00b0050e80fe2ed0sm1283946lfb.8.2024.01.30.00.44.02
        for <linux-trace-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jan 2024 00:44:02 -0800 (PST)
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5101f2dfdadso6345254e87.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 30 Jan 2024 00:44:02 -0800 (PST)
X-Received: by 2002:a05:651c:1cc:b0:2d0:4ef8:3472 with SMTP id
 d12-20020a05651c01cc00b002d04ef83472mr3848048ljn.47.1706604241691; Tue, 30
 Jan 2024 00:44:01 -0800 (PST)
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
 <20240129193549.265f32c8@gandalf.local.home> <CAHk-=whRxcmjvGNBKi9_x59cAedh8SO8wsNDNrEQbAQfM5A8CQ@mail.gmail.com>
 <CAHk-=wh97AkwaOkXoBgf0z8EP88ePffLnTcmmQXcY+AhFaFrnA@mail.gmail.com>
In-Reply-To: <CAHk-=wh97AkwaOkXoBgf0z8EP88ePffLnTcmmQXcY+AhFaFrnA@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 30 Jan 2024 00:43:44 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi6m7d-nivx10Lo=aGhbdk2qg-8SzjtDd9XW01LxGgAMA@mail.gmail.com>
Message-ID: <CAHk-=wi6m7d-nivx10Lo=aGhbdk2qg-8SzjtDd9XW01LxGgAMA@mail.gmail.com>
Subject: Re: [linus:master] [eventfs] 852e46e239: BUG:unable_to_handle_page_fault_for_address
To: Steven Rostedt <rostedt@goodmis.org>
Cc: kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev, lkp@intel.com, 
	linux-kernel@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Ajay Kaher <ajay.kaher@broadcom.com>, linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 29 Jan 2024 at 19:56, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> But I've been staring at this code for too long, so I'm posting this
> just as a "it's broken, but _something_ like this", because I'm taking
> a break from looking at this.

Bah. I literally woke up and realized what the problem is.

We're caching negative dentries, but eventfs_create_dir() has no way
to invalidate the old negative dentry when it adds a new entry.

The old "try to reuse dentry" ended up hiding that issue, because it
would look up the negative dentry from the 'ei' and turn it into a
positive one.

And I was stupidly staring at the wrong code - all these functions
with almost the same names.

eventfs_create_events_dir() is fine, because it gets the parent as a
dentry, so looking up the new dentry is trivial.

But eventfs_create_dir() doesn't get a dentry at all. It gets the parent as a

  struct eventfs_inode *parent

which is no good.

So that explains why creating an event after deleting an old one - or
after just looking it up before it was created - ends up with the
nonsensical "ls" output - it gets listed by readdir() because the
entry is there in the eventfs data structures, but then doing a
"stat()" on it will just hit the negative dentry. So it won't actually
look up the dentry.

The simple solution is probably just to not cache negative dentries
for eventfs.  So instead of doing the "d_add(dentry, NULL);" we should
just return "ERR_PTR(ENOENT)".

Which is actually what /proc/<pid> lookups do, for the same reason.

I'll go back to bed, but I think the fix is something trivial like this:

  --- a/fs/tracefs/event_inode.c
  +++ b/fs/tracefs/event_inode.c
  @@ -517,9 +517,8 @@ static struct dentry *eventfs_root_lookup(
        }

    enoent:
  -     /* Nothing found? */
  -     d_add(dentry, NULL);
  -     result = NULL;
  +     /* Don't cache negative lookups, just return an error */
  +     result = ERR_PTR(ENOENT);

    out:
        mutex_unlock(&eventfs_mutex);

I just wanted to write it down when the likely solution struck me.

               Linus
