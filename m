Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39FE7E792
	for <linux-trace-kernel@vger.kernel.org>; Wed,  7 Jan 2026 00:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767747272; cv=none; b=kslcHhWjn9AZde2v0P1uKK1zKa5yezKEGVjGebt3wruklUurD4uLjhi2CSVMswFMPb+Xcx/NUVKKHM/Boa3kxZ6nBWo4Ly5x0CX+GAyhmlqlehwbahUyTqLHlIeKTrauZm49W71MSlRBBNgM93gpWhD4RlMNsUpHnFYgIXMEjFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767747272; c=relaxed/simple;
	bh=tHVIlxd0OrYfUfL9QitxcVudnAJjLfhW9l0XkGQiuH8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dpi/++TNDmzz/xfel00z/tdSr7XPIk+eRnvesh+FMta/Bif0l+zDwFAeSGPACpFD5qgul2e4aJ13jiSJIQhSulXWrPxI+LcsXXJsaDQYpav6tbHg5b2yiU+I+B9JjJgTJT8NT0r7KrAIcAL/gOucO6uTiaIZV5mxH/Dy8tK6s7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iHEDrhv4; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iHEDrhv4"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-2b0ea1edf11so2101928eec.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 06 Jan 2026 16:54:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767747270; x=1768352070; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nKFtuRxvG8Sc4Hw9c2NIcUDhbvE2DGMRpi93OKfcQC4=;
        b=iHEDrhv4yb34Zb2vJPOtSFInXPMzSKZTYQpnvtByooPDiDCpVM553QDL5PcVY+ll4R
         +KlluRjarKKZVl0fhZNJvd64q+AUzqcGuyG3pAhwagzhV7YzV7UstL2odQmLjk9J1mHK
         Vjoi/hvcI/v7ukRS3eqLjcFtEymQU8PEfWadOD859uIo21Hy+67p2hnmWhvtHphGPQoS
         9oYpYb/rogmyXmFQX8eh+clLFwdemLSKuMv3TEN4cT51DDPLnp5HD3hL+7AulzokJQ8J
         tE5j0FPkq0EGe18PREp80NyQT4cOkt+IVQ7x4iq9FjOne3IRyd/zPRirpq+CuK624rJM
         MC8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767747270; x=1768352070;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nKFtuRxvG8Sc4Hw9c2NIcUDhbvE2DGMRpi93OKfcQC4=;
        b=kSsyYKIJJ9fGKfZip8gCk+TSIAuLuLvhaaPV0gaOe/Qp6naKE1Hku/tz5BZMBnPzkM
         kGzYdx31+pDcYe0VkPjCqjYc18xRIYlpmxPeB5zoPP4GpiVOrumnEzyrefECFPZL5peO
         bF7U/UM4a4qifx9Lxtdm2l+Hy8rImuhwKz9ul9ItP2MCpjy2BjAAxRyqunR74PboXMzV
         oFZ6Iw4sKAIP54vUPAkxQyTemEaU1oRWlE74l6D4GX/u8/efyv6qOex0UHpH4zqJGhKZ
         B+ayhFqWoSOOaOaldSn+vex0adKuUI+xE0CzRFR0OXRLAG0EeAFMSUE9XAGbg4VtuSuo
         jZcQ==
X-Forwarded-Encrypted: i=1; AJvYcCVwMAmhX3txqcTVVUgqRGvJBoSS2tPixjAE+9BKcopOoBsUP3CbVkP8//RrDZca4djEYld6nOC5O7v1zFy5Pf0E+As=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwYMM7jImYqsbSzOfN/CDKVK6paFbEy2l4xdlukhFliergtg3U
	0TIOFBO28JemwZQLdA0IhqtQ1CsC+VBLkStLwJa5VRR6TJu9MkEjGnH9
X-Gm-Gg: AY/fxX7RCuAwLkoMW1wsGs7VCnTK4KsPXRWuDidHzddu0jbRDo8K4+o+tqPceMgdSv1
	XsLTGDFUEJVGGjd81cmolmi5Te2UG2nTW1d0+SYORUUy1yJjAojjH9CJyfJUtCF9BtFMZPHIfBw
	kUkgUQjZdtC/hSTwx3lGHFRlzYrNfnvFhfCLhnaXa004OuYwdLmNsj6+HoG0Pts7istvYuaMR2p
	sd1wqk80ndffA4b570sgAK7QSM0B0Es5tT0D+C+STCxWsLr6rlwHHmSP7JgywhizKyU9radAsGg
	qon+6VktZ+wzpCGG8bIPOwwvnwfQ3Yav3dVt3HTPi0IZK/GkJ8CLrLIApSexiNIy8fjMsesfnqi
	ReElU47XF/qwsZBXhof5HDl3f97RStGXXh5qDoUxNnIaJBZ6CMVHs4Lxpk/H/hRtC3WBkTxuUKy
	w6sN4Kik42A/d+ARwndhm5egAf
X-Google-Smtp-Source: AGHT+IHB6AOl+mK8nO1d90rNd5G0CXOq/nrjk54nUlOimZbEwbghfsrd5mTOmHUoD0CDyiPS/VTFbQ==
X-Received: by 2002:a05:693c:60ca:b0:2b0:5435:2e04 with SMTP id 5a478bee46e88-2b17d266983mr767010eec.19.1767747269549;
        Tue, 06 Jan 2026 16:54:29 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b17078dd78sm5350516eec.19.2026.01.06.16.54.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 16:54:29 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Tue, 6 Jan 2026 16:54:27 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ftrace: Do not over-allocate ftrace memory
Message-ID: <b13af4e1-3510-4240-9347-31459d5f0ef6@roeck-us.net>
References: <20260107002428.2904852-1-linux@roeck-us.net>
 <20260106194355.66cf869e@fedora>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260106194355.66cf869e@fedora>

On Tue, Jan 06, 2026 at 07:43:55PM -0500, Steven Rostedt wrote:
> >  
> > @@ -7304,30 +7305,6 @@ static int ftrace_process_locs(struct module *mod,
> >  
> >  	/* We should have used all pages unless we skipped some */
> >  	if (pg_unuse) {
> > -		unsigned long pg_remaining, remaining = 0;
> > -		unsigned long skip;
> > -
> > -		/* Count the number of entries unused and compare it to skipped. */
> > -		pg_remaining = (ENTRIES_PER_PAGE << pg->order) - pg->index;
> > -
> > -		if (!WARN(skipped < pg_remaining, "Extra allocated pages for ftrace")) {
> > -
> > -			skip = skipped - pg_remaining;
> > -
> > -			for (pg = pg_unuse; pg; pg = pg->next)
> > -				remaining += 1 << pg->order;
> > -
> > -			pages -= remaining;
> > -
> > -			skip = DIV_ROUND_UP(skip, ENTRIES_PER_PAGE);
> > -
> > -			/*
> > -			 * Check to see if the number of pages remaining would
> > -			 * just fit the number of entries skipped.
> > -			 */
> > -			WARN(skip != remaining, "Extra allocated pages for ftrace: %lu with %lu skipped",
> > -			     remaining, skipped);
> > -		}
> 
> Don't remove this block. It's still needed. A lot of entries are
> skipped when adding the records. Weak functions and zero'd pointers
> that were part of the count are skipped. This is the code that handles
> that. It has nothing to do with rounding errors.
> 
Sorry, misunderstanding. I thought that is what you meant with "This will
make pages equal the number of pages that were allocated. Then I'm not sure
we need this extra logic."

What is the no longer needed extra logic ?

Thanks,
Guenter
