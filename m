Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A94F6277CB4;
	Thu, 21 Aug 2025 08:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755765231; cv=none; b=UW1euApM2WmiGRVOcAy9JLWUQN4is7OO2vNNxntzpPPmNc3uTcqCPwOxIqSDIrusSTMMr/CeBbe7mw3J867+1YKp5SYeMBw34kCV4qBr0mwQ3aQJDeYDzevKEx5YpO8cppNmQM+friu6PBWmFBZ19lFv2qEwd65UAhzXo6Gr+KA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755765231; c=relaxed/simple;
	bh=EDQMUD163/PsSKhQ/C/oFy04iaU6YGYrNe8p6Jih4ts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fhdifqYRiJATCmpgBTr75+YpO0Mp0WzOzWfdoMkXRT4pQ+3qWL/542qZzg3/b2bsxV865wyugUOALxW4ukMBP+pICbh88y+xU2wxZtOsrMFWk85Npqn3VjSwE44QKS/t64MCkut5CX0/XHRFvE5bmn1RCrfFrifwys4AzjwTaOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=byXyswnO; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=e/E7YlEO; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="byXyswnO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="e/E7YlEO"
Date: Thu, 21 Aug 2025 10:33:46 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755765228;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qVLOMP3peEviAlxpJeN013Ps2j0XdPNBI8r6+cBD39o=;
	b=byXyswnOxYAdv7GTZUMOioyGNc6JnI3KQ4+EpleaV/iDi+tCTp2UpU/p1nkSEBsZM9F3yo
	cgyujMsFTTO+Mb/LJKQeXp4l2lUNoSdhO9lQbS7M6bq3m8Nun/I5pnL8TR9Yl76lQ2xsAV
	NC0ZwU4dkQJvPgfrxzzX+7qA13jQwO0fVSaTF2KcQFtGHLph6GIflgFz7JQ6tsLF5ttvf5
	wnbg2i1I13as7HQ9rjC+8uRpWBkmB2xxJ4vhoIyACFhZHS/cFINLmugFHZif9RpeYJdTaB
	Z9dxd59HEOPopXlsKoBnQtxDDNkIh8ARlh5o0pIUKRmXk245CDqH3ooscc3ORw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755765228;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qVLOMP3peEviAlxpJeN013Ps2j0XdPNBI8r6+cBD39o=;
	b=e/E7YlEOKT8YzUH5k6gYSJI2HyIsy5orUSu/hPEiC1azHdyuZa+cFMaR9ymn0MyQKXQUUw
	Vnt70+SLJANJsICg==
From: Nam Cao <namcao@linutronix.de>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-trace-kernel@vger.kernel.org,
	Tomas Glozar <tglozar@redhat.com>, Juri Lelli <jlelli@redhat.com>,
	Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: Re: [RFC PATCH 07/17] verification/rvgen: Remove unused variable
 declaration from containers
Message-ID: <20250821083346.5MSO6h_Q@linutronix.de>
References: <20250814150809.140739-1-gmonaco@redhat.com>
 <20250814150809.140739-8-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250814150809.140739-8-gmonaco@redhat.com>

On Thu, Aug 14, 2025 at 05:07:59PM +0200, Gabriele Monaco wrote:
> The monitor container source files contained a declaration and a
> definition for the rv_monitor variable. The former is superfluous and
> can be removed.
> 
> Remove the variable declaration from the template as well as the
> existing monitor containers.
> 
> Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>

Reviewed-by: Nam Cao <namcao@linutronix.de>
