Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D253B2D0C7B;
	Thu,  2 Jul 2026 14:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783000837; cv=none; b=PZCOoFke6SSktRRl5CxcycuVXZsM67dMp8mVu6aq2zNy0lghbWLJt3WFt+xFCkNoP8va+GnhNDr7srNR8RqoW/3G51fq//KKxnLI7ARkSNWt8ZRvrlGrrVzpHqXLCvo4yE5IlyjuTQWdjU3kvUJ/2opSBfHCzoHX+XOY8Z3zFso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783000837; c=relaxed/simple;
	bh=piD5E/PMTcu0sSWVmeyLtKcUF2i/dcLJ7gKqSgoZvoY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V2weyFM++CUGXWC0N5yrJdhtagASjhaBg/a/WrETLs2gDcYBrn2mdy3CgKpjN17Cboh0NcCXMWXJ0KtpZ0Zjur2Hg3kfdfFPxE45V/WQB+OBlq1uwlwPT97wZSgE61+pWB/GNx7InNTU3I3mjc9k6YGmwvxQ1P4nZQGfjjtSOKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aiMpGp31; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ayfsj7VV; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aiMpGp31";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ayfsj7VV"
Date: Thu, 2 Jul 2026 16:00:27 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1783000832;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EuOcNiBA9kIHQom+t9U4CN4J3rXd4xxXtK6J3KnKndo=;
	b=aiMpGp31PFc2QfwzD4Jb3xmgR0NFfZNU73NHxq4je+ev5ZmhfTp48nDen+X+IihkAWErA+
	8vf08qvCQf3fIcV6BMZCRxjKMIotZIsrPMgu7TCgbQQsEu+Zu5cRW9TAP9CLlYH4tTLvYD
	sVm9QwgcBa21hns2seWBUXBhfMXFlM4oAPXKMzU9XBkAMqj0MkUUfeIDMcP4d0wjzI8M/q
	TR/il22DP0xmI68t3mwhdrbq0WdA0AKNvASc+D6kvjZvmI7B1hmLIQraAs7TTIdwTj6Mrg
	Bw1wzN7j5RuY+ziCtG+RvdEHCKOQUDahz8cmBj8KESnIWYV1cjp54/cEKidO7Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1783000832;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EuOcNiBA9kIHQom+t9U4CN4J3rXd4xxXtK6J3KnKndo=;
	b=ayfsj7VVHtf1/Aj+w1A00vmX3BCnIe1LONCvKYpQlZDVq9OghZAeWiibwnWW4fUfIHORkq
	5QDgLR/Q2LAlNdBA==
From: Thomas Weissschuh <thomas.weissschuh@linutronix.de>
To: Nam Cao <namcao@linutronix.de>
Cc: Gabriele Monaco <gmonaco@redhat.com>, 
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Steven Rostedt <rostedt@goodmis.org>, Tomas Glozar <tglozar@redhat.com>, 
	John Kacur <jkacur@redhat.com>, Wen Yang <wen.yang@linux.dev>
Subject: Re: [PATCH v3 03/17] verification/rvgen: Improve rv_dir discovery in
 RVGenerator
Message-ID: <20260702155849-0a911b5a-20ca-48be-a606-ab5f9bffa551@linutronix.de>
References: <20260625121440.116317-1-gmonaco@redhat.com>
 <20260625121440.116317-4-gmonaco@redhat.com>
 <87y0ftijkw.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87y0ftijkw.fsf@yellow.woof>

On Thu, Jul 02, 2026 at 03:53:35PM +0200, Nam Cao wrote:
> Gabriele Monaco <gmonaco@redhat.com> writes:
> > The RVGenerator class can find the RV directory (kernel/trace/rv) in the
> > kernel tree to do some auto patching. This works by assuming PWD is
> > either the kernel tree or tools/verification, which isn't always the
> > case (e.g. when running from selftests).
> >
> > Make discovery more robust by relying on the absolute path of the
> > current script and traversing backwards the right number of times.
> > This should work from any location if rvgen is in the kernel tree.
> 
> Agree.
> 
> > +        # find the kernel tree root relative to this file's location
> > +        current_dir = os.path.dirname(os.path.abspath(__file__))
> > +        kernel_root = os.path.abspath(os.path.join(current_dir, "../../../.."))
> 
> 
> The  "../../../.." makes me sad.
> 
> We can find the git project root instead. For example:
> 
> def getGitRoot():
>     return subprocess.Popen(['git', 'rev-parse', '--show-toplevel'], stdout=subprocess.PIPE).communicate()[0].rstrip().decode('utf-8')
> 
> (stolen from https://stackoverflow.com/questions/22081209/find-the-root-of-the-git-repository-where-the-file-lives)
> 
> But that's not important, up to you.

Relying on git is problematic as the git directory might be missing.
People might use the sources from a tarball or use funky container setups.


Thomas
