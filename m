Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB0C315747C
	for <linux-trace-kernel@vger.kernel.org>; Mon,  6 May 2024 17:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715016381; cv=none; b=jtEFB55BFglGtpghwIA7/xOETwC0CJoDMPurqEWfirufk2bnpjJi9wnx80rhdwXGCcBKuG4aurVqtFmbEQiVBuGgNGQxzrStdHjpAO20KrUclnolnqszzCt2IrVb1Ygyi9kN6n7EnnAtGbZ2DTsj+QrvzwzZQeVJPE4fNM9yARU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715016381; c=relaxed/simple;
	bh=GeBm+fiewP8Hp6FtkoqI7u2j4sm8eUwPee92+IiBQsw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HaRXrSHo441FEczeQUwlz5sn9BSSyCL6XqZlwZ8xwj+kGr836YUyrx8Fw7+yXLeuMs/ov9LPNIdcwhqNomb4fv4ZTnOdh8dwcy7IKwOfSY+/+vBqFMRhZtyTVcdCt7i+TNobUzo7DNW0vw/kEPzDRHpbkk8z6FE82HibJOZcA0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=hqWzazoa; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="hqWzazoa"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=gpU1XaagYAB/QpNPVbZIAFBh53jAJkeYizsToKuRKHM=; b=hqWzazoaM5lwgkjK
	Sv3toB7P0AW0RqBYOv3nxDwOEpOsxrBiYxm9sKxsAK7iOCaxaT8A6VvJoPIT3uPxbyfqd0j5muvW2
	nokAvzsOJ99DV64nccStbtWslHSy66Svk8GrcTZOxzfXlyt/1dEfrzQJwlgQB51VxAlyzsuuktNNw
	uJQTtWJzSeWsDT3qc4XixEmJJePPrF3iyrTBukkZWdrTAJhsi165jWcfRLs+q8439Q9vKaw6E73o5
	5XQFFW1aanK8UV1zPgaeBecLYyCNCbZpGhHVkfc1oHB13RHUuBgM1yVNoktHkYNRvGyu+ZvyoAMpu
	779M4fFb2SXWnsxlww==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1s426S-004ybF-0h;
	Mon, 06 May 2024 17:26:16 +0000
Date: Mon, 6 May 2024 17:26:16 +0000
From: "Dr. David Alan Gilbert" <dave@treblig.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-trace-kernel@vger.kernel.org
Subject: Re: ftrace_direct_func_count ?
Message-ID: <ZjkSuOAGH5ml7YiP@gallifrey>
References: <ZjY5np4coyMk4ijJ@gallifrey>
 <20240506132515.11754794@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20240506132515.11754794@gandalf.local.home>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-17-amd64 (x86_64)
X-Uptime: 17:26:00 up 124 days, 20:15,  1 user,  load average: 0.07, 0.02,
 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)

* Steven Rostedt (rostedt@goodmis.org) wrote:
> On Sat, 4 May 2024 13:35:26 +0000
> "Dr. David Alan Gilbert" <dave@treblig.org> wrote:
> 
> > Hi,
> >   I've just posted a patch 'ftrace: Remove unused list 'ftrace_direct_funcs''
> > that clears out some old code, but while at it I noticed the global
> > 'ftrace_direct_func_count'.
> > 
> > As far as I can tell, it's never assigned (or initialised) but it is tested:
> > 
> > kernel/trace/fgraph.c:
> > #ifndef CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS
> >   /*
> >    * Skip graph tracing if the return location is served by direct trampoline,
> >    * since call sequence and return addresses are unpredictable anyway.
> >    * Ex: BPF trampoline may call original function and may skip frame
> >    * depending on type of BPF programs attached.
> >    */
> >   if (ftrace_direct_func_count &&
> >       ftrace_find_rec_direct(ret - MCOUNT_INSN_SIZE))
> >     return -EBUSY;
> > #endif
> > 
> > So I wasn't sure whether it was just safe to nuke that section
> > or whether it really needed fixing?
> 
> Yes, after commit 8788ca164eb4bad ("ftrace: Remove the legacy
> _ftrace_direct API") that variable is no longer used.

OK, thanks, I'll send a follow up patch to my other patch to nuke
this as well.

Dave

> -- Steve
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/
