Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0290A21B9F5;
	Thu, 26 Mar 2026 14:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774535448; cv=none; b=R8t31xjTk1tWYQmJ7muOPxUblQrhuKLE2PovonHs3ixpTrDzKSyPr7zZ9Vjnd7Q2YUliYiXykUezMoGyWlOw4U97oWvRvGpoVLsDof2sRBN9/8cRR53dKSyDf0yYn+ZUal3u817Skns01bGN37GcPaa9lgvDQpjqqVmJntfpbX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774535448; c=relaxed/simple;
	bh=vYDPnxFpC03iD43jZeheL6iLUaSs0dhG3IX1X1iA0vE=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=p+JRB4ApUynOSIcQ3KvLbBYow6Uj0ptgOredzqGFnfCpNKGGzL95qd710ZVACgd3vpVvyEK2rT7c67pXXmOY4i50qG0nxFTPV6EcqYIqM6/Wn8gpMBa4aeZoaXL/ZhEC/l9vb2n0N/hI14o8HRAQoAPq11lFOfKuZDKhR3eN/UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sdVo0R4f; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sdVo0R4f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3510C19423;
	Thu, 26 Mar 2026 14:30:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774535447;
	bh=vYDPnxFpC03iD43jZeheL6iLUaSs0dhG3IX1X1iA0vE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sdVo0R4fhDWVa7cQh9ishx/ySDds9RdX7ZA75LXGkh+O6MlbGkWBwaw53nBiRjzWQ
	 OruKsn+lTYuJWgQza2f32GU4BCGwLTDLX35Qo2jpDPofHkjMeIpkgGcUx5fHcpMfxM
	 HisOUOvTJAg7nM81bhG/OXn5VNROBcVELOlcQJjWYNSaRndCzvn3KQfnuOi8ONBVw7
	 5xV+iGLtg5DW7lMc14cy1PHHrg0ai7kWJpDnqmoD7HaitxxL0v92xYmjHqzikzXeHi
	 HGN0JvjQBR4xdKebJoQkx1PPdKMPcsdo+olc0weRCtPWt8JhYx+TbzlrToGOSgXk7R
	 x7J9MWv2tL1ng==
Date: Thu, 26 Mar 2026 23:30:42 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Cc: Breno Leitao <leitao@debian.org>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 oss@malat.biz, paulmck@kernel.org, rostedt@goodmis.org,
 kernel-team@meta.com
Subject: Re: [PATCH v2] bootconfig: Apply early options from embedded config
Message-Id: <20260326233042.f52cfc127ec934d52713bce1@kernel.org>
In-Reply-To: <20260325232204.05edbb21c7602b6408ca007b@kernel.org>
References: <20260325-early_bootconfig-v2-1-6b05a36fbfb5@debian.org>
	<20260325232204.05edbb21c7602b6408ca007b@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, 25 Mar 2026 23:22:04 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> > +	/*
> > +	 * Keys that do not match any early_param() handler are silently
> > +	 * ignored — do_early_param() always returns 0.
> > +	 */
> > +	xbc_node_for_each_key_value(root, knode, val) {
> 
> [sashiko comment]
> | Does this loop handle array values correctly?
> | xbc_node_for_each_key_value() only assigns the first value of an array to
> | the val pointer before advancing to the next key. It does not iterate over
> | the child nodes of the array.
> | If the bootconfig contains a multi-value key like
> | kernel.console = "ttyS0", "tty0", will the subsequent values in the array
> | be silently dropped instead of passed to the early_param handlers?
> 
> Also, good catch :) we need to use xbc_node_for_each_array_value()
> for inner loop.

FYI, xbc_snprint_cmdline() translates the arraied parameter as
multiple parameters. For example,

foo = bar, buz;

will be converted to

foo=bar foo=buz

Thus, I think we should do the same thing below;

> 
> > +		if (xbc_node_compose_key_after(root, knode, xbc_namebuf, XBC_KEYLEN_MAX) < 0)
> > +			continue;
> > +
> > +		/*
> > +		 * We need to copy const char *val to a char pointer,
> > +		 * which is what do_early_param() need, given it might
> > +		 * call strsep(), strtok() later.
> > +		 */
> > +		ret = strscpy(val_buf, val, sizeof(val_buf));
> > +		if (ret < 0) {
> > +			pr_warn("ignoring bootconfig value '%s', too long\n",
> > +				xbc_namebuf);
> > +			continue;
> > +		}
> > +		do_early_param(xbc_namebuf, val_buf, NULL, NULL);

So instead of this;

xbc_array_for_each_value(vnode, val) {
	do_early_param(xbc_namebuf, val, NULL, NULL);
}

Maybe it is a good timing to recondier unifying kernel cmdline and bootconfig
from API viewpoint.

Thanks,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
