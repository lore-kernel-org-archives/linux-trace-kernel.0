Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BFC42C1BA;
	Mon,  3 Jun 2024 06:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717397153; cv=none; b=dEkmrMmkHmgWKLh9Uequi0wMxf23jR6nG18zkjWgkfFgi9i1MNejNqa3nz3iWxYf18JfFGbcWnYckTgWwjS+tcKXgsji1Ra8+dIuiPDWi2SsNPLHT18A03hyedTuocP1PKxZPULwID9NouOrMVcW1rZJesWZVmYeUxKN3Kw/xZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717397153; c=relaxed/simple;
	bh=Pyy4ovwtosXvgy2lviTvJPTsT5T7HV7laF3GNbepqV0=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Vcy9zmT9TQ5ly2FGVR67jftsSfAvHPYMpO75fMt8s3kHArzwC1RGNSJbKeL82nmvbY3bUJ6S/PNEz6ctUpAFX4VwsVo37HuMsIXpJF6QSpYNGsWsFgM6xqucrFnLX9fmHu+i0nf+fvVKG/MySifS838A0wRNv804upyZc3O+mtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JeSelYwV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JeSelYwV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DA60C2BD10;
	Mon,  3 Jun 2024 06:45:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717397153;
	bh=Pyy4ovwtosXvgy2lviTvJPTsT5T7HV7laF3GNbepqV0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JeSelYwVyATu2d0wuRrkm6e1MRFGHHe72Da39BIBi3U+N1y3TXLokPnU+WxakED6/
	 +fZosFTt9Y0Ioskn1LRKbfX2Czi67V89SAgviKFaUDotkVO3B2Z3asoglIbVSdljYO
	 hgmphj9FjS3srvCXSxpuhGuK2oP7OyS2eEXARmV7WjRok4tri/oRRv5p82FA2GuxW6
	 4JS8F9CLD0vuuQ7x3v97dgKtg5bz3/svlPTsthCo6Sj6jLjdzIVuOOmsBtCG+yZYpN
	 wDhBwFT19Ap9dlVnp5FSH1NoPdASV44swkuhRpbQurZDFiNxeJpJnGAPfNqY7zEgOD
	 v0vR2cJCQB3Hg==
Date: Mon, 3 Jun 2024 15:45:49 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: "wuqiang.matt" <wuqiang.matt@bytedance.com>
Cc: Jeff Johnson <quic_jjohnson@quicinc.com>, Andrew Morton
 <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] lib: test_objpool: add missing MODULE_DESCRIPTION()
 macro
Message-Id: <20240603154549.4a338c065e42f07c8c3d1b82@kernel.org>
In-Reply-To: <7ba64e00-373b-4c13-a30a-113646dad588@bytedance.com>
References: <20240531-md-lib-test_objpool-v1-1-516efee92a05@quicinc.com>
	<7ba64e00-373b-4c13-a30a-113646dad588@bytedance.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 3 Jun 2024 11:25:59 +0800
"wuqiang.matt" <wuqiang.matt@bytedance.com> wrote:

> On 2024/6/1 08:31, Jeff Johnson wrote:
> > make allmodconfig && make W=1 C=1 reports:
> > WARNING: modpost: missing MODULE_DESCRIPTION() in lib/test_objpool.o
> > 
> > Add the missing invocation of the MODULE_DESCRIPTION() macro.
> > 
> > Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> > ---
> >   lib/test_objpool.c | 3 ++-
> >   1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/lib/test_objpool.c b/lib/test_objpool.c
> > index bfdb81599832..5a3f6961a70f 100644
> > --- a/lib/test_objpool.c
> > +++ b/lib/test_objpool.c
> > @@ -687,4 +687,5 @@ static void __exit ot_mod_exit(void)
> >   module_init(ot_mod_init);
> >   module_exit(ot_mod_exit);
> >   
> > -MODULE_LICENSE("GPL");
> > \ No newline at end of file
> > +MODULE_DESCRIPTION("Test module for lockless object pool");
> > +MODULE_LICENSE("GPL");
> > 
> > ---
> > base-commit: b050496579632f86ee1ef7e7501906db579f3457
> > change-id: 20240531-md-lib-test_objpool-338d937f8666
> > 
> 
> Looks good to me. Thanks for the update.
> 
> I added Masami Hiramatsu and linux-trace in the loop.
> 
> Reviewed-by: Matt Wu <wuqiang.matt@bytedance.com>

Thanks, let me pick this to probes/for-next branch.

Thank you,

> 
> Regards,
> Matt Wu
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
