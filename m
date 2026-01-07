Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC1110FD
	for <linux-trace-kernel@vger.kernel.org>; Wed,  7 Jan 2026 01:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767750976; cv=none; b=KMkYttR73PwsP9+Kg1Ke/d07DeLktl7bFipgNwEGZ8IUENUTMEwSPim/A5tqehAp+O+emU3qfgcy4OKmOmbC4kesKXUgV7INsN7aqw60qFcJFfDsaDqHFrtTFshUbRypQKMQ02vVjlUgXFqlXiYESYiAOI4u7GQlG1uXU5hFpr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767750976; c=relaxed/simple;
	bh=i9CvjPjYzHpXfy395Iu7hC/J5xvVGAm9SRv099YEo+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qSx+4fmoqvDda8+sVP7M2RKd2wP6gi1FncniLKJQYhfu/fMOTZvzPSmPeAcQqLoiKmEbhSU5J0cylELLvKehEuajNOK8pPkUJGHOxjhJn0QRc0wTIZvqzJnl8VO+h2ChtVH52MejJOfCFPdwCcOrqeNo9CNvLru7+8YE4xSJABw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E0ov6vfc; arc=none smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E0ov6vfc"
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-12056277571so1126460c88.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 06 Jan 2026 17:56:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767750974; x=1768355774; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VlVS6vkxouJ7ZRpCqrQRqBlJbY8szTHfi0a3hUoZ0w0=;
        b=E0ov6vfcn4eFH2cc2//o7Wrm8t3qXZxQ0Wwpyb1VfNNJ/+mX5qvdOTPXVvaLx5LmuT
         oVhBIQjr8MFQ+UhPIaHWwTtjpfLcs+S3tCZpD98F1rA3cfYkclg4KmuYZs/E+ap4AeB1
         g9EgOnA7tZ6Plz4ii5FRj3B5WIrdKyuNs5klPDIbj09lNO5tSdBWBX2v985HIBJYqRy0
         AOtUd3+kMvZX/h46fxoRawbgVpo/wQ3O8Djn5OZcEJpNK4nHfUPQeHm+6IPU7exJ/UNc
         i4wSdee4Rbh3J6Y/ppiI2/DfzLodnhaSz6zexfYNUHJSr//qgJiSqDj2aCVmtHCDEFPZ
         ltSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767750974; x=1768355774;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VlVS6vkxouJ7ZRpCqrQRqBlJbY8szTHfi0a3hUoZ0w0=;
        b=qmeBJnbzGiH/oBYSUHLqGgX7ydbFxGnmojX5vSeQWQunVHtXTm7Q5Gwug2EgzJmKPh
         UuXX7ml4KecwEJjhteNmfevGgwRgJekXx6d9v6fIOcO3krjdw5H7RljugkLtqIPKyLK9
         FEwm77azaw3cIScp2PHndj2kJnJgB92GjQCBi75AvEDIllRJVIgsFBadqk0BWbGW42oG
         i+Dx/QQWKh/SxALqOw6jS81sH17SIFOFzvvaCAuwn2seSwbsOsdtHGgR2wSGvM/uI9bS
         CEKTB7K1oFyVyGVEjMctozCAeB4xgrQT0dW4v+W3eZEcTbiUvjmQxvZXyImWxioxB1+u
         D+bg==
X-Forwarded-Encrypted: i=1; AJvYcCWZUC7K6e4l1ZeCjlJ4vGtTUnnCuJhPl8BUWAIP73wlzE8rDCTyXqrBdU8N8PDwokM1AMhfhYuMLlSgEQN6gZSMSkQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZ7oAYYdo7xpvyaOPIokwqeLP78Z3msjl5udj+ROhhrhVukXOL
	pbm3TaXOhHkpiy9IItUvXH5M1RMfcE/4KRn/3ujt2R/sEThY2JYWGSCBdUbxfA==
X-Gm-Gg: AY/fxX53rVFyfwjJhT+f4RdL9pgxo3KcL0MOJVavXOqsF68UoqsXNF3eRn0fFMsW5t5
	1XhswXcDAlZi4UVW6Pd88AKLoYq/e7zJt+PRrBvQSbgJ3maz+SGJWt522jOoOES6SVna/a7ou5/
	+TsnWKtF5Hm60t1eLIPREp5wvp9OXtSW4YEUhFYpFFCnXhKV0/qqYXlQMfILwLS74WWcaDDSy2g
	yidJlFWlx1tGw5HCgg84BnpLc1OAl3nYJHAIBb1gD2zm+VQ+76xOrJtMyMWeeG+h9iworvLexti
	4WUopBoJSHMPD8tlv3FT8xJjGhQHF6EKpYlUSxGp1owT2OgYFQZ1tQE0A4B3+oMcw3Eq+d87C6T
	YJLPTHWiITAIA/6PVZUbMcHlkZ7Dpomxd/9EJ1oQGFrdC1TnBL+llf1nS7cnSLRG1pM/IPkoJo+
	IoBYhQm5Of77PFfsF9ZnnSldYT
X-Google-Smtp-Source: AGHT+IEBWQtWJBseWfjNgkmXq7j6uMZfwSor2aBaCRQOVa9jlxzgUupLVdrE+xkHOoSJNLYUTSRXPg==
X-Received: by 2002:a05:7022:697:b0:119:e56b:98a5 with SMTP id a92af1059eb24-121f8b0db87mr773223c88.12.1767750974079;
        Tue, 06 Jan 2026 17:56:14 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121f243421esm8332977c88.2.2026.01.06.17.56.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 17:56:13 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Tue, 6 Jan 2026 17:56:12 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ftrace: Do not over-allocate ftrace memory
Message-ID: <3cd8b2bf-c18f-4fb2-85ff-afcaaa1b38ca@roeck-us.net>
References: <20260107002428.2904852-1-linux@roeck-us.net>
 <20260106194355.66cf869e@fedora>
 <b13af4e1-3510-4240-9347-31459d5f0ef6@roeck-us.net>
 <20260106203352.539b9548@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260106203352.539b9548@gandalf.local.home>

On Tue, Jan 06, 2026 at 08:33:52PM -0500, Steven Rostedt wrote:
> On Tue, 6 Jan 2026 16:54:27 -0800
> Guenter Roeck <linux@roeck-us.net> wrote:
> 
> > > Don't remove this block. It's still needed. A lot of entries are
> > > skipped when adding the records. Weak functions and zero'd pointers
> > > that were part of the count are skipped. This is the code that handles
> > > that. It has nothing to do with rounding errors.
> > >   
> > Sorry, misunderstanding. I thought that is what you meant with "This will
> > make pages equal the number of pages that were allocated. Then I'm not sure
> > we need this extra logic."
> > 
> > What is the no longer needed extra logic ?
> 
> I meant the added logic you had there, as I was a bit confused by the
> "spaces" part.
> 

That was just to avoid "skip" going negative in the for loop.
The code below should work as well. I'll give it a try.

Thanks,
Guenter

> The logic still needs to be updated, but I think it can be done with the
> following:
> 
> 	if (pg_unuse) {
> 		unsigned long pg_remaining, remaining = 0;
> 		long skip;
> 
> 		/* Count the number of entries unused and compare it to skipped. */
> 		pg_remaining = (PAGE_SIZE << pg->order) / ENTRIES_SIZE - pg->index;
> 
> 		if (!WARN(skipped < pg_remaining, "Extra allocated pages for ftrace")) {
> 
> 			skip = skipped - pg_remaining;
> 
> 			for (pg = pg_unuse; pg && skip > 0; pg = pg->next) {
> 				remaining += 1 << pg->order;
> 				skip -= (PAGE_SIZE << pg->order) / ENTRIES_SIZE;
> 			}
> 
> 			pages -= remaining;
> 
> 			/*
> 			 * Check to see if the number of pages remaining would
> 			 * just fit the number of entries skipped.
> 			 */
> 			WARN(pg || skip > 0, "Extra allocated pages for ftrace: %lu with %lu skipped",
> 			     remaining, skipped);
> 		}
> 		/* Need to synchronize with ftrace_location_range() */
> 		synchronize_rcu();
> 		ftrace_free_pages(pg_unuse);
> 	}
> 
> -- Steve
