Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC5CC3AB5DE;
	Tue,  7 Jul 2026 07:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783407641; cv=none; b=T7gg2ZiSdDLkBBed6z0i8IQpNSYfGGrTcdNYTbcgrOb1WlRt7UYS12PhhnwxA1IGmp0lFGPy5SvLh45VASz1MPep02RuXST5TAcCNGTAGSfGmexvqVoRwgMZquM2IpbRedyrC98NKwLMPId64O9d7DoPHWHa1yVv1kZaFgMACec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783407641; c=relaxed/simple;
	bh=4DhjN/AGvRqCsrEvXLTTiEEADLAHfEENZNm++ejemRM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lU9b7nBXvu9DGJe+tY3yWyKj1Tw9+C0UmbP5xXKz+BxNwgc53ZSvChq256CJDAga/wXw0vzWzvY8MkquXX2Fm2v88hRP+ObTVIjFR5awnzjSlWgaeIRm/+k0X+En3336zzFgb5O4HOpobzZY+qCjBhPVlCOuk1Wrvv1RxNj9N9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rGSuBxMY; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=8ZoVqbGr; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rGSuBxMY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="8ZoVqbGr"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1783407639;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4DhjN/AGvRqCsrEvXLTTiEEADLAHfEENZNm++ejemRM=;
	b=rGSuBxMY4IhB0shz7eD+LYxu/Sk0GVDvkOZHn2eya8ADaecHGMMuXDkteBi5y6Jjm7QSg1
	ptrAmeGxeNby7TIaFEZ8jFc7Nnv0Z2F6v0xKLMf96mMtVoPoV9FetjzhceeBJ9Fhe95v+a
	/InA0IxQap4nK1NtgHMNTf42dq5FHGJgBGiLtZo9fN/dIQnLwcklBqq1bxb9M4nWj9ZbVL
	pd9aB0nhsFEmIwcHH+dMNOe+rVQeKeia3GR89DSk4KmI07j9UfJ9b6VKGQVPp3kWRagOEU
	YEY3vfXfywJuxPXKQikIM65/l0jALO9shqJdUxTJ14bEmpaEIaD7mN5Fl5ZwEw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1783407639;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4DhjN/AGvRqCsrEvXLTTiEEADLAHfEENZNm++ejemRM=;
	b=8ZoVqbGrpoc+j1+fClWAnAoDUDv+jeXlx/qoesyHPRxmlSEI5Zch/F4OjFli+bdZmKptzc
	coAnRddYIwLD7RCw==
To: Gabriele Monaco <gmonaco@redhat.com>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, Steven
 Rostedt <rostedt@goodmis.org>, Gabriele Monaco <gmonaco@redhat.com>,
 Masami Hiramatsu <mhiramat@kernel.org>
Cc: Thomas Weissschuh <thomas.weissschuh@linutronix.de>, Tomas Glozar
 <tglozar@redhat.com>, John Kacur <jkacur@redhat.com>, Wen Yang
 <wen.yang@linux.dev>
Subject: Re: [PATCH v3 11/17] rv: Prevent unintentional tracepoints during
 KUnit tests
In-Reply-To: <20260625121440.116317-12-gmonaco@redhat.com>
References: <20260625121440.116317-1-gmonaco@redhat.com>
 <20260625121440.116317-12-gmonaco@redhat.com>
Date: Tue, 07 Jul 2026 09:00:38 +0200
Message-ID: <878q7n2six.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Gabriele Monaco <gmonaco@redhat.com> writes:
> Monitor initialisation also called during KUnit tests may register some
> tracepoints, this can lead to issues since we don't expect real monitor
> events running during KUnit tests.
>
> Prevent tracepoint registration if an RV KUnit test is running.
>
> Reviewed-by: Nam Cao <namcao@linutronix.de>
> Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>

Somehow I have no recollection of seeing this patch.

But since we already hold rv_interface_lock during the test, is this
really necessary?

Nam
