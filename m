Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC7682BD029;
	Wed,  8 Oct 2025 16:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759939763; cv=none; b=JsRGdmjkjtEhphDHnwIrAOdG5BgXUiLMGc4+6DUsZ11Mgx12yKMMtCYpWjXBlToyBZM08f3GeilEuID3TekCaAnFsa0aR2Mlrk+U2mygZNyosJYzgLUICCUKeF3FmWSF6IxnrqwviywrEatfMxYqjvT6z3OM915X5cRsK3omw+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759939763; c=relaxed/simple;
	bh=7qG9+11u3mCpiyNEifUFS7i/al/DnxnwuP9mz9DKpxA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RByO7P1yGqATk9bYKbu2ypv3K2ELAh8bE6nN8EwPHWaun0NRh/PyOpR3ZsjwHa/3+gujHqgBElzmu5RurNBKzJcQMgJ4X0NeDMS57w7hDbgarWK/955pqzhFVPVuWkzPhuyaKzs2Ru9vxny/aMUU0lgaUyDM6vpXvhZSabvGvhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf16.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id 36FE71A05EE;
	Wed,  8 Oct 2025 16:09:19 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf16.hostedemail.com (Postfix) with ESMTPA id 012A520016;
	Wed,  8 Oct 2025 16:09:16 +0000 (UTC)
Date: Wed, 8 Oct 2025 12:11:10 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Ankit Khushwaha <ankitkhushwaha.linux@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 david.hunter.linux@gmail.com, skhan@linuxfoundation.org,
 linux-kernel-mentees@lists.linuxfoundation.org, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 syzbot+ddc001b92c083dbf2b97@syzkaller.appspotmail.com
Subject: Re: [PATCH] ring buffer: propagate __rb_map_vma return value to
 caller
Message-ID: <20251008121110.4e7c3671@gandalf.local.home>
In-Reply-To: <20251007171256.20884-1-ankitkhushwaha.linux@gmail.com>
References: <20251007171256.20884-1-ankitkhushwaha.linux@gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 012A520016
X-Stat-Signature: drgddpbyrfrhq5xtite7umqbhqhkufe1
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18o0hnhvzZVrS/THusq5BDX3T986j69cyg=
X-HE-Tag: 1759939756-70540
X-HE-Meta: U2FsdGVkX19193Sv84va4CFxLEBUFYDcm2cRgLxlqYnUKTMjNK8HnR/ZYDaveYfvYTb13tR6o6O03VHrvePJNGOBik4UjEa/kSgtkM16OsUV0CgYpFWtaEdFtJzHm2sq4r0F3Aj4pDCcxtLohjoRLW7AKZUAhyjWAfoOUyY3UX4IZgcPwUDOQQu60rdMBUr38EW8wwANmllQR8/FpZQ6gNmMb82nnRq5Oi4DJPxDve/J6lkvBKJY6u5uP2aMh6kAPant6SCmUw9MdhGAzVwzmAygch1lbuzYc2mJwaDrU16c8Ve3fKsxT3KB4H/xQ+lOyNZI+OEBGDb0HJp/a3y+jff8jlzUz21P8cyIf5HMfEBuJcCTsCJDQsqe4GdBc6EpYLOxVnderg5C9qENSbewg1oOsqu8lhTaQRAxxaIzv/P0BlSf9TGi3kyTHW2h51JQByflRNbupKgqoGCfXtcFvQ493Llp9T+UBU8+CMZyesE=

On Tue,  7 Oct 2025 22:42:56 +0530
Ankit Khushwaha <ankitkhushwaha.linux@gmail.com> wrote:

Note, tracing subsystem expects the subject to start with a capital letter:

 ring buffer: Propagate __rb_map_vma return value to caller

> The return value from `__rb_map_vma()`, which rejects writable or
> executable mappings (VM_WRITE, VM_EXEC, or !VM_MAYSHARE), was being
> ignored. As a result the caller of `__rb_map_vma` always returned 0 
> even when the mapping had actually failed, allowing it to proceed
> with an invalid VMA.
> 
> Reported-by: syzbot+ddc001b92c083dbf2b97@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?id=194151be8eaebd826005329b2e123aecae714bdb
> Signed-off-by: Ankit Khushwaha <ankitkhushwaha.linux@gmail.com>
> ---
> 
> #syz test: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 4ff71af020ae
> 
> ---
>  kernel/trace/ring_buffer.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> index 43460949ad3f..4efb90364f48 100644
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c
> @@ -7271,6 +7271,8 @@ int ring_buffer_map(struct trace_buffer *buffer, int cpu,
>  		cpu_buffer->subbuf_ids = NULL;
>  		rb_free_meta_page(cpu_buffer);
>  		atomic_dec(&cpu_buffer->resize_disabled);
> +		/* VM failed to be mapped */

No need to add the comment. It's obvious what happened.

> +		return err;

Don't return here.

>  	}
>  
>  	return 0;

Change this to:

	return err;

as after that if statement, err will be 0 on success or the value you want
to return.

-- Steve
