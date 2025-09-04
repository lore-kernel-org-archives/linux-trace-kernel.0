Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 621752C11CE;
	Thu,  4 Sep 2025 08:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756974067; cv=none; b=UfGpP5ZCeL1TWB870l26UFMcgiIDESY/oo2/gpTPyUH3I4UFNqphTRq2JEpyx6WCPwk8yiye8y2QMzIdMsFzX6WUjHgcn4Xn1IQwMpy4U7c+IgCJOlOscCGtPGP/VUR0ITReR0pK3kTacFvK6HJ2fl3YEHQFr+4thkVQckqaBbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756974067; c=relaxed/simple;
	bh=5pU3lCcZIMMUPd7itWXVJiRbd8i372zWp0UaGvbm6Ro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HVIbJ3zP6UxfjLR21s9VFn9BWUFWXfaVs6Y1XTVDuOmohwIlU78aVDIH50qVe47Jb3zmK1tOmgo1TreFROL3bWufgWNsQ1nWkyM2DGleInMb+EbMjotMwYC9+mrsGjvj1ciSD131PqYRVvOSWmlxsi5apekUMDHBqFguAJNz9KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=34jLjEpo; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fq8SCTbR; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="34jLjEpo";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fq8SCTbR"
Date: Thu, 4 Sep 2025 10:20:54 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756974056;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LgKZEQgTNNt9FIDqyGUYA+pKErtCZCz7YZuMjPmhs4k=;
	b=34jLjEpoHDDC4Hxfx3dU/lL20uh+fVPDIo5647C6TqQ8eKEQAIsfVRXav6h681xHiouEjb
	4b3H3vaKxCqAqueQi/SaBdMrj2gIah8MkDQC+qUULPKL5JQIhXgf+QxfNnsXMcn/7EXv+Z
	+9QTRYZfPOW4KpsR/e1eZICytE+m59JSo9DkE00ZOqhBx3E8O881OK8cBWVuYwkpRWOfrQ
	1w4qtFTBIwpcUKeZBiVP5TJVZIRYA88nOWHNyZkJJ6rUTznwYQpe8kS0DZ/J6xEDMKH3rK
	YUjUfsl0/i9TX/hBzWhZVGU/esTNevhLg5Qc78F15ufBipPFl/wRfrXe6jhF1w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756974056;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LgKZEQgTNNt9FIDqyGUYA+pKErtCZCz7YZuMjPmhs4k=;
	b=fq8SCTbRlmzfiY6orM272DLWtUYNe78JJrNDhU6E1D1TjIWYPMGXSu1NnQlRfl530JHjQD
	qk6J5ErYw8hldGDQ==
From: Nam Cao <namcao@linutronix.de>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
	linux-trace-kernel@vger.kernel.org,
	Tomas Glozar <tglozar@redhat.com>, Juri Lelli <jlelli@redhat.com>,
	Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: Re: [RFC PATCH 16/17] verification/rvgen: Add support for per-obj
 monitors
Message-ID: <20250904082054.W0fQJAQw@linutronix.de>
References: <20250814150809.140739-1-gmonaco@redhat.com>
 <20250814150809.140739-17-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250814150809.140739-17-gmonaco@redhat.com>

On Thu, Aug 14, 2025 at 05:08:08PM +0200, Gabriele Monaco wrote:
> +    def fill_per_obj_definitions(self) -> list:
> +        if self.monitor_type == "per_obj":
> +            return ["""
> +/*
> + * da_get_id - Get the id from a target
> + */
> +static inline da_id_type da_get_id(monitor_target target)
> +{
> +	return /* XXX: define how to get an id from the target */;
> +}
> +"""]
> +        return []
> +

I know this is the existing style that we have. But I think this is not
something we should keep. How about something like:

import textwrap

def fill_per_obj_definitions(self) -> list:
    if self.monitor_type == "per_obj":
        return [textwrap.dedent("""
            /*
             * da_get_id - Get the id from a target
             */
            static inline da_id_type da_get_id(monitor_target target)
            {
            	return /* XXX: define how to get an id from the target */;
            }
            """)]
    return []
