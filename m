Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E667E111;
	Fri, 22 Nov 2024 20:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732307397; cv=none; b=REE6FEVeDlO3xxvk5wtOWLaRmLGH66LOQp2RZZY+jLeBx4R+vd3Zch3crkbnoCPx1fUY0qInln3BYkIlPcfz12jCgNJK2KdTv6LDnppmKAQx74iIbhF34kfbcMRtpiS73kav+56cyqujBlusbbb5RM/cd4gQPgKtoxZfvuU6DW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732307397; c=relaxed/simple;
	bh=SGHk7dhD2Kp1Mzi2aK/Kf/lHMi6+RRvXpIvuudQ6/lU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qf325Ib9oN3lB1uuHSLFYZ07/jx6Av4C0WdVdmcVQJFCAH0dVEJb3eBjl0+nYUfWIreHJDRJRCUaVPl1GUUZFISFm27gbJlDhW782EmLDAerYDCTmFXIIcmi1jzrmrrHm9cRa6HZcXMu/X9ymljZ3I0jk8JoQOhUvzBAJ3EbEv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gj9+IZu2; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SkC0I2bs; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gj9+IZu2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SkC0I2bs"
Date: Fri, 22 Nov 2024 21:29:52 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1732307394;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SGHk7dhD2Kp1Mzi2aK/Kf/lHMi6+RRvXpIvuudQ6/lU=;
	b=gj9+IZu29a1lo6uhXtrLC0O+lnsTozTLkc4YTVAq/QOj0PP793Y0VpX06cLyYUYccOgwkK
	jhQf4qStLURjfkiyuZ3jKoy0CF0/ki20Q1YiXe+d5O6Q+7fkUz5X5AJP1ZnYsy+JKhryUW
	QjtdxJ2CqGbG1ShjsPRllrBScmDxISjUQL+Vc5j0J1Sk0MM0Z3Dd1+PZ8RQU8AjJQvUR8c
	lirAcR6VH6IV2SwSwtAtQ6asmK015kc8J5YTKCDXw5dX6Ka1NrXhcTqHHvLs67uRdX0wfk
	uFVdSTA6VNUaVKrZDfKgwj0qOFeRkhMRZwllkbJWGEo8hsoEBC/BFKnqEeCqRw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1732307394;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SGHk7dhD2Kp1Mzi2aK/Kf/lHMi6+RRvXpIvuudQ6/lU=;
	b=SkC0I2bsQ3Y4N5jaW4f/uxHP8OQPk41qUW5ygO58lEDkS6TFX9A3PqR7jxzG6xHx7Ka9vX
	UQfHxWNVx4oCFnBw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>, tglx@linutronix.de,
	mingo@kernel.org, juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, ankur.a.arora@oracle.com, efault@gmx.de,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH v3] tracing: Record task flag NEED_RESCHED_LAZY.
Message-ID: <20241122202952.3W3XY_2h@linutronix.de>
References: <20241122173201.tsqK0eeD@linutronix.de>
 <20241122143742.038c77fa@gandalf.local.home>
 <20241122145839.15fc318d@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241122145839.15fc318d@gandalf.local.home>

On 2024-11-22 14:58:39 [-0500], Steven Rostedt wrote:
> Actually, on Monday, can you send me a v4 with this fix?

already done.

> I just realized that this patch depends on both my branch (which I'm still
> waiting for Linus to pull) and the code that is already in Linus's tree.
> Once Linus pulls my branch, I'll apply this on that merge commit. But that
> will not be until next week.

okay. But that one is ready ;)

Sebastian
