Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1287828D8D1;
	Fri, 27 Mar 2026 10:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774606724; cv=none; b=ZIN8qy1aYr6LN+FV9narsMy2qIoVjN5nZFerixzvo6FE+tMh9M61xYUllLKnjWRIOBH5om0qykF/5o95Oui20nOmIADPr8OUCmfdHhaL8da7yf/AflstX1IaXyhBEOnwiW1bjk3HsPBJoQ32Ddm0Cesdve7LTB+3MSubU1lInKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774606724; c=relaxed/simple;
	bh=o++TphoTF+Z5OBm9AP8a155sJj6yg4o/UJxBa1U4qUM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hw+4ZbSbnw7cPWsyJ0HsstsiOJNkAAG18M1+ICJrG+X4rJYUuxgQ04DkmDZNGONw3eQ+iGVUuerN7CKuArwZTFIl2uXpMFyyezcRP3O3IUDi+urqdGy2ClTPy8qxphRjb0W0Qnua6cGJp3VOy2N7ZsiEXxpq/D4xubAUfsWGbjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=DqaB8gum; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="DqaB8gum"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Reply-To:Content-ID:Content-Description;
	bh=0nFJUo05OWIx8JKCyHATNetSJpt2GXS6ZF3hfagU8X8=; b=DqaB8gumKInYUSX5JgnXJjjE5c
	FHcoe3aV/4MFMNhWRt92tsbE6DdbDLB4qwkZKJ+HdcL7pkCPhWPbAaKdzE35OZrt+sLAHmk8GbIUk
	E/KAjDPqtMNdp0BUmZVkHoCZYH4+q44JNHkq+eafMTC9H9znRxHCYHOMRONS93rmrH2NUtYjjseIV
	7sFQe9oeBMxBu60uwA5/a5xI60gqHsMSPepAUXLUuD2M/bFAavD2q2f/u1udrZ+VnRfI7dSeSye9O
	ai02YkAKrJhqiH6I5NM8VHhLJCivYCWJiKY/GVsE7Gm4CE1S5ebvA0SE/Bh52HGf9OqfIfNs66Nc1
	yrJ4wwWA==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <leitao@debian.org>)
	id 1w64Gy-00AYRn-Pa; Fri, 27 Mar 2026 10:18:37 +0000
Date: Fri, 27 Mar 2026 03:18:31 -0700
From: Breno Leitao <leitao@debian.org>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, oss@malat.biz, paulmck@kernel.org, rostedt@goodmis.org, 
	kernel-team@meta.com
Subject: Re: [PATCH v2] bootconfig: Apply early options from embedded config
Message-ID: <acZX_IXQiGwMMi5e@gmail.com>
References: <20260325-early_bootconfig-v2-1-6b05a36fbfb5@debian.org>
 <20260325232204.05edbb21c7602b6408ca007b@kernel.org>
 <20260326233042.f52cfc127ec934d52713bce1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260326233042.f52cfc127ec934d52713bce1@kernel.org>
X-Debian-User: leitao

On Thu, Mar 26, 2026 at 11:30:42PM +0900, Masami Hiramatsu wrote:
> On Wed, 25 Mar 2026 23:22:04 +0900
> Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
>
> > > +	/*
> > > +	 * Keys that do not match any early_param() handler are silently
> > > +	 * ignored — do_early_param() always returns 0.
> > > +	 */
> > > +	xbc_node_for_each_key_value(root, knode, val) {
> >
> > [sashiko comment]
> > | Does this loop handle array values correctly?
> > | xbc_node_for_each_key_value() only assigns the first value of an array to
> > | the val pointer before advancing to the next key. It does not iterate over
> > | the child nodes of the array.
> > | If the bootconfig contains a multi-value key like
> > | kernel.console = "ttyS0", "tty0", will the subsequent values in the array
> > | be silently dropped instead of passed to the early_param handlers?
> >
> > Also, good catch :) we need to use xbc_node_for_each_array_value()
> > for inner loop.
>
> FYI, xbc_snprint_cmdline() translates the arraied parameter as
> multiple parameters. For example,
>
> foo = bar, buz;
>
> will be converted to
>
> foo=bar foo=buz
>
> Thus, I think we should do the same thing below;
>
> >
> > > +		if (xbc_node_compose_key_after(root, knode, xbc_namebuf, XBC_KEYLEN_MAX) < 0)
> > > +			continue;
> > > +
> > > +		/*
> > > +		 * We need to copy const char *val to a char pointer,
> > > +		 * which is what do_early_param() need, given it might
> > > +		 * call strsep(), strtok() later.
> > > +		 */
> > > +		ret = strscpy(val_buf, val, sizeof(val_buf));
> > > +		if (ret < 0) {
> > > +			pr_warn("ignoring bootconfig value '%s', too long\n",
> > > +				xbc_namebuf);
> > > +			continue;
> > > +		}
> > > +		do_early_param(xbc_namebuf, val_buf, NULL, NULL);
>
> So instead of this;
>
> xbc_array_for_each_value(vnode, val) {
> 	do_early_param(xbc_namebuf, val, NULL, NULL);
> }
>
> Maybe it is a good timing to recondier unifying kernel cmdline and bootconfig
> from API viewpoint.

I'm not familiar with the history on this topic. Has unifying the APIs been
previously considered and set aside?

Given all the feedback on this series, I see three types of issues to address:

1) Minor patch improvements
2) Architecture-specific super early parameters being parsed before bootconfig
   is available
3) Unifying kernel cmdline and bootconfig interfaces

Which of these areas would you recommend I prioritize?

Thanks for the guidance,
--breno
