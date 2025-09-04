Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1943E15B0EC
	for <linux-trace-kernel@vger.kernel.org>; Thu,  4 Sep 2025 07:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756970375; cv=none; b=XPj8aRdDQcrBiib8nFkSsHItUi+FmEGQbW1ZVGb1jNhU8BypK+7NFvpB1it6AeCoV/YmJ0hkD7jp4xtyk2aq7C6bJEFDEATclOQC7Y4rzliTKua7wzeiQBYg3q09/obe/xBoobF+JitEQ3k06esdKXX5ZukBFuTkuJ4PS3k3+7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756970375; c=relaxed/simple;
	bh=1MuIm2iXg2+Prniqe7oHDTCViDB+Q/SfwVYOVigBcvo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WYdkwFGEOpwvDkKZ9s+fXrGQ1BaaOwSKT6bLLWGJVfLuztnjbSmY46vZ+EhPU2YdvCxhZD8VgUb1rY6o1A+qVwl4FoLKpEMdUeESvQhzgajugXuMaDdGTrwrp43tDurOfm7uhBsOssH73V6kOiiu/tJnpgUCroGw26DN8AVcIqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tVoOG4fA; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=p837XktR; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tVoOG4fA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="p837XktR"
Date: Thu, 4 Sep 2025 09:19:27 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756970369;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QXnphlLeKEHPSnqUEb3kK6Y1ERQEKmd2XWYV19FTIrI=;
	b=tVoOG4fAzGY9XnSjc6hoBLWKTEL4yS5xpLuFGH8mnYA1M0dUoBGOLS2eoSZoWT4tk0/aIP
	LvzXnIZJ5TIbtoT/Y5osBjkIoIeX/ikpAUIECsVRLJtbxdcy9uSurQwNfvCxeaxjrURnF9
	2yoTTYlxGRVof8m29AbtZDNAGU7RRnQQG5MZ5HsAcM6sqqSIPZ5tejKUSB8/0JOfash1gQ
	W6QexKnk4dw/9jl/ZHQioPbiPyYiFScS1lF8iR0Ph0VLrwn5Tcw+8Nb8YF5F56KQSjdxBI
	ZI+eUp5EXFHl0T52pHEWEWKRrFMTl5eGuMZ4+qTPo2+x1eZHDN01mTs1MNKzLg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756970369;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QXnphlLeKEHPSnqUEb3kK6Y1ERQEKmd2XWYV19FTIrI=;
	b=p837XktRwEZYz857TBIvr2WGUY8W0XCW9pI9Wq+nz4acdYqoBfcyBpuanyAfdDOU65yjmF
	SIy4WnO0PLB5PeDA==
From: Nam Cao <namcao@linutronix.de>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Zhen Ni <zhen.ni@easystack.cn>, linux-trace-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>, mhiramat@kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] rv: Fix missing mutex unlock in rv_register_monitor()
Message-ID: <20250904071927.m3sY5lso@linutronix.de>
References: <20250903065112.1878330-1-zhen.ni@easystack.cn>
 <8fa89db22320220e1bc411ded115f0a40097f961.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8fa89db22320220e1bc411ded115f0a40097f961.camel@redhat.com>

On Thu, Sep 04, 2025 at 09:07:38AM +0200, Gabriele Monaco wrote:
> On Wed, 2025-09-03 at 14:51 +0800, Zhen Ni wrote:
> > If create_monitor_dir() fails, the function returns directly without
> > releasing rv_interface_lock. This leaves the mutex locked and causes
> > subsequent monitor registration attempts to deadlock.
> > 
> > Fix it by making the error path jump to out_unlock, ensuring that the
> > mutex is always released before returning.
> > 
> > Fixes: 24cbfe18d55a ("rv: Merge struct rv_monitor_def into struct
> > rv_monitor")
> > Signed-off-by: Zhen Ni <zhen.ni@easystack.cn>
> 
> Good catch, thank you!
> 
> Reviewed-by: Gabriele Monaco <gmonaco@redhat.com>
> 
> I would also add a:
> 
> Fixes: 24cbfe18d55a ("rv: Merge struct rv_monitor_def into struct rv_monitor")

Am I hallucinating, or the fix tag is already there?

> (Adding Nam to the loop, as author of that patch)

Thanks for CC!

Reviewed-by: Nam Cao <namcao@linutronix.de>

I have been debating whether we should convert rv to use lock guard.
Problem like this one is a good advocate.

Nam
