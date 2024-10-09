Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4E331E0DC4;
	Wed,  9 Oct 2024 16:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728491509; cv=none; b=H+08O+VEPlr0XL5xa6lhaDYxMFQ7nwviZajz/MFAHSKOgTHbVomoT4/Tq8Fn3IEtwEPEucxZEvGSytMiIO0WA5m+sAMhD6zS1t+LwrslXBIKwNDD7Ycxyz20/QucykYVanR1Ai6PLJuSlnZYDcrJ93uU9rgYYQh6KkpBD1c3aZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728491509; c=relaxed/simple;
	bh=XweQ4V9KX/NPvV++7j48UoMg0Q+hG0KxtfZ5geH7y2g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dD+3XrcXMNu+UA8HwgoOkNeevZM6tzI+fH9ItBp8yI9yYcJy3L/GcZ8bM/3muaR211Wp+74SMEZQLSqu/UAdlL3EAfFy7z2XCZoLMf90lZw9QX7AUgiV1of5NyPQnhWrbJBFThyRj6k525VvmiPm4pHtECPaoryTAKM88F+tef4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F8E9C4CEC3;
	Wed,  9 Oct 2024 16:31:48 +0000 (UTC)
Date: Wed, 9 Oct 2024 12:31:53 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Ard Biesheuvel <ardb+git@google.com>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, Masami
 Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH] x86/ftrace: Don't bother preserving/restoring R10/R11
Message-ID: <20241009123153.4a26f226@gandalf.local.home>
In-Reply-To: <CAMj1kXEwpXPWVm2X8ZzpMc0JoynA=H8kABzD_Bb5+JEhULEr8Q@mail.gmail.com>
References: <20241009153901.3878233-2-ardb+git@google.com>
	<20241009120257.7b2de987@gandalf.local.home>
	<CAMj1kXFjd8AuHaBMLap6RZ18PR9_Cwv2GFbBkswj-e5YpaQFdA@mail.gmail.com>
	<20241009121931.6156accd@gandalf.local.home>
	<CAMj1kXEwpXPWVm2X8ZzpMc0JoynA=H8kABzD_Bb5+JEhULEr8Q@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 9 Oct 2024 18:25:25 +0200
Ard Biesheuvel <ardb@kernel.org> wrote:

> > Say we have code of:
> >
> >         pushq   r10
> >         pushq   r11
> >         call    foo
> >         popq    r11
> >         popq    r10
> >
> > Where we add a kprobe to the start of foo, the callback should be able to
> > see what r10 and r11 were.  
> 
> Why exactly is that? The contents of R10 and R11 have no purpose going
> forward, so is it just to see what some previous code may have left in
> them?

Because the probe is on the call. Unless they were used between the push
and the call, they still have the value you may be looking for.

> 
> > But the restore part is for the function foo to
> > see. It shouldn't care about r10 or r11 and if a kprobe updates them, it
> > should not have any effect.
> >
> > What does restoring r10 and r11 give us?
> >  
> 
> Nothing. Which is why I don't understand why you would need to record
> them in the first place.

As I mentioned above. Unless they are used after they are pushed, you still
have access to them on the call (or the kprobe attached to ftrace).

-- Steve
