Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF27351C26;
	Wed,  3 Jun 2026 01:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780450490; cv=none; b=Rv7rI+KpF18nlH1Hb4zOw84DMNMEheUXYyYKT2tRWRJETi7YOntvARUDvYQSyppXIhl4I4t7mOU02BMsZ5K76QC0Ttdvi92y5UaF29gaAu3H1I66QonuovpXbCQMK/ZsftNwl9FuOTmg552O1gZ0QOz3UOpD9Euuope8Vr+Eugw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780450490; c=relaxed/simple;
	bh=jteWY92EN0baOtyNaPZGac6GrODUl8jmCKyqJ1M9NR0=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=FnY5DMRfdOPcLgKw6vI9hefaK+TE4sguDsMntwvg9+AlIkjY+HSlwmNQ0nPEdkd6+9t+QOjQfPWRFY5R9CCdXMqTx6S9QJNBct2MbSZ4IIkCS3CnVzeQ7ObNUBcLyZmNbhwJFIFKVheqyNHJ90fXC5b7DlRHvitgSRf2sJg+yfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QXktHdqS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QXktHdqS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 841C11F00898;
	Wed,  3 Jun 2026 01:34:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780450489;
	bh=HGbGbhMZ42+Sk55WDmNuSi2XA6XnRnoZ4RuDXx20Hpg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=QXktHdqS+rA5prGflt1PtRcvxndFDo7Czs3evc+h4aDmvX1ERQXLiDaa3bId4hwuj
	 FvKEkNa0vYElU3hmL4TJ4qTTGDVK7kCiMPtg567afvVW0ZOoQoK2HZt2cyFiBzgmRD
	 tUzftA/X62fbnggRYB6qALxpGCFojUeRxWR3HYdbIb1pGjNxT7UcCVzIcgmrD8LQ38
	 yEV40UFbJBidYCOVstA7aOJ/1xvWNZGLntDGW7auIsluBdInnI4BhZa2gTaGC510c5
	 xvKIYnzdMCkjMlfAqW+c1BldyPvjtotOMJMsBUi+l4iA+wq+myaQaE3Iimdl1/f1lk
	 G+e7W3yleinXQ==
Date: Wed, 3 Jun 2026 10:34:45 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: syzbot <syzbot+2dd9d02f60775ce5c1fb@syzkaller.appspotmail.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 mathieu.desnoyers@efficios.com, mhiramat@kernel.org,
 syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [trace?] KASAN: use-after-free Write in
 ring_buffer_read_page
Message-Id: <20260603103445.236f260a3c5eafe140055761@kernel.org>
In-Reply-To: <20260602122829.4a91864f@gandalf.local.home>
References: <6a1ede7b.b4221f80.1326c5.0003.GAE@google.com>
	<20260602122829.4a91864f@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 2 Jun 2026 12:28:29 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Tue, 02 Jun 2026 06:45:31 -0700
> syzbot <syzbot+2dd9d02f60775ce5c1fb@syzkaller.appspotmail.com> wrote:
> 
> > syzbot found the following issue on:
> > 
> > HEAD commit:    e7ae89a0c97c Linux 7.1-rc5
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=16f06e2e580000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=58acee1ac5406016
> > dashboard link: https://syzkaller.appspot.com/bug?extid=2dd9d02f60775ce5c1fb
> > compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
> > 
> > Unfortunately, I don't have any reproducer for this issue yet.
> 
> Looks like the test was doing something really weird to trigger this.
> Without a reproducer, it's pretty much impossible to find out what
> happened. Maybe AI could do it?
> 

Does the "I don't have any reproducer for this issue yet." means
this is not reproducible even if it runs completely same sequence
in the console output? If so, might this be a timing related issue?
(e.g. read v.s. write-event)

Thanks,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
