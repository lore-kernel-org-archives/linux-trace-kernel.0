Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B16371925BD;
	Mon, 30 Sep 2024 15:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727710305; cv=none; b=SAfD2WG+btadGZSLsCgANMUYKtS93Wktt+33b+ZTWBX4uh6ypMVwJ7lOxuvYNUZZWzhA6UDaR+YwIUqU/pBv7h7OywAuf+U7vSpjnCbus/IiX9xkl1aaLen0x+e1IhUieBfYtyNWBvdOFnHZMeFDP3K/69GkCRpQ6L325h0P6Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727710305; c=relaxed/simple;
	bh=E7iKVSqxRfYpU8b56Xm9+4HTpvl2d7jhBSKkk9lp4/8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Uts+dDWxhkvJf2kwDImTcbzc8DLyvSlHSVefUD2qIQkp4eH2qR0jT5pvOEqIDsvbKj1JljljxgsqWOEnyOt2nv20Q2W1zLat1ZX3WFYpB65lX6KVlmozHAWmR19FACEuP+caK/8bPTh+YV9sguxm0heGv9Svmn9vsuVIRsWoU+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC6CAC4CECE;
	Mon, 30 Sep 2024 15:31:44 +0000 (UTC)
Date: Mon, 30 Sep 2024 11:32:31 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Tiezhu Yang <yangtiezhu@loongson.cn>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Question about config UPROBES and UPROBE_EVENTS
Message-ID: <20240930113231.6c87108d@gandalf.local.home>
In-Reply-To: <20241001002813.6012587b5e52737a576f1d0b@kernel.org>
References: <1a3567d5-e558-351a-c45d-73b2e5a8788c@loongson.cn>
	<20240930081529.f6f9161c20db9b95c9b46252@kernel.org>
	<f639079e-bc1c-7f2a-4c3f-de1a6780da84@loongson.cn>
	<20240930100630.7894c442@gandalf.local.home>
	<20241001002813.6012587b5e52737a576f1d0b@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 1 Oct 2024 00:28:13 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> On Mon, 30 Sep 2024 10:06:30 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > On Mon, 30 Sep 2024 09:33:42 +0800
> > Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
> >   
> > > > the CONFIG_UPROBES is disabled by default and make CONFIG_UPROBE_EVENTS
> > > > depending on it, the uprobe_events menu is hidden. I don't like this.    
> > > 
> > > This is somehow like the current status of CONFIG_KPROBES and
> > > CONFIG_KPROBE_EVENTS.  
> > 
> > The question is, can uprobes be used without uprobe_events? With the
> > current BPF work that I haven't been following, it may be possible now.  
> 
> uprobe_register/unregister APIs are exposed to the kernel modules,
> since systemtap had been introduced this feature.
>

OK, but since they have always been visible, I would just make
CONFIG_UPROBES a normal option and CONFIG_UPROBE_EVENTS select it if it
gets selected, and not depend on it.

-- Steve
