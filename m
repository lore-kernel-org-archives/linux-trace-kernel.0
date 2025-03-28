Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C298A10E4
	for <linux-trace-kernel@vger.kernel.org>; Fri, 28 Mar 2025 13:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743169920; cv=none; b=hBI7+NH382xB1Q41e0YgMlevDCVzbTslcXa5+DkL4baxahWkNH7bg+QwgceG5TLqnpVs+uHGF8b9GzK0j9PSFC0rm5KI2BI6nII0BCY3BKVXoVESewH2eJdhuesiC/LrqajPirUf/DEUi8FYg/SA3iqWqM/K8Xg2ncUlA3Boib0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743169920; c=relaxed/simple;
	bh=7keX5FQHfuj5criWs662qvX5Y0mvZuQ+wEIWA+09qU0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V6YRcE+qjPANp4JfyiyrtVWc+HUIaSeY7le9aYA7wCkAddQn22VxKGhfp8wsEYPMONWPIWt/o4nlARm7k+03O57D1DqQs2kmgRn466AvOYEs929D2l4OCmNItjocv0CqJHCNni9q5Ls6xH5q+wGB3Qg/i3pag0TfcA8eTgWBe+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Ri52rTuY; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Ri52rTuY"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-39ac56756f6so1695908f8f.2
        for <linux-trace-kernel@vger.kernel.org>; Fri, 28 Mar 2025 06:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1743169915; x=1743774715; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=olQvXU3SlpssZcd54ZBPK/yHAsySM9j/3+8owqmZXYk=;
        b=Ri52rTuY+auIlCiZoHCuVbwfsheeZHWQ1FjX+m0j7RQjXBzvmnDcfAW0Twomki44QH
         H/AY0m5enj43ba3w/UsyeJ9GYkolrQRZTj0eV53UxSJsBSqPM4ByLvPe0KqN2P6DMHRg
         MWFEjTiDp/OlbsZTBU1YrK/kxKLpkYT0M+O+QQrGU3FLG/EVTbYnGYumiplgEAWrlTas
         8ZiXqcstegbn4gbJHY/us/tanKGWOsdXyaTqBSbkLY+N8nQm0iA34YdQC/PAv17XtEBL
         o8WhJH1ljNGuYE0dLHBm937FxgfZr23qPQxOsi8XGvRb2KcmtiyRk75tfmlTD9gWb8bm
         SUbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743169915; x=1743774715;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=olQvXU3SlpssZcd54ZBPK/yHAsySM9j/3+8owqmZXYk=;
        b=h87pZMQjvNNBPsVLEh/hqAv1ykSOnBWrruIKZgYpKdrv5m9r3pB5sw3w28SVaNoC99
         7XE2sYxAfGYHDcmExiUMgGMpObq6PsJg1XzrJ8mtP6QU8FwCmZu8V219fC6zfoEk4w+H
         /aZ1RKqwOPJZ+vsyR6S472kattCmWsRGTtJksMJEv1i5QZOZFUnsu1+CXy0h207Q9l6g
         kSymOlXPxCPa2B/wsAJBzq7BZ5ddGrReGf9T1EA1EQFdCqxhPghwitv2HrfQPUJhebX8
         vnrl4lRGT8hAZEs1aqjjHkqnqE48eqKWh7P+k5t4KKWOJgl9+FtWrjrShWNNB/jW6mYw
         azZA==
X-Forwarded-Encrypted: i=1; AJvYcCXYAPvs2kr+ty3V5kRQJxq0F5ETxmqoU1A4UkfOUl3g5l6kUbbiRZIzzemItnZ1v0SqhrqeGtrJGxLceuJ9D6fgB5E=@vger.kernel.org
X-Gm-Message-State: AOJu0YygFbFgoOUlnWD5bcBk7IukjZzDPL6hs5n5EyPWs9pAcIRBfZTH
	WsMnvYzxf447be13+uSxgsIDh63XA84XkkuF6kQpSGkP3uHDN/a47Lg7x7bhFrE=
X-Gm-Gg: ASbGncsS1VV9scORf0TDyUPoL66mbHdFzPSnSFYGlGiLmHwTMdXRgA03RvACAQW0AHc
	hA/marerAvMRnP2m7FNvTylrlBZLNLa79Vzj6x+UCTnZ7DnQCA1fW5+QPhpfP4hIG9lIeD2t/Kq
	zPE4I7wF5cRDgJsJZHCImwAvSIbi73eU/o2wzzJEuxmOyYERx0Dh+3+weKrrjmYavgPOv2gq8u6
	jh0a7nh4o7wtkyTbLFQbWHYlWLcDaG9zVVfDf/3RetGfmJTz+Tt3zgJviYWrg6K2Tlz/dDabqfT
	P3XhvlDomloQfoS1ZqsGnA6Ba8reYZJ/GnrRZLmMdvZTkBc=
X-Google-Smtp-Source: AGHT+IHbfndbuHfkuasI/Cf4p6r8nuRFhsT5d5n30IcceIH6HCihEcayWTwO3EYsoj8rQdERKU6JoQ==
X-Received: by 2002:a5d:47a2:0:b0:391:3049:d58d with SMTP id ffacd0b85a97d-39ad1719a55mr6958877f8f.0.1743169915024;
        Fri, 28 Mar 2025 06:51:55 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d8fba4b4fsm29091505e9.1.2025.03.28.06.51.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Mar 2025 06:51:54 -0700 (PDT)
Date: Fri, 28 Mar 2025 14:51:52 +0100
From: Petr Mladek <pmladek@suse.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Kees Cook <kees@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Andy Shevchenko <andy@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH v2 0/6] vsprintf: Add __printf attribute to where it's
 required
Message-ID: <Z-apePufuwt19djQ@pathway.suse.cz>
References: <20250321144822.324050-1-andriy.shevchenko@linux.intel.com>
 <Z-KCNy7Qu2vFdwVx@pathway.suse.cz>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z-KCNy7Qu2vFdwVx@pathway.suse.cz>

On Tue 2025-03-25 11:15:21, Petr Mladek wrote:
> On Fri 2025-03-21 16:40:46, Andy Shevchenko wrote:
> > This whole series started from a simple fix (see the last patch)
> > to make GCC (Debian 14.2.0-17) happy when compiling with `make W=1`
> > (note, that CONFIG_WERROR=y and all warnings break the build!)
> > down to a rabbit hole.
> > 
> > However starting from v2 the last patch doesn't require the first
> > part, I prefer still to have them since the functions, while being
> > _binary_ printf()-like, are still printf()-like. It also puts in align
> > the tracing stuff with the rest and fixes the wrong parameter value.
> > 
> > These first 4 patches are organised in a strict order and can't be
> > reshuffled, otherwise it will produce a warnings in between.
> > 
> > I believe the best route for the series is printk tree with immutable
> > tag or branch for the others.
> > 
> > Alternatively the first 4 patches can be applied first as they
> > are pretty much straightforward. They also can be squashed to one
> > (as the same topic behind), but it all is up to the respective
> > maintainers.
> 
> The whole series looks good to me:
> 
> Reviewed-by: Petr Mladek <pmladek@suse.com>
> 
> I am going to push it via the printk tree. I think about doing
> so as a second pull request by the end of this merge window.
> 
> Anyway, I am going to wait few more days for eventual feedback
> or push back.

JFYI, I have pushed the patchset into printk/linux.git,
branch for-6.15-printf-attribute.

I am going to send a pull request the following week
if nothing happens in the meantime.

Best Regards,
Petr
