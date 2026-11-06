Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793975112;
	b=3zAp662NCecl+JiDhnvH7lXC5I9KNeqYcycFMTEikDx4syVd18GcFHg2m7ZOFySmYieN
	 P2Qj0ayQT1buOW+g0Wf/GzLfZm3jPConwXMzQlWMc5VaEEfO33H7Y8d9ZU643YNHA/WgR
	 bTOWNi2gMN7W84n27Yn6fbfvdR1b7P/9iX7+BhprPY+egWsCn7lupq3qhSrntFJNfQmcn
	 YToQ7Sbfw+VJ5zV+2a1qGfLZ5spci+pzMmO18jZW7GjSQEthGlR7akS3nTOqwxg3Qf6be
	 S2Y5XbFs+LqgDqGDOA2Q69qJT0dGrqI+ZLqOI9Zeumy6kA54r0gkDFFvTBBR4OV1O+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793975112;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Rspamd-Server:X-Rspamd-Queue-Id:
	 X-Stat-Signature:X-Spam-Status:X-Session-Marker:X-Session-ID:
	 DKIM-Signature:X-HE-Tag:X-HE-Meta;
	bh=cIFQN8lbuhCH6n2559vbvnmkzA9ag6ZDHFiIHX+X3HE=;
	b=IknYQYwn9pbC/D3SFpwHlNIqbhqIzCLqEZJotcL98N9yQSmPX79t1rUDWNtRtF4zgmWU
	 DXEdcamfagTwfW1qTQrTmmJcnz312s7Y4O4Wv5spl2TOYrx27kcAGLPinzFlYetPNha6q
	 4bXy8wiuEXE93AnJSsbLxHKUvxaIM9QcFo2omicWrpiPNbHO4TfusBCcPoCw7pGJIbaUv
	 /Q/eTP6vV+WANUx6wq7vELmryYYWMxrcsL155ZdqkH3JbgGv3k1lmHs1Rfr2U4/z9uAdC
	 d2mdUa6xy/irNpl1ntDmw8xbG1LTYyFFyFPt0mjmcUL5RQaVtp3e7SkEWeL2nYtDIgw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goodmis.org;
	spf=pass smtp.mailfrom=goodmis.org;
	dkim=pass header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=ot8Grwlz;
	arc=none smtp.remote-ip=216.40.44.15
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F67606D80E;
	Fri,  6 Nov 2026 14:25:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 72F67606D80E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=ot8Grwlz
Received: from omf14.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id 4FE42805A8;
	Fri,  6 Nov 2026 14:25:09 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf14.hostedemail.com (Postfix) with ESMTPA id 079BC2F;
	Fri,  6 Nov 2026 14:25:06 +0000 (UTC)
Date: Fri, 6 Nov 2026 09:25:05 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: kernel test robot <yi1.lai@intel.com>, oe-lkp@lists.linux.dev,
 lkp@intel.com, linux-kernel@vger.kernel.org, Martin Kaiser
 <martin@kaiser.cx>, Vinod Koul <vkoul@kernel.org>,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [linus:master] [tracing]  b5cc230af5:
 WARNING:at_kernel/trace/trace_events.c:#test_double_dereference
Message-ID: <20261106092505.709bd856@gandalf.local.home>
In-Reply-To: <undine-1793940873129741182-d37e5f54bdcb36ed@undined.local>
References: <202611060303.c90f27a7-lkp@intel.com>
	<undine-1793940873129741182-d37e5f54bdcb36ed@undined.local>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: 079BC2F
X-Stat-Signature: 66s46irswjjs47phibtxn6i48k4akhuh
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+oo0ooH9pi1shr4G+DOxcEzseuNzebQug=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=cIFQN8lbuhCH6n2559vbvnmkzA9ag6ZDHFiIHX+X3HE=; b=ot8GrwlzvFRrxTHjAkWneeNRuygXWNwzqDRpI5yo8DuGcnGjPKxZ0nmz9Gsuxlygw6Rea7GhISHegZErvXC4PKm8GjMgecQ8Xks+yx5N82DkyfS5qVLrbPblrz9qu+4S0/AnrCgNiZdKz0pIXNfG8ssHLILJrWFWPIB+zrkedG4=
X-HE-Tag: 1793975106-12521
X-HE-Meta: U2FsdGVkX1+qj6MPSDgSDkuZT5AXZhU9B+iXwgKPW+/B7216Vd43ekFJsXOxnoFdtkKpR6TO5G/td0rTU6wdSqUM94XUTJEcihhWdMBOwbrLp0YXRUeca7fFhBWqmXIJaJkMW+GFohSuORvNuThs8c4l4Lyatmm5EpVuVznQ2TfavGcx9FKG2EMZ9A0k2I5ka5UaLsC1JQwzaKnQ8uogAFXhlOqd8AlWiTe5So4XDvoOL9iO7iCEv8dX29t+qGtorEpMLCkqubtvtDfs/lJ23OXrxWV3jAstaHrOS+UVCMYZ4fN7PfPJ3s08nbwP6gBuxctqbzP8zUP3Ti1g5QLBmfBa76kJqlMMoerhbapiF9OmC74Mq57uHA==

On Fri, 06 Nov 2026 04:54:33 +0000
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> On Fri, 6 Nov 2026 11:07:56 +0800, kernel test robot <yi1.lai@intel.com> wrote:
> > 
> > 
> > Hello,
> > 
> > kernel test robot noticed "WARNING:at_kernel/trace/trace_events.c:#test_double_dereference" on:
> > 
> > commit: b5cc230af5e536ff752f8bd5c30e23612936d5c3 ("tracing: Warn when an event dereferences a pointer in TP_printk()") https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> > 
> > [test failed on linux-next/master ddfe51b0a0f5dc9e415cc2c8ad8db17532dd426b]
> > 
> > in testcase: boot
> > 
> > config: x86_64-randconfig-r2309-20261012
> > compiler: gcc-14
> > test machine: qemu-system-x86_64 -enable-kvm -cpu Cascadelake-Server-noTSX,enforce -smp 4 -m 16G
> > 
> > (please refer to attached dmesg/kmsg for entire log/backtrace)
> > 
> > 
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <yi1.lai@intel.com>
> > | Closes: https://lore.kernel.org/oe-lkp/202611060303.c90f27a7-lkp@intel.com
> > 
> > 
> > [    0.808840][    T0] ------------[ cut here ]------------
> > [    0.810236][    T0] Event hfi1_txq_complete has double dereference in TP_printk: REC->sde ? REC->sde->this_idx : 0  
> 
> This seems to be expected behavior. Because "REC->sde" can point already
> freed/reused object, this should not be allowed. The event must save the
> sde->this_idx at TP_fast_assign() instead of recording sde.
> 
> In drivers/infiniband/hw/hfi1/trace_tx.h:
> 
> DECLARE_EVENT_CLASS(/* AIP  */
>         hfi1_ipoib_txq_template,
> 	...
>         TP_printk(/* print  */
>                 "[%s] txq %llx idx %u sde %llx:%u cpu %d head %lx tail %lx flow %x used %u stops %d no_desc %d stopped %u",
>                 __get_str(dev),
>                 (unsigned long long)__entry->txq,
>                 __entry->idx,
>                 (unsigned long long)__entry->sde,
>                 __entry->sde ? __entry->sde->this_idx : 0, // this must be recorded as a value
>                 __entry->sde ? __entry->sde->cpu : 0,	// ditto
> 
> 
> So this is a bug in an infiniband driver.

Yep, I'm working on a fix, unless you are already doing it.

-- Steve

> 
> Thank you,
> 

