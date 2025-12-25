Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6648C2A1B2;
	Thu, 25 Dec 2025 01:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766624745; cv=none; b=ID0JW2L3rabe+0U1lQkE9iuzbAxuVWuJPoUgVJ7z3cSRHABFDFbenPrHf1Wh5LcmXo/80CAfrVQLTVH9vbR/XKKIGiISEBQpnUexxc3TukYB628vdsDZ4+kdTVyrufgaFPto9JmK+hhw6J8s40rpyZs9wneZSMedOjDvvfJl6yQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766624745; c=relaxed/simple;
	bh=Do8wvcigFjeHfGHWYSSuPQqBc+fvUzEcZv1VKiGN6mQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=W+IQGEQ/y6ENC8uA22Uqe5lYAVOiBh2dhn7oOqcU+OWqAHXgx98/niTmnt+5uveBQBLt9SL92VmnTuCdAJu8WHtUBORGX/oVe+8qRJLBwm7bTMLNIwhv6EsjoUPZTjNrA0zoj3aTJwBpjHF5iP6N5PAd/wgIwCQyQystfxqNzmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Vf8foyP7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=z509jfcW; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Vf8foyP7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="z509jfcW"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1766624735;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Do8wvcigFjeHfGHWYSSuPQqBc+fvUzEcZv1VKiGN6mQ=;
	b=Vf8foyP7iqGZwGcyf+C14APF841UhWafGNxpMub9Mai3ODtZLCVRoTx7lfBYi4KI77qUG5
	tZoBG+gR0bUGE3NvuvGxy8flbeIxN5F0jAOwEhZXqsYgOvjT26bnWXnhcitjcv/+KOTLcc
	H79io+r+TML7fLx17du1dP8oWO9Nd58kOFml1RdDl+ANMj0RFA8PzRWjMZQJZESiI4OYMd
	vyazmHS0pNiyXzsmvyE2uAYibnGRo5/Ik1MHBTCjC9RJay/WrCICszRQjuSkBgVZDz0LPy
	VOOUTc8pxv1P/kP4WeLCvl0Vk0jTsWuN8Tp/7QHymkqPkx3mVa2TAcAevDluTg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1766624735;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Do8wvcigFjeHfGHWYSSuPQqBc+fvUzEcZv1VKiGN6mQ=;
	b=z509jfcW6pqZBTrZLPb14zbLY8bokUkD5Ys3L1zvLe0yl6h2f4RKGforExsz4pc0hpwlFB
	T0D04gmQSfy+8WBQ==
To: Gabriele Monaco <gmonaco@redhat.com>, linux-kernel@vger.kernel.org,
 Steven Rostedt <rostedt@goodmis.org>, Gabriele Monaco
 <gmonaco@redhat.com>, linux-trace-kernel@vger.kernel.org
Cc: Tomas Glozar <tglozar@redhat.com>, Juri Lelli <jlelli@redhat.com>, Clark
 Williams <williams@redhat.com>, John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH v3 04/13] verification/rvgen: Add support for Hybrid
 Automata
In-Reply-To: <20251205131621.135513-5-gmonaco@redhat.com>
References: <20251205131621.135513-1-gmonaco@redhat.com>
 <20251205131621.135513-5-gmonaco@redhat.com>
Date: Thu, 25 Dec 2025 08:05:29 +0700
Message-ID: <87a4z7bcbq.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Gabriele Monaco <gmonaco@redhat.com> writes:
> Add the possibility to parse dot files as hybrid automata and generate
> the necessary code from rvgen.
>
> Hybrid automata are very similar to deterministic ones and most
> functionality is shared, the dot files include also constraints together
> with event names (separated by ;) and state names (separated by \n).
>
> The tool can now generate the appropriate code to validate constraints
> at runtime according to the dot specification.
>
> Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>

Reviewed-by: Nam Cao <namcao@linutronix.de>
