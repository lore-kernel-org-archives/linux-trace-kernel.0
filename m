Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B7A315A865;
	Mon, 19 Aug 2024 23:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724110476; cv=none; b=GTuFQ5EIxeeKguj+R8VHIXi12Y4WcCQcMK7dfPb/dxSlpC3MLK5zHOEKavIo54zSuRylbIMQkFwHbvCq0NDdr3fKnyA+orXaV04xgAOtx8ndC+lOtlfGbPe2WY2X7LdMnIYRmhcIgrQ2e5zzrvwnya4lxtMhY7brXJoNogg6W+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724110476; c=relaxed/simple;
	bh=EskfZYxtcQRI39nS+fX7B611q9gHlN6kBxvW78AdaLg=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=EYc+RAIn5bnpK8bOLiyZYtykjy3UIuB+YQ0hVWM20I6A9JDVLdMw/B8uoqM5SNPEEucSscs1KgxV5h+NWuKt1JNO3f22+x/l3PdxBMl0ERHzAwZduLIJkAot8r6Zb9b9I6QklqV7ZKb66A1kkxoHJJdGq8X6TRjW6Km/AIknQCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NZ/TkekZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NZ/TkekZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCD45C4AF0E;
	Mon, 19 Aug 2024 23:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724110476;
	bh=EskfZYxtcQRI39nS+fX7B611q9gHlN6kBxvW78AdaLg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NZ/TkekZ7xLBFqExd33rckwX0fOQMBv1NDzHnldXfBNeZc2Gn1mXUH/RnJnFJblrg
	 XxLxd6K9AMb/tBzaXuDRqqErkzQQtyFA5enThJMnRClf2f6X9FBIfDMsnzl4a71X6a
	 FlxN4kXIq+/qqA4kblxsLeMTVOYtbCWbAv95IcZqHzeHobhLwdJYWNycun87BlSDdI
	 uZF3hgZ72VLus6v1ISYCpBS26KLQKgiMhji5sopQTmOHq4F9HjYpkSvBo+7ufbRPVA
	 obXOXCvxTfSiwQ+20bTJ7roeVNM/M/9UDidtd6iCkPZvQsYKuKqIaMUcug8Y7oFezE
	 zLzNHE3UWaPGQ==
Date: Tue, 20 Aug 2024 08:34:31 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
 linux-kernel@vger.kernel.org
Subject: Re: [BUG] tracing: dynamic ftrace selftest detected failures
Message-Id: <20240820083431.0dd9ff59b894d2174b1cd512@kernel.org>
In-Reply-To: <20240819120244.5657eb2f@gandalf.local.home>
References: <20240819171152.12f05e0ae5c9472004d1b00a@kernel.org>
	<20240819112902.11451fe8@gandalf.local.home>
	<20240820005649.dd019cfa70a8955d91cf85a0@kernel.org>
	<20240819120244.5657eb2f@gandalf.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 19 Aug 2024 12:02:44 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Tue, 20 Aug 2024 00:56:49 +0900
> Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> > 
> > > 
> > > We may need to add "noinline" or something to make sure those functions
> > > don't get inlined for LTO.  
> > 
> > Yeah, we need such option at least for function call test.
> 
> Could you add the noinline, and if it fixes the issue send a patch?

OK, BTW, I got warnings from kmemleak when I disabled LTO in the selftest.
Let me fix it too.

Thanks,

> 
> Thanks,
> 
> -- Steve
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
