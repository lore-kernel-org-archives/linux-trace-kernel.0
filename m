Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C009E2BEC35;
	Fri, 27 Jun 2025 12:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751028177; cv=none; b=hJs7dxYHxPq6VHXY9tD6aERv9CXkCHhuUts+Uv0NDfaYxN99x0U9D33MOhWM0YUBjBKiwYHPqY3lQfv0MsKVmifKmRSPjUIBUavp4dd3615r2VZtGhpO57MbuEiy5n/z6+SawgdNNYRpa4HWnwknjthcgc+a7h3SwuwaU7Xwg9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751028177; c=relaxed/simple;
	bh=ubEtR9R5kWBifbEQQgrU4ba85V/db/Ip3fJrYVWhXW4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h4Q0xVmNESg+SaM/cAEvMXUobuXioNxpQ86grrhj3sb6XdBJ+1j0VjdOG/70xBLNCA3x0jT8fp/j6Wpmq0htaEjJyqONo9gNIZDbNx7DAd8PQgY2rgA0zdx8uH2viktYqCitP5OJnnsZK0mwVIygYUFx4diK/ayNCK5D/8ueVFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kBMxQne4; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eTSCEMC9; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kBMxQne4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eTSCEMC9"
Date: Fri, 27 Jun 2025 14:42:48 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751028174;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=I0cdH9AbsDi9cOvGMuZ/YHlpDL+qgXIFG21O180RDIY=;
	b=kBMxQne4sMCFAfdTQjt0V9wOknq6dkzUUmodR5ImDbjhiR81CXk1grNhsNZqz4CmkCijZL
	R0WsINweshhs1Mafhx4/1/cKgVxDFkdre0PmWy7nOIz6j6kEMxfpVuxe0GM2JyCTMfeJSQ
	z6JebjSDjHPNgC5Kr0b3mR15fvK8u9gO1J3+ykDhFO8EcKleM3CfNMxrS1digy/Q6Rj/tM
	2XuCZXq5AQGWuSzb2ub3Q0aaUjnBE/4p0YWhzcR5QkEddbeRhIaYdSoJRWMkf7j+5sLZlK
	vHl9f9nTQB5/BaiFgaSYQ187e5xiV1PMISNYL3lRob2iibmZHQT6r2y+GrrlUA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751028174;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=I0cdH9AbsDi9cOvGMuZ/YHlpDL+qgXIFG21O180RDIY=;
	b=eTSCEMC9KF84uvwGrVlz2d43pt7Dsifs6agerMg3qKYs7V9VRIMXJ6sy+cHVtaWULWD3fG
	IYRC8uwDvKPNjcBQ==
From: Nam Cao <namcao@linutronix.de>
To: Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: john.ogness@linutronix.de
Subject: Re: [PATCH v10 00/19] RV: Linear temporal logic monitors for RT
 application
Message-ID: <20250627124248.fpuBrdWJ@linutronix.de>
References: <cover.1749547399.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1749547399.git.namcao@linutronix.de>

Hi Steven,

On Tue, Jun 10, 2025 at 11:43:25AM +0200, Nam Cao wrote:
> Real-time applications may have design flaws causing them to have
> unexpected latency. For example, the applications may raise page faults, or
> may be blocked trying to take a mutex without priority inheritance.
> 
> However, while attempting to implement DA monitors for these real-time
> rules, deterministic automaton is found to be inappropriate as the
> specification language. The automaton is complicated, hard to understand,
> and error-prone.
> 
> For these cases, linear temporal logic is found to be more suitable. The
> LTL is more concise and intuitive.
> 
> This series adds support for LTL RV monitor, and use it to implement two
> monitors for reporting problems with real-time tasks.

Is there any chance this series could be applied soon? I have some more
patches which depend on this series, so it is holding up the show. I think
Gabriele needs this applied for his patches as well.

Best regards,
Nam
