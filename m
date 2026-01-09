Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7855B33D6EB
	for <linux-trace-kernel@vger.kernel.org>; Fri,  9 Jan 2026 21:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767994848; cv=none; b=uSqnIT4lxDj5oEbUivCHrH4FQPoM96ywXai+Cf523XwhKtI501PgggHZi82K9p5fOHpEUVGCXlgvd6AjbYeIZWXkoV9rl3G/A6rvvMaxAqDtLZ4nB0MY/mqdKaHgX0di02vdokodOKNRL0tAG6BV4D86OmKZSaMICEc/iKuwleA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767994848; c=relaxed/simple;
	bh=/QSJlUBUdWSP+SY66u3JljD/2KGdEYC7dW5U/Cw+/PE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fbWnk0V4GM+JM9sBrR2eRvzAUSr+JVThiJznNP5oBr1QJa8GujcpIYK08Yh+KN7pG2mFsi93pOqCxg8J/8/88vBjHD84augy0xJgCtMTOY+WroUre8j60V2mKf9mbrwtY3TERtYXUGp/w9x5UWpyXzl6IN5vvCrNkchpayUhuGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IA5JSeA5; arc=none smtp.client-ip=209.85.221.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IA5JSeA5"
Received: by mail-wr1-f67.google.com with SMTP id ffacd0b85a97d-432755545fcso2741930f8f.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 09 Jan 2026 13:40:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1767994845; x=1768599645; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sCTw4EBCGwVONJjQmcyN+IYawg2li4nH7oS2Xxt6ei4=;
        b=IA5JSeA5YRrpFyiRdfkR+IotBHTvfxt8pMFi3D7qg2Zs5dY+4E3BV7/2IRUAUClS7O
         jqZUc+Qp0r0o35p2PjiH9TkH9X1i+fD7E3eIYSsK9AeX7Oclxki0zG21J3h8g8FUsuZC
         iwXrcLSuUTo5Hy1tG++TH0app2YIRt645UN0tk0fyzcy66XCBcPpzQs5+RRK3Mc8PRt0
         PI0q9gfCluF/lE7xIkKe1VhmI4PqBZ3Q98trD26eWPl0jH+t3ii3CMr6Rvslkx/sA6sK
         ACTL9bIhtKbMyunbZFujUGe8h1xehuTF83Ri/CzkYQRXVrEhniZvxZ1gfqGX6x7odIRg
         Jv7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767994845; x=1768599645;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sCTw4EBCGwVONJjQmcyN+IYawg2li4nH7oS2Xxt6ei4=;
        b=uWPa1xyeOoVl1OSQWM+2O8Jcg3AXSToLL0uRMHQuR9qu8ji4dE7rrj7grUh8xW1XpS
         DRQhiTD0yVxU60dtRN06xnxtKPCrh1TZLLnMBl7qdbznJZCbEzoOZHvaODTLEnMKjbMX
         Fq2KzAyny5L2zBPx2P6vaGElP6qP5aPOGnVmDGXcGtPxQvqa89YtrjWIjyTtydhWkekI
         H/MLYl7z0auRnKhhycc+PR8BS207hc76iijGI0rXRzOJA3ppptuL6ARMLIg+C5EfTSri
         4Nezb9PPt/ubAGSZk5pr1j2Pu02ggQPAgj8nvSEOelFIfVt1OhF6C2hbFGKBjZkrpoKE
         350g==
X-Forwarded-Encrypted: i=1; AJvYcCV5cWLtayexAvg9FcRT4EJn4wwSNuHwEsp8hLz2SPVSlU1yipgC60Y7Xc8Y1QGBboSA/zKu1D4eaj9RlTqf3rTyT70=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpmJ9/Q/7QrRKeWIAUPc1TaJcdZ+a5cTEHl7kU4tqpeDuavdqw
	24KB5l32h7gl9cjkRcdcNGLvyE9YxaLiLdI3JLNyCFxZeKNuAgCyJTSFULBInd1KXL8=
X-Gm-Gg: AY/fxX5vM5d8zwN+j1A2B9hKc30rfy5TwO2yJgAP9neWXx34PKKvi2qPHd4G/ZpSBVy
	KpmIyHhQRsDxgHRD/rszjF5kyGk5gP1Icta1Lzz5phNBI5fc1LFkaECb1rz4rzJyUNlL9zpuzou
	kZdjBNscmvnFNetuC4WqKGG6q9K+4GYh3JHFgoinXAq2jz39CC7ecgm9xnHwrn2yrDerNS9cDU4
	J5dbWSr7Yr4Go0tjI1q2AM+g6LfBcVH+DE08b7evZ+b1me5HXgYyckLG62sAAuXz+PXHJ7Pxnei
	tBI6IEjjq9QRrCAFL8Z2kPUu69Pd1zvY42ZLDHZvsBqTsjLnCr6aN48rvlWDmXB1sqEFL2jud4M
	mtY76DXpJSGNUHR9nPn0qde0c1hSw1Jj9SKaK+/M822JSdAAzI7Iw5/LC3waejLWL+YBRe4mG/D
	ct0824DSYWWipmqCgL
X-Google-Smtp-Source: AGHT+IHZeutMutt4esVNRapvQ9J/Z5RqsU8ZQldTS4RPxGqd9QwuZ9aFqAW34NuikYYDRpVsKKDUiw==
X-Received: by 2002:a05:600c:4fd4:b0:479:35e7:a0e3 with SMTP id 5b1f17b1804b1-47d84b3b687mr128511495e9.30.1767994844639;
        Fri, 09 Jan 2026 13:40:44 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d7f68f4ddsm235668775e9.2.2026.01.09.13.40.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 13:40:44 -0800 (PST)
Date: Sat, 10 Jan 2026 00:40:41 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: oe-kbuild@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, lkp@intel.com,
	oe-kbuild-all@lists.linux.dev,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: [PATCH 3/5] tracing: Have tracer option be instance specific
Message-ID: <aWF12Wjv_MIKu6hQ@stanley.mountain>
References: <20251105161935.545400234@kernel.org>
 <202511071533.domGENBS-lkp@intel.com>
 <20260109102301.19daeb27@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260109102301.19daeb27@gandalf.local.home>

On Fri, Jan 09, 2026 at 10:23:01AM -0500, Steven Rostedt wrote:
> On Mon, 5 Jan 2026 18:23:31 +0300
> Dan Carpenter <dan.carpenter@linaro.org> wrote:
> 
> > Hi Steven,
> 
> Hi Dan,
> 
> > 
> > kernel test robot noticed the following build warnings:
> > 
> > https://git-scm.com/docs/git-format-patch#_base_tree_information]
> > 
> > url:    https://github.com/intel-lab-lkp/linux/commits/Steven-Rostedt/tracing-Remove-dummy-options-and-flags/20251106-010511
> > base:   https://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace for-next
> > patch link:    https://lore.kernel.org/r/20251105161935.545400234%40kernel.org
> 
> This is an old patch (v1) and v3 fixed this issue:
>    https://lore.kernel.org/all/20251110234341.767135255@kernel.org/
> 
>  and v4 was applied and is now in mainline.
> 
> The patch you are reporting on was sent Nov 5th, the fix was sent Nov 10th.
> 
> Why is this sending reports about an old patch that is obsolete? Is there
> something wrong with your setup?
> 
> -- Steve
>

Yeah.  I appologize.  That was my bad.  I accidentally was looking
at old emails.  I think this was the only one I sent, though.

regards,
dan carpenter

