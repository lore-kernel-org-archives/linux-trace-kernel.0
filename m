Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE7948AE0D;
	Wed, 17 Jun 2026 15:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781711898; cv=none; b=V5VTsI/EXUmo+qrIC8qHvMi6yq83CoDJm0WzBNwpAm1w6q+cXoK/MAFq6l976giDCrkHUbE3jCsLC9Pu4csuTQdo4ksPxsiAPPPJsL/4AgZ03FfxvAvJP49ykOwXhZFzdHDJ7cOobDOXpdA5xw7k68T+bacybclwPFLjXBCtjis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781711898; c=relaxed/simple;
	bh=ffytNPU0txI3nkYOG+24QalnR/KA0QnKt4NWojxBj4s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Kq3in1MPbtDUYJy6X4YGBu2ZB99i5mNs8+SnmQHgQBnLQ9OWM+kYwdlCPqQtNHzELfV4ievVO3Im299pH9r+Pnk5Wx9vdPXxZx5XXi1q4m62kXQf9WlKd43XWNb08aY/EntgeIJeGUeW0CfAvM3Yk3htCvHxU8eJGhu996nZu0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=u5TXry66; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3K4FHJB+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="u5TXry66";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3K4FHJB+"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1781711884;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JdHXXa5bQIcoI4PiaDNN2L5dDXndxXkTAhOkpdwHX10=;
	b=u5TXry66OCID2FW7WENB4viz+Afh9IdlB93BhS6RPOZa0jWj9vDhMuRG9lbQXxLQDOwSNz
	JqiFehYURhvseri5nhZXq4Otm6airOj/tOa1yGCAI9NGGC2IhqQ3O4zdYOIko0ri5IDf22
	6wzIXNxIfvLzEA27ARQX92OTGPmzT+zmNZxaYhdKquny2J08+K5b9p4O969SG2pcxlEMiL
	j93qo6zPFu7fGp4InZeNxgY4U1PeecpcQqLFtO/sv0o75RRwhZtmfdCQ2AgdktLHwzHfmY
	MWawRi4AffRRu4Gx2LTLUsNGk24ugatxnyvz5c+4dTAtod4d3LW0axNBMsyFDw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1781711884;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JdHXXa5bQIcoI4PiaDNN2L5dDXndxXkTAhOkpdwHX10=;
	b=3K4FHJB+J5rYcXEbQWNg+D3giKYJT7xNF88ZRK0Sa88/IoSOFBrfjR2DaDXKaE9jT/JJRk
	4J3HqTUVP2pGfSAg==
To: wen.yang@linux.dev, Gabriele Monaco <gmonaco@redhat.com>
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, Wen
 Yang <wen.yang@linux.dev>, Thomas =?utf-8?Q?Wei=C3=9Fschuh?=
 <thomas.weissschuh@linutronix.de>
Subject: Re: [PATCH 1/3] rv/reactors: fix lockdep "Invalid wait context" in
 rv_react()
In-Reply-To: <bc01343ae74acf6bdf142434aeaa4e6b40aa72a9.1781541556.git.wen.yang@linux.dev>
References: <cover.1781541556.git.wen.yang@linux.dev>
 <bc01343ae74acf6bdf142434aeaa4e6b40aa72a9.1781541556.git.wen.yang@linux.dev>
Date: Wed, 17 Jun 2026 17:58:03 +0200
Message-ID: <871pe56tx0.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

wen.yang@linux.dev writes:
>  void rv_react(struct rv_monitor *monitor, const char *msg, ...)
>  {
> -	static DEFINE_WAIT_OVERRIDE_MAP(rv_react_map, LD_WAIT_FREE);
> +#ifdef CONFIG_LOCKDEP
> +	static struct lockdep_map rv_react_map = {
> +		.name = "rv_react",
> +		.wait_type_outer = LD_WAIT_FREE,
> +		.wait_type_inner = LD_WAIT_SPIN,
> +	};
> +#endif
>  	va_list args;
>  
>  	if (!rv_reacting_on() || !monitor->react)

From my limited understanding of lockdep, this looks fine to me. It now
will not warn us if reactor takes a raw_spin_lock, but I think it's fine.

But I would wait for Thomas's thought on this. He will be back next
week.

Nam
