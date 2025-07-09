Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C60B21D5BD;
	Wed,  9 Jul 2025 16:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752079545; cv=none; b=llqv2g9jxzGQFenc/3sTUwtUHntTMv52+qU9kQf3cVzS+1tPu7bELOKKYZo95SaCq3pBzeNg5Vg5l88P3TAAS3vDZE0ssdAk33CEgdEbcwWd75C6g01hxDWld4U1s03d37hC1VcZajLg1pIlN38C6EdZGauZC1kr9ebxoSRHyD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752079545; c=relaxed/simple;
	bh=Tb8SyoTnhwKs90lbvP0xyKWYMU93ftYSwCjgAtcSIfU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SneXn9Sukx4jzLHsmaB5DvwwwxvHzquaamVDSQ5xEoaaymVY7W5WJWA5GIsB36CUGh3/wa/kf4QM8MRSoiaP4oQ5203wchSdUZ1ChpGRYwwnAS17x/QtubG9P7dJv+JEc8rkBRwuVC+69v2MVvfn09zyHXKZ7LJ3JfuDLutqP8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf01.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id DF2F157E1F;
	Wed,  9 Jul 2025 16:45:40 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf01.hostedemail.com (Postfix) with ESMTPA id 0C5A460011;
	Wed,  9 Jul 2025 16:45:37 +0000 (UTC)
Date: Wed, 9 Jul 2025 12:45:36 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Palmer Dabbelt <palmer@dabbelt.com>
Cc: alexghiti@rivosinc.com, mhiramat@kernel.org, Mark Rutland
 <mark.rutland@arm.com>, Paul Walmsley <paul.walmsley@sifive.com>,
 aou@eecs.berkeley.edu, Alexandre Ghiti <alex@ghiti.fr>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org, rabenda.cn@gmail.com,
 wangruikang@iscas.ac.cn, ziyao@disroot.org
Subject: Re: [PATCH] riscv: ftrace: Properly acquire text_mutex to fix a
 race condition
Message-ID: <20250709124536.4ce3a90b@batman.local.home>
In-Reply-To: <mhng-6AFAE150-B97C-493D-9699-545AABAC78FD@palmerdabbelt-mac>
References: <20250708-alex-fixes-v1-1-5b008d3f4d0c@rivosinc.com>
	<mhng-6AFAE150-B97C-493D-9699-545AABAC78FD@palmerdabbelt-mac>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: dbppecj37pgrgr3u6b58j3g43t3z69f5
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: 0C5A460011
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18UUMhmi698+5oz7ltzhrraposOL8pK02w=
X-HE-Tag: 1752079537-42978
X-HE-Meta: U2FsdGVkX180JxbK93sOvlUDnb3OvLcohVzegobLEKocfOHmrAVGuLey7IEzNeauoVjMkrt8/FPTHMUlZRq0i/F3+H4KTwAsMbeus86KcB6dVwleMtJsfRmSAQDi5IKFYul6PZw7fYTZGkG1L60CJlkZz7d8Ep9nH3I6Oa45sv+5Clu+5c3wwnOIFlaH/dPFGCf/P9vkD2R/PoRW2AZikTv6zjr+lbizAuKNUSyrLJUTKmVTAPcdrR2I4Ih/zqHz9YqD65NPVkLdw2fE5CkvO2aoRGoxYNXduZ0GLyurW0IW2WS+7nOGLUF/0eHmu0mQLslKniVrItLW1dzjlikxFw9JkaJ/+W6fbrf79PNu6lldwbDO+vm+/pDBAYnyZbRVgKRK/GFqUXqrhLJSIoYGIAU89mjquIGM6P+8LfTJJdQ=

On Wed, 09 Jul 2025 07:12:47 -0700 (PDT)
Palmer Dabbelt <palmer@dabbelt.com> wrote:

> >  #ifdef CONFIG_DYNAMIC_FTRACE
> > +void ftrace_arch_code_modify_prepare(void)
> > +{
> > +	mutex_lock(&text_mutex);
> > +}
> > +
> > +void ftrace_arch_code_modify_post_process(void)
> > +{
> > +	mutex_unlock(&text_mutex);
> > +}  
> 
> IIRC there's a reason we don't do it this way, we had (or had tried to) 
> have it before.  It's been a while, though, and I'm just having some a 
> coffee so may I'm just wrong...

Yes, because it caused issues with stop machine[1], but if you are no
longer using stop machine, this should be what you should do now.

[1] https://lore.kernel.org/all/20220310045454.672097-1-changbin.du@gmail.com/

-- Steve
