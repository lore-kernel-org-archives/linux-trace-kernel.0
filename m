Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F8E31B6D0F;
	Wed, 19 Feb 2025 07:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739949279; cv=none; b=b5FSCv7Oid6Z+3RnzjUlQwbtaEDVmctU2Rw+ShZJrSp7S7nLLoo+26Ca0vWvOFA2MMbLYTaUxPgfJEzYseY3yOA54ADWWDOvYo1WFMhubcnpvOkPTn5eFgsAXyZ25WJxEAq491Bomi9NSNgoCTsPkZRqZ5nYnDvJyOB05W9EWRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739949279; c=relaxed/simple;
	bh=gT5Ot5Dqsi8Zg3ajhbOfiz6BalGQ9orq7BuU+V/4+8c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qqc2G3iH6FToupD9/XhlDG+jaSSSQ6V3mwOV/AK4s499KFdWlv+e1FVBEDj3+pHuxXXPZnAZex6XR+/PZda8qtykCKCyd554e98POaFymdgvJVTNzlUz3M4JLc7RT76fNmNha1GVvLEVPGpTvdWsEMiLAoGuT8bAUIc6jzVWOYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XwedHFTy; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VibUNDDY; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XwedHFTy";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VibUNDDY"
Date: Wed, 19 Feb 2025 08:14:34 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739949275;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ICs/Wkbt6qj1JF2X0Vfj7AIqap/5GZe7zs0d0KHGaOw=;
	b=XwedHFTyqEKkVBaPRC6i2rxQBt0pa7TMsk67+/O3Q11FH47DS1YDILilxxBxdLaw5cVYNM
	0fzYlxRDbJY4eq6uDIi4eh2tXTMhI3eSlMFbR9srLczixAHy48k/cvc/RJh7mnwCpnAMn6
	GVtzGTFxkkc3H/YzEFkuUliFbz0fRTMuSg1bbOOVCufoslx9MThPpLo0YRWPUijlNUAe+e
	hZQszsTAKNV5QlRSUCAFIC7BB61/3DIQe7fV+NLtaE3FmC4cqMyvTgM8h9YP35X3W6g1jS
	DLpLffAVxT0OWr8ZadFJ30OgGfrr62ceATDOjSqPU9T/JfM7BlrrejCWPIF56A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739949275;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ICs/Wkbt6qj1JF2X0Vfj7AIqap/5GZe7zs0d0KHGaOw=;
	b=VibUNDDYmvAHpCmLAzcuoymTqX+78oqN+8ZSFgTmJFpRc2izKokTvj+2ZaiAL7QSpoo/tJ
	lDa60I+VHGrpAgCQ==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing/user_events: Don't use %pK through printk
Message-ID: <20250219081236-812a157c-5c60-41af-a7c8-f75f9da5e92a@linutronix.de>
References: <20250217-restricted-pointers-trace-v1-1-bbe9ea279848@linutronix.de>
 <20250219091023.f17833aea92a3d90e1bbc7da@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250219091023.f17833aea92a3d90e1bbc7da@kernel.org>

On Wed, Feb 19, 2025 at 09:10:23AM +0900, Masami Hiramatsu wrote:
> On Mon, 17 Feb 2025 14:16:12 +0100
> Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de> wrote:
> 
> > Restricted pointers ("%pK") are not meant to be used through printk().
> > It can unintentionally expose security sensitive, raw pointer values.
> > 
> > Use regular pointer formatting instead.
> > 
> > Link: https://lore.kernel.org/lkml/20250113171731-dc10e3c1-da64-4af0-b767-7c7070468023@linutronix.de/
> 
> This is only for the kernel pointer, but the "uaddr" below means it
> has a user space address. So I think this does not need to be applied.

"uaddr" is formatted with %llx, which is fine.
"%pK" is used for mm->mm, which is a kernel pointer.

> Thank you,
> 
> > Signed-off-by: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>
> > ---
> >  kernel/trace/trace_events_user.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
> > index 97325fbd62836f4fb477c4a2b2936eff544291ec..3effc6fce20e65a8077de5221eb69db04fb1a775 100644
> > --- a/kernel/trace/trace_events_user.c
> > +++ b/kernel/trace/trace_events_user.c
> > @@ -455,7 +455,7 @@ static void user_event_enabler_fault_fixup(struct work_struct *work)
> >  	if (ret && ret != -ENOENT) {
> >  		struct user_event *user = enabler->event;
> >  
> > -		pr_warn("user_events: Fault for mm: 0x%pK @ 0x%llx event: %s\n",
> > +		pr_warn("user_events: Fault for mm: 0x%p @ 0x%llx event: %s\n",
> >  			mm->mm, (unsigned long long)uaddr, EVENT_NAME(user));
> >  	}
> >  
> > 
> > ---
> > base-commit: 0ad2507d5d93f39619fc42372c347d6006b64319
> > change-id: 20250217-restricted-pointers-trace-a0fb12707ac6
> > 
> > Best regards,
> > -- 
> > Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>
