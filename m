Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FBA833ADA9
	for <linux-trace-kernel@vger.kernel.org>; Mon, 19 Jan 2026 14:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768833574; cv=none; b=gi1Q2HaZ7dj/j0dtXNWxBO4HtHPH/b+NYiN+TLpmbxtyVli2NrkZBlRS5VTlXp6MYkUOB2Uab4KDpi2ISD51Box1ZWLDrn7sKR+KIfpdZgmfvRaAd7lnTAo9xzBbEXfunqBy/vixJLABv/6JnM92cy+vIYEmxZBOXiP73d0ogj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768833574; c=relaxed/simple;
	bh=2dJlh51NJrHUTf0lubg/WtQ1TdYnj9PHI5PYAn7cutk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Txp83Cp37rqUTDGFbrKcc0kGsuUU+7OMIFXoVfgeBsvFknlPdxWJ4rSJuJYGqSqh3/jwfr0lfCdFAa9LCtF5DmJrN0i92K8/Kw1scLxjRt/rSs5DUYc7EPChidYVPSp1Q9Ff4lCsjUeJrxdl7ARXQtrDPmQBaAZSpFbj0PEjNso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=Vw298HYo; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="Vw298HYo"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-47d63594f7eso30150155e9.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 19 Jan 2026 06:39:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1768833571; x=1769438371; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=C44Hzf/BGJ1hEivAUCRdCyF7sts8+63+SuDB5GtrMgM=;
        b=Vw298HYocLGGUOby2R/LVDj9JCdtP45KTgKBBxyc8IW0Ntie8X+YOKkmUPAuxP37Qr
         rHKszYQsmGc1hQJM5cnDRzDiM1ZgnGQDbE4nQf1VF5YAK0JOUPhGouf/cHaL50hOOvMp
         8lc3agf1mw5WwaKKtKKpiIRdr2SGqKnBgpvauYpUqUvt6y8mgjOrOWKFSjhqyE3qQ5Rn
         ttQvuAboQ+UVyEyt4JjRsmhIYcvCXf+ff+sBc7BhlOIvccSTX8ds1srDQqh/v+n1S0Tl
         pRagfkoyhR7nmFvm+j6CBO3vqK+3Z+0eifieazA1rkWFRO3AzONxJgma/EeOUlVss8FZ
         e+tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768833571; x=1769438371;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C44Hzf/BGJ1hEivAUCRdCyF7sts8+63+SuDB5GtrMgM=;
        b=lPJRDPBtr1Tfl+d0ofQzAPDXlVT+DHsIb/qQFDHAuwno175D6FEdzurDSYrBFwtafu
         IAfWh6vmEXpNeIajDS/IBrokZggYgB2wsaNU27vahP4yDd22ktpFJ4UzsrfIRynU+xcy
         N0FkivJdoU7ThrI3vkvHDzjEbnWmaTSyqsF6kjVIros4TBx3Fb4gGO9ZYUnfryNtafWW
         FYuawGxhEJRiDRpuJHf2yqgFYK6gUlj0K91tP9F+0C6v8uiza2wVqDqYvIAbt1k0+Fcu
         2CH4YoZn6bVp3DwMo50HTsW+lvprBXteJjWKFWsqtdOREmQXsAl59N7sKmLnRhxOnQkH
         /2vQ==
X-Gm-Message-State: AOJu0YzzP9zHRfczAnim3IYZ1J9wsL5Ud6tVoVPyOkEGcd75Vx3ufWty
	nSpCS6DRcSoE2jM03vkDhapHXU54r03Zs8l7N/ym4FZ6VbAhVT4XG3F0mSrvUZtj/j0=
X-Gm-Gg: AY/fxX5ELDrtK8cFsXnyieau7icBCHSQFygQ02o4sX9GqxPdwN5QyMT4uilNK1OBgyp
	IVojgNN0QX98sKdMZ9swoaQw30pdTKBhvZxCy1LJFt2KCT1K1S8V/svWu+hb3TYhQ7hhAL69y2r
	t/91nQ5zZwegv0uguILn5XsOOPd4F2YpHLDVlwlcJl6K53Yy4I0fd66710h/Sk39g4Lc8h27NUi
	vTa8b0mPuDRg4M1BSpRJiYW/eztBV4d+55PS1zi4s+3bnLOosZq8lUURXShj1uvlkNfXZkz1uOT
	XaT8QfvjsgmaTsVh8H4ctIKxnt4uBrHpmDVeoqcWiflreOihCXe8Pp3Hmo06jY5q6aWeU1KE7pK
	n5VwaIkM6T0mlpkyeqsYZXHcISFN8i/NYmDqbDgl/Zpnxho7c7omr7mOa05XATkEzQBpqVn2OYC
	j1t1BgBKbbwyMykrr570hzBFvs1kJ7j0EUbnrWVsj554VqZ/M2f6442XZntu+kQCOAGr/VPBosS
	z7+M5Hgll+35NikH4rNHKbOiVpfDUBiBvxXOV8Paaf+2vJKZLK1zloPJ+4BU+4IAFEOzJuu
X-Received: by 2002:a05:600c:a305:b0:480:2521:4d92 with SMTP id 5b1f17b1804b1-4802521516emr95758905e9.24.1768833571562;
        Mon, 19 Jan 2026 06:39:31 -0800 (PST)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47f429071a2sm249813135e9.11.2026.01.19.06.39.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 06:39:30 -0800 (PST)
Date: Mon, 19 Jan 2026 14:39:28 +0000
From: Daniel Thompson <daniel@riscstar.com>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: linux-trace-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH] iommu: Fix NULL pointer deref when io_page_fault
 tracepoint fires
Message-ID: <aW5CIA1aCC8FVyFl@aspen.lan>
References: <20260116-iommu-io_page_fault_null_fix-v1-1-6c20c2e62987@riscstar.com>
 <fca8f2cd-c3e5-40b0-a793-bded109e37bc@web.de>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fca8f2cd-c3e5-40b0-a793-bded109e37bc@web.de>

On Fri, Jan 16, 2026 at 05:02:35PM +0100, Markus Elfring wrote:
> …
> > Fix this by adding logic to the tracepoint to safely propagate NULL.
>
> * How do you think about to add any tags (like “Fixes” and “Cc”) accordingly?

I could add a

Fixes: f8f934c180f6 ("iommu/arm-smmu: Add support for driver IOMMU fault handlers")

However, who do you think I neglected to Cc:?


> * Would a summary phrase like “Prevent null pointer dereference for a tracepoint”
>   be a bit nicer?

I don't understand what is wrong with the original phrasing. Can you
explain why this change matters to you?


Daniel.
