Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDEA321E08D
	for <linux-trace-kernel@vger.kernel.org>; Wed,  7 Jan 2026 20:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767818132; cv=none; b=jKyPP7SRF5H+9bkgtIb3HH154eomq/0AJ20Dm6tch+SW8P3oo0Eq7gZu8ETOEfbBYMiTSzbky0N2AzvgFv6jC1oxMnTGdpJZn6de50ZNST/R2cgJlqNNZr191m61ZXTUUVGHV2J9PbQjfxmJBSJwwov4GDu6Tj3rVdUcf8nKt1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767818132; c=relaxed/simple;
	bh=DYsosLdGRBIRROhwU9v8kIh0MBPdaE22UfvH2vgCH7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d4D2JNNjKkB9FaNCU1nzXFPyePEDV++ievb2bMSkpMPIGgaLEys4ZqjH7IvthHlF5R+M23xL74RGgnOjLblxefrb4DDrpLyHE9fFAM1zGHqu8vJ7ye9uGDhviQsuKFYaeHJJsc/EOcyFcNOVRhCvnxRFXJSU8Xqv7XykBCDVPLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=s/i757TN; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="s/i757TN"
Date: Wed, 7 Jan 2026 12:35:19 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1767818128;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BwCFjFalN2/8s1wbIvxRRJTe8J6YxTX0NCS4gLgdyQE=;
	b=s/i757TN1Q+PmiyZqrczqMqOj6PaAuzgQEDneTiRTrmkURkycvc+g6rgbwq8QyvK6BGb5z
	3mTYUHZiUOa1h1n9TUV2izrMQDP8aeHcR6pIoL6ojXnWR+9zdeY3iwM54pRqEAGLEL19/a
	ieDc0mtseSkFb1q4/GX8iftVYeN2z+Y=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Thomas Ballasi <tballasi@linux.microsoft.com>, linux-mm@kvack.org, 
	linux-trace-kernel@vger.kernel.org, mhiramat@kernel.org, rostedt@goodmis.org
Subject: Re: [PATCH v3 1/2] mm: vmscan: add cgroup IDs to vmscan tracepoints
Message-ID: <hpbntcznzgnwxerqzvyrauibecqg2ttgzch5d762mzn3q7dkzr@dm3vp6pnsnjo>
References: <20251216140252.11864-1-tballasi@linux.microsoft.com>
 <20260105160423.23708-1-tballasi@linux.microsoft.com>
 <20260105160423.23708-2-tballasi@linux.microsoft.com>
 <62ia3v3oduyt2srkaneccoei7cwimifwduarteyn2ugpmmbw3p@rivcqvcksgpt>
 <ovqxo2mmjiuymqk36t2xydcyzvtppcqsog62yx3qtwsknbkgzq@3phadh5gfyjd>
 <20260107103208.e64fe3c26d02bfcb21404dd9@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260107103208.e64fe3c26d02bfcb21404dd9@linux-foundation.org>
X-Migadu-Flow: FLOW_OUT

On Wed, Jan 07, 2026 at 10:32:08AM -0800, Andrew Morton wrote:
> On Wed, 7 Jan 2026 10:14:53 -0800 Shakeel Butt <shakeel.butt@linux.dev> wrote:
> 
> > On Mon, Jan 05, 2026 at 02:46:39PM -0800, Shakeel Butt wrote:
> > [...]
> > > 
> > > Orthogonally I am cleaning up memcg id usage and after that cleanup,
> > > mem_cgroup_id() would be preferred way to get the ID. No need to do
> > > anything now as I will cleanup this usage later as well.
> > 
> > The series has been landed in mm-new. Please use mem_cgroup_id() instead
> > of cgroup_id(memcg->css.cgroup).
> 
> fyi, I removed this series yesterday due to a CONFIG_MEMCG=n build failure.

Oh sorry, I meant my series [1] landed in mm-new and with that Thomas
can directly use mem_cgroup_id() without worrying about CONFIG_MEMCG=n.

[1] https://lkml.kernel.org/r/20251225232116.294540-1-shakeel.butt@linux.dev
