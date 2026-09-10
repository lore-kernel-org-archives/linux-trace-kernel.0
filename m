Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2D5E453A5E;
	Thu, 10 Sep 2026 14:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789050972; cv=none; b=sDcV2cvkVmXsEHCHyy14gV05PA3hq0iHcAmx4kc1PoKpeT+wXJJDIenVCX0B4T1TwXKVAUZ8jq1uKiuyiHkdiASdcCN+otJEeCd6E4CYCiUChjVjXdwJ4acj/NiLXc2IaYCO84S15licnYO6s7lfOpO7Up0nyohuCocCSeZIo3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789050972; c=relaxed/simple;
	bh=dJcwlHSrk8Uc1scS/UQ2C54Oi/ibr3avJ3v6PU8C6v4=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=egCCy4Kr6SdDK2jqgBnqcUcXlOm2a0q+v1FMTAGhy6+j8XLHOLDvXwGGzuinkM0Poa1jYJjxg+ZinxVe2mx3ouy+VYEkS6AetslXucZCe21BGxQyHCzVbd5syert08YS4v3WNYNhy6W9M4RXzVI1tOrIfSOQHIZGhr1ETZ28aaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mmYrOd0j; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mmYrOd0j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F32901F000FF;
	Thu, 10 Sep 2026 14:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789050970;
	bh=vwBroyK2ArSODGHueMlq5V0IhUwKrMhcJFB9fs6tk6s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=mmYrOd0jEyiHPMPZX27wW70Qn2UCRBJnl4wd/qtJCPsnmCtv/YagumQCfBkYD4BJa
	 xAQX4pfciy5M9ciwrQGvEWi8Avn37DPa5l2yotjxb+y36vl1dENjLsS15FkfzRpZBg
	 suLnJIWhnEb9NUX5eBQFDr+vL16D5CVKu5vYMWg8FOzx/+Y5eJ+TZOauqMS00yODvV
	 lhhJI81LBNx7powZ3awNa0ecG+fzYiWtiy2UoLvglqzmDRRND4bVmyhOsCxjYk/EfA
	 LWxkXuRbLICKhDyyE5hmlbxDs6RMCqPFKQZvyIpsp9UkyHOMU8GS54SCTXoj680jtf
	 hr1v2wPrqw9TA==
Date: Thu, 10 Sep 2026 23:36:06 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Sang-Heon Jeon <ekffu200098@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] tools/bootconfig: Consolidate xbc_init() to error
 message wrapper
Message-Id: <20260910233606.83bbc260bf8684110b81cf31@kernel.org>
In-Reply-To: <CABFDxMFbHoDrGKr7039XL3BwHOjZC+4Qt2YQNeGbyuAitQPGDg@mail.gmail.com>
References: <178896921555.177508.434402948295885560.stgit@devnote2>
	<178896923375.177508.14682854552827605824.stgit@devnote2>
	<CABFDxMFbHoDrGKr7039XL3BwHOjZC+4Qt2YQNeGbyuAitQPGDg@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 10 Sep 2026 14:30:02 +0900
Sang-Heon Jeon <ekffu200098@gmail.com> wrote:

> > +static int init_xbc_with_error(char *buf, int len)
> > +{
> > +       char *copy = malloc(len);
> > +       const char *msg;
> > +       int ret, pos;
> > +
> > +       if (!copy)
> > +               return -ENOMEM;
> > +
> > +       memcpy(copy, buf, len);
> 
> Can we remove this? xbc_init() already copies buf and does not change
> it, so show_xbc_error() can use buf directly.

Ah, good catch! OK, let me fix it.

Thanks,


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
