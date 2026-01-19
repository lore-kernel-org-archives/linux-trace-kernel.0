Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C3E2DC79A
	for <linux-trace-kernel@vger.kernel.org>; Mon, 19 Jan 2026 16:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768839331; cv=none; b=pbJ0whDlE/SWMS91A46+GlWlEnLrGXfDqq/NDPAXu+on49wzrgBQL8bCq5UXto8TQQi9qt82wJfgqgQX6EZhla2FeANcbQFUZ7/osUTF749MTqMPtKXRnOW/vbtco9hT0In9wNUVMsBtL1avkwIogD/cQ2MoPw+VlQhO+YcjpVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768839331; c=relaxed/simple;
	bh=Lj8EWfO4d5xx46YqC9/DQ+Bjt0ijTkrqc5EhsyRcKe0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NDbAOQNLMAnW8GzMEBM2k7ZuPbwWGraWXb9ix2/GM6U3ceLmllnYPvVZi7mn9Lc6paV2TZxxAMfmzX4Ft/zwcwOcPeVd5qqRk5Jh9Zsug3mlXzww2wgLS6ZlNvtgpymL6JFDNR8yU51OhpOEbQEAiYM+e9nw3YVOoIniaQDUMd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=K95AaniQ; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="K95AaniQ"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-430f3ef2d37so3500500f8f.3
        for <linux-trace-kernel@vger.kernel.org>; Mon, 19 Jan 2026 08:15:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1768839328; x=1769444128; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=L8EWer9va4PMCPeiXWm5LUi6W7Ruo1VzwHiLnjS8mAE=;
        b=K95AaniQTc5GEr/ja6F2nlQH+F5ErcGvPNm8xuvHXRr8iEhBEIF5IuTyMdq4rHyKRX
         p3HTTEfBDgub4KCgvzlKohsHWzZDRHbV+IzZzD3flJZav3UA6RoNX9BWitAlje0/mNAx
         cumYQnWqKwLgo/YURuMrM+SG4AeUeBWUSB/MkamK/TJcT3YF8BqvohauIRTuP5tidEIo
         rhLREzuvi3YJYTUmt2eJMv4Yix3VAtDzk4NAYdQ4fLg/5uhr2vfV2RmnyccYKNGLkr7K
         jzSsPqL6rikvKLbYUU8WY6KNLmWIsDFwKnNf1lhZcMK1a+Yc5SeEcQLEsIjWPBqZ3zIS
         hnLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768839328; x=1769444128;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L8EWer9va4PMCPeiXWm5LUi6W7Ruo1VzwHiLnjS8mAE=;
        b=eOBM4Cak2cAQgFDun5UYAcGa8bN1blAA3S8etV6cANryELjolYtxH269Eqdwf40s3H
         /4jCzbuciE/nwfMSSOJklEHAxnQFKQYiSHrOdX94Z66+SwgfQagNRJcT03j/Qs+XEdJF
         SSMKyt/eRW953y91+qOPk2aXfIYU9aWYgedzF2+EkUQd5FfoAeCJiCd4qXDjlEpLMTka
         6c6T5nhfqdBCvma0SmBv0H9nsydUuDc+JExaj1624XMw115jSKMvU4r+8G9N9Nz9WgMl
         uj234ca4O2SWRYloxam3zDhzNglx0EMmv0I0UC0YsIBqxL0xv/qId9Ik5LR8Pg4zcNzo
         3Szg==
X-Gm-Message-State: AOJu0YyjPboZq7mNYdqwAHxtQbPz6sdJe7qbVzGJ1rNDJtuv5C6GRsKf
	dCxebvZ/+RmmVU8333KVkhjXpTKUvaHgQRpjHJeqfj5gOM5WetUmi0YApH4OGq2M6O6RUhlceVK
	EMzAE
X-Gm-Gg: AZuq6aJO/GVom1AqBl7WxLOn2D6H4+hrWnZEe0rOcFG624jiprUg1dZRGfseWFyRJqv
	8nqogGZkg9iOY5gNNzTxAC7xtwkvr96W3qlOMT0/BO2i2zRYk3/ffigzY0TEAdv4oRbDen71XxA
	mTT/aPTEJfYRutrBsX6eZtRDTNx4dQ7NWBpwd2FrM93aXMY+psqJOxyN+Lr0tVbO1yamEi9jnMM
	F/T9ah9t2Sb76Qoy28xZ9F5EPe4khaaJEGR/mGmOD3fIeZ7PYIw8D6lgxFbsp9EdTlGeclI3FX/
	M8bJ7IGCqdaBiXx7zjdHCps+Mio1fNf+/vOzvG5R71HKy3Veizim2hJasOZoWudXUJEwyD9W88W
	ra4BKKHOtuv30WTI9IRvxuq6J2X4nY6EZIfCdF/2Zs8JjGvw1h+jR8G04Xvr9czgisjvsmXiOKn
	RxNGCO+tumLfl2P8iQgrFdpldFb0ha35bILN+FSUKaQ64cJ2jVR+pCYGEEEJrp3lIhhS8KQZpos
	t5tfHUUXhrBwhjOIlT0+AuhXNZno1FqaMwFVc4P8YeGxUJzcwswCnrk0CfKlzMNGp3MecnJ
X-Received: by 2002:a05:6000:2506:b0:432:8504:befd with SMTP id ffacd0b85a97d-43569bbb23dmr15947030f8f.32.1768839328088;
        Mon, 19 Jan 2026 08:15:28 -0800 (PST)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43569921da2sm23988345f8f.1.2026.01.19.08.15.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 08:15:27 -0800 (PST)
Date: Mon, 19 Jan 2026 16:15:25 +0000
From: Daniel Thompson <daniel@riscstar.com>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: linux-trace-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>
Subject: Re: iommu: Fix NULL pointer deref when io_page_fault tracepoint fires
Message-ID: <aW5YnTnOJ2dJNuhq@aspen.lan>
References: <20260116-iommu-io_page_fault_null_fix-v1-1-6c20c2e62987@riscstar.com>
 <fca8f2cd-c3e5-40b0-a793-bded109e37bc@web.de>
 <aW5CIA1aCC8FVyFl@aspen.lan>
 <a2aa3091-4a93-48be-970a-8bc506fb0cd3@web.de>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a2aa3091-4a93-48be-970a-8bc506fb0cd3@web.de>

On Mon, Jan 19, 2026 at 04:56:04PM +0100, Markus Elfring wrote:
> >> …
> >>> Fix this by adding logic to the tracepoint to safely propagate NULL.
> >>
> >> * How do you think about to add any tags (like “Fixes” and “Cc”) accordingly?
> >
> > I could add a
> >
> > Fixes: f8f934c180f6 ("iommu/arm-smmu: Add support for driver IOMMU fault handlers")
> >
> > However, who do you think I neglected to Cc:?
>
> See also once more:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.19-rc5#n262
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/stable-kernel-rules.rst?h=v6.19-rc5#n34

That's not what I asked! You suggested I add people to Cc:, who do you
think I missed?


> >> * Would a summary phrase like “Prevent null pointer dereference for a tracepoint”
> >>   be a bit nicer?
> >
> > I don't understand what is wrong with the original phrasing. Can you
> > explain why this change matters to you?
>
> * Questionable abbreviation “deref”
> * when clause

I dislike the proposed new summary. I think keeping "io_page_fault"
in the summary is a much better use of characters than spelling
dereference in full.


Daniel.
