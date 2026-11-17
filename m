Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794951682;
	b=TSf4IQ2p7NeHZB5zYi37Vjr44JRcnoR3iUsZsrc1aNcBMnrUqT6B0By05ga1iWEDiJM9
	 fP1fc3lH4drVCviTwG+G+Rxw5w5Xz6/k4pr5WWZ1T8u03VEft4p5gqk4go8xjHIHT4eOy
	 s5gt99OyRgTf/Ysao08tsifW6QWDhJC84XAGoxRwEvfVlHxJNtfTyY7ORT3OxN+0Cykje
	 kC6k7HrfBH7Acg1MOmgQWodTT3Wr4YnpkPlRHBjF27X5QUuJWZXFicKMANfxBrNCbtRq/
	 0TysmBIgD7HXpC5uTjyZl7Xx7h+8L9R+cN5Nz+XHXQ/Ny0zrGKwOeGkssZfd56rfzuw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794951682;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=/GHQAMyTcVgW7kfw1l2Fy10gQWmLXDGkkGBuXSUeJAo=;
	b=duS6imYWtxN5kvwDxVvuBCjGsVEInzqX0Y796VybprH7rfjbjMGEriWSUGDyzNj230Js
	 p8aBNkAlcFPAvXDnohc66SfxVrTlqaqBatdEEeiZ4A463Pa6gnU78i+qsUyC+em0k5HQ2
	 q/WDEMVWh9uDEV0rYuxFRNQXlfRz2wK6Kl9tmZRN7hurFCj49rFJb0unDAa/Ik1wR6R8o
	 d2qs3E3BpumubaCkolaQQTkz8VzwPtuNTz4ufHCsIVs5Iv9fmQBDxnY1aB/cFppjFohSv
	 ru6Huv61+7ABD2rDKkEzmS1OgjpeTkZ1wXsZmM6AdrRrT8Tt7+XmeTktVMTP9qO+Png==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=gobRoYW1;
	arc=none smtp.remote-ip=74.125.82.173
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 867DB606A32A
	for <linux-trace-kernel@vger.kernel.org>; Tue, 17 Nov 2026 21:41:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 867DB606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=gobRoYW1
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-380c28f9e35so1580214eec.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 17 Nov 2026 13:41:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1794951681; x=1795556481; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/GHQAMyTcVgW7kfw1l2Fy10gQWmLXDGkkGBuXSUeJAo=;
        b=gobRoYW1W8svUtTm8wo1ksZLWsWYB1ni1vtPZwjTvFXB4pL3xMRsXHjBVktWr3um4R
         0wpRq+GewDKiDKj1rC8CgSjMDxkbA9Rd8iJn0IKLcdZJa0q/csJeYC9n+NRgVpcBqMoG
         v0ut0xT8RB44Ekj6eaWSKtxj1yjwTmUTS79gQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794951681; x=1795556481;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/GHQAMyTcVgW7kfw1l2Fy10gQWmLXDGkkGBuXSUeJAo=;
        b=ISN62QRWPKOaLjlZV9QEgr812gMvdfUwKoy8kJtUdm7zVPDI8bNnQR8yEZ7T46K0it
         CJQaOhcXN07WM0pAtH/J6xQwEm+rXfbyy1GSpJCyZXbLIOm0HR/MtQD/E/rsfKds0+NF
         NoJEXaOJF7IWrc72L8HU+ezbcOm2FrpZLsqf06AFlwoEyYFlYsPz4JvUE2Q3SAbVcpuF
         XWnJMldNeKfuhBFYqRF1cpJ8rsKmGVKtoyqVkJA8Ct19QFoWOTO4RIoYiqz/n9UwqYKT
         puo3IHc18JQPknlZWUJu3ik1aVaIO6liMudrXmn16sEFxxNdfM/FYmhS6gdHKCRLkndR
         71Gw==
X-Forwarded-Encrypted: i=1; AL+hErGhSRrOMpV1oeL053CQmWkr74GgvKg6cncow/Spf0kHoJoUIivDNL7F265s7JZLWJV3JGc+Ue+FTPutWCpud+7WXIE=@vger.kernel.org
X-Gm-Message-State: APuU4Z9QcsH4Ns1z3Fv8Nfq193AC5HRDiIFwju+88JgMs/CSaudfClTx
	AuMOvKgDqXWKuCYoJWJo0auJ9drtYLmziUlkwK5vQSor3+k6PJ1j+C959Dy02bJ0nw==
X-Gm-Gg: AZFdTZdkUdnXSg5o91dwv4qAosqfj6qQTlN8P919xv1COcoDQlNSvPUqA/6Z5TBQmBi
	rLlZyGDdOivHCznU7j/DBKqHwYDGmn2HWdvCDncxMj/dkAg/aJE7bB+2nWlZDVuEeQzyXobrC8D
	7Sv5DrYI69HeOFY2jYioaeu89VlBJISN6/NaCcj4RUBhmYqwphqNur8FtU0vhcKDwAIOpkWClq7
	hJs4w8zAz69D9ItLnwBb1HSIuzzfqJl+WrYEMoVtMjAb3aykYhlVibmNlHxjriT0ZPdZlT34Sdi
	Z0TrVbNGJk135HW4Y0OAlLTeT3E7DhM0BViySsAlLjuZpP4zT33+GWm9JihS8Wr6Y9yGxxlD+sn
	TIpvwkxEt2AqzAddFtXkrDl0eGMxkQjTZq86fNl65986u0UROwNWHipnDkXYh/kz54wSToaj/Yq
	oZ2G7kPaCuwSS14PGEW2O37BWCkcXTcVjYePqwDo3qRWqFR2bUnTjzOPqvwYBD075q3tWJNEB33
	h5I5olUSc6MHJdQtAQXtJtN8GGqHTIIP4MfgNPYJKks/qZ3f87SXkfJE4p7ZFMpxFMzlK0YKJ5g
	8ySa2cfu5MyYJ7Mo2Evf47Mlm1b+Ot0XETFOYre0viXnz/O6W3l4j/yRfm72qQn6u2Q7
X-Received: by 2002:a05:7300:fe49:b0:382:75b5:e77 with SMTP id 5a478bee46e88-38275b516f6mr736632eec.25.1794951681348;
        Tue, 17 Nov 2026 13:41:21 -0800 (PST)
Received: from localhost ([2a00:79e0:2e7c:8:d92d:531b:8d97:bf51])
        by smtp.gmail.com with UTF8SMTPSA id 5a478bee46e88-382a6fe75b5sm678252eec.15.2026.11.17.13.41.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Nov 2026 13:41:20 -0800 (PST)
Date: Tue, 17 Nov 2026 13:41:18 -0800
From: Brian Norris <briannorris@chromium.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: sashiko-bot@kernel.org, sashiko-reviews@lists.linux.dev,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: 'select' GENERIC_TRACER, not 'depends'
Message-ID: <avzJ_uvfpL2nPij7@google.com>
References: <20261116144652.1.Iecb63200dd245f62032a3b1f60ae78cc48868094@changeid>
 <sashiko-outbox-217828@kernel.org>
 <20261117085552.0e4ef272@gandalf.local.home>
 <avybp3O2zxcLozKB@google.com>
 <20261117142203.72235895@gandalf.local.home>
 <20261117142310.4f440b3f@gandalf.local.home>
 <avy6nTb0ccqNNnOo@google.com>
 <20261117161011.59101930@gandalf.local.home>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261117161011.59101930@gandalf.local.home>

On Tue, Nov 17, 2026 at 04:10:11PM -0500, Steven Rostedt wrote:
> On Tue, 17 Nov 2026 12:35:41 -0800
> Brian Norris <briannorris@chromium.org> wrote:
> 
> > On Tue, Nov 17, 2026 at 02:23:10PM -0500, Steven Rostedt wrote:
> > > On Tue, 17 Nov 2026 14:22:03 -0500
> > > Steven Rostedt <rostedt@goodmis.org> wrote:
> > > 
> > > As it doesn't need to be visible let's still have:  
> > 
> > What's wrong with visible? Hiding it is part of the confusion, because
> > it disappears when you select something else, even though it's still
> > effectively enabled.
> 
> Well, one thing, it's precedence.

Do you mean: because that's how you've done it previously? Or
precedence, as in "other tracers take precedence over a visible
EVENT_TRACING"?

> But another is that you can only deselect
> it if everything else is not selected.

Right, but that's pretty typical of interdependent features, I think.
And it's explicitly represented in the menu:

 - the non-deselectable item loses its box, to represent that it's no
   longer a checkbox that can be unchecked

 - if one wants to drill into "why can't I uncheck?", the Help option
   gives a good breakdown, with something like:

     Selected by [y]:
       - GENERIC_TRACER [=y]

   That gives you a burn-down of what other things must be disabled if
   you want to disable it.

Brian
