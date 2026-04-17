Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D2A441C62;
	Fri, 17 Apr 2026 01:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776390376; cv=none; b=Jgayr/u5I/e1xve2J2fDyVGVOVZuCEnZLXo4eLO4KH6NXDWBYMULTwc1DYmTCfQKR7IkgzABRxr2qaIaeVy19SWd7tdLFeI4NNvYLnE5LYmLm/OYmFTqmmZdUjhDrp5VhzJxMwBmFYJLAamShZdXiQBpW3BANvGvc22D3lzmyEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776390376; c=relaxed/simple;
	bh=9GV2cqGSWKW8OhRYCnTtDoSytBNAPLgGcM23mRKlFLI=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=LkLjnsNQPmWECOVy2rbCokXS2w0DnU6bqheiKnFuqIlmdia5Lq6xhBizCF1EBTIYjLjMGS6Uq7/hPNrLf02vO/pTSDbL17FvsH75zdXTVHUjUxrhkt+4V+LpARdbiBVX8vJaEDFrA36kfCQ/feCefxu1OCtW5edE7gus0I0UbUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jjx79DQo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jjx79DQo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 640C3C2BCB6;
	Fri, 17 Apr 2026 01:46:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776390375;
	bh=9GV2cqGSWKW8OhRYCnTtDoSytBNAPLgGcM23mRKlFLI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jjx79DQoe9MufrzLSh3Zx3Y2Hn78WNvNjaveh6ypMHnSlqisXrByMOIS2yL/gkAu/
	 +9IaRDLD2MQdO5xciiZwyL/Cc10vKWd5xtWIgBk2X5XIxj+5Nxnhax0jDG/+/jhvZA
	 dEWxa5LZcqXhiNseYW0OB204mlXBmmHhZyGUz7fAtysA4yqr9hgKfsjAWuJEI0mLi+
	 QeWRWqebZ/Tjbd85ZkuVe5aRzL5DMall6oG6mJG2PFsI02czOyc320INLhoL+HtKFU
	 BxyVReG26WeQJypyvWI9fH0+SdvhCMc8c4QLhY5zpfe3numMu9XBdbNZmd54jZUFjJ
	 T4DtWALeCCfpQ==
Date: Fri, 17 Apr 2026 10:46:13 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Shuah Khan
 <skhan@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 oss@malat.biz, paulmck@kernel.org, rostedt@goodmis.org,
 kernel-team@meta.com, Kiryl Shutsemau <kirill@shutemov.name>
Subject: Re: [PATCH v2] bootconfig: Apply early options from embedded config
Message-Id: <20260417104613.6c7e3211f56a950814e9c9f5@kernel.org>
In-Reply-To: <ad9wwUJ3lh_536Xy@gmail.com>
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
	<ad9wwUJ3lh_536Xy@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 15 Apr 2026 04:15:57 -0700
Breno Leitao <leitao@debian.org> wrote:

> On Tue, Apr 07, 2026 at 03:19:09AM -0700, Breno Leitao wrote:
> > On Fri, Apr 03, 2026 at 11:45:19AM +0900, Masami Hiramatsu wrote:
> > > > I'm still uncertain about this approach. The goal is to identify and
> > > > categorize the early parameters that are parsed prior to bootconfig
> > > > initialization.
> > >
> > > Yes, if we support early parameters in bootconfig, we need to clarify
> > > which parameters are inherently unsupportable, and document it.
> > > Currently it is easy to say that it does not support the parameter
> > > defined with "early_param()". Similary, maybe we should introduce
> > > "arch_param()" or something like it (or support all of them).
> > >
> > > >
> > > > Moreover, this work could become obsolete if bootconfig's initialization
> > > > point shifts earlier or later in the boot sequence, necessitating
> > > > another comprehensive analysis.
> > >
> > > If we can init it before calling setup_arch(), yes, we don't need to
> > > check it. So that is another option. Do you think it is feasible to
> > > support all of them? (Of course, theologically we can do, but the
> > > question is the use case and requirements.)
> >
> > I don't believe all early parameters can be supported by bootconfig.
> > Some are inherently incompatible as far as I understand, while others
> > depend on bootconfig's initialization point in the boot sequence.
> 
> I've developed a patch series that relocates bootconfig initialization
> to occur before setup_arch().
> 
> Adopting this approach would streamline the categorization considerably,
> as only a small subset of kernel parameters are parsed before
> setup_arch() is called.
> 
> This enables a clearer distinction: parameters processed *before*
> setup_arch() versus those handled afterward, rather than classifying
> based on what occurs before bootconfig initialization.
> 
> Just to close the look and link both discussion together, the proposed
> patch series is available at:
> 
> https://lore.kernel.org/all/20260415-bootconfig_earlier-v1-0-cf160175de5e@debian.org/


Thanks for working on this series!! Let me review the series.

BTW, I found that the current __setup(), early_param(), module_param()
are a bit complicated, for example, __setup() and early_param() are
stored in the different array of module_param(), and those can use
the same parameter (e.g. console).

And as you found some of early_param() options are only applied via
command line. Maybe we can introduce another special macro which is
only for command line.

Thanks,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
