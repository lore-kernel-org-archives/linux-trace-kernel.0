Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E715D27E;
	Tue,  8 Jul 2025 05:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751951765; cv=none; b=EU5bzjDzB/aK63dvdZK6BHc0IwgljXdOXOL+vwsSvPZpW0aRwGNrCDZC/LqI6nu8ggRygNB6HXs/596yx0/AYVyNoQ3L4Vz6ck22JK6svW8h+v4Wp0OYUET+acfK0crqP60HTTE/YsDUd81Qxzxq3kGma9o7oDtyLnF/XtxO9n8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751951765; c=relaxed/simple;
	bh=vwWTmtEhyYaokbT4pg4vQi/76twGoXovFRT7DrY0su0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SiLskqV7+rT0Cs+ldYWFqg4QOfcGR7Stj0ILGWRPwXpfWyiwy0Tx7iHTkZlf7/wShzZHIMtuu/936YvOOxEzwAeff4TT6JlpfHIz6NkL18X5DX0/soMA/hAOyLZ5NUtdC2v6B2D/o2eNT3tHckW7JZJovLN9wdBWNInDc0N/xsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=HsWlEiWh; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="HsWlEiWh"
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 8997825D3C;
	Tue,  8 Jul 2025 07:16:01 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wH3v3tcvD4eS; Tue,  8 Jul 2025 07:16:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1751951760; bh=vwWTmtEhyYaokbT4pg4vQi/76twGoXovFRT7DrY0su0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=HsWlEiWhVQJ5oNbhnw+ykb0EgLDskRU/cQH8h0Y1qV8sdf5ZQhtU5FwXjsvJkQxux
	 ybOJgF+ZPVB0dQhier81jKRf9gMQEqgixR4xtdQn+fw/KgZdmDwtF9vrC9Dwrhl/Hw
	 CeSkUincSsq3pbnoAu+C8vur5Ykkoxo8BBJfLqcT3pRjDGAAiV5QfhnawC8hu97G/J
	 m5IejVLcCywGXIrWPGe0x0KMTZDMuUHPt+aonHX/sTbP/LJOTNzCsHBOI7n0bqFSvV
	 mrIUZ43EYi0tXEOsxo5cBfO0F+8WlIjgrWLV4+LrOuPLn9pMpUgnE5fqt30YhKTrcm
	 F2pVrsBr1qTEQ==
Date: Tue, 8 Jul 2025 05:15:15 +0000
From: Yao Zi <ziyao@disroot.org>
To: Alexandre Ghiti <alex@ghiti.fr>, Andy Chiu <andybnac@gmail.com>,
	alexghiti@rivosinc.com, palmer@dabbelt.com,
	Andy Chiu <andy.chiu@sifive.com>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>,
	Mark Rutland <mark.rutland@arm.com>, puranjay12@gmail.com,
	paul.walmsley@sifive.com, greentime.hu@sifive.com,
	nick.hu@sifive.com, nylon.chen@sifive.com, eric.lin@sifive.com,
	vicent.chen@sifive.com, zong.li@sifive.com,
	yongxuan.wang@sifive.com, samuel.holland@sifive.com,
	olivia.chu@sifive.com, c2232430@gmail.com
Cc: Han Gao <rabenda.cn@gmail.com>, Vivian Wang <wangruikang@iscas.ac.cn>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	regressions@lists.linux.dev, linux-riscv@lists.infradead.org
Subject: Re: [REGRESSION] Random oops on SG2042 with Linux 6.16-rc and
 dynamic ftrace
Message-ID: <aGypYyyR3EtsKGKy@pie.lan>
References: <aGODMpq7TGINddzM@pie.lan>
 <b060e694-caa0-4aa5-ac67-75531a5f60eb@ghiti.fr>
 <aGUO8L7oXpvEpvZo@pie.lan>
 <6d478129-324a-4c5a-8258-4abe3d0732d6@ghiti.fr>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6d478129-324a-4c5a-8258-4abe3d0732d6@ghiti.fr>

On Wed, Jul 02, 2025 at 03:05:06PM +0200, Alexandre Ghiti wrote:
> Hi Yao,
> 
> On 7/2/25 12:50, Yao Zi wrote:
> > On Tue, Jul 01, 2025 at 02:27:32PM +0200, Alexandre Ghiti wrote:
> > > Hi Yao,
> > > 
> > > On 7/1/25 08:41, Yao Zi wrote:
> > > > Linux v6.16 built with dynamic ftrace randomly oops or triggers
> > > > ftrace_bug() on Sophgo SG2042 when booting systemd-based userspace,
> > ...
> > 
> > > > Not sure either reverting the commits or fixing them up is a better
> > > > idea, but anyway the fatal first issue shouidn't go into the stable
> > > > release.
> > > Let's fix this, we were expecting issues with dynamic ftrace :)
> > > 
> > > So the following diff fixes all the issues you mentioned (not the first
> > > crash though, I'll let you test and see if it works better, I don't have
> > > this board):
> > Thanks for the fix! I've tested it with both QEMU and SG2042, it does
> > fix the lockdep failures as well as the boot time crash on SG2042. The
> > boot-time crash is caused by the race so will disappear as long as we
> > fix the race.
> > 
> > > diff --git a/arch/riscv/kernel/ftrace.c b/arch/riscv/kernel/ftrace.c
> > > index 4c6c24380cfd9..97ced537aa1e0 100644
> > > --- a/arch/riscv/kernel/ftrace.c
> > > +++ b/arch/riscv/kernel/ftrace.c
> > > @@ -14,6 +14,16 @@
> > >   #include <asm/text-patching.h>
> > > 
> > >   #ifdef CONFIG_DYNAMIC_FTRACE
> > > +void ftrace_arch_code_modify_prepare(void)
> > > +{
> > > +       mutex_lock(&text_mutex);
> > > +}
> > > +
> > > +void ftrace_arch_code_modify_post_process(void)
> > > +{
> > > +       mutex_unlock(&text_mutex);
> > > +}
> > > +
> > >   unsigned long ftrace_call_adjust(unsigned long addr)
> > >   {
> > >          if (IS_ENABLED(CONFIG_DYNAMIC_FTRACE_WITH_CALL_OPS))
> > > @@ -29,10 +39,8 @@ unsigned long arch_ftrace_get_symaddr(unsigned long
> > > fentry_ip)
> > > 
> > >   void arch_ftrace_update_code(int command)
> > >   {
> > > -       mutex_lock(&text_mutex);
> > >          command |= FTRACE_MAY_SLEEP;
> > >          ftrace_modify_all_code(command);
> > > -       mutex_unlock(&text_mutex);
> > >          flush_icache_all();
> > >   }
> > > 
> > > @@ -149,16 +157,17 @@ int ftrace_init_nop(struct module *mod, struct
> > > dyn_ftrace *rec)
> > >          unsigned int nops[2], offset;
> > >          int ret;
> > > 
> > > +       mutex_lock(&text_mutex);
> > Besides using the guard API, could we swap the order between
> > ftrace_rec_set_nop_ops() and calculation of the nops array? This shrinks
> > the critical region a little.
> 
> 
> If you don't mind, I won't, I don't like initializing stuff which could
> never be used in case of error.

Yes, I don't mind it.

> 
> > 
> > With or without the change, here's my tag,
> > 
> > Tested-by: Yao Zi <ziyao@disroot.org>
> > 
> > and also
> > 
> > Reported-by: Han Gao <rabenda.cn@gmail.com>
> > Reported-by: Vivian Wang <wangruikang@iscas.ac.cn>
> > 
> > for their first-hand report of boot-time crash and analysis for the
> > first lock issue.
> 
> 
> I'll add all those tags in the patch I'll send today (or tomorrow if the CI
> is slow).

Is there any update about the fix patch? It'll be nice to get the
problem fixed soon.

> Thanks again for the great bug report, really appreciated.
> 
> Alex

Best regards,
Yao Zi
