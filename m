Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D60941DEFC8
	for <linux-trace-kernel@vger.kernel.org>; Tue, 25 Mar 2025 10:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742897725; cv=none; b=YFC8BmKJ8WABjkscZ3cuMe8/GMYLgdO6ffVv6ora8W2EDLaRAKX37d0MzWw71bc+P9BOgLQy6ghC5BlG/kBr7On4E7gCt6l9cFbA+ryw27x0ngRmx9oOuQxfNfkCosMrq+DMQdRp4TZUbYeKhgAyCqWk6g1V+mXttm1SZCmCsLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742897725; c=relaxed/simple;
	bh=gBxlLT5ivpGDh72oKPJ3CBVf2yMPWUqCIsclGPiI0ug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K9OFwLS4oc+TqEGQQX1kvTKAGg6vwMc4AqSub0ANdUF5eyvly7GQu0WsmThfToOi6hoEHCx9YQ64i3eNcZZX50uxZYcxfXmE+/qio3tZoJUiYGGtR5jhxf/aDRVCVHh0FlXUkyz2Y6cOWMY/TbXAIPK0EZuP/VAtgq7bCTbBaUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Fc6lIOAK; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Fc6lIOAK"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43bb6b0b898so51551375e9.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 25 Mar 2025 03:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1742897721; x=1743502521; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VSbCNl4BxWO8IbyHRgNtn/a7Rf0u1sJorrF8gojdNyo=;
        b=Fc6lIOAKpCOraZEvR/fbMV5DPHBT9DVzUJxny4j4iSVPija1FrydvR31VLyl9m0P+3
         st+zmzGmXGZ73QIc3dXalcaw91I5w3P7vT426vY5pUqgLyziJcfoqOdbgodK+8P9vKh6
         2poKQl7dd/2hNfG2GG3wenA7LXBMeIIyOACwJ+eEviS/HHsqvObC7FX5QZ7PwDsX+Wpj
         xH2NV4KxrEtTLzbDlFjxSAs+SxBRrlgSfl3ccvgU+0qneT8Vu/5toPBGhYI2TQvWUr5X
         UiwNQkLTv+lMQGSVrABaVF55REQI17nfgtaAtzXZoZM225/5YsKBN92o01tcCHg2RT0S
         9/cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742897721; x=1743502521;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VSbCNl4BxWO8IbyHRgNtn/a7Rf0u1sJorrF8gojdNyo=;
        b=gTs5gKeOZOREtvFLNdI6s8ez+z2Odj/gaLYDBlj+aGqLa/eZcQ5ZqJ9bNsAIdxiVz/
         /I1OgdwUz78sriiHlZYDvtX57AMY5Cgpjt4DQDU7EHqDvklvYSBEnsgF/dhWDbekk30+
         mMH5TtfsVtwdGJyTxA/Ta9SlidrCciC6VqcNdIFoXK+klWecZB/F8bzJrbHzWyxlQjr9
         WLlL/bZVvDQlvoP4b9AQg8ltZlHmLq6gt3U1SLxZabcnkhnGQYkmTz3UIowMiyAZrpQF
         Ms4MkMXggQ3LpJnewUhl157Qu0Dh/hdNjjY9k7wFu4zhL7U1hD2/769VGerP5YUQozaV
         hJZQ==
X-Forwarded-Encrypted: i=1; AJvYcCWHtKOUMblm7La4Reyfd3JthP9Rmcwf/tuyrACnhPPA+jBDWYL+kKiOQEsGSOVyvqqsN5XlqPd83cECOAJldKo/Tko=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6ZrSR6C2wbkyez6oLSaeORBokXl+EErhcajAqegWf0zKIUvB8
	67qfifn88zKiNNQ1ts+q8wkZNdk+v+9DNZMLo/GVFVdfFxqQTU1xOHxvh6dH4tk=
X-Gm-Gg: ASbGnctXRTEavEOH/FZ3KUybyTv8OWo0/0by2dCx70g+GyW4Jlf8uM2d0wFqJ4oONeC
	tx0eCaPxqahJthotRBQ+eLXxG6uN3syADgYUyBnP/Pno0glSiuRzj/fuT40WPyBCxelP9SbGRlh
	NSfLiwhohg30Ca7HWOFwdYkxRih9rUY2d1c6huOiY6KZhKhBIkWpZkAThDpa/QvmWLqUWk1DOEj
	ftpvaubpcrS7eQSMrhQfiyLJjGER61e21W8htXora7J2QWBOo1ZYw9nkMLoKE0NuHpONY8lYF56
	vd5S2gBaPBLjG14O+PuPWZrEtfVXqIJs50hVdvFU0hiH
X-Google-Smtp-Source: AGHT+IEHsfS3jwIQd3DXLtKs6BlMXePkgOPcd8GrAW7V3JTw8OOWk8DEnFNJlXsh14KOgVQNsnrCHg==
X-Received: by 2002:a05:600c:4584:b0:43c:efed:733e with SMTP id 5b1f17b1804b1-43d509f58b4mr147592855e9.14.1742897721087;
        Tue, 25 Mar 2025 03:15:21 -0700 (PDT)
Received: from pathway.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d4fceb780sm149735745e9.4.2025.03.25.03.15.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 03:15:20 -0700 (PDT)
Date: Tue, 25 Mar 2025 11:15:19 +0100
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
Message-ID: <Z-KCNy7Qu2vFdwVx@pathway.suse.cz>
References: <20250321144822.324050-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250321144822.324050-1-andriy.shevchenko@linux.intel.com>

On Fri 2025-03-21 16:40:46, Andy Shevchenko wrote:
> This whole series started from a simple fix (see the last patch)
> to make GCC (Debian 14.2.0-17) happy when compiling with `make W=1`
> (note, that CONFIG_WERROR=y and all warnings break the build!)
> down to a rabbit hole.
> 
> However starting from v2 the last patch doesn't require the first
> part, I prefer still to have them since the functions, while being
> _binary_ printf()-like, are still printf()-like. It also puts in align
> the tracing stuff with the rest and fixes the wrong parameter value.
> 
> These first 4 patches are organised in a strict order and can't be
> reshuffled, otherwise it will produce a warnings in between.
> 
> I believe the best route for the series is printk tree with immutable
> tag or branch for the others.
> 
> Alternatively the first 4 patches can be applied first as they
> are pretty much straightforward. They also can be squashed to one
> (as the same topic behind), but it all is up to the respective
> maintainers.

The whole series looks good to me:

Reviewed-by: Petr Mladek <pmladek@suse.com>

I am going to push it via the printk tree. I think about doing
so as a second pull request by the end of this merge window.

Anyway, I am going to wait few more days for eventual feedback
or push back.

Best Regards,
Petr
