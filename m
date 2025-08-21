Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB86B23E32B;
	Thu, 21 Aug 2025 12:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755779924; cv=none; b=KfTtBlBiczdgpz7d3ORISZk9nOK6yJGoXw+hkAHM37cop3qj2BkVdWguB19/9bEIzQiquwH+znoLj/TVmsXaU0+sH7j8VfnGWgWdJSSKRTWnkqzKznZ39ZUQ7/314ZCNgh0+Whs3Yib270s4zUQeUH6alrxkH9zsX4Qs0Z/wVeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755779924; c=relaxed/simple;
	bh=oXhDUv87NoCszJ8tfluMEgInDZ24yKa+PfkHBpJD45A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uL2FkKRzYBrPU0yIrIzmv+vvyUquaKLkAlfSTuDvcI7pEUmlfNxSmELgDHS26bKLKT/FgYDD/6cRuJDSXoS6fXrLmJc91rhySdvFT2fCvYRKgrrP0X3rRb1UIir5Yma93MhZgCiTdh88FSPDr5OvOfJPS6v+9IcCjRXwGTTpE4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3G9p2mup; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pWUDwvyw; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3G9p2mup";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pWUDwvyw"
Date: Thu, 21 Aug 2025 14:38:39 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755779921;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KbDOghMuFQXuB3jWN6gYshboT1kfc8EL9B6GPmeFLlE=;
	b=3G9p2mupIErF15oKhHnIHUrphQ9Yd48PQ1Cxe/YnvoAlbTSwgPPp4RLUxROzs9jLMi2imG
	nBoV9boof9YJ9BcuiXjmY6RPE1B0usKuPzpRHyaJaWkMpYheDV34ScdJB6ACTtAQtMMa/Y
	DBdr9q9xPLz0A+Ntp0eCNPJIax90jNTXrip2H9YYr7eb9+ZKuarphEpitJ5ynDYzybQZ8N
	zTVtw+WTAZ4xe0YPar82KLYbeT88erLSAMPfacM8HIw350iKKVmX7ddugY0nG8fxjUyup/
	Z2si2IVLAB3vd6a5P9ZbBwf1FnoYjn0GJKhPQFzLEGHITj1uh1NZ8FtfWQgadA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755779921;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KbDOghMuFQXuB3jWN6gYshboT1kfc8EL9B6GPmeFLlE=;
	b=pWUDwvywEQ0Xe2xQakcXyJZvoTZjoZYJkMi95swQWMVSggu6/ZjsNxM/vzmbnRrwd/W0BZ
	6SbWnA3HcwehyqAw==
From: Nam Cao <namcao@linutronix.de>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
	linux-trace-kernel@vger.kernel.org,
	Tomas Glozar <tglozar@redhat.com>, Juri Lelli <jlelli@redhat.com>,
	Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: Re: [RFC PATCH 10/17] verification/rvgen: Add support for Hybrid
 Automata
Message-ID: <20250821123839.Gj3vCzCo@linutronix.de>
References: <20250814150809.140739-1-gmonaco@redhat.com>
 <20250814150809.140739-11-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250814150809.140739-11-gmonaco@redhat.com>

On Thu, Aug 14, 2025 at 05:08:02PM +0200, Gabriele Monaco wrote:
> +import re

Oh no..

> +from typing import Iterator
>  
>  class Automata:
>      """Automata class: Reads a dot file and part it as an automata.
>  
> +    It supports both deterministic and hybrid automata.
> +
>      Attributes:
>          dot_file: A dot file with an state_automaton definition.
>      """
>  
>      invalid_state_str = "INVALID_STATE"
> +    # val can be numerical, uppercase (constant or macro), lowercase (parameter or function)
> +    # only numerical values should have units
> +    constraint_rule = re.compile(r"""
> +        ^
> +        (?P<env>[a-zA-Z_][a-zA-Z0-9_]+)  # C-like identifier for the env var
            ^
            My regex knowledge is not that great, but I think this is not
            standard regex syntax, right?

            I'm guessing this is Python's feature to store this group into
            "env"?

I think my brain's battery just run out, I will continue with the review
another day.

Nam
