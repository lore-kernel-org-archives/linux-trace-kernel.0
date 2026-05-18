Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F7253CFF65;
	Mon, 18 May 2026 07:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779088554; cv=none; b=pgFIcjC4aciZYUQ5b9YrbQACxwACePxMUB7ebPKQcW5v0BTK/FQ9hiF/Rhpj9t0mv8JunOPfcAxnYt/E4UmkzjZ3ryBJUOm9VlZWVLSunF9LJt3+OGXed6ry+t+ZP+cBNLK5VxuXsoADwUb818c2y0QVMykXYTVPpRirbHTWv2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779088554; c=relaxed/simple;
	bh=My3kKLuZsbFBv7To0oiLjFYIQflyujZgHoJsOHUpoOI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=E/MFHbf5ixIMI50R1wfxGTTfZcqhLup9lVtfgdKMnbz0TidgP9971uTXRot6MJZO4ZjIEdvRBpfUlGmrHpNR4OOPPQ+Sm/hobSNJ7pxLdXLploQZko/AnfcUpWsdjXA0eoxYLgJ0VNzCtoNvqc3zYsj4HzTWHP0tBlSKKeRR8p8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zYPhPbS/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=K/G8C+GJ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zYPhPbS/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="K/G8C+GJ"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1779088543;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qY3aSowlj1Rupx0o2fAND3uYe45Y2K4ngv7BZrZw04Q=;
	b=zYPhPbS/8/VQhUirpMZimKN7/DIkEAn+fGIizjYeJJNY7n+F3Qkvq025mXO7I5mVhEej2Q
	IOIQo3CqN/fH7Pi8m+q5XgsKqAN8qth62TwS3VBdstfjrsaKAnGSSOsJYjy1RSmQ+xcnTr
	m+4vkG1mTkT3LybDGOQS83QVKIkVMwWiR4SeEiGssGcY7IeHzaYvg/TW7l4eTO0qqmVhYG
	U/gX21LjbBDx3Hpe11mDyc/+j/LJfV3jvzG1S+jcsnx6RTrut9zir7XosYYODwQ1Ejkp3F
	jZZjGURftaC8OP39uiro6Ruy+d/XS7k5FWIfSoSlC9JSNcjNM9cCTdZ/uo+93A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1779088543;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qY3aSowlj1Rupx0o2fAND3uYe45Y2K4ngv7BZrZw04Q=;
	b=K/G8C+GJzFH1MZx9tQyZA/RPIjaWDeeSMmGVZlAoj9Aiomk2tFxI3yDaz/bPICMPKIPUm6
	Ff8+GpbMEOOXyJCw==
To: Wander Lairson Costa <wander@redhat.com>
Cc: Gabriele Monaco <gmonaco@redhat.com>, Steven Rostedt
 <rostedt@goodmis.org>, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/13] verification/rvgen: Switch LTL parser to Lark
In-Reply-To: <agdBcW8_GTP3YuNs@wcosta-defaultstring.rmtbr.csb>
References: <cover.1777962130.git.namcao@linutronix.de>
 <85aaa8cacb31cfc78619a07aeae9a86d059a4cc1.1777962130.git.namcao@linutronix.de>
 <agdBcW8_GTP3YuNs@wcosta-defaultstring.rmtbr.csb>
Date: Mon, 18 May 2026 09:15:42 +0200
Message-ID: <87se7p89y9.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Wander Lairson Costa <wander@redhat.com> writes:
>> +VARIABLE: /[A-Z_0-9]+/
>
> Is it ok to start variable names with a number? (unless I am reading the
> regex wrong).

Thanks for pointing that out. Let me switch to Lark's built-in CNAME.

>> +    def LITERAL(self, args):
>> +        return ASTNode(Variable(args))
>
> shouldn't this be `return ASTNode(Literal(args) == "true")`?

Yeah that's broken, should be
    return ASTNode(Literal(args == "true"))

Nam
