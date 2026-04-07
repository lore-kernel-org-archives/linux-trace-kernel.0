Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7CFF38B7DB;
	Tue,  7 Apr 2026 10:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775557165; cv=none; b=AMKBJZVNCzSpXWpjHUkVZrOg14nDmXoL48Z5zxDWfsIrvV3BUyVHFCHsjaJI4fyR8Kst2kHqIbxhzgzvIZoLVIbqU4z3Y4VHNKyzCR39WVWYnS3JSVHGPLkzCOd36lSorO7PMAhrTatChAlMUpE2Bd1rYvZwfZTyIvnxXW3ca+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775557165; c=relaxed/simple;
	bh=cFu9iV3KLh6c/ypGHNHvXaZZWxQZTF2gBZh7fS9zwAQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dZsi/7JdIunPl1uXP9AQmDp4VSSLzoSTSd0uq6o6oQkJaXQSofJBMfr6Tv0krztnSX5XH08/lo/wuaEicmEiM75N6JR7bQbhZekD9jXilZlOkKOHIB8N6nRUQC3CSxXl63DDeKxUVAe/GRE2PQiXX/3KCvsKY6gWFX05yMP7Bi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=GOvkyM5G; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="GOvkyM5G"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=VFDVchFaNKi+sA5axj4zEOdZ4xD0dqs17PnYt1n9CxA=; b=GOvkyM5G7jzAdaIECXTpX1rw7/
	eAueMz4oNLqDlnWPSjtO5AFxCddt63pPkjIxjs/opu3PzfJ0OLKQ44ZYIoZsqYrP0vUPYt+4XHOGF
	JyU4Yyq0hY/4afNIXpgOeNM4mBaB1zZhK8VuQ2vaqdKtMneLgq9r4FM+qL2YBqvQw0HJZyC4yf7N0
	S0oQUJsbmO4DTU0hcI9qJoM1EDTwul+MnmJNcO7LUkr06yvZIiWdYhanwVs0EiNlRbJ+cUtKW6AQn
	MGEk3uR8M4mY6U73KE0EsvkqI+ieukyA0fInStERcZBnH1bsAUGHA11/DeE3x84ptqLFKcu2KI95Y
	HWJjuC0A==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wA3Wd-007ZeC-2m;
	Tue, 07 Apr 2026 10:19:14 +0000
Date: Tue, 7 Apr 2026 03:19:09 -0700
From: Breno Leitao <leitao@debian.org>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, oss@malat.biz, paulmck@kernel.org, rostedt@goodmis.org, 
	kernel-team@meta.com, Kiryl Shutsemau <kirill@shutemov.name>
Subject: Re: [PATCH v2] bootconfig: Apply early options from embedded config
Message-ID: <adTX6h4Ej5jOcONP@gmail.com>
References: <20260325232204.05edbb21c7602b6408ca007b@kernel.org>
 <acZPZ4XKy4QynznK@gmail.com>
 <20260327223744.f246150adc1671f7605a4f0a@kernel.org>
 <acpzhCBEPh-tKVqg@gmail.com>
 <acqJk-zbyjIiy6hJ@gmail.com>
 <20260331125827.157a833882830007ea9b0b31@kernel.org>
 <acvjcCqIAeHyIiQN@gmail.com>
 <20260401224853.d8ed517a344c4be51d371a9c@kernel.org>
 <ac0wz_eW5Zgi4t45@gmail.com>
 <20260403114519.14e326a4bba019373bf3ff09@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260403114519.14e326a4bba019373bf3ff09@kernel.org>
X-Debian-User: leitao

On Fri, Apr 03, 2026 at 11:45:19AM +0900, Masami Hiramatsu wrote:
> > I'm still uncertain about this approach. The goal is to identify and
> > categorize the early parameters that are parsed prior to bootconfig
> > initialization.
>
> Yes, if we support early parameters in bootconfig, we need to clarify
> which parameters are inherently unsupportable, and document it.
> Currently it is easy to say that it does not support the parameter
> defined with "early_param()". Similary, maybe we should introduce
> "arch_param()" or something like it (or support all of them).
>
> >
> > Moreover, this work could become obsolete if bootconfig's initialization
> > point shifts earlier or later in the boot sequence, necessitating
> > another comprehensive analysis.
>
> If we can init it before calling setup_arch(), yes, we don't need to
> check it. So that is another option. Do you think it is feasible to
> support all of them? (Of course, theologically we can do, but the
> question is the use case and requirements.)

I don't believe all early parameters can be supported by bootconfig.
Some are inherently incompatible as far as I understand, while others
depend on bootconfig's initialization point in the boot sequence.

Regarding documenting arch_param(), I need clarification: should we
document parameters that are currently called before bootconfig (as of
today), or those that fundamentally cannot be called by bootconfig
regardless of its location?

> > Do you have any additional recommendations if I proceed with this
> > approach?
>
> OK,
>
> First of all, even if we enable early parameter support in bootconfig,
> this is only possible if bootconfig is embedded. In that case, we can
> pass memory that has been pre-allocated at compile time to bootconfig
> as a working area. However, this will consume a lot of memory, so it
> needs to be selectable in Kconfig.
>
> If you're going to embed this, as Kiryl pointed out[1], it might be better
> to pass pre-normalized (or compiled) data and avoid using a parser.
> Compilation itself is relatively easy if you utilize the tools/bootconfig.
> (However, in this case, there doesn't seem to be much point in using
>  bootconfig in the first place because we also can use embed kernel
>  cmdline.)
>
> [1] https://lore.kernel.org/all/acueCFv4neO7zQGI@thinkstation/
>
> Can you clarify the main reason of requesting this feature and
> examples?

My primary objective is to enable early configuration of
`irqchip.gicv3_pseudo_nmi`, allowing the kernel to support pseudo NMI
on arm64 by default.
