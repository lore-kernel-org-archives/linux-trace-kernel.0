Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C594267B95;
	Mon, 19 May 2025 08:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747642005; cv=none; b=f7KJcC1BAjThq6/MbNdFDS1fxRf0b/KL22x6xs2w5c2jMxdK1FmzMGPn2UgSjIDqz8gOxrwt3NqS1pMN6JP5/TvWP9d5SmaH4JwG0pkYExyVlm6WMeaKnsVTJ6REP4Bp10svRDLhFd/UZsX9XfTADC/0u5CMo9imMkOW4lcZvyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747642005; c=relaxed/simple;
	bh=csniL7wD1w/bBQKn3ZejzxYLSGU6BV74pp5nNU1S06s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aC42/umeA/Zf0BYBiGPgacvjnuPgqNa1vZkWYlZbLlYrjwKtV80fvgQpMgmyTjAUm7pwoVtSvijn/I1AwpAbs2DsPh/8yUqQZxrC1NQ5wkcEqsXp/28OQiPFBkjZL0JBKB8qlJ2RfbUnOVMhL4Rt+BR8V0a46LHfNPJm9tgkeEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EJ8pVt9q; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=e1qCOISC; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EJ8pVt9q";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="e1qCOISC"
Date: Mon, 19 May 2025 10:06:41 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747642002;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vN2VdDYE+3QR4LES1aXoh7cKQ1zmhVMtFasl+jhB2MY=;
	b=EJ8pVt9q1/DOaWnWfdAmb44OzciQALvSw7efazU6AzoCraAPunnJTf3UvDByBj8Iz0XHza
	Pq+SwJoJ26KFDUfI63Atwnjc51aD65BNvjFj5UBYCzI61sMYeOoH7MD8l7AVaGfFw4JXqa
	5FwcNIxct+rRow8JTLZvg+CwrRnjmA2pMKC3E8B0qkHmIOnTsyOAAn/KU/uE+7HEndcBOD
	EsICIZQzwLtOdHlPzPvN7nJS29MdAIOkF4jhrWTtPi72etKlKMpgy9ZbtKXEHUBDp/XN5W
	fcdI0XbF/NXq9FgRV1sJTnEbu+fP+RZzo9XVnbRYHlhQKmn3QPCS+Ub+5Q5cyg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747642002;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vN2VdDYE+3QR4LES1aXoh7cKQ1zmhVMtFasl+jhB2MY=;
	b=e1qCOISCnXHBzddOKU5iD56Ej8rC9Cy/ViJAxrTufnvDr7BmuE+CkCbdLGTwsox0WTSjRz
	odB6ZFRbyevtQABg==
From: Nam Cao <namcao@linutronix.de>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-trace-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Tomas Glozar <tglozar@redhat.com>, Juri Lelli <jlelli@redhat.com>
Subject: Re: [RFC PATCH v2 05/12] rv: Return init error when registering
 monitors
Message-ID: <20250519080641.6FFQAC2k@linutronix.de>
References: <20250514084314.57976-1-gmonaco@redhat.com>
 <20250514084314.57976-6-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250514084314.57976-6-gmonaco@redhat.com>

On Wed, May 14, 2025 at 10:43:07AM +0200, Gabriele Monaco wrote:
> Monitors generated with dot2k have their registration function (the one
> called during monitor initialisation) return always 0, even if the
> registration failed on RV side.
> This can hide potential errors.
> 
> Return the value returned by the RV register function.
> 
> Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>

Reviewed-by: Nam Cao <namcao@linutronix.de>
