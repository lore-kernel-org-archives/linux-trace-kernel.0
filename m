Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA2861EF1D;
	Fri,  9 May 2025 15:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746804210; cv=none; b=G3Did6YFLLWl/2j9S4d8CBb1XcUD3h/CT9O6cuTcMI5jnVGRgCDPMhaBp1kR7/lAIQQV/IilPJv41t72F8xCzlNHZq0nb6fVZY+KRuEdxMX0wjDd/QIcKWxl23QOx7znTLZt8/WcOuOXidP8JXiM2slkXBGY58+zsW7k+rBdEuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746804210; c=relaxed/simple;
	bh=Gsm7maKqBiGEkB4CMrW8kR92MF+qpAT+l9JBsjjJEi8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dzEGtUgRk9AA+2wmLQ6HQRvgyplGdl0HcmjOhGucAktCijbqVQSfSQFj3XRdjq3NwBSZl0HKPjokvSbTa9Q7WM5ShuLmp8fjDybY/Esj4l9FpV4ItxoYi7EF1BYfMWJHXbdz8b3ljYW/q0/y37xal9Qrm2x+LAWLTbRDh9C5J7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=E9a1ruxU; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=X75/8YF0; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="E9a1ruxU";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="X75/8YF0"
Date: Fri, 9 May 2025 17:23:21 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746804206;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ztJasIoBDJWEIKfzfzMyjc+QbQB0gz4/ludEgLczczU=;
	b=E9a1ruxU3+LfR45oiR+UTe1jARe961mB4jU3IqmC37Y/Lt3KLBVgZg4ive3LPO+spUq/Xz
	INuV5+X69oOlHxGir01XGnhp03tOzLEDi6iSGrdhR6ILPaPm98qq+zFnvqKpACgqJLyiRB
	fo5nkotsoy1mGzJX1Sphmze3KeqrwNDct9qL+AV7hbvG2cTWU1kcNgP0iUrKJRbRbvKi7Y
	OG/NIYj/YvmgwPLa0g1++T9gkKp+8L/J2qWE7lLu7dwyKuMKBPstuTDqjxyNzZpB8ZPYOp
	cItnCk4JUIz2Daax+0lY447v6qLTBw5kkAB9S0S5B9apbrDU8TKY9rB25nAKow==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746804206;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ztJasIoBDJWEIKfzfzMyjc+QbQB0gz4/ludEgLczczU=;
	b=X75/8YF0OEs4v9F6foa88dGP8RIHr5p/v37BC88SUVCUBGk6avIUSESrZxd4m3xPWsz9V5
	jrcjqIZPGb/7p9DQ==
From: Nam Cao <namcao@linutronix.de>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: john.ogness@linutronix.de, Steven Rostedt <rostedt@goodmis.org>,
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 13/22] rv: Add support for LTL monitors
Message-ID: <20250509152321.zsiacCwk@linutronix.de>
References: <cover.1746776116.git.namcao@linutronix.de>
 <4a992489b5bebd8558dc42eeef0bd998686a42b4.1746776116.git.namcao@linutronix.de>
 <817f3cb62b2632286e5c6fffde3163592a110eee.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <817f3cb62b2632286e5c6fffde3163592a110eee.camel@redhat.com>

On Fri, May 09, 2025 at 04:50:29PM +0200, Gabriele Monaco wrote:
> On Fri, 2025-05-09 at 10:12 +0200, Nam Cao wrote:
> > +    def negate(self):
> > +        # ![]F == <>(!F)
> > +        return EventuallyOp(self.left,
> > self.right.negate()).normalize()
> 
> Shouldn't this be:
>   +        return EventuallyOp(self.child.negate()).normalize()

Yes, remnant of the old version :(

> > +def p_unop(p):
> > +    '''
> > +    unop : ALWAYS ltl
> > +         | EVENTUALLY ltl
> > +         | NOT ltl
> > +    '''
> > +    if p[1] == "always":
> > +        op = AlwaysOp(p[2])
> > +    if p[1] == "eventually":
> > +        op = EventuallyOp(p[2])
> > +    if p[1] == "not":
> > +        op = NotOp(p[2])
> 
> Pylint is complaining about this one, wouldn't it be better changing it to an
> if/elif chain and addding:
> 
>     else:
>         raise ValueError("Invalid unary operator: %s" % p[1])

lex should have failed due to unknown token before getting here. But yes,
this would be a good change.

> > +def parse_ltl(s: str) -> ASTNode:
> > +    spec = parser.parse(s)
> > +
> > +    subexpr = dict()
> > +
> > +    for assign in spec:
> > +        if assign[0] == "RULE":
> > +            rule = assign[1]
> > +        else:
> > +            subexpr[assign[0]] = assign[1]
> 
> rule may be undefined here (but I guess python will just say variable rule is
> undefined and it would be quite clear the ltl didn't start with a rule.

We could make the error verbose.

> I'm still getting a few more errors but my model may be to blame, still need to
> play a bit.

Feel free to send me the model. Maybe it is a bug in the script. But I
would be happy to help debugging your model as well.

Thanks for the feedback,
Nam
