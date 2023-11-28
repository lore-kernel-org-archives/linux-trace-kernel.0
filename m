Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="FEUGpzRy";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="rz5+lGrW"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27878A7;
	Tue, 28 Nov 2023 00:47:03 -0800 (PST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B1D312196E;
	Tue, 28 Nov 2023 08:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1701161221; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mAPSrIdxMutGqOgHy9I5KLLkgBk3CDdDoYEnmVJ1EvI=;
	b=FEUGpzRyu91W+4DUyreQTfLkK+XD/iQpmpFMYF0FhmVAYY7/4MdbR0Zo+JJUSh8NYmsjPc
	GWq8vmJEe9HsqJImDK0s3f4BtH88lEwXPCyBBnxlANejfs1GWVOxRg2HfBBfu46ctN8Ejo
	Ki+LXFVg/hz55HboRRG0z5TNYdPeb9M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1701161221;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mAPSrIdxMutGqOgHy9I5KLLkgBk3CDdDoYEnmVJ1EvI=;
	b=rz5+lGrWzTmWLBcOncceK7BEolS0FQu3CVgPMl9O6gAJTTsQrzGP2GzcdonOmDXSBnFIId
	iFEYM6iRohBLUBBg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 9EB2F139FC;
	Tue, 28 Nov 2023 08:47:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id ur1KJQWpZWVKRQAAn2gu4w
	(envelope-from <dwagner@suse.de>); Tue, 28 Nov 2023 08:47:01 +0000
Date: Tue, 28 Nov 2023 09:49:14 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	dmaluka@google.com, Sean Paul <seanpaul@chromium.org>, Arun Easi <aeasi@marvell.com>
Subject: Re: [RFC][PATCH] tracing: Allow creating instances with specified
 system events
Message-ID: <o7zzg7i5jpso2x5rp3mawsjja3j52lomqyx2k2jgp54nrtf4gc@qhqv2ubkvubf>
References: <20231127174108.3c331c9c@gandalf.local.home>
 <20231127175021.0c0edc53@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231127175021.0c0edc53@gandalf.local.home>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -0.60
X-Spamd-Result: default: False [-0.60 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCPT_COUNT_SEVEN(0.00)[9];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[19.90%]

On Mon, Nov 27, 2023 at 05:50:21PM -0500, Steven Rostedt wrote:
> On Mon, 27 Nov 2023 17:41:08 -0500
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> > 
> > A trace instance may only need to enable specific events. As the eventfs
> > directory of an instance currently creates all events which adds overhead,
> > allow internal instances to be created with just the events in systems
> > that they care about. This currently only deals with systems and not
> > individual events, but this should bring down the overhead of creating
> > instances for specific use cases quite bit.
> 
> This change log is not very good. I didn't actually state what was done :-p
> 
> Anyway, function trace_array_get_by_name() has an added parameter "systems"
> (and I forgot to update its kerneldoc). This parameter is a string of
> comma, or space, or commas and spaces deliminators of event system names.
> If it's not NULL, then it will only create the event system directories of
> those event systems that match the systems parameter.
> 
> That is:
> 
>  trace_array_get_by_name("qla2xxx", "qla");
> 
> Will create an instance called "qla2xxx" and only have "qla" system events
> in it.

Makes sense to me. The qla2xxx driver is interested only in its own
trace events. This should be fine, at least as far I understand it.
