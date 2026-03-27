Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 588083F7A99;
	Fri, 27 Mar 2026 14:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774620994; cv=none; b=f73L4nNmI9/05aqiAOlOxEcJKjFaFwTd8oxJ+jI0cDSw3KsR2b46VfpLqOhLCkl7QlzNqtrMqH/k+QWtrQ2v7FlyfSftZ9Z7vAa3jvg8goSw3vIsWYB43CZGrYgn+pTadozLFJ3D11egl+TaTC/I2FAT8X0YEYhhsnfFQbApYtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774620994; c=relaxed/simple;
	bh=35cGEaNcbPb451YamWMiFjEsrnJqgA06YeeGl6bu7EM=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Y0UVbQFlEkl3GgcBb0B1OUfzl6H3DaDzXCmyuNUyawK4VvXFlSvhq1X5FxI1a6YCS3EIvZlHBsXkby3SiVMat/IwuVhwPDvfUNcj8stGLb5O0w9BFxih9ffiP2Hu2MUWK9OKaXWYuwC0WtEPd1dHQ5BJpIpeSpmhtiu6faPChEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h1HP9IwA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h1HP9IwA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34363C2BC9E;
	Fri, 27 Mar 2026 14:16:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774620993;
	bh=35cGEaNcbPb451YamWMiFjEsrnJqgA06YeeGl6bu7EM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=h1HP9IwAGuGI01k1YFTFyCwYaWnoCTyhbklGOApwxFW6lpLuF4cVjs9B2JYRLKoZT
	 ihkNytV5P8CIgRUY6FkydPeg3irU4+wK+ck95RYi+duT3n9mudvLC5qf6NCV/80yMU
	 5xTDu22EzzAfXIE+892Uj35AxEs/q6fboKYMWk02qpq2V2KFlbOHI3am9LeKif6U7i
	 ovs4DObn3Z1Lw5BUVVyP8zhDHLDB8mD4u+Z2uDla9aw2Udj5UPIClfm56RHqXuuedu
	 Z3jaEoXCnS+8D+EUJe8eiGETKcedRD+2Y7Wd9gYtdwiYq9QJkthg9jQeiqaauWvTbZ
	 GEKI4JcEh0jGw==
Date: Fri, 27 Mar 2026 23:16:30 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Shuah Khan
 <skhan@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 oss@malat.biz, paulmck@kernel.org, rostedt@goodmis.org,
 kernel-team@meta.com
Subject: Re: [PATCH v2] bootconfig: Apply early options from embedded config
Message-Id: <20260327231630.2d6f4273b7d615bda4b51053@kernel.org>
In-Reply-To: <acZX_IXQiGwMMi5e@gmail.com>
References: <20260325-early_bootconfig-v2-1-6b05a36fbfb5@debian.org>
	<20260325232204.05edbb21c7602b6408ca007b@kernel.org>
	<20260326233042.f52cfc127ec934d52713bce1@kernel.org>
	<acZX_IXQiGwMMi5e@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Fri, 27 Mar 2026 03:18:31 -0700
Breno Leitao <leitao@debian.org> wrote:

> On Thu, Mar 26, 2026 at 11:30:42PM +0900, Masami Hiramatsu wrote:
> > On Wed, 25 Mar 2026 23:22:04 +0900
> > Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> >
> > > > +	/*
> > > > +	 * Keys that do not match any early_param() handler are silently
> > > > +	 * ignored — do_early_param() always returns 0.
> > > > +	 */
> > > > +	xbc_node_for_each_key_value(root, knode, val) {
> > >
> > > [sashiko comment]
> > > | Does this loop handle array values correctly?
> > > | xbc_node_for_each_key_value() only assigns the first value of an array to
> > > | the val pointer before advancing to the next key. It does not iterate over
> > > | the child nodes of the array.
> > > | If the bootconfig contains a multi-value key like
> > > | kernel.console = "ttyS0", "tty0", will the subsequent values in the array
> > > | be silently dropped instead of passed to the early_param handlers?
> > >
> > > Also, good catch :) we need to use xbc_node_for_each_array_value()
> > > for inner loop.
> >
> > FYI, xbc_snprint_cmdline() translates the arraied parameter as
> > multiple parameters. For example,
> >
> > foo = bar, buz;
> >
> > will be converted to
> >
> > foo=bar foo=buz
> >
> > Thus, I think we should do the same thing below;
> >
> > >
> > > > +		if (xbc_node_compose_key_after(root, knode, xbc_namebuf, XBC_KEYLEN_MAX) < 0)
> > > > +			continue;
> > > > +
> > > > +		/*
> > > > +		 * We need to copy const char *val to a char pointer,
> > > > +		 * which is what do_early_param() need, given it might
> > > > +		 * call strsep(), strtok() later.
> > > > +		 */
> > > > +		ret = strscpy(val_buf, val, sizeof(val_buf));
> > > > +		if (ret < 0) {
> > > > +			pr_warn("ignoring bootconfig value '%s', too long\n",
> > > > +				xbc_namebuf);
> > > > +			continue;
> > > > +		}
> > > > +		do_early_param(xbc_namebuf, val_buf, NULL, NULL);
> >
> > So instead of this;
> >
> > xbc_array_for_each_value(vnode, val) {
> > 	do_early_param(xbc_namebuf, val, NULL, NULL);
> > }
> >
> > Maybe it is a good timing to recondier unifying kernel cmdline and bootconfig
> > from API viewpoint.
> 
> I'm not familiar with the history on this topic. Has unifying the APIs been
> previously considered and set aside?

Previously I considered but I found some early parameters must be composed by
bootloaders, and they does not support bootconfig. Thus, I introduced
setup_boot_config() to compose kernel.* parameters into cmdline buffer.

> 
> Given all the feedback on this series, I see three types of issues to address:
> 
> 1) Minor patch improvements
> 2) Architecture-specific super early parameters being parsed before bootconfig
>    is available
> 3) Unifying kernel cmdline and bootconfig interfaces

I think we can start with 1) for embedded bootconfig for this series
with using bootconfig in parse_early_param().

For 2), I think it needs to check which parameters are expected to
be passed by bootloaders, which does not care bootconfig currently.

For 3), eventually it may be need to change how kernel handle the
parameters. I think I need to introduce CONFIG_BOOT_CONFIG_EXPOSED
option which keeps the xbc_*() API and parsed data accessible after
boot (Remove __init) and exposed to modules, so that all modules
can use xbc_* to get parameters from bootconfig directly.

Thanks,

> 
> Which of these areas would you recommend I prioritize?
> 
> Thanks for the guidance,
> --breno


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
