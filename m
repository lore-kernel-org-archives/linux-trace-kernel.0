Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 387D130C371;
	Wed,  1 Apr 2026 15:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775055723; cv=none; b=q7qyKJAoSkYMPeQdOyBZRWd0BOEVX7KBAn8g1iRnUP5rkQlh5yxT3Q0MQaBiIxhGxkNJCsn/3A/lBy/z8O0HRtuFXRsAU2SwKHdDBQLPiPt2l3g2ZFk2/fgrR/CsYdqzl7oHyJk8NtV8d+zAdQo4h5LMw0RjSjXgwrkj5Qo4qzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775055723; c=relaxed/simple;
	bh=/41jHFMLvQEawsHuNLzVPOrLdBt8POZyw+0Y/fllTrA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iMsu8D5vdx2YG0w87tQ4ntDCVPNC2dkDt1qY3lOTNDVzAncc5W3qeu2jfxDh9poITq3ux1DDeZ4Q0Y8lyb9J3UpiZSu26mgw1OJ/MZmq+yHBaKXB2cCcaNLWEg4iX+bncgaeF0hRr1XXqRRtm4pXIbm50soaooCzJLUz/UsNs0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=cjbTdYsm; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="cjbTdYsm"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=+WzoGOwpf75acULbUdLCCSgMRdoRK75E6CWGbOYR5ZQ=; b=cjbTdYsmL1LugDvbI+G1od+x5X
	U0sjnJlEsTkwTYb4fq9x5jxlzfY3jiMYTWT12dmcSoY7TJpyaZSzBJ3p5pP9eMjZfKu4dVMo60n8L
	KA/a0G/X1klcmoEwRJX7k1QCZya2esiyqTnXRTmO5II47MA8aIVYXgL1YD9afND/II9K4YcMA3mJm
	2/Qyqh8mBrFth06DINUoPWVgJKwTAOyudumsJlPpVIJDZcN+Ig/iWa4w/enSz4UbCWc+4lfOOoUjQ
	LInkGozPY9JYdCZ09QBI/PyKFOvBeNXwD4xvrSj2FcJQa8QLKe/p7HfqdIskdleD81ndLF7vOgPEi
	JWbqceOQ==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1w7x4t-0034E6-11;
	Wed, 01 Apr 2026 15:01:54 +0000
Date: Wed, 1 Apr 2026 08:01:48 -0700
From: Breno Leitao <leitao@debian.org>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, oss@malat.biz, paulmck@kernel.org, rostedt@goodmis.org, 
	kernel-team@meta.com
Subject: Re: [PATCH v2] bootconfig: Apply early options from embedded config
Message-ID: <ac0wz_eW5Zgi4t45@gmail.com>
References: <20260325-early_bootconfig-v2-1-6b05a36fbfb5@debian.org>
 <20260325232204.05edbb21c7602b6408ca007b@kernel.org>
 <acZPZ4XKy4QynznK@gmail.com>
 <20260327223744.f246150adc1671f7605a4f0a@kernel.org>
 <acpzhCBEPh-tKVqg@gmail.com>
 <acqJk-zbyjIiy6hJ@gmail.com>
 <20260331125827.157a833882830007ea9b0b31@kernel.org>
 <acvjcCqIAeHyIiQN@gmail.com>
 <20260401224853.d8ed517a344c4be51d371a9c@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260401224853.d8ed517a344c4be51d371a9c@kernel.org>
X-Debian-User: leitao

On Wed, Apr 01, 2026 at 10:48:53PM +0900, Masami Hiramatsu wrote:

> > The challenge extends beyond that. There are numerous early_parameter()
> > definitions scattered throughout the kernel that may or may not be
> > utilized by setup_arch().
> >
> > For example, consider `early_param("mitigations", ..)` in
> > ./kernel/cpu.c. This modifies the cpu_mitigations global variable, which
> > is referenced in various locations across different architectures.
> >
> > It's worth noting that we have over 300 early_parameter() instances in
> > the kernel.
> >
> > Given this, analyzing all these early parameters and examining each one
> > individually represents a substantial amount of work.
>
> Yes, that may require a substantial amount of work. But to improve
> the kernel framework around the parameter handling, eventually we
> need to examine each early parameter.

I'm still uncertain about this approach. The goal is to identify and
categorize the early parameters that are parsed prior to bootconfig
initialization.

Moreover, this work could become obsolete if bootconfig's initialization
point shifts earlier or later in the boot sequence, necessitating
another comprehensive analysis.

Conversely, if we successfully move bootconfig initialization earlier
by breaking the dependency of memblock (assuming this is feasible), the
vast majority of early parameters would execute after bootconfig is
configured, eliminating the need for this extensive categorization work.

Please, feel free to tell what approach might be better for the project.

> > Are there alternative approaches? At this point, I'm leaning toward
> > breaking bootconfig's dependency on memblock, allowing us to invoke it
> > before setup_arch(). Is this the only practical solution available?!
>
> Basically, the memblock dependency comes from allocating copy of data.
> Only for the embedded bootconfig, we can just pass copy memory block
> to the xbc_init(). Something like;
>
> xbc_init() {
>  xbc_data = memblock_alloc();
>  memcpy(xbc_data, data);
>  __xbc_init(xbc_data);
> }
>
> embedded_xbc_init() {
>   __xbc_init(embedded_bootconfig_data);
> }
>
> Afterwards, we can pass mixture of embedded bootcofnigt and initrd
> bootconfig data to parser again.
>
> (But in this case, we must be careful not to override the early
>  parameters that we have already applied.)

Do you have any additional recommendations if I proceed with this
approach?

Thank you for your detailed responses and insights.
--breno
