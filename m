Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B782F0E40;
	Wed, 16 Jul 2025 09:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752656565; cv=none; b=EwX/Tzo7P8ibBtu2f+H11VYtUGzAldDkcn+8sf0sA1xtXRhpPQBfnoY6AwGpgQnBmSpLgmauCohbON/qdO/z4zEVk3OwuKdhFrkBM+wFVfFxrRtuSJJy7znSZOHWSbeJzoJYC6Shs7CpYdMYpbaAGoItHPUQmylh+SgV5BUeKcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752656565; c=relaxed/simple;
	bh=/0PfMbumNAsfChajc9mgwsYf0L1/3DMCYxgGQVts91w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rBilvowDIT90Q13gkUgDNH5nqpTUVGc8kYA/TcpU6mDKawPxK0uNA3h69PKO8dnV2JOQiga4FLP8czOJxuyPJWtmTPbpUeWDTDFNwYgPidTyZ25PI98RhzWAQMXgEdHcnj82TLlR7sJ3tHQA8xdv1Ptunlvw5rsPKNKHQ8h1CfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Gl8dgrN1; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=i4oDevIE; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Gl8dgrN1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="i4oDevIE"
Date: Wed, 16 Jul 2025 11:02:40 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752656562;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LefaMQdcauIZipAnc8MzRC5S+mCYs3SiWJQQzgsufic=;
	b=Gl8dgrN1WVT/bJJjW2FYsh0+y1V4vwcNO8P2pbPdvp4yS6iCAvgKkhqKoGbUTjnu9/W3+N
	MK7nz+IQFLh+ZcavmK6MznMhvK5KpdqfA88MBnQ56jvJJSlIcXZA9V+dSs6sagQJdEve/1
	0bRgwA9+G1rk17pLBe2FmCUqhxtgoKo0IqJzVBj9u+V5LJK/PElh9b/Nfm80xxek+VhjFA
	A1Csj51uAmF3wfeUN3G8M22Sd9KIQUWQ/utD3M/KtYtOk5ZfeMv6EJel6YASdPBgc3NchS
	qoSy6lhKk2yVIQiQvUAq8D8Ie8p7dXo45PJndhmoIVvKuFvYxVg0mXglnI2xAQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752656562;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LefaMQdcauIZipAnc8MzRC5S+mCYs3SiWJQQzgsufic=;
	b=i4oDevIEI+4V11wZBqWyZ27066LYlNA6OjJiYWjyAstD4JiH3sHuEGopjAqrzJI1/gFU/X
	BBVrOLPduBANksAg==
From: Nam Cao <namcao@linutronix.de>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
	linux-trace-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Tomas Glozar <tglozar@redhat.com>, Juri Lelli <jlelli@redhat.com>,
	Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH v3 11/17] rv: Retry when da monitor detects race
 conditions
Message-ID: <20250716090240.PHfqyEfL@linutronix.de>
References: <20250715071434.22508-1-gmonaco@redhat.com>
 <20250715071434.22508-12-gmonaco@redhat.com>
 <20250715152322.Os4lDq_B@linutronix.de>
 <e2f4f8d372612cd61689b91562e73677599d08de.camel@redhat.com>
 <20250716082712.L9z_ptHK@linutronix.de>
 <f7028488e9d820848955de87ead3ec619fe5dbec.camel@redhat.com>
 <20250716084520._QLbd5AY@linutronix.de>
 <37bc7ab78b03f4e794a5466d9cc0a1e187e1ae72.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <37bc7ab78b03f4e794a5466d9cc0a1e187e1ae72.camel@redhat.com>

On Wed, Jul 16, 2025 at 10:59:44AM +0200, Gabriele Monaco wrote:
> On Wed, 2025-07-16 at 10:45 +0200, Nam Cao wrote:
> > On Wed, Jul 16, 2025 at 10:38:11AM +0200, Gabriele Monaco wrote:
> > > Yes you can, but I wouldn't do so silently.
> > 
> > Why not? The absolute worst that we get, is the rare case where a bug
> > appears at the exact same time. In that case, we would get a false
> > negative.
> > 
> > And I think that is really really rare.
> 
> Well, we wouldn't even know how rare it is because we don't track it!
> 
> It may be a harmless note but might also be a design flaw in the
> monitor, so it should be possible to understand when it happens.

Oh, so you just want to track when this happens, as a RV developer. That
makes sense.

Just make sure it won't confuse other people who use the monitors to test
the kernel.

Best regards,
Nam
