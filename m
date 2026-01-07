Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE3D7FBAC
	for <linux-trace-kernel@vger.kernel.org>; Wed,  7 Jan 2026 01:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767750446; cv=none; b=UDQ2NyuXgnN0ATkKc5nVj6qBQHOfIpWGDVohFSPNrorVd0NPBZTS+9VmWztJuu4wL/eze+KFPGe8+ruzSPzctWzo9iCTU3VMQii0VV/hdeNJ2zxRCXoygOVIrHVu2csiA135JIS50xwHLCVzNVGiNevwe8JLnFj1IUA+JgueBts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767750446; c=relaxed/simple;
	bh=jLXi0znS7WYEwkEk9PrWkzM4hv/8LNw96t0l0jl3fn0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XekGy2rYDBOvDfMkm6jan8TloDYfoWZvM8/ffnclQ7Z6TEYYQfmTeTxNYmaEMuyBwc40YvDYyJq79kpKw2/NLfp27BCgNHDbOO0EdL8Se1TcXWub62mROPJwLpvyTtl8siW0JsUGZIqXxqNdm/gFyjCgR7IH7+PlCP6lMojCsYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f+hDhMfU; arc=none smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f+hDhMfU"
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-11beb0a7bd6so218612c88.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 06 Jan 2026 17:47:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767750444; x=1768355244; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RoXDYEWmsDDUhtVNh/8jymS7BJoQBbn8Lv407Kkn1KI=;
        b=f+hDhMfUeB3r71FAtAsfOxIUvGQYJRnF6g9Zf1T0JCYC3Tst1V/PlVFSo4dy9ueREM
         Nqph7Ze4Xhn4XxJPyq/5/3hHFaFI7OhcE468p/HMbB3CMAbO8nGkmZlELa62U95U+c8Z
         Q/4skNZwYUgx68hK3qjupzwgz9D90a4mHsOfnWHnxhh4LLP3aS/0Icj7dy838cS9mhnr
         SDt71cLLg8AooZpMu1WfX35ogGWTFnA3iO85E3Sl1yGZ4j2mu7wTD3FJls3CR3TX8BEr
         TLCk66OrgxXhW2egkP1XZw9Do8s+TZ1kY+6yGxdL6kz09xpANkjVOqxrzKjs/1BFrBh5
         os1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767750444; x=1768355244;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RoXDYEWmsDDUhtVNh/8jymS7BJoQBbn8Lv407Kkn1KI=;
        b=ppmpWN8XHVL/1EDET9votmJYZPl9DJ/OjWOhP+jYpdhgQ49uJAxxUEb//Vc40jrjHi
         J3yE2hxMWBnK1k2Q5+N7nj/bNDnuN/ytZICMqEGJtTLMOCCkyItqs8RdCQDmndKsMD2F
         vzD2aTlgPTn/n/i+TE2W/KISgnVO4gnbM1BPZMFnuRUnX2Y5UjLdDokVzgziZJEtMsAY
         shX7cDQEZrt70jq8vQqBGK6KvruwDUhMChma+AmWN7ltpaLpg6TNRk2GEP+7PGeNcVzi
         zd9U39+v05sLCNsS25azwxd7gzu1kAgJp6n3v1t/gBrEwoMyybc7zZfYVhwD3R9O9SMr
         qPyg==
X-Forwarded-Encrypted: i=1; AJvYcCWew1ryJXrQUz1zCfF97R0SuWbK2dgNtuiS6Qref/h3nihWldyfzarwR3zmENwk3C5TKNqNjcWIm7ISZBdlmTxxFZU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2GjUlMvQlwuqVrOp8+vvhfaAN3c3Tceziu60XBKpSRaVBlvIZ
	XoVKSLeckAAl3s4hr0ZFl0QfP1v/iuwY3YgnG5VtbJk+mSQWyHCz0W5O
X-Gm-Gg: AY/fxX7g5e2cqjWWwXuybSkmykOKYLVd6UGzfCBJtCUBH/otJX16qwXQgKVDciTa3+K
	wZY06CXQjcBckHYcKEotSbHTrXXH4QV0vsj20XW3wAl/hHxb9SSFYBSxo8DEVfDw0araYIh7zAS
	OG8/MgNG7MGlUinWAzScJrDxNL+C9F7CQSfxvcxxO8KL3DLbG6WTasz3M6dqUoEzn/Lxb52ah9r
	Mo+sCnVqu+GOn/HAZYzF8nHF8yYai6pNQJVBeHRR8OujIEpcVaOFJOIoUz3sgY08mPH/kOx45wX
	sjFLphgJunugvqGmyEPkihefnXRNGVNNMnoFTL86WnBteqa4uBmxt4NO1TVcDns577MSAudpJtD
	J7/+yCtG5vDefS4vYnmDGaV0GFqDlxCwbmUmPKF0hN0IgfH5GnsruvM/qevGF2YOwC1xv1OT1EQ
	8E2b3kklX41Vmx7pNwutXKu2rY
X-Google-Smtp-Source: AGHT+IEBpLAJzTQzgBsTEVf6wzVZRDlzQHQzRM8jri8pFBsZkHkAcBX5ssubNOWpTGNglJ93oQJBYw==
X-Received: by 2002:a05:7022:2584:b0:11e:3e9:3e94 with SMTP id a92af1059eb24-121f1b59840mr3973277c88.25.1767750444238;
        Tue, 06 Jan 2026 17:47:24 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121f243421esm8308978c88.2.2026.01.06.17.47.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 17:47:23 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Tue, 6 Jan 2026 17:47:22 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ftrace: Do not over-allocate ftrace memory
Message-ID: <6909622a-7d96-41ff-aee1-d3b216033cfe@roeck-us.net>
References: <20260107002428.2904852-1-linux@roeck-us.net>
 <20260106195241.166f4115@fedora>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260106195241.166f4115@fedora>

On Tue, Jan 06, 2026 at 07:52:41PM -0500, Steven Rostedt wrote:
> On Tue,  6 Jan 2026 16:24:28 -0800
> Guenter Roeck <linux@roeck-us.net> wrote:
> 
> >  	if (pg_unuse) {
> > -		unsigned long pg_remaining, remaining = 0;
> > -		unsigned long skip;
> > -
> > -		/* Count the number of entries unused and compare it to skipped. */
> > -		pg_remaining = (ENTRIES_PER_PAGE << pg->order) - pg->index;
> > -
> 
> The above needs to be fixed though.

Yes, and
	skip = DIV_ROUND_UP(skip, ENTRIES_PER_PAGE);

is also wrong. That means

	WARN(skip != remaining, "Extra allocated pages for ftrace: %lu with %lu skipped",
	     remaining, skipped);

will be hit because because 'skip' may be inaccurate. Example with added
debug log:

ftrace: skipped: 654 pg_remaining: 313 skip: 341 (3) pages: 310 remaining: 2
------------[ cut here ]------------
Extra allocated pages for ftrace: 2 with 654 skipped
WARNING: CPU: 0 PID: 0 at kernel/trace/ftrace.c:7299 ftrace_process_locs+0x5a8/0x5c0
...
ftrace: allocating 52250 entries in 308 pages
ftrace: allocated 308 pages with 4 groups

The warning is seen because the number of pages needed for 341 entries is
mis-calculated as 3 instead of 2.

That means I'll need the added code from v1 to calculate the correct value
for the number of pages needed, at least if you want to keep the validation
code with the warning backtraces.

Thanks,
Guenter
