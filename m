Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF25C4C6EE5;
	Thu,  2 Jul 2026 14:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783001394; cv=none; b=fZAjJUSOWDgJuHmMUrmXFclJFBfRstLJ5tz+22aYIe7sT6IoxPCjRyoGknnGIpINVHC8gefwuqtYAvru+HcIvvNFBSLOP4E8j+N5zfX8BtESiaClUVBX3cyJd8cJuBVOHBf0jToKBlUUNu1veEBMoVPCD0U/M5NO4sTlZOjmcMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783001394; c=relaxed/simple;
	bh=O9nxlUH6NRA41nYORQ6zmZ2rr17x6eEG7HnEfovJ+ko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mHxPC0UqdXvKSjeewqhf7yr9xhH+M9d3PvkF/949uS6ENyp4/j4Sj7svrKySG9BZUDNWEahy1vWswsLwkuqtvbYmPzUzOqPDkVCNIp00wXoj8jWJd8fcK3W2vGtfJSY8m4dR1PK2d+F15gUXiXENkfZdwXD4KNqlutYMJQa4OLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EuCM7XTN; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nRaMlxht; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EuCM7XTN";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nRaMlxht"
Date: Thu, 2 Jul 2026 16:09:51 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1783001391;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=abEb/BJRC84S2lHm5WUc1/jjlaw1vg7w4WO5HZJqwSw=;
	b=EuCM7XTNTmAUeNaciuwwfCN1hZpizX+zNBxfCsOyedC+aqXAx4C+Prpc+Pj7FmOCbxGVI1
	2TzSJs4/wyKJZjne424kh4ZkzJ3sdmGYlLVCm11DqotEKxE7zLURDfsEPL67bfy+TON5R5
	vWJk65ATLFbCDpm5DOFyPBQYe82K2mfQk7Tm+x9rUWzPi+IREyEOWW2ECkTnjbKkgHCF8v
	gGTauewtV7NoD41owmtauB++SDN6XFyEWoq7ye6Bfufenp/a/uyjNJcMuGf5pq1wlhPGU/
	AQ8qfjewBmY3W5zApgDyDkOaz8VFLkydCUDE6/Tgh/eyNI9wSkHEvnc5cfOjxA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1783001391;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=abEb/BJRC84S2lHm5WUc1/jjlaw1vg7w4WO5HZJqwSw=;
	b=nRaMlxhtWT0L5ARNzyzDZ01y3TQGw9U0oBoOE616S1UbOVYkqESp09IF3jCo+GmvXr0s75
	/576yRRVVbhbJhBw==
From: Thomas Weissschuh <thomas.weissschuh@linutronix.de>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Nam Cao <namcao@linutronix.de>, linux-trace-kernel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, 
	Tomas Glozar <tglozar@redhat.com>, John Kacur <jkacur@redhat.com>, Wen Yang <wen.yang@linux.dev>
Subject: Re: [PATCH v3 03/17] verification/rvgen: Improve rv_dir discovery in
 RVGenerator
Message-ID: <20260702160816-f9cee37a-cce4-4bea-9533-f7e281ff8fe2@linutronix.de>
References: <20260625121440.116317-1-gmonaco@redhat.com>
 <20260625121440.116317-4-gmonaco@redhat.com>
 <87y0ftijkw.fsf@yellow.woof>
 <4dc81b777bb8daaf4687c0d9db7ce740abd0a825.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4dc81b777bb8daaf4687c0d9db7ce740abd0a825.camel@redhat.com>

On Thu, Jul 02, 2026 at 04:01:21PM +0200, Gabriele Monaco wrote:
> On Thu, 2026-07-02 at 15:53 +0200, Nam Cao wrote:
> > Gabriele Monaco <gmonaco@redhat.com> writes:
> > > The RVGenerator class can find the RV directory (kernel/trace/rv) in the
> > > kernel tree to do some auto patching. This works by assuming PWD is
> > > either the kernel tree or tools/verification, which isn't always the
> > > case (e.g. when running from selftests).
> > > 
> > > Make discovery more robust by relying on the absolute path of the
> > > current script and traversing backwards the right number of times.
> > > This should work from any location if rvgen is in the kernel tree.
> > 
> > Agree.
> > 
> > > +        # find the kernel tree root relative to this file's location
> > > +        current_dir = os.path.dirname(os.path.abspath(__file__))
> > > +        kernel_root = os.path.abspath(os.path.join(current_dir,
> > > "../../../.."))
> > 
> > 
> > The  "../../../.." makes me sad.
> > 
> > We can find the git project root instead. For example:
> > 
> > def getGitRoot():
> >     return subprocess.Popen(['git', 'rev-parse', '--show-toplevel'],
> > stdout=subprocess.PIPE).communicate()[0].rstrip().decode('utf-8')
> > 
> > (stolen from
> > https://stackoverflow.com/questions/22081209/find-the-root-of-the-git-repository-where-the-file-lives
> > )
> > 
> > But that's not important, up to you.
> 
> Mmh good point, but what if we're running from a tarball?
> 
> I could still fall back to something that uses directory parents (maybe
> something arguably nicer like
> 
>   os.path.join(current_dir, *([".."] * 4))
> 
> But that may not be more readable..

current_dir = pathlib.Path(__file__).abspath()
kernel_root = current_dir.parents[4]

pathlib is generally nicer than os.path.


Thomas
