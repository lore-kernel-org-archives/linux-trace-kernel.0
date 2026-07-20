Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A98E23E959A;
	Mon, 20 Jul 2026 10:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784544872; cv=none; b=WrP0E7NNZG2QfvAYzM8dPzzuDrfqTotiEvGDJxlas6EMYTcScA5a7Dtd7y9n+5Cg14DPPcFyRcQegHfS6wwlPWQhXoHemEDp5bQrPgjTnwFyoerWO7fE3FekGZg3k2+QLx+M/TypBDc/rL5K52i1iApomfhmN2Upv+sD1w0IhII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784544872; c=relaxed/simple;
	bh=NqAXmU+ix6BaLmE5TNa4ewNKg4XAxzu7VX/z4f5vMUk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=K1O/YCV0w4gmpyuaiVuB9yVwLV7VO7TsVo2ElEklbLv+IjBvqjGaHuEO6ilPO46RyDKNZxqTtTB24St0dDyTSVoaOAtNisYgeHFd9KnC3g1Z+c1a59ZCifrBHNGelbWM4NbvnCQfSUPog5sAUw8exsURjBOjmb7Q5LdKp++TMFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=g7SScpfE; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DBBGXngV; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="g7SScpfE";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DBBGXngV"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1784544868;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NqAXmU+ix6BaLmE5TNa4ewNKg4XAxzu7VX/z4f5vMUk=;
	b=g7SScpfE7ROJ4RFy+L+pz3WEdHtplFS48N06umRClVmkOzACga5ZMBZOZjGX88u68RA1ou
	69I0mh0VdxstrKeV6VrzSbx5oFnJ/MZJRfP4D2/lvonNRoJl97cX2W00hPqiwWbpTMrAHD
	7IVD5O+fm5ljzUgrnEk0v78M7PWCGAxdqbh6EWlFD4r/umVR/bSqXQVYeI6A5KSfzEg7nh
	tusA6gIhw7+4w7w/SKu0IiBAC+oOKSFKuVdkKTR9XfxOYGgw8mly+A2ppmH6Iy2NsSkpvj
	BAt6w+8Gx+pIhECZ3SOGJ9BRkvZuOxiBPvD22ltQkVNtrfk/781DFJHMcUtSrg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1784544868;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NqAXmU+ix6BaLmE5TNa4ewNKg4XAxzu7VX/z4f5vMUk=;
	b=DBBGXngVqXprzt3ETG5e65xB0oaJL00oOyI3BvzCwH+bloO/M83UMrVaAFYDXRP72tI/dz
	cAoPvYUAKNyCoSCQ==
To: Gabriele Monaco <gmonaco@redhat.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
 Gabriele Monaco <gmonaco@redhat.com>
Cc: Thomas Weissschuh <thomas.weissschuh@linutronix.de>, Tomas Glozar
 <tglozar@redhat.com>, John Kacur <jkacur@redhat.com>, Wen Yang
 <wen.yang@linux.dev>
Subject: Re: [PATCH v4 09/17] verification/rvgen: Add the rvgen kunit
 subcommand
In-Reply-To: <20260717154638.220789-10-gmonaco@redhat.com>
References: <20260717154638.220789-1-gmonaco@redhat.com>
 <20260717154638.220789-10-gmonaco@redhat.com>
Date: Mon, 20 Jul 2026 12:54:26 +0200
Message-ID: <87wluqdj8d.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Gabriele Monaco <gmonaco@redhat.com> writes:
> Add the rvgen kunit subcommand to patch an already generated monitor for
> kunit support. It parses the handlers and create the necessary structs
> and initialisations.
>
> The only remaining manual steps are importing the test in the runner
> and writing the test itself.
>
> Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>

Reviewed-by: Nam Cao <namcao@linutronix.de>
