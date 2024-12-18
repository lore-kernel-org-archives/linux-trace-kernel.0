Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C424D1B0422;
	Wed, 18 Dec 2024 16:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734538685; cv=none; b=ehA1n6Rqa3VnnwnyRMtVcPH59UyGr6Dh8jsUvJwyoEoMPVH3wNdFRA4+i5JYnOVmilQvFlbhjCW06Pb7SKbPGzWviV2imFicYrBQLGJJIX9LMh35Jx/SbM4VeBkzEaLt+gvTrYKin94OT3nE6yCdZwNYmPnFHWh3DeUJy2bKT4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734538685; c=relaxed/simple;
	bh=xuZ5A+juYgpNeF9zTIRa6/8VnE0VAkGa9P01mslxBwk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KiAFT+7jaGPTiAoMd5vn1dk45aUTzauMDR3ZpfLcMJ3ZZD6oAUqJcyN3VT6a/l9r8TPwRlIny4/Vo9Y1YpBPqjArXKewfATwyYCDec6nkuGwwx8DXTr2FvkdJHuxRouFwPxRU1zfTUjXqqm1NJgKmgWGQ/DRtKTFg+8IVAeun/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68952C4CECD;
	Wed, 18 Dec 2024 16:18:04 +0000 (UTC)
Date: Wed, 18 Dec 2024 11:18:42 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Dmitry Vyukov <dvyukov@google.com>
Cc: syzbot <syzbot+a1d25e53cd4a10f7f2d3@syzkaller.appspotmail.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 mathieu.desnoyers@efficios.com, mhiramat@kernel.org,
 syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [trace?] WARNING in tracepoint_probe_unregister (3)
Message-ID: <20241218111842.0261dfdb@gandalf.local.home>
In-Reply-To: <CACT4Y+YrQR5HQWZuWb9OrupPR0C=mvLyWcJN3ofuUyf7j-nGRA@mail.gmail.com>
References: <6761e9b5.050a0220.29fcd0.007b.GAE@google.com>
	<20241217164810.2a9bcb57@gandalf.local.home>
	<CACT4Y+YrQR5HQWZuWb9OrupPR0C=mvLyWcJN3ofuUyf7j-nGRA@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 18 Dec 2024 11:09:31 +0100
Dmitry Vyukov <dvyukov@google.com> wrote:

> Hi Steve,
> 
> I've filed https://github.com/google/syzkaller/issues/5621 to not lose
> this request. Thanks for the feedback.

Thanks for requesting this feature.

-- Steve
