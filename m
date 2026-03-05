Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E26CA3A1E84
	for <linux-trace-kernel@vger.kernel.org>; Thu,  5 Mar 2026 18:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772735740; cv=none; b=X+zv/Fz/xNCx5gn7TZThfjjkhvBUhxoy0NjlrYSiGhEAXIGw3CuFaDOY5pZkhG9u6Y3aetfjzwoO+8vpVJi7m2+btm1+Ozm7zrmIbr/33rLXUbADGlaosz32OcbiJM+hLwnCkynUpmTn7iyOo7NUvNUZdkcUqaIvPpMj0dS2xt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772735740; c=relaxed/simple;
	bh=/2DbjUHnT80T7lxCR3Ys8zzU7qzwgw+67gVahd1hgzI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NfsTZnC3xrxVXzSQXSwscFJx4uD9YFTdSEaQTE7/i+YdbrotoozvQpcniFsxyPLtoq2zoG0ggyspEWlkGsZcO1tjVd5ZOY+OIyaLjelLkJT2HMeXfd1hwzhQ64d15e2S6vQv+Mx/ePN5ePiJRRnnSikudiCQx6OOITW4TnkoseU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=riPmV9Rp; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="riPmV9Rp"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-48378136adcso50760115e9.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 05 Mar 2026 10:35:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772735737; x=1773340537; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rT3HFFE0hN5Iv+Nkv4cLwwjitenY62fCR7k08+CamVo=;
        b=riPmV9Rp/eB2R6EQH4uCNRi5WcXqzuX68HgswDd9xGzVpEFHiTmT8oTCyg3y6ogxVs
         66Jm0V83flldSwvzMT9OkD4DHS1HzUbB+XvDO/jIES+V3b6j5RzrwdEEqjhratowxj+7
         wNvDpo8uLwWBTcDJaa/HCPCvwoIMQ4F+9bIErqrsZdhSlBEg6eXLxv9NGLlz4JghxWF1
         k4R0w2eGfwDni3l71w9zKNTS8YBdolVWHMN1auzZPe4gAXaHsZK9x9bEUkNxAUAsJ+Wy
         yMdrDsAesm5AStwN19YFssYFvHqiXTPziqMYSA/6o7lYpSKI04tYnOIAXPb9SG2P+wZm
         m96w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772735737; x=1773340537;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rT3HFFE0hN5Iv+Nkv4cLwwjitenY62fCR7k08+CamVo=;
        b=Kx9R0BTBwkEUqA+pyDVuuO7SdSfuElKczXQA1aMpW3FxBZo/y5wpyDP34GB6zDJoPp
         ck/SmJdWkeGV5e5okEXkCJGvrRGuu4YEpsRGDP7JCQe7ZXD0ElckZjNUVEoWTQP5XUar
         SZpAXYFiaoqa/F4m7a/fzEzLzVhN7ycTNG5f36aHYk1ryzkTLNwWYer2t7oxV9ycaWOG
         KAK6EVLsLtXrldu+lbT9tTcOTgTb599900/OMgMgX9A6tjz64n9p/UZJYhMF3CCQWlPN
         8qU4R90cFJhe16ir2r74cdRB0H7ClAW6QrLBcNRwTbecptfJCcpwGl/BOSZ/jtGzpHcR
         OQNQ==
X-Forwarded-Encrypted: i=1; AJvYcCV9gL0DgIoKGVcAOaQAB77oPz94SM4nmKkMHLvjb4dp+tGGYYMT1SAggUhK7pYZ2d7urQ7phhpUeZnQH9m7/oXZiyQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5lcNlQXqUYvuBIVgJZcJ0AGMSs1xTnwDJ1lu+DXzSwMG51nmu
	Eg1Kx0cuBXpCah2D4qEA+nacuYx1FdUx8YvULBRdcqG3tSpTdi+mm+Ko6NA1wUw5TA==
X-Gm-Gg: ATEYQzwWQT+NVDAGbPFLNphbMKw1AeZj3WWlxO6PUhcqgtXzqxLBFNgMHwwmiZH3Zmr
	Op9KFeK7u6McjhWa7gqyBRXXgGS1NJboBHxPPjh2keQvyzLKJbt3dsUDqUygzt+Mtr57dppVeRb
	K3nIovod8+BDUyiH9ltaCDIi8UnlxUpRahBk5DTI5VTFm7GQUdSy1a2FTMN/uK5RTRDI4T/B9GM
	RCufZJv3xpUxFj6Xt/mN6sgNgIPaxLhudtfHKVHsNOwBy+r73t2UJhZ3IBRLZuHwLOD0fxHgYry
	1Q8QSY44cpmADnoM9n8UerW5aTk5HS9yngEhQTZI47FebOjNCzyF3gOr7Zixxw9SPqHyi0jq802
	YPyrrCNvqAwJPJFuP20HchBej28ffSJ6s6k++NXcj5a+aAbD7C2fEgsez6Suy9Zb9hOnO8h2gDF
	U+AnNyUrk3atR1PXk7+Zrkk+aM8djenXQ93W1h1FmLlyTYPrlTJH4nGuFuUUYzs0OIrow=
X-Received: by 2002:a05:600c:529b:b0:47d:25ac:3a94 with SMTP id 5b1f17b1804b1-485198840ddmr121717605e9.17.1772735736986;
        Thu, 05 Mar 2026 10:35:36 -0800 (PST)
Received: from google.com (198.115.140.34.bc.googleusercontent.com. [34.140.115.198])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4852378de86sm2222085e9.4.2026.03.05.10.35.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 10:35:36 -0800 (PST)
Date: Thu, 5 Mar 2026 18:35:32 +0000
From: Vincent Donnefort <vdonnefort@google.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Marc Zyngier <maz@kernel.org>, mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com, linux-trace-kernel@vger.kernel.org,
	oliver.upton@linux.dev, joey.gouly@arm.com, suzuki.poulose@arm.com,
	yuzenghui@huawei.com, kvmarm@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, jstultz@google.com,
	qperret@google.com, will@kernel.org, aneesh.kumar@kernel.org,
	kernel-team@android.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v12 00/30] Tracefs support for pKVM
Message-ID: <aanM9DL_jKkhHHAF@google.com>
References: <20260219150307.14538-1-vdonnefort@google.com>
 <20260219130220.063c8db3@gandalf.local.home>
 <87cy20eeg6.wl-maz@kernel.org>
 <20260305111703.6346b243@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260305111703.6346b243@gandalf.local.home>

O Thu, Mar 05, 2026 at 11:17:03AM -0500, Steven Rostedt wrote:
> On Thu, 19 Feb 2026 19:11:21 +0000
> Marc Zyngier <maz@kernel.org> wrote:
> 
> > > 
> > > Then the arm/kvm folks could start with that branch and add the arm/KVM
> > > portion of this series on top of it. This will prevent major merge
> > > conflicts in linux-next.
> > > 
> > > Does that sound OK?  
> > 
> > That works. Just send us a link to the branch after -rc2 and we'll get
> > that sorted.
> 
> Vincent,
> 
> There's a few minor conflicts with this series and v7.0-rc2, can you rebase
> and send again?

I'll send a rebased new version tomorrow.

> 
> Thanks,
> 
> -- Steve
