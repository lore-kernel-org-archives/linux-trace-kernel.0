Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C682248A3;
	Mon, 30 Mar 2026 13:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774876531; cv=none; b=GhUH0V1V1K0Z6or4wJvXGb0Kcn77L6emIlom7Ql0DgqFS3WqnNKrh1l8p4YCKtiSOoGDoJqZiFBhYs2Rwuahkqh6+8oDZncg+SPXbxzIGIEsb1e3NTcyuWDCzS8Cx6BEdcCEqSoJZGVwTUAcg4hJLCjPC2vJjhdkyPUrII8a+v8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774876531; c=relaxed/simple;
	bh=Xgj9cc6h07bIyibv0AcQP4GG4xG/7JDImGZF1lph/lA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wd1TGrBRnyzFKT1uN6kdMxGrKIAfjwV8bGWvI67qyfTR8rENkUgEPlQkkSVsEsndfip1A2qV3jwJQ2JiUV+/GxENLhBKJlccHdmN4p9wbrXxLc1JEJlQ8eGm/erd/QwW1BeKurgPPBj/K58A2J7sEgIYhQMR7k8GliZDylRiqjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=CB1PUKSB; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="CB1PUKSB"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=doXlkuwocQiCVhAJbOMIc8Opqf2z6NTVXIz6lc5zrls=; b=CB1PUKSBplwnPdjpF7qm8x0GS5
	TRbuQu1kOniDkYYE2kWWYS6+XfkFTYrd0b2bTc4sPISK54Axdjr+kmYtWZldu+V5ZEhU7DRJD2YdO
	hm8Tk9zeLfpxvXTSpObajsF+P5a4M9TUjn6adJ5cbG5+S6GVyTboJHr4PUB0xKw+LG/sNBUmBpNec
	0rgxhcC7qTEmjGQ8F0a+GuesDSJjAkJoVl7VVtOnWxOV7VJXUUE5vnY6ToS/dP6iu2/a3aGzQaWg3
	DWu3po6FCPiVMvR4kdYCzATQj23Uy0U+MYUA0U/p5sEXosoT1VG0iBJyWBCZBWryQZWzENSCmS8XA
	gBG9tbUQ==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1w7CSh-001TLj-14;
	Mon, 30 Mar 2026 13:15:22 +0000
Date: Mon, 30 Mar 2026 06:15:17 -0700
From: Breno Leitao <leitao@debian.org>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, oss@malat.biz, paulmck@kernel.org, rostedt@goodmis.org, 
	kernel-team@meta.com
Subject: Re: [PATCH v2] bootconfig: Apply early options from embedded config
Message-ID: <acpzhCBEPh-tKVqg@gmail.com>
References: <20260325-early_bootconfig-v2-1-6b05a36fbfb5@debian.org>
 <20260325232204.05edbb21c7602b6408ca007b@kernel.org>
 <acZPZ4XKy4QynznK@gmail.com>
 <20260327223744.f246150adc1671f7605a4f0a@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260327223744.f246150adc1671f7605a4f0a@kernel.org>
X-Debian-User: leitao

On Fri, Mar 27, 2026 at 10:37:44PM +0900, Masami Hiramatsu wrote:
> On Fri, 27 Mar 2026 03:06:41 -0700
> Breno Leitao <leitao@debian.org> wrote:

> > > To fix this, we need to change setup_arch() for each architecture so
> > > that it calls this bootconfig_apply_early_params().
> > 
> > Could we instead integrate this into parse_early_param() itself? That
> > approach would avoid the need to modify each architecture individually.
> 
> Ah, indeed. 

I investigated integrating bootconfig into parse_early_param() and hit a
blocker: xbc_init() and xbc_make_cmdline() depend on memblock_alloc(), but on
most architectures (x86, arm64, arm, s390, riscv) parse_early_param() is called
from setup_arch() _before_ memblock is initialized.

So, bootconfig will not be available as early as parse_early_param(). 

An alternative is replace memblock allocations in lib/bootconfig.c with static
__initdata buffers, similar to Petr's approach in 2023:

	https://lore.kernel.org/all/20231121231342.193646-3-oss@malat.biz/

But, there was concerns about the allocation size:

	Petr Malat <oss@malat.biz> wrote: 
	> To allow handling of early options, it's necessary to eliminate allocations
	> from embedded bootconfig handling

	"Hm, my concern is that this can introduce some sort of overhead to parse the bootconfig."
