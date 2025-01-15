Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ADC514F12D
	for <linux-trace-kernel@vger.kernel.org>; Wed, 15 Jan 2025 16:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736958582; cv=none; b=o/FJOzwFtyCtZaSZinwdI6CB7qWi3R0gQ6O5SNlddPzkiOQQh81lhPjmsAEYyuY2gfS4RCnpYaYe98jcZkVX27yRycXmOD0h9XtyuLaT5ml+GpIIQpiHZ+Ta4CaeUGg0RGMbnSoU9I/grZDbwLxDkPCwZPRS5KY79hjvphdDdS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736958582; c=relaxed/simple;
	bh=kihgjBZlZQW+8gKAA9x6EcFq++t+M/78z/VBjtmDVbo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=szQVqJLuh3pOQk0JnDNp1/1WGMO8TlkxlSc+rp6gIfVhXBvJhnbgPu0eyCfxWQrxRfH/+Vf3JjeNFF8EgbhHR5hMgoZo7U5ONWD4zvmCHNG3NpaWZ+k3Hb6oM/SxKedck+0MSiO58c4TTsuL7rpVsxBlt1mYdLeck80ph9fzLuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=FU3SIyPA; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=E6WddCHD; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=FU3SIyPA; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=E6WddCHD; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="FU3SIyPA";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="E6WddCHD";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="FU3SIyPA";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="E6WddCHD"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A9C9B1F394;
	Wed, 15 Jan 2025 16:29:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1736958578; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Qz12Wc5P2Lk5yPmEeTSbchP1gv42UFV0wGc5y6vYbGg=;
	b=FU3SIyPAflNHav0Je4qDhCFQpOc5SeTmqX8Y4ACdhFIZXZuUINhYW9zBEVNjYBejrlntXV
	UqiTE3KbhfTm+EoWdVlH50vfIrUIhUuSFztoj/I+Vd5fOIkSP0UCPWX3muAUR5rz1l/6PX
	Q8Sydq8mmuE3E9QnxNWZaZl58996Jq8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1736958578;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Qz12Wc5P2Lk5yPmEeTSbchP1gv42UFV0wGc5y6vYbGg=;
	b=E6WddCHDsnhNwLqg2KnWWyCyeOcNj0xYeFhrwFkzfV/VtxB9V5AladRbOKFAqwlsX8/C75
	70D0nEyGkxSnKXDg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1736958578; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Qz12Wc5P2Lk5yPmEeTSbchP1gv42UFV0wGc5y6vYbGg=;
	b=FU3SIyPAflNHav0Je4qDhCFQpOc5SeTmqX8Y4ACdhFIZXZuUINhYW9zBEVNjYBejrlntXV
	UqiTE3KbhfTm+EoWdVlH50vfIrUIhUuSFztoj/I+Vd5fOIkSP0UCPWX3muAUR5rz1l/6PX
	Q8Sydq8mmuE3E9QnxNWZaZl58996Jq8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1736958578;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Qz12Wc5P2Lk5yPmEeTSbchP1gv42UFV0wGc5y6vYbGg=;
	b=E6WddCHDsnhNwLqg2KnWWyCyeOcNj0xYeFhrwFkzfV/VtxB9V5AladRbOKFAqwlsX8/C75
	70D0nEyGkxSnKXDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9B573139CB;
	Wed, 15 Jan 2025 16:29:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gKb0JHLih2cBHQAAD6G6ig
	(envelope-from <dwagner@suse.de>); Wed, 15 Jan 2025 16:29:38 +0000
Date: Wed, 15 Jan 2025 17:29:34 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-trace-kernel@vger.kernel.org, 
	Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: kprobe not always triggering
Message-ID: <e5d64ac8-5a30-4196-a5e5-b3d2743356b1@flourine.local>
References: <f91a64bf-c5cb-4d36-b50b-67cdcdccdccc@flourine.local>
 <20250115101715.12c6cce3@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250115101715.12c6cce3@gandalf.local.home>
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -4.30
X-Spam-Flag: NO

On Wed, Jan 15, 2025 at 10:17:15AM -0500, Steven Rostedt wrote:
> [ Adding Masami ]
> Is it consistently the same locations being dropped?

Yes, it is very consistent.

> There's been cases of a compiler inlining some functions for the code
> called in the same file. If that happened, then those will likely be
> dropped. That can be tested by adding:
> 
> bool noinline nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
>                 enum nvme_ctrl_state new_state) 
> 
> You would think it shouldn't inline it, but there's nothing in the spec
> that says it can't do so.

This did the trick, now I see the missing state transitions.

> > The system is idle, so I hope it's not just a dropped event. Any ideas
> > what I am doing wrong?
> 
> I don't think it's a dropped event. It's not busy enough. But the compiler
> making a copy of the function (by inlining or what not) can cause something
> like this to happen.

I didn't expect that the compiler does inlining and not inlining at the
same time. Again what learned :)

Thanks,
Daniel
