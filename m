Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0BE515E5C6
	for <linux-trace-kernel@vger.kernel.org>; Mon, 27 May 2024 12:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716814328; cv=none; b=vC9xK6VEPuAjgyxrt6XUaap/eyBOKfVuxMO4XaqUnGvwWm3St+7JmGKN4v/1gRi8uCjvKO1vsz5LdnrAVYleyz9o9T540v5J3fpzjRngHDShQOGiul3g0APfrM0vcV5CnPpEJHgpkGJbYgKIM4YD1dlsUI/RBxjHm9+A1/EzuZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716814328; c=relaxed/simple;
	bh=Wp2PL4Lp+93QUWUZcmc+Tq1Ux1TQU3XmS74FbUA7GwA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kvTisgqFyNBWgBM6EQSl3sRmjXn++gYn8G0g7qnw7TWf58lhbwBcR808B9qMY1bsVNH7LEHo1bxKmugAUl5OaKwCcWqPjA1wI7ceMTlIMmSM7avoaEo5TA4LaL8/Vk5cTSAJSL+15C6kuxIWjiE/kWAIF3WOywtRx1wUL24uOCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=FnGVNuLu; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="FnGVNuLu"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=QJ3nyJ6zYMYDlHXvM/LFHGefiWmEFxK4DDRt6GM5lX4=; b=FnGVNuLuDP/t1jh4TK62tRGa5V
	dTjiZbxSCiO2jQF1Hd+IEQXMPZfsLy27sYA2FCxo26Sa0AOU6JptB1rqTcR9EgOjQFt7yw9ECNakX
	t3XID1yPt4Je1aJeSlZ1LAaQIq0apHoOXfxF82Npc7dc47jvQtARh+I0miFITNQ/EgQjBhvfDZSg/
	G5wp2PR2y8AX3G5oXTwrwD2/VCKUwpbuAEOHSX7sP0u5XaYfS8VSPG9m/QGaERmwy03xaCM+5tb3H
	BYTa2oP50mCg4dyBD85ITi7SM5N2gUFxPxPNKNa6k6keamrfFNrF8BZg2Uo6S6YPcXKI9voz4PYbe
	kYU7pJlg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:38678)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1sBZpN-0003Vg-1P;
	Mon, 27 May 2024 13:51:49 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1sBZpN-0002Kd-6p; Mon, 27 May 2024 13:51:49 +0100
Date: Mon, 27 May 2024 13:51:49 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Thorsten Scherer <T.Scherer@eckelmann.de>, mark.rutland@arm.com,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	rostedt@goodmis.org, Justin Chen <justin.chen@broadcom.com>,
	Doug Berger <doug.berger@broadcom.com>, mhiramat@kernel.org,
	kernel@pengutronix.de, ardb@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: ARM Ftrace Function Graph Fails With UNWINDER_FRAME_POINTER
Message-ID: <ZlSB5eEsxlKZfjDv@shell.armlinux.org.uk>
References: <d870c149-4363-43de-b0ea-7125dec5608e@broadcom.com>
 <z42qu35nuybho36bwjdoatqp3skwm7w2l4apd75ubzaezyvxef@f6yrdlgltlaf>
 <ZlQ8oDh/Kgkm1+WE@shell.armlinux.org.uk>
 <czbbd3mvqanerbcqgycy3bnvmfnbu5fhyzfujk2ijo2vnngnkn@6ldafursohkn>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <czbbd3mvqanerbcqgycy3bnvmfnbu5fhyzfujk2ijo2vnngnkn@6ldafursohkn>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, May 27, 2024 at 02:28:59PM +0200, Uwe Kleine-König wrote:
> On Mon, May 27, 2024 at 08:56:16AM +0100, Russell King (Oracle) wrote:
> > On Mon, May 27, 2024 at 09:43:41AM +0200, Thorsten Scherer wrote:
> > > Hello,
> > > 
> > > in the context of a panic on an i.MX25 based v6.9 kernel [1] Uwe pointed me to
> > > this thread.  With the proposed code change applied the procedure
> > > 
> > >     # set to some known good (randomly guessed) filter function and enable function_graph
> > >     echo mtdblock_open > set_ftrace_filter
> > >     echo function_graph > current_tracer
> > > 
> > >     # walk available filter funcs
> > >     cat available_filter_functions | while read f; do echo $f | tee -a set_ftrace_filter; sleep 1; done
> > > 
> > > produces the following output
> > > 
> > > [  159.832173] Insufficient stack space to handle exception!
> > > [  159.832241] Task stack:     [0xc8e44000..0xc8e46000]
> > > [  159.842701] IRQ stack:      [0xc8800000..0xc8802000]
> > > [  159.847712] Overflow stack: [0xc1934000..0xc1935000]
> > > [  159.852726] Internal error: Oops - BUG: 0 [#1] PREEMPT ARM
> > > [  159.858273] Modules linked in: capture_events_imxgpt ti_ads7950 industrialio_triggered_buffer kfifo_buf capture_events_irq capture_events iio_trig_hrtimer industrialio_sw_trigger industrialio_configfs dm_mod
> > > [  159.876948] CPU: 0 PID: 199 Comm: sh Not tainted 6.9.0 #3
> > > [  159.882412] Hardware name: Freescale i.MX25 (Device Tree Support)
> > > [  159.888547] PC is at prepare_ftrace_return+0x4/0x7c
> > > [  159.893520] LR is at ftrace_graph_caller+0x1c/0x28
> > > [  159.898376] pc : [<c010dd44>]    lr : [<c010d988>]    psr: 60000093
> > > [  159.904690] sp : c8e44018  ip : c8e44018  fp : c8e4403c
> > > [  159.909959] r10: c0c09e78  r9 : c35e9bc0  r8 : c010d9bc
> > > [  159.915227] r7 : 00000001  r6 : 00000004  r5 : c8e44064  r4 : c8e440ac
> > > [  159.921800] r3 : c8e44030  r2 : c8e4403c  r1 : c010eb9c  r0 : c8e44038
> > > [  159.928376] Flags: nZCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment none
> > > [  159.935652] Control: 0005317f  Table: 83074000  DAC: 00000051
> > > [  159.941436] Register r0 information: 2-page vmalloc region starting at 0xc8e44000 allocated at kernel_clone+0xa8/0x408
> > > [  159.952253] Register r1 information: non-slab/vmalloc memory
> > > [  159.957988] Register r2 information: 2-page vmalloc region starting at 0xc8e44000 allocated at kernel_clone+0xa8/0x408
> > > [  159.968791] Register r3 information: 2-page vmalloc region starting at 0xc8e44000 allocated at kernel_clone+0xa8/0x408
> > > [  159.979592] Register r4 information: 2-page vmalloc region starting at 0xc8e44000 allocated at kernel_clone+0xa8/0x408
> > > [  159.990391] Register r5 information: 2-page vmalloc region starting at 0xc8e44000 allocated at kernel_clone+0xa8/0x408
> > > [  160.001187] Register r6 information: non-paged memory
> > > [  160.006303] Register r7 information: non-paged memory
> > > [  160.011415] Register r8 information: non-slab/vmalloc memory
> > > [  160.017139] Register r9 information: slab kmalloc-32 start c35e9bc0 pointer offset 0 size 32
> > > [  160.025718] Register r10 information: non-slab/vmalloc memory
> > > [  160.031530] Register r11 information: 2-page vmalloc region starting at 0xc8e44000 allocated at kernel_clone+0xa8/0x408
> > > [  160.042422] Register r12 information: 2-page vmalloc region starting at 0xc8e44000 allocated at kernel_clone+0xa8/0x408
> > > [  160.053315] Process sh (pid: 199, stack limit = 0x68fc3abb)
> > > [  160.058955] Stack: (0xc8e44018 to 0xc8e46000)
> > 
> > No backtrace? No Code: line? I'm guessing there was an attempt to ftrace
> > a function involving the ftrace tracing infrastructure, which is why 8KB
> > of stack has been gobbled up. It could be
> > copy_from_kernel_nofault_allowed() but it would be useful to have at
> > least some extract of the backtrace showing the recursive cycle to
> > confirm, otherwise there is nothing in your report to confirm. As I'm
> > not a ftrace user myself, this isn't something I'd test for, so having
> > a full report would be useful.
> 
> Is not having a backtrace related to ftrace_return_address() returning
> NULL, as Arnd pointed out in
> https://lore.kernel.org/linux-arm-kernel/36cd10de-c51c-40ff-90e8-71495406019d@app.fastmail.com/
> ?

Unlikely - the stack and code lines are also missing. I think the
submitter truncated the oops which is highly likely given that it
would've dumped all 8kB of the stack in hex, and the trace and
code lines would be after that.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
