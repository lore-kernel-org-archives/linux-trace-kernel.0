Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA59386AEF
	for <linux-trace-kernel@vger.kernel.org>; Tue, 30 Jan 2024 16:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706633772; cv=none; b=YurZDUJBkYG0j1wzB3+wwCZYWPD2qJmadHFfZbIpS4mRqRwBzzbYIBh6wHehzgTMN9meUJ4/yRFLraq5tMyNavvzk127aZTX7BQE99IwDwdzUleWSdVPtPIPdSGVyBqlTmFhIFnfRerOo0h7R4/pnKf69x/q7lvslR7+dxv2sV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706633772; c=relaxed/simple;
	bh=ypmOqj/q+NNTyaOgW1vO3SUeOqeEi21Zhohn4esARF4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VNhm28LTxPBzPnf29SbHhauJP0/JOf/3EJKpztn7/Y8YKn52729aykFG/x57fXUH7pXjTt+eSnRlpqMk+tug0mem0tpcp9Y2WoZe1hw1fsatxW4YepPDhKtra7X6Vxe2iT9K2plVRvbBP9DW4MzNJ1/7lDRj+dIMpMpswHgaFfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ITxhwscC; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ITxhwscC"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-51032e62171so4473275e87.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 30 Jan 2024 08:56:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1706633768; x=1707238568; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LAAKLjZaHiiD7rj2ZPOdCI2v+5OE83poGDSWqAYQSrc=;
        b=ITxhwscCw1PO/+9hvmk8jTOXUIsM87fE++zbJeCTcL81Fx72qSmUYWN9LxVv61AO6K
         0WfPZwT4hQ05rh1Z2IcRurN0XNuUtCpuQSujaxRTyamsOTY8oOa8x6WJYNbj5qwPvsJt
         TDHKsJcWQG/KbqRZGXk9Ha44shgx03QWKxizA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706633768; x=1707238568;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LAAKLjZaHiiD7rj2ZPOdCI2v+5OE83poGDSWqAYQSrc=;
        b=SXDxPMEo7bElunUs1kGKR1gTy9WFfSzPhZGJyf+z2LONzvLHlOw3Sepdiv1NHQ2N2L
         zwE0k+hCIwDKqcBzRXP9HrGptyBGTwvIwwxmm+RoONjyiB3bWJeCpCIBD68p2KdIb0bh
         RvGA9UUCdk9aJQC0Bb4M69CmgZRq4RhefAx5fwvCTlH+CUcPYkXZSFfAMXmAxiJ62X1/
         U5B8PxheyotZmfi5bhuRmevhh3aj/K8rP3BNZ234kzjzRm/J2fJSn4px2xsUt84EvSOz
         kdI0dheTsQCb5SpGduRoeBseC5jLviG38uVY9+djF1nDU6zNDQwfHd+yOPt40PahGNoW
         KT9g==
X-Gm-Message-State: AOJu0Yw9RO+0y4E6bUa+nIKHXZ2frhtdF6TMnzoUySD0ugjBBUUqcvJn
	UiSOZpdknNMFKGSSBeeKvBXJsesZYZ+FwnWG0IL8L0PfFmgS89eo2MIWk/GaXYN4QBBCQlfp+Pu
	Ze8UkvQ==
X-Google-Smtp-Source: AGHT+IEce2ea1vs0JqHzmpReRiLYBIA2fMvd5uURSer8TyJA5JzJhq5kE0TwTacyqGoi76GBVKenow==
X-Received: by 2002:a05:6512:2256:b0:510:6e7:8e43 with SMTP id i22-20020a056512225600b0051006e78e43mr7247729lfu.49.1706633768720;
        Tue, 30 Jan 2024 08:56:08 -0800 (PST)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id a2-20020ac25202000000b0051121b7d926sm32018lfl.306.2024.01.30.08.56.07
        for <linux-trace-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jan 2024 08:56:07 -0800 (PST)
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2d061f1e2feso3034801fa.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 30 Jan 2024 08:56:07 -0800 (PST)
X-Received: by 2002:a2e:b8d1:0:b0:2cf:334f:a7f9 with SMTP id
 s17-20020a2eb8d1000000b002cf334fa7f9mr8159344ljp.27.1706633767505; Tue, 30
 Jan 2024 08:56:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202401291043.e62e89dc-oliver.sang@intel.com> <CAHk-=whb91PWEaEJpRGsuWaQpYZGj98ji8HC2vvHD4xb_TqhJw@mail.gmail.com>
 <CAHk-=wgp7UkG31=cCcbSdhMv6-vBJ=orktUOUdiLzw4tQ4gDLg@mail.gmail.com>
 <20240129152600.7587d1aa@gandalf.local.home> <CAHk-=wghobf5qCqNUsafkQzNAZBJiS0=7CRjNXNChpoAvTbvUw@mail.gmail.com>
 <20240129172200.1725f01b@gandalf.local.home> <CAHk-=wjV6+U1FQ8wzQ5ASmqGgby+GZ6wpdh0NrJgA43mc+TEwA@mail.gmail.com>
 <CAHk-=wgOxTeTi02C=kOXsHzuD6XCrV0L1zk1XP9t+a4Wx--xvA@mail.gmail.com>
 <20240129174950.5a17a86c@gandalf.local.home> <CAHk-=wjbzw3=nwR5zGH9jqXgB8jj03wxWfdFDn=oAVCoymQQJg@mail.gmail.com>
 <20240129193549.265f32c8@gandalf.local.home> <CAHk-=whRxcmjvGNBKi9_x59cAedh8SO8wsNDNrEQbAQfM5A8CQ@mail.gmail.com>
 <CAHk-=wh97AkwaOkXoBgf0z8EP88ePffLnTcmmQXcY+AhFaFrnA@mail.gmail.com>
 <CAHk-=wi6m7d-nivx10Lo=aGhbdk2qg-8SzjtDd9XW01LxGgAMA@mail.gmail.com>
 <CAHk-=wi+WbXZcc2Sx1i-MGV2DfG4eS4Ci+mrqi-PBSLSnww6qA@mail.gmail.com>
 <20240130093942.56206ff1@gandalf.local.home> <20240130114947.5bc856b0@gandalf.local.home>
In-Reply-To: <20240130114947.5bc856b0@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 30 Jan 2024 08:55:51 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiNY3W1QKveFnH=dJtRNW7kA1Nbn6Ua49EbM6AC+Rx8wg@mail.gmail.com>
Message-ID: <CAHk-=wiNY3W1QKveFnH=dJtRNW7kA1Nbn6Ua49EbM6AC+Rx8wg@mail.gmail.com>
Subject: Re: [linus:master] [eventfs] 852e46e239: BUG:unable_to_handle_page_fault_for_address
To: Steven Rostedt <rostedt@goodmis.org>
Cc: kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev, lkp@intel.com, 
	linux-kernel@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Ajay Kaher <ajay.kaher@broadcom.com>, linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 30 Jan 2024 at 08:49, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> - On removal, I got rid of the SRCU callback and the work queue.
>   Instead, I find the dentry of the current eventfs_inode that is being
>   deleted by walking the ei->parent until I find the events inode that has
>   a dentry. I then use that to do a lookup walking back down to the
>   eventfs_inode I want to delete. This gives me the dentry that I can call
>   d_invalidate() on.

Yes, that works.

However, I have a patch that is *much* smaller and simpler, and
doesn't need that walk.

The VFS layer already has a good interface for "should I still use
this dentry", which is needed for various network filesystems etc that
want to time out caches (or check explicitly whether the file still
exists etc): it's the dentry d_revalidate() check.

Let me just reboot into it to test that I got all the cases.

It makes the code even more obvious, and avoids all the complexity.

           Linus
