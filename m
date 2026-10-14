Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 751B2223DFF;
	Wed, 14 Oct 2026 04:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791951833; cv=none; b=Jbm3PXZgNgSI8LZPVltgYKifSn1vCyXitGuDE74b4chmCvBIISbvKynwiYyZFLAq7WsSCiSjerVtxsNb7fiZjc4LSId/gbzsn88jbF8VsQ1G+uhy1H/DeMTnnJIVk4vv+NztS2oy9L6s8qqJ6iPCmgDiNEbWgpRmY5PqKftfeXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791951833; c=relaxed/simple;
	bh=PtlbFuvKfW7drScklexHuni2rRunqHr7iiGES4AADlo=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=UDQqHvgCx9Mn1Xokuumzg1N+oMSOXkqyn6+jg3fD8Kn80rETwDkk4Sizu/bWa3Eve9cONS/8d0B64EWF6fo2XfsVoqAgcvDuQhsc35Dgp9GBFIijoIuO55JSnTwSH3mZTzY80yyIEjIIHOC7NIesP3AmkajFsmzinLLvQ7F6oOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=lRP3CuQT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="lRP3CuQT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CC0A1F000FF;
	Wed, 14 Oct 2026 04:23:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1791951831;
	bh=HTlmqq49K1s2Uio5GpAUNkmOrPs42WtTHIax0Wf1dpc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=lRP3CuQTTJqf0GhVZ0l0yzjlHIQZrgmdzwG1YfurC1tMHDbVPou646/Qkm8iidWte
	 5X7CKeM1ImZncJJF4y3urbJ51aX6Zr87hFSLJy7wv30qsHv8Kkhp9TIqy27qqNif9i
	 nxZZh9k7Ms2U8M5sfeiyA4JnW+Izlb51DlzJkAVw=
Date: Tue, 13 Oct 2026 21:23:51 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Thorsten Leemhuis <linux@leemhuis.info>
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Sang-Heon
 Jeon <ekffu200098@gmail.com>, Linux Next Mailing List
 <linux-next@vger.kernel.org>, Mark Brown <broonie@kernel.org>, Linux kernel
 regressions list <regressions@lists.linux.dev>
Subject: Re: [PATCH v2 2/4] tools/bootconfig: Consolidate xbc_init() to
 error message wrapper
Message-Id: <20261013212351.ce16d411abeb7e710eed5157@linux-foundation.org>
In-Reply-To: <1dcf2ee8-02f7-41af-b1f4-bff3a16a2c90@leemhuis.info>
References: <178913597653.248794.1237187523153227751.stgit@devnote2>
	<178913599508.248794.10388592925402087434.stgit@devnote2>
	<1dcf2ee8-02f7-41af-b1f4-bff3a16a2c90@leemhuis.info>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 14 Oct 2026 06:04:52 +0200 Thorsten Leemhuis <linux@leemhuis.info> wrote:

> On 9/11/26 16:13, Masami Hiramatsu (Google) wrote:
> > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > 
> > Use init_xbc_with_error() for all bootconfig initialization in the
> > bootconfig tool instead of showing errors in different way.
> > 
> > This simplifies the code logic and make it easy to maintain.
> > 
> > Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Masami, Andrew, this patch is now twice in -next:
> 
> e732d7c18d4d6a ("tools/bootconfig: consolidate xbc_init() to error
> message wrapper") [merged via: "9eae8e94e61f20 ("Merge branch
> 'mm-nonmm-stable' of
> https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm")"; next-20261012]
> 
> 78715511921cc8 ("tools/bootconfig: Consolidate xbc_init() to error
> message wrapper") [merged via: "71ee85976d09e8 ("Merge branch 'for-next'
> of
> https://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git")";
> next-20261013]

OK, thanks, I'll drop the mm.git copy.

I was surprised to see bootconfig patches in the linux-trace tree, but
it seems that's where they're hosted.

