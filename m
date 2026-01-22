Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6428130F53F;
	Thu, 22 Jan 2026 14:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769093867; cv=none; b=DjtTKThpgYzmKxYKqMJU+N7J0b+xu3W8YJdQ5b3hp/d+RIvIo85KEegLFpw3lU9mh16M97KXQ+lFHuWZW0dvBqsgaIEVjtnpPckDhPwL4nqiZYNs39r1c6zefy3nJ/bDbv/V8MY7yDJNbERtmTE1AbCWIgz+0kt2rA30tZhgONw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769093867; c=relaxed/simple;
	bh=DSDtvWjhbywtKtWF/bjEYVwIEvSQiMHr/PkeT64wwYw=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pKlDwM0pNZ8qtrigDOTsnqech3BIGpu34T3NNc2wBzqnvNOEMJp2Q3fO9d5zLt8hFwemR3Dlu2tQTjnBG5NOIkFa96bk8YhDWtEUN4qAf0RJiP9YX6rhSeWZ1KIcN1YfDK/RE++IdAd5dZJU8I5qGYqddPKp1RNohXi1qMY9F2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aGx7oiE0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zk3eMYZ7; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aGx7oiE0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zk3eMYZ7"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1769093863;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DSDtvWjhbywtKtWF/bjEYVwIEvSQiMHr/PkeT64wwYw=;
	b=aGx7oiE0RcHuDVBUrLTRN+SxXiGr887b4fJpoi4ZmqcYJ2/burKsoOezMLGneELAmse+ja
	LUmglzsNNU3TToR/aJYhrylgfo9bIvKhyFrMq6yh5r/nRlgJeQc//oXUFEdKliZYPwi2/7
	3NO7GtQdN7yt1eJaQnT3EHB1/qHHafs8aHRnBE6XRYPFBkzVzEqBRWpM2FGsHv20QOuvPz
	qDBXPdUPYGHqhAl0me2oMMdlNM1rzmxxkkf7B2nP9tJzgshaiEoZBtXhUFXlcc2Pni6ZaA
	+bK70hCWxcatqeCRayrlp3qmc/ufPRwVQ+kABVxYPvlVBIH24X7YaNVLnY2P3Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1769093863;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DSDtvWjhbywtKtWF/bjEYVwIEvSQiMHr/PkeT64wwYw=;
	b=zk3eMYZ7pxTN1t6Vuuk33yMj7k21YvcCasYgS0zcicujXlyobuU/+r3lz9TwL3SQIi8UtS
	3eDgsyZ4Z5mnMMAA==
To: Wander Lairson Costa <wander@redhat.com>, Steven Rostedt
 <rostedt@goodmis.org>, Gabriele Monaco <gmonaco@redhat.com>, Wander
 Lairson Costa <wander@redhat.com>, open list
 <linux-kernel@vger.kernel.org>, "open list:RUNTIME VERIFICATION (RV)"
 <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH 09/26] rv/rvgen: replace inline NotImplemented with
 decorator
In-Reply-To: <20260119205601.105821-10-wander@redhat.com>
References: <20260119205601.105821-1-wander@redhat.com>
 <20260119205601.105821-10-wander@redhat.com>
Date: Thu, 22 Jan 2026 15:57:43 +0100
Message-ID: <87sebxitjs.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Wander Lairson Costa <wander@redhat.com> writes:

> Replace inline NotImplementedError raises with a dedicated decorator in
> the ltl2ba module. The previous implementation used explicit raise
> statements inside abstract method bodies for BinaryOp and UnaryOp
> classes, which required maintaining identical boilerplate across seven
> different methods that need to be overridden by subclasses.
>
> All stub methods in generator.py have been converted from returning
> strings to using the decorator with ellipsis function bodies, which
> is the recommended Python style for marking incomplete interface
> methods. This ensures that any attempt to use unimplemented
> functionality fails fast with a clear exception rather than silently
> propagating string values through the code.
>
> The new @not_implemented decorator consolidates this pattern into a
> single reusable definition that clearly marks abstract methods while
> reducing code duplication. The decorator creates a wrapper that raises
> NotImplementedError with the function name, providing the same runtime
> behavior with improved maintainability. Method bodies now use the
> ellipsis literal instead of pass statements, which is the preferred
> Python convention for stub methods according to PEP 8.
>
> Signed-off-by: Wander Lairson Costa <wander@redhat.com>

Reviewed-by: Nam Cao <namcao@linutronix.de>
