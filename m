Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6772024679C;
	Tue,  6 Jan 2026 23:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767742676; cv=none; b=FW9vdBaCBumPyRPWobhCS3EYSIOy8h7sSFrRf2Axgt1AdtpI/DMmxVUonXHK3w1Bnb+LhxFiatQ8rmZ1pCZogvyyZOy+Rmdhjn4ig3c9qc0HOr41lwd/EMAyFgY7Z9u6rGHQnyblqFLGGlE0+pzA77hBNxAhrbnq56qGtRQlf90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767742676; c=relaxed/simple;
	bh=Ao6gSWts5YeN7bKSpvaqV4kYXRslwZ3KmaFiyNJKHWk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J+q31UqKewuT19/I7EmJSn/T3UyNTZJhLKkjixpdao5bRUF6bqHdBqlNkaohnOpvDbkl5ZMF+WNvgquInzzxC/qAVwLbVWCC7FZJDjwNlFhBG7D+b9uaskfu7fANAFAjzzBU3eevV4fdyPWRx7AmxyeuDDbWki10+yrQ1ibQxRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf13.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id D637FC46EE;
	Tue,  6 Jan 2026 23:37:52 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf13.hostedemail.com (Postfix) with ESMTPA id 11F5220011;
	Tue,  6 Jan 2026 23:37:50 +0000 (UTC)
Date: Tue, 6 Jan 2026 18:38:15 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] ftrace: Do not over-allocate ftrace memory
Message-ID: <20260106183815.33fa41f9@gandalf.local.home>
In-Reply-To: <0a9cd12e-6db8-4b41-979e-95f06e9390f6@roeck-us.net>
References: <20260106203533.2896197-1-linux@roeck-us.net>
	<20260106161844.02ab387f@gandalf.local.home>
	<dc80ae8e-54f6-45f0-bf2f-69012c3b47aa@roeck-us.net>
	<0a9cd12e-6db8-4b41-979e-95f06e9390f6@roeck-us.net>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout06
X-Rspamd-Queue-Id: 11F5220011
X-Stat-Signature: pzegrh3hjcxqh6fjcm6b59t7eb3xzpju
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX183DHvSZFmqlzRw3T43cNxiqhNbq8eZuCs=
X-HE-Tag: 1767742670-463286
X-HE-Meta: U2FsdGVkX18QPejJGtt/j/0Y1+XiFr87WMzBwSzqDv0ev+vNSx74yGMhn2+BScLMiPvA0KzqXcNT16GxVtTOK+tVN8AdvqGP1AbkiXJJQVU45zzBjh4Gq6kfDia192BTxhfCvvHURQtAz5FkWn+4SNyYmp9LyzY8decE/0D2IbrTVnXT7KbdZuS2r+UGT+UqHrRHAvLEByrUmEdwulKvTbi4ZdAfbRCcIkPywCn1rlIK8veQts1Pts8Wuw1iHRO+FrekW8ZVXpKDP5iV7FlnjAkZiMdz7jeZ9dPiO4dA2nEeQUOL6bIoJLK6hcxw/+TaJvT32iab9n2sBwp/ogAcWZrlEVPXUIkDREKrk+KiLaQ3gqEEgnWoSLM1kTdrN6aS

On Tue, 6 Jan 2026 15:05:25 -0800
Guenter Roeck <linux@roeck-us.net> wrote:

> > > 	/*
> > > 	 * Use ftrace_number_of_pages to determine how many pages were
> > > 	 * allocated
> > > 	 */
> > > 	pages = ftrace_number_of_pages;
> > > 
> > > 	start_pg = ftrace_allocate_pages(count);
> > > 	if (!start_pg)
> > > 		return -ENOMEM;
> > > 
> > > 	/* ftrace_allocate_pages() increments ftrace_number_of_pages */
> > > 	pages = ftrace_number_of_pages - pages;
> > >   
> > 
> > That might work, assuming that the code updating ftrace_number_of_pages
> > is (mutex) protected. I don't immediately see that, and the
> > "mutex_lock(&ftrace_lock);" right after the above code makes me a bit
> > concerned.
> >   
> 
> One way to avoid the locking problem without potentially risky code changes
> would be to pass a pointer to pages to ftrace_allocate_pages() and to
> ftrace_allocate_records(), and to update it from there. I tested that and
> confirmed that it works.

I was originally going to suggest that, but when looking at the code, I
noticed that these variables could be useful. They are only updated on boot
up, module load, module unload and when module memory is freed.

But looking into the module code, these updates are done outside of the
module_mutex. This means these values need to be converted to atomics as
they are updated without any protection.

Yeah, better to just get the value from passing in a parameter to both
ftrace_allocate_pages() and to ftrace_allocate_records().

Something like:

	unsigend long pages = 0;

	[..]
	start_pg = ftrace_allocate_pages(count, &pages);

[..]
	ftrace_allocate_pages(unsigned long num_to_init, unsigned long *num_pages) {
		[..]
			cnt = ftrace_allocate_records(pg, num_to_init, num_pages);

And have ftrace_allocte_records() have:

	pages = 1 << order;
	*num_pages += pages;
	ftrace_number_of_pages += pages;

And I'll add another patch on top of this to make the variables atomic.

Thanks,

-- Steve
