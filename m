Received: from mail.nearlyone.de (mail.nearlyone.de [49.12.199.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A51D21DB94D;
	Fri, 13 Sep 2024 13:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.12.199.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726235249; cv=none; b=mLuIHFmmnnU2OD8OojjBrEEKVtNTjl34tLy3tayL8h/VdqmK9wKPwb1BBBSbCxAtErUwtfbBZCFULbVB14IDJhTYaTYFXIqzkfGy6zlrJJ56aN1rNn8lTD3U4wOaip61an9o+atq+fKUzHnIVgnSldDjt5fi3k7+SoEDlgxjqjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726235249; c=relaxed/simple;
	bh=GZG5Q4PYxwRPU+OS+/CNkqCPb50HPjc3xKewmpW3GLg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I+ggPBhaAPP7vwFEEy8R7Z6K54HM78LTDUVDKI8w8cNWiX/fTdybRkxg6tV+en0N6Gaz5txGmlqOrZ8RlDIPRKsnvo0BbnLcrK7Ov9Nl5UNUV9eM6MRfhQBcm2DejsYShUYqmugRyzDNPARxvA/5Z0FEtaWpF8hmQivSL+wDW88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=monom.org; spf=pass smtp.mailfrom=monom.org; dkim=pass (2048-bit key) header.d=monom.org header.i=@monom.org header.b=aXiK1slG; arc=none smtp.client-ip=49.12.199.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=monom.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=monom.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=monom.org header.i=@monom.org header.b="aXiK1slG"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 258F2DAC06;
	Fri, 13 Sep 2024 15:47:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1726235239; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=fZY5alxMSv52zndyax4LhSJk/d8fGq0vKOA63eoQKx4=;
	b=aXiK1slGH1j2yTrch4uqHfTFeQW6E0zd6/Y/RyADbTSnM0wCvFOs0SczdOsmbJVpY/2pvb
	JPuss1YGuE99LTEnFKsVFanFAsvEwkMu0OxHAa7dWjs59R4aDONA1q9YQnhsyU4OMydrNC
	ZGYUJXVvo+ySq/uhd/YL25q0ykLkN+uWDt7oT1cncJL7vV2HSkJjsxvM267xPuw1yd/hwu
	8A57QsoQrp7tMoBZQCQF3kcPWvlp953VmK/oWSjI8azzg6xXNhps16IBAdieE/zm9TFdGi
	CMrcy+v2q5w9nsdJJ07qUNr+Eke+VV+NUp9h4lyUItkGob6XFgbuiLXLTSKyqQ==
Date: Fri, 13 Sep 2024 15:47:13 +0200
From: Daniel Wagner <wagi@monom.org>
To: Muhammad Usama Anjum <Usama.Anjum@collabora.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, 
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Daniel Bristot de Oliveira <bristot@kernel.org>, kernel@collabora.com, gustavo.padovan@collabora.com, 
	helen.koike@collabora.com
Subject: Re: [Report] rtla: Failed to set runtime and/or period
Message-ID: <5b7e6aa4-8fe1-4ba3-b5e9-80bfa710afb9@flourine.local>
References: <d3468fce-088c-45d0-8543-a2bc9fef07c9@collabora.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d3468fce-088c-45d0-8543-a2bc9fef07c9@collabora.com>
X-Last-TLS-Session-Version: TLSv1.3

On Thu, Sep 12, 2024 at 06:58:02PM GMT, Muhammad Usama Anjum wrote:
> We are running rt-tests on KernelCI. I'm looking at failures and I found
> out that rtla osnoise and rtla timerlat are failing. We have just
> enabled these tests and they are failing from day one.

Thanks a lot on working on this!

> The first thing I fixed in my local setup is to sync the version of rtla
> with that of the running kernel from the source. It resolves the Tracer
> timerlat not found!" error as we had installed the older rtla package
> from Debian on CI.

There is some dependency between kernel version and the rtla tool suite.
I suppose there is a window of version which you can differ but I
suppose the Debian packaged version is way too old for recent kernels.

> I'll update it. Is the version of rtla dependent on
> the exact kernel version or any recent rtla version is acceptable?

I have to figure this out. It could be that we need to build/provide
matching rtla versions to the kernel. In theory the API should be stable
etc but I suspect the APIs got broken (not on purpose) in the early
days. Anyway, we have to figure this out as we can't ask Daniel sadly.

> The other errors are persistent:
> 
> ➜  sudo ./rtla osnoise hist -r 900000
> Failed to set runtime and/or period
> Could not apply config

This works on my Tumbleweed kernel (pretty much a vanila kernel)
6.10.9-1-default with the matching rtla version 6.10.9.

What version do you use?

> I thought maybe some argument are wrong. I ran the example from man page:
> 
> ➜  sudo ./rtla osnoise hist -P F:1 -c 0-11 -r 900000 -d 1M -b 10 -E 25
> Failed to apply CPUs config
> Could not apply config

Same here. This works on my local kernel.

> Is there some configuration which is missing for running rtla? Please
> let me know.

Are these

    CONFIG_OSNOISE_TRACER
    CONFIG_TIMERLAT_TRACER

config option enabled in your kernel?

Thanks,
Daniel
