Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7467D1917F1;
	Mon,  9 Mar 2026 13:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773063167; cv=none; b=nBrMG4FTrkN8hFtLn84wvnYF4DBCn55AUnlkY1fHcqQRUKfg3rXZHqxKbU24kL4c1HA11SLY/kQgnDcB+SQHil+0GFXG2IOtTTKeVmw43bRTaEOVulm8u+Zoktocld0KRkpKEp+bwdK5IKPhuc0yED3tl5sYA5yK/+G0KBd9Rrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773063167; c=relaxed/simple;
	bh=6m0F6DHTrQFfdZaVLQo7TZiweMGnXiHFuP1Q5pUL2u0=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=sQWDAaTOIv8jPlrv2I/77VRoaaQadsqIQTMRthhJM1ZJy8/7KvirZF/Vjp726H+V1Q6aPHlll9/luQ0vuo03hiN1VfUtrKuhdIIhGbL9/GcgFfLdAdRBMdJGjGIBPf70l0oEAo8VvEKC39UiO5Bhua/MFGc1sPr5qALgE5WPTxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Su/3/isJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Su/3/isJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C1E7C2BC86;
	Mon,  9 Mar 2026 13:32:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773063167;
	bh=6m0F6DHTrQFfdZaVLQo7TZiweMGnXiHFuP1Q5pUL2u0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Su/3/isJKj119tSDYQcDGfh+XNI/A/NsSC/JKgVUAWei+K6guTNqnhXfQjUWKNRqc
	 AN5pHt5boabO68nBIP38CaPE4x5jCpODb0s+y4PmhV+b0GhTTK69AfNDyivf9itdwY
	 QdKnMxSJX+YpoZk3MtsoOmi8/Sc7a+lWxOsQVTiU+/wO4G8S6e2u9yR6wJ7ofUaBca
	 qF3cuUW+Ut8w0V5FxbBsrYunpS8+pQuv41FynXAR7dd/xgq/+JUdTWYEetGtJq/iJV
	 ga8l5pFptuEPslXoIBrFHPlO7ALnKkgzY7Wp9UXQL3jA3upIviS3sLS/DuEO60muB2
	 ptlhITPLCo2Tg==
Date: Mon, 9 Mar 2026 22:32:44 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v7 2/2] ring-buffer: Skip invalid sub-buffers when
 validating persistent ring buffer
Message-Id: <20260309223244.3be47d8abbb91b87680da2a3@kernel.org>
In-Reply-To: <20260308221901.545e7b8b@robin>
References: <177289358078.248514.14947007976699929481.stgit@devnote2>
	<177289359843.248514.164858607457269337.stgit@devnote2>
	<20260307102711.50932648@robin>
	<20260309085317.6679cf91151767eff7130cc4@kernel.org>
	<20260308221901.545e7b8b@robin>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Steve,

On Sun, 8 Mar 2026 22:19:01 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Mon, 9 Mar 2026 08:53:17 +0900
> Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> 
> > > Also, I mentioned that if the commit == RB_MISSED_EVENTS, then we know
> > > the sub buffer was corrupted and should be skipped.  
> > 
> > Yes, if RB_MISSED_EVENTS bit is set, the commit field is out of range.
> > That is checked in rb_validate_buffer().
> > 
> > > 
> > > And honestly, the commit should never be greater than the subbuf_size,
> > > even if corrupted. As we are only worried about corruption due to cache
> > > not writing out. That should not corrupt the commit size (now we can
> > > ignore the flags and use page size instead).  
> > 
> > Hmm, but if the kernel crash and reboot when it sets RB_MISSED_EVENTS,
> > we will see the bit is set and commit size is different. 
> 
> The RB_MISSED_EVENTS is only set on the reader page.

When is it reset after read? I think I removed that with commit ca296d32ece3 ("tracing: ring_buffer: Rewind persistent ring buffer on reboot"). So the
flags will be remains until the page is reused (as a writer page).

> 
> If the kernel crashes no boot up while reading the validated buffer,
> then that's a bit more than what this is supposed to handle.

But the above commit recovers the subbufs which has been read in the
previous boot. This means commit field of those recovered subbufs
can have those flags.

> 
> > 
> > Note, I think the reader_page RB_MISSED_EVENTS flag is not cleared after
> > read. commit ca296d32ece3 ("tracing: ring_buffer: Rewind persistent
> > ring buffer on reboot") drops clearing commit field for unwinding the
> > buffer.
> 
> But that should be fine, as it's only read only. Once tracing is
> started, it should be reset.

IIUC, RB_MISSED_* flags are using 30 and 31 th bits and committed
bytes counter is usually use 0-11 th bits. So other bits should be
cleared. 

So, if "commit & RB_MISSED_MASK" is under the subbuf_size, this
subbuf looks OK for checking its entries(timestamp data).
e.g.

unsigned long commit;

commit = local_read(subbuf->commit) & ~RB_MISSED_MASK;
if (commit > meta->subbuf_size)
  return -EINVAL;
return ;

Thank you,

> 
> -- Steve


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
