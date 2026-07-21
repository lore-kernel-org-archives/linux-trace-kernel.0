Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C273793CA;
	Tue, 21 Jul 2026 14:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784643191; cv=none; b=VXHKkvJ7FbVhHfNBftOFsXfVkOQUchBpz+AoeqB2kHaaPbzVxbsk8feACT5eJL6Fybjg6V+dEj9KPQY+d2H9Dk0pKbLM0EabWayHDC5ApY34yF5tiwDPWzdozI5/Y/FR3UXmkH0uIKBArwwniAUflt9IlreBOtf2OzdSreOoGDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784643191; c=relaxed/simple;
	bh=SXSa4OnWw2PLbvVMk0Gig3k44XVGPk5THDuSeqAebaM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fSvAIetPWO5poBmaon2NvdZdjQlp0jKnVTeyl2fLeyzAUcZtD8R5D8fBs4Ork6kP+lFKDjbHzfhdfUBr8UsCjKlgZByKBJaBBgBlU4H1nfhYTPkz/56/jb2lorX6ZW5GchYzPtiwmw7ZEwlvlQEYXZX1lu74W7guc2LGhGk/aBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=odTLRGoO; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lGmiQdT8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="odTLRGoO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lGmiQdT8"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1784643188;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SXSa4OnWw2PLbvVMk0Gig3k44XVGPk5THDuSeqAebaM=;
	b=odTLRGoODer/w7NGAotNdUAM3rD+HwUxYi/6PsdoiZ+3sbeKedRzbtYG26T7Hitc6X3keU
	3kuJqnKPD+fb3rl7EkDU9kcClwS6DO+X/KIwQtAPNPd2DdsQPR31wCRzJnjFmCtR1TSJzI
	dg5rD8hFJRXQYnV5BjEl7CP4OUkr7AEAOAgkMaxGntBlh0iBXSLbjNAIfBonLno50FG6uX
	cEMIxsZOIDL+KvPStlRcI29nXVHM+LDB2nHv2Rmmj2RFa7siyOtilnCcE9X2/ygApQ08CF
	4xGmbSDcwnl7Bs0ipVjLcT/vMwm/qXFPeVGWPXdP62J7Y07pkPTq2z1gx584ng==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1784643188;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SXSa4OnWw2PLbvVMk0Gig3k44XVGPk5THDuSeqAebaM=;
	b=lGmiQdT8MuGVqHbju8Cc2Xhw3CAciOUDftU+heP2d+KOFI/K0uEhcSyuP0Bo1jcmEnBdo9
	UCHJMzKLnbFqDYDg==
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Wander Lairson Costa
 <wander@redhat.com>, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 09/13] verification/rvgen: Delete __parse_constraint()
In-Reply-To: <2b19681b46b6bb5b64f1686c1ffa642a7bcef2a0.camel@redhat.com>
References: <cover.1781847583.git.namcao@linutronix.de>
 <b22a5a3822fe53afb8e2cf1df623a0e4c9ed5f49.1781847583.git.namcao@linutronix.de>
 <5bd5c857c5130dd7b122112c69baf793bcf45090.camel@redhat.com>
 <87ik69evgy.fsf@yellow.woof>
 <2b19681b46b6bb5b64f1686c1ffa642a7bcef2a0.camel@redhat.com>
Date: Tue, 21 Jul 2026 16:12:56 +0200
Message-ID: <877bmoxwgn.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Gabriele Monaco <gmonaco@redhat.com> writes:
> Right good point, this is the branch I'm going to use to to send a pull request
> to Steve:
>
> https://web.git.kernel.org/pub/scm/linux/kernel/git/gmonaco/linux.git/commit/?h=for-steve

Nice!

> I don't have direct access to linux-next and I was planning to wait for my
> testing series to avoid sending Steve 2 pull requests in about a week. Unless
> there's something terribly wrong in that series, I think it's not going to take
> too long until they all land on next.
>
> What do you think?

I didn't know you can't include your tree in linux-next. That would be
nice. But well, it is still fine as is.

Nam
