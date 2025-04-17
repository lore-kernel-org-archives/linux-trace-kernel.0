Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E363C1DE2DB;
	Thu, 17 Apr 2025 05:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744868555; cv=none; b=BUUkKvv7rcDYb0qggwbmBf6ZOdEisaMMS2r8KvaliAZM4uvAtARSJZ59y8iGRS6NMbyr8pgseRWgZIReINvgUdAIDq7ve3SMQa4/TqapOicdYQ/qTrEQdRNKq/wOiZgTxU6pDHXxC5KRTYzNJKx7mlxPmscVdPHtYnP4ns3+qOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744868555; c=relaxed/simple;
	bh=VdQb6IRmYJ6SmHypJkX+d7rS/wBDlH/MG+oC2rhXsTk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KjRGaV8+jV/mjGbtyG1vuUC5RhTLKtzxQ0dp4tM64MqCBFLqMWU6YkGizjpXwugeco0MNfOZDCnnq4UXPRjdkLWzEvu1Vf9t9quKjPVn12CyA/SWGhvPNw///Cj0POQizfJAnsTCN+zgz05EY/Lf9ybposBKrqjGOMyZhQBJElY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=btMWYgKn; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Fj7waKfB; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="btMWYgKn";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Fj7waKfB"
Date: Thu, 17 Apr 2025 07:42:20 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744868546;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=g8njsPKCjIHIKwSLd0/crxihlFEZBxm3kDfkalCi8mc=;
	b=btMWYgKnhXIWpbPu4UMcJWnqCVel1kdeLpSpxVT2PEQskteowMfil2Gx2aHwOK5HCniyf7
	tyubT3JlmspfldzCBD8wtINaigoKizi0bahIocCUluinEO7HJEEYXCI9/+mcgMQJWI1mW+
	4igvcz0Ay19hE/eQGhgelrkR/b1kvZ6emaWAqY1ogi9EedzR1rYtMj6FbuX7kLOHxD042Q
	a4OX2QPrtgtlq+wXXDYY9CdMfvh+aI7+bp2Km9kQl2T0lJep6lL1ceTjtXxeoGSY9V5BJH
	9FKggfELOEvPEKcS7EgZBKAkHNnVEXqn4mXLIRmpffNxfboIuhws50KpHFKiug==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744868546;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=g8njsPKCjIHIKwSLd0/crxihlFEZBxm3kDfkalCi8mc=;
	b=Fj7waKfBQxOHvPzTsj6lL2+rcXsYVkaoBi7qc5BiT9syEq2z7yFG2wEsfyRaJQYR58c1BU
	Kj6H6/jMns30gKAg==
From: Nam Cao <namcao@linutronix.de>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
	john.ogness@linutronix.de
Subject: Re: [PATCH v3 14/22] rv: Add rtapp container monitor
Message-ID: <20250417054220.x_NLyn_L@linutronix.de>
References: <cover.1744785335.git.namcao@linutronix.de>
 <7d1a7337879b991ed454d1457d44a15dabc4b3f7.1744785335.git.namcao@linutronix.de>
 <0a41e42243d2c102b159bed4b231f143bda02243.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0a41e42243d2c102b159bed4b231f143bda02243.camel@redhat.com>

On Wed, Apr 16, 2025 at 09:32:43AM +0200, Gabriele Monaco wrote:
> On Wed, 2025-04-16 at 08:51 +0200, Nam Cao wrote:
> > diff --git a/kernel/trace/rv/monitors/rtapp/Kconfig
> > b/kernel/trace/rv/monitors/rtapp/Kconfig
> > new file mode 100644
> > index 000000000000..94689d66a79c
> > --- /dev/null
> > +++ b/kernel/trace/rv/monitors/rtapp/Kconfig
> > @@ -0,0 +1,6 @@
> > +config RV_MON_RTAPP
> > +	depends on RV
> 	depends on RV_PER_TASK_MONITORS >= 2
> 
> Not sure we want to be that picky, but what about making sure we can
> run the monitor in its entirety?

That makes sense. But CONFIG_RV_PER_TASK_MONITORS doesn't exist yet at this
point. I will add this in the commit adding CONFIG_RV_PER_TASK_MONITORS.

> Ignore this if your use case doesn't expect both monitors to be run
> together.
> 
> Other than that
> Reviewed-by: Gabriele Monaco <gmonaco@redhat.com>

Thanks!
Nam
