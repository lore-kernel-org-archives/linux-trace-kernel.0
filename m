Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0FDD21B191;
	Tue, 22 Jul 2025 08:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753172865; cv=none; b=Hs+fFpFVhebu2M2UH0/hZMADCGMujxOBE4UbC5xcvlybMoPhqoyYNErw/PqdcYPPUCMKeno3GIJP5XL+GUVbxZSTJblASq2kLFmwr3gxv+TEvcYcW1I6+e3kTLm/kDdZ+IIcOrNlc5M7fOdbrd/8GbwxcnU47/s+YFYDYGkVP/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753172865; c=relaxed/simple;
	bh=uJt42FEYyOPDVYWHeoObVF7KyZy+Rhx4cUnr/zrSZT0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NQR+RYoHd7rS8HByGgpRMrSw6dICtC8Jxk/T/CKW6CkEyuf/XIz8xAbuShxrdNH3lb04CGMh1DqBXo+L0qpKPf3mDIqmUa+dkIGUprLoe/8FEh8VrCtLa0kzQEWrmTGeB8nEHIvV+um6dkc2pVd1X+siMHyq0vewhpUwj4AooNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iDyzCr+m; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IvewGc8a; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iDyzCr+m";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IvewGc8a"
Date: Tue, 22 Jul 2025 10:27:40 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1753172861;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uJt42FEYyOPDVYWHeoObVF7KyZy+Rhx4cUnr/zrSZT0=;
	b=iDyzCr+mXdSoYZBvbOBHFsRS6RAOS4nNC60NPuHQmr5ZxDpvoilKzjJQFqpx9MoLWfVHIw
	gaPcHwzle+SzLEaAUv6LmD4iKLYKRbY5AJDLXz8IZOd3cN31syFbdGwxaOIJGP2FTE35Kx
	fsLRiHrEn3ieTscp03fgbjQ1ybeBVZhHqpLS7qgtvZ8V9cjNSTQZlKvyhdlW4mluJ9XcVm
	UsZFTMaFyAT/zsKJoU1ibk43kUUeGMMo2hUusEWpI2rSzlIMSLBbpBwwnUcxRa2GoOwSey
	OvgbIuMg5S8gB941a7Iux9EE41+IId21T4SX8IKlsI6AExdlIzkt2gJlg5IJ3Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1753172861;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uJt42FEYyOPDVYWHeoObVF7KyZy+Rhx4cUnr/zrSZT0=;
	b=IvewGc8arpdd0qX9eVaNLcm47F0PxTibK3PP613ix68bH9cqwja9mWsEbsgjD/nkiZTfNw
	a8ccsSydkXqSnzBg==
From: Nam Cao <namcao@linutronix.de>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/6] rv: Remove rv_reactor's reference counter
Message-ID: <20250722082740.a0kYzRv_@linutronix.de>
References: <cover.1753091084.git.namcao@linutronix.de>
 <4ebe4d49e07890eadae41da233e111f8723fba12.1753091084.git.namcao@linutronix.de>
 <2de814842fbbeee888e076db2f80bf2028fdbb0d.camel@redhat.com>
 <20250721140425.OeD16I4D@linutronix.de>
 <eabfae8b0f29c88437cc51af21797e869d99aef6.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eabfae8b0f29c88437cc51af21797e869d99aef6.camel@redhat.com>

On Mon, Jul 21, 2025 at 05:49:02PM +0200, Gabriele Monaco wrote:
> Yeah I get your point. If I understand you correctly, what's broken is
> that we just return EBUSY and ignore that on __exit instead of doing
> something about it (set nop to all monitors using this reactor).

Yeah, EBUSY is ignored.

> I wonder if we shouldn't also fix this (using the module refcount).
> But that can be done in the future, I'm not even sure reactors as
> modules currently work.

Yes, let's worry about it when we allow building reactors as modules.

> Also, I'd need to verify this but depending on the order of exit
> functions, we might be seeing the same problems with built-in reactors
> when active on shutdown. I'm going to play a bit with this and see if
> this workaround of not deleting the reactor was introduced for that (I
> doubt though).

I'm not sure I follow. exit functions are never called for built-in
reactors. They are even discarded out of the built image.

Nam
