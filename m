Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D8848CDD;
	Wed,  9 Oct 2024 17:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728493867; cv=none; b=WwH6ygiJ4By5dAPTkGuaAcdP/O8jZ/m838kkOwrqHJz9VyH1Q/R6vyIf6KmNAtE80x80UPAp45yfoGRpXURGtjU7+LrRWJuQmxmR0XvIRx7qMvFzQL24q5ST9CFUiXWry8dgK9u9i7nNUuMO2nCFUHm9XhApoQFyoDCnCbMR4Ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728493867; c=relaxed/simple;
	bh=rGOvvnzp2dt2tRWEA9TxFXfky1CLdrBypq1DemqWQBs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=McejnzHrGUEy2sQRQ7pRCabcqWesrfNeICZLVHCgBr3O7vPm+V910Z+Nvi66TTtzYcHyCMKvXDEdZ3seig6etDDflNySc8moUK5e3QUVSIq5gTEkSzAW6hqGkhPoyureLDtC+NU9owqAgbqkpR6k59lSdEeqKv3C6GzXLHC15+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jYk4Kvk1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jYk4Kvk1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E058BC4CECE;
	Wed,  9 Oct 2024 17:11:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728493866;
	bh=rGOvvnzp2dt2tRWEA9TxFXfky1CLdrBypq1DemqWQBs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=jYk4Kvk1gY1uvFbXCPYRUAUbrhlp/+8wAbme3d62xKuAC9Th3k48Kg6AvrjLST2SR
	 pykIeziMLP7jfYEDJ9UOu0GIzQEL7po1ZnWJmodHOy0MA65xAH4YhII/VOCt9mR8Vj
	 2J79y4o+575tcdWhPW/cbP5hIqsCCOXJxJTOfMwtgGr9/3MPB8h7wmihK1CPa70wY6
	 tZ/mGJjZpNx92L+cKvvipPpVAU+hupjVBDGRIcykTA16Ln/SXoj5nwxDtuGvsJR2Lh
	 ju6EubqZ1RoyAfbn4AmFvnD1l1uAWqJ1TrQPGNOuJnXdxtItZaowtD86t5CXBqdFsN
	 eE8fHnT6ClHwg==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-53991d05416so8796874e87.2;
        Wed, 09 Oct 2024 10:11:06 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUd4pHfVLnwBgajKxgA88oABuBXLlTrwyUu1NjfGaPwqHZa6wgn3SlsZ2tfLB+RTv31gVWtusXgHjU4J0c=@vger.kernel.org, AJvYcCWr8oTt+hjTJ9SuoXJUWlGBlS2QlLQPysZmSvboG94TP6wOk6+x6JSJc61S0xl/8sGQt11e9FoEherouJHBfS6iRHsY@vger.kernel.org
X-Gm-Message-State: AOJu0YwLmEY0ZXvC8+UYwWvFKMjk22Fm4AA3jJUrYIkOq9ewrrZcMeIw
	Wo+mHlNzE76hJS/SFzp+WAY7eC0Vhs4ulNZpyjAfvyt786PyGi5RmvFcaB+kg/Hbc32ZFaj3mam
	cL2WIMWe/1xlcWl3iQsDB0+M987Q=
X-Google-Smtp-Source: AGHT+IGNJAwzhfHJj0HOj5vHsytQW4u22wVUYU59ysyKknL8uIV+alUYqiOogmDp5RRStrx50BlGDPRCxCNYdpkdQ9Q=
X-Received: by 2002:a05:6512:1394:b0:52c:cd77:fe03 with SMTP id
 2adb3069b0e04-539c4899100mr3127476e87.14.1728493865313; Wed, 09 Oct 2024
 10:11:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241009153901.3878233-2-ardb+git@google.com> <20241009120257.7b2de987@gandalf.local.home>
 <CAMj1kXFjd8AuHaBMLap6RZ18PR9_Cwv2GFbBkswj-e5YpaQFdA@mail.gmail.com>
 <20241009121931.6156accd@gandalf.local.home> <CAMj1kXEwpXPWVm2X8ZzpMc0JoynA=H8kABzD_Bb5+JEhULEr8Q@mail.gmail.com>
 <20241009123153.4a26f226@gandalf.local.home>
In-Reply-To: <20241009123153.4a26f226@gandalf.local.home>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Wed, 9 Oct 2024 19:10:53 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFcxOTKBZzT8gar58xZn+hsAN0gnu3ELKoYzmcXF76H5A@mail.gmail.com>
Message-ID: <CAMj1kXFcxOTKBZzT8gar58xZn+hsAN0gnu3ELKoYzmcXF76H5A@mail.gmail.com>
Subject: Re: [PATCH] x86/ftrace: Don't bother preserving/restoring R10/R11
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-trace-kernel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 9 Oct 2024 at 18:31, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Wed, 9 Oct 2024 18:25:25 +0200
> Ard Biesheuvel <ardb@kernel.org> wrote:
>
> > > Say we have code of:
> > >
> > >         pushq   r10
> > >         pushq   r11
> > >         call    foo
> > >         popq    r11
> > >         popq    r10
> > >
> > > Where we add a kprobe to the start of foo, the callback should be able to
> > > see what r10 and r11 were.
> >
> > Why exactly is that? The contents of R10 and R11 have no purpose going
> > forward, so is it just to see what some previous code may have left in
> > them?
>
> Because the probe is on the call. Unless they were used between the push
> and the call, they still have the value you may be looking for.
>

Right. So putting a probe on foo() is a way to inspect the register
values during the execution if its caller. Fair enough.

> >
> > > But the restore part is for the function foo to
> > > see. It shouldn't care about r10 or r11 and if a kprobe updates them, it
> > > should not have any effect.
> > >
> > > What does restoring r10 and r11 give us?
> > >
> >
> > Nothing. Which is why I don't understand why you would need to record
> > them in the first place.
>
> As I mentioned above. Unless they are used after they are pushed, you still
> have access to them on the call (or the kprobe attached to ftrace).
>

OK. I just didn't imagine this usage mode, where you probe foo() to
capture the values of dead registers in its callers.

I'll send a v2 and drop the first hunk.
