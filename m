Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CFF630ACF6;
	Wed, 15 Apr 2026 11:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776251772; cv=none; b=Ekm0vCLZJKgdWM8RbWgPqeL9wQdMg/Lr9FiISSv4ZpnY065k4fMHi2oXGgB1lFhXgdw4ncsnPI6MFQg6KO0aMkZlEPX6RyTicllhqmpSn20BXn70XMdkWAM6WDFkKa9BKVj48ejSnBg/rRxRvVhcI7QCzrE3SbMWCg/i94nhBWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776251772; c=relaxed/simple;
	bh=x0Ti+MMtlG36NDqMz+AWtmoLIFfR4SVxIgJEa2CZPXo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s8BKAvt+/XbhWD/1LkftsCi1ZuFuTEKqGsB0xIWRYblunVE4zUqCePEzwB3MJlO2nU6DCE7S6a32KGYiy59MYHhlo+p6U5wZCkXIL+fSq0EUf0SiAY0bj2UhcF4kcjwt3+HLbjR6PMpazhERBs646FTGxH/4QyQn6t7MgNWezqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=XutY8iYg; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="XutY8iYg"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=x0Ti+MMtlG36NDqMz+AWtmoLIFfR4SVxIgJEa2CZPXo=; b=XutY8iYgOsW5dxK+6LuYCy7LKk
	5UR0wZVLon9MydJVMfs6mVysd510Hq1+by+Xqaxf3ijVWF30ApxKWJGIgK4VzEAOW86qpFBldr4NM
	UWL/iOH4buy3i2DOrEgOftpf0qdUIJkSv4K6Cug5jvkVt8dthfpdeVwD4Bo/ZjzSDvgVN7b3pEeos
	ha/9+MU5Qd+BiVjX7lGtL0eSdRdKD38kez9G5ABMNJhQx79YSwEM1T3r4nYGcrAHvO7pt8owFr7RP
	BfGtmCDdzuTy+TcIjlnF2mfZlPvocRtQk7/kvH68+587Ga1IaJGfOJ8VBwfLpXheTK6l68J5Ky3F/
	kNtZLeBA==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wCyDx-00DnWX-2J;
	Wed, 15 Apr 2026 11:16:02 +0000
Date: Wed, 15 Apr 2026 04:15:57 -0700
From: Breno Leitao <leitao@debian.org>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, oss@malat.biz, paulmck@kernel.org, rostedt@goodmis.org, 
	kernel-team@meta.com, Kiryl Shutsemau <kirill@shutemov.name>
Subject: Re: [PATCH v2] bootconfig: Apply early options from embedded config
Message-ID: <ad9wwUJ3lh_536Xy@gmail.com>
References: <acZPZ4XKy4QynznK@gmail.com>
 <20260327223744.f246150adc1671f7605a4f0a@kernel.org>
 <acpzhCBEPh-tKVqg@gmail.com>
 <acqJk-zbyjIiy6hJ@gmail.com>
 <20260331125827.157a833882830007ea9b0b31@kernel.org>
 <acvjcCqIAeHyIiQN@gmail.com>
 <20260401224853.d8ed517a344c4be51d371a9c@kernel.org>
 <ac0wz_eW5Zgi4t45@gmail.com>
 <20260403114519.14e326a4bba019373bf3ff09@kernel.org>
 <adTX6h4Ej5jOcONP@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adTX6h4Ej5jOcONP@gmail.com>
X-Debian-User: leitao

On Tue, Apr 07, 2026 at 03:19:09AM -0700, Breno Leitao wrote:
> On Fri, Apr 03, 2026 at 11:45:19AM +0900, Masami Hiramatsu wrote:
> > > I'm still uncertain about this approach. The goal is to identify and
> > > categorize the early parameters that are parsed prior to bootconfig
> > > initialization.
> >
> > Yes, if we support early parameters in bootconfig, we need to clarify
> > which parameters are inherently unsupportable, and document it.
> > Currently it is easy to say that it does not support the parameter
> > defined with "early_param()". Similary, maybe we should introduce
> > "arch_param()" or something like it (or support all of them).
> >
> > >
> > > Moreover, this work could become obsolete if bootconfig's initialization
> > > point shifts earlier or later in the boot sequence, necessitating
> > > another comprehensive analysis.
> >
> > If we can init it before calling setup_arch(), yes, we don't need to
> > check it. So that is another option. Do you think it is feasible to
> > support all of them? (Of course, theologically we can do, but the
> > question is the use case and requirements.)
>
> I don't believe all early parameters can be supported by bootconfig.
> Some are inherently incompatible as far as I understand, while others
> depend on bootconfig's initialization point in the boot sequence.

I've developed a patch series that relocates bootconfig initialization
to occur before setup_arch().

Adopting this approach would streamline the categorization considerably,
as only a small subset of kernel parameters are parsed before
setup_arch() is called.

This enables a clearer distinction: parameters processed *before*
setup_arch() versus those handled afterward, rather than classifying
based on what occurs before bootconfig initialization.

Just to close the look and link both discussion together, the proposed
patch series is available at:

https://lore.kernel.org/all/20260415-bootconfig_earlier-v1-0-cf160175de5e@debian.org/
