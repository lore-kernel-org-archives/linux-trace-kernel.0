Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 893292C86D;
	Thu, 24 Jul 2025 01:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753319447; cv=none; b=QUglOJgJc4bAahlB5jrhA02GzqTQATR+tKC4FKEjlzARgjiwswXylyUUWWG7xqGqX/+Mu5/7YK2S+8qEVt3g6WXLufGKpl1ZjTPAcuLAgq35aAqWPOF4STtL9OI889rEP27Lb6uQ1t7yglpIV5YYvJgtq1iwfDlJbrsfLcf8gkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753319447; c=relaxed/simple;
	bh=W4m2ckVc6I3FFkqRkMIqKr81SWJ6nZa/RedrKf6ZJLo=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=gKIb5IgVJam8XGKmcqNGlpfTTflZe86ptclx20ucKKo09pHifLKKcVfPfRiCjmWPVF1+yK5wajNrQlwxR31oi/b8BFHE6UdP3rgNZDrx64v9SysluYr1lKJs/QH8Qrt5GYS8LJNuyOuL18j/BAUTouQhPzRZJnAflsKxHaYBC1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WsBHUVh7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WsBHUVh7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E1FDC4CEE7;
	Thu, 24 Jul 2025 01:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753319447;
	bh=W4m2ckVc6I3FFkqRkMIqKr81SWJ6nZa/RedrKf6ZJLo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WsBHUVh7Y8u5OneqaAcptfPxGb0lLxxw3025Dwcn6sfjNfRRJIw6YmSJEhUQuw3US
	 N4vKJOXmjIUrTLe5RdZl1pSL9ObJWgHHizcHqnyRt4/lRXO2QabtSu7Oju+y8lLOML
	 qxnsluCAVPnAS3OPotJH92FnO+B2n+Ku8uXdE8LCPA9ko0dEV+bTJCwo1X4ce997FA
	 eLCpesy/UTkotmhC1ZIX2RT1nWiADX9b9LWx8YlEwRumHx5qqLMDBXwgkM+FuZ27OW
	 fvzPmM140Io5dzX5RBdd3kJF+hP8Ngzd02iKGR8etE9Un/ylao19zYXsHfHjT/6esK
	 5+6/Jja7bSTDQ==
Date: Thu, 24 Jul 2025 10:10:44 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Ben Hutchings <benh@debian.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] bootconfig: Fix unaligned access when building footer
Message-Id: <20250724101044.d32c46958f6605ae22016851@kernel.org>
In-Reply-To: <59abcb9262e97b76bfdf18d6de71c15eb2af8a6e.camel@debian.org>
References: <aIC-NTw-cdm9ZGFw@decadent.org.uk>
	<20250724003747.be2a733e2e7fcf8a9e263cc4@kernel.org>
	<59abcb9262e97b76bfdf18d6de71c15eb2af8a6e.camel@debian.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 23 Jul 2025 22:20:35 +0200
Ben Hutchings <benh@debian.org> wrote:

> On Thu, 2025-07-24 at 00:37 +0900, Masami Hiramatsu wrote:
> > On Wed, 23 Jul 2025 12:49:25 +0200
> > Ben Hutchings <benh@debian.org> wrote:
> [...]
> > >  static int apply_xbc(const char *path, const char *xbc_path)
> > >  {
> > > -	char *buf, *data, *p;
> > > +	struct {
> > > +		uint32_t size;
> > > +		uint32_t csum;
> > > +		char magic[BOOTCONFIG_MAGIC_LEN];
> > > +	} footer;
> > 
> > Don't we need __attribute__((__packed__)) for the footer?
> 
> I don't see any reason for there to be padding in this structure, since
> it has an alignment of 4 and the size of each member is a multiple of 4.
> 
> I included an assertion that there is no padding:
> 
> [...]
> > > +	memcpy(footer.magic, BOOTCONFIG_MAGIC, BOOTCONFIG_MAGIC_LEN);
> > > +	static_assert(sizeof(footer) == BOOTCONFIG_FOOTER_SIZE);
> > > +	memcpy(data + size, &footer, BOOTCONFIG_FOOTER_SIZE);
> [...]

OK, if we saw the assertion error, we'll add packed attribute.
Let me pick it as it is.

Thank you!


> 
> Ben.
> 
> -- 
> Ben Hutchings - Debian developer, member of kernel, installer and LTS
> teams


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
