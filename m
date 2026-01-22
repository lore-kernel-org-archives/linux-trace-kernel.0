Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A581F324B32;
	Thu, 22 Jan 2026 14:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769093240; cv=none; b=Xf2jxatiegbfkPPjOZwpEvYRFlmMEAuAtpRJTvyTvGrH8eUpUC0r+dCVgr+w+HGNOqsu+q3oa5I6OWy66S4qgw0vFrKIYcK4hgMrgbE+44nfte2o9l8A52e07d23cZO0yS9tEiPu2sfJ4JKxsleZGTp6KLlJAu7gCspktTaHrvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769093240; c=relaxed/simple;
	bh=SscInfiFoXwTPd0Hr2/Ea58hL+6OX5Zoae3PfN14o7k=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PofD36irttytNZR4p/37AHKz+xrtWn+UE5oVBeTtDbiPy3NAIQ0TmbGGXW4enIMwQqlvx2UtrgAmlPMaEFJIK7tAj/nOf9fCP1MHwnuEorGaFSu54WGkdUB81UvMgNUJBwvrAUYWhIRQt7PgYBGKiIN1u3yrZxjA2iIO3YBQRsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RbZl8VZi; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tpjplMwg; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RbZl8VZi";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tpjplMwg"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1769093237;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SscInfiFoXwTPd0Hr2/Ea58hL+6OX5Zoae3PfN14o7k=;
	b=RbZl8VZimHJMPyGD1Mo1hEbUw5AU//sLNIP1/qIJCZEa8Ayxk483iig4SFeIHRXrzfF6D+
	28aeRpqr9v23KNns/m2Sf8luYhtPX+ZcV1Kgn8xOjaIeO1JJzKF7pbxZkWAUeeKz8Fz0x2
	opybfbVFtaI6bEjiR/KbD5Wnvof/4TXx+bJbVCjP6cZPJz0WHyjJLPlY7BOkJqKp8xDMMM
	Pg7NZ9O5Rf3Uwo9+5ECpMC0+PL3mLOgp/R95ec+s191elLksGOEOxEoheJR+y8Nvq0DmOx
	vq05xsd6OaAkQdZuhfqkevWqB6ZMCzefLoCDoCwYbv5CcFqQQNGpgYZ1+Mxnbw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1769093237;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SscInfiFoXwTPd0Hr2/Ea58hL+6OX5Zoae3PfN14o7k=;
	b=tpjplMwg7quGK+JqCPX10F9zQ0vqVpoiWy44ehpN+WtEnPiA4YzUWHBreGOrhToJKYJFyC
	d8nZ/oEGrps81FDQ==
To: Wander Lairson Costa <wander@redhat.com>, Steven Rostedt
 <rostedt@goodmis.org>, Gabriele Monaco <gmonaco@redhat.com>, Wander
 Lairson Costa <wander@redhat.com>, open list
 <linux-kernel@vger.kernel.org>, "open list:RUNTIME VERIFICATION (RV)"
 <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH 05/26] rv/rvgen: remove unnecessary semicolons
In-Reply-To: <20260119205601.105821-6-wander@redhat.com>
References: <20260119205601.105821-1-wander@redhat.com>
 <20260119205601.105821-6-wander@redhat.com>
Date: Thu, 22 Jan 2026 15:47:16 +0100
Message-ID: <87bjilso0b.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Wander Lairson Costa <wander@redhat.com> writes:
> Remove unnecessary semicolons from Python code in the rvgen tool.
> Python does not require semicolons to terminate statements, and
> their presence goes against PEP 8 style guidelines. These semicolons
> were likely added out of habit from C-style languages.
>
> The changes affect four instances across two files. In dot2c.py, one
> semicolon is removed from a boolean assignment. In dot2k.py, three
> semicolons are removed from string append operations that build
> generated C code. Note that the semicolons inside the string literals
> themselves are correctly preserved as they are part of the C code
> being generated, not Python syntax.
>
> This cleanup improves consistency with Python coding standards and
> aligns with the recent improvements to remove other Python
> anti-patterns from the codebase.
>
> Signed-off-by: Wander Lairson Costa <wander@redhat.com>

Reviewed-by: Nam Cao <namcao@linutronix.de>
