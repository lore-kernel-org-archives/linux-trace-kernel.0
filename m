Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794273071;
	b=xcmJX5X0ZfmuNaOEWTy33qTqqLrsNlB7Uh0owYVRUy4CZLcOxbx/AFdZO4JEo87jmUlQ
	 LyHoEFoXSf7ERtxx/9+LQOwUhmxtLLab+/dlnkQqntJTa2xNjApe3xv/jgJ9mMerzHSda
	 3WQ4e9yXCDHSQ6bkXlYuDlP8PqCmjmfSx3tGwaxE77IAuSMse0aYXQi7E/g/C3RhDtKLG
	 FPdqgsSaspwkJP6iKMLbvU1B4TvJ8JgnB3WtILJ1v+MEkGalANV6mvCRVQr2DjRyIAf+A
	 RCcua640BHs11xDxEKfuYnY9bXUl6dU/hhU8I0jbwHatVt52hFc8V6ci8cpe6GCSffg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794273071;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=rfARRKJ2elGfshxD3wg6mA+RZ+/rVMBa8iNEe1Cr8iU=;
	b=uu8Tb2d1api6EyJqE5aJAbt0vKPMVQUuj3I/ALjwrE31+PJrD5BdygAuBn6Nk4E1BLtA
	 UXzbiZ4QTKj+8C+Z+uz6+nHsDpqW28BaFoywyFTd6WgDFTQR7lkJm+RtdJiLJGArVkuNf
	 fTukn9HV0bZPGi9DYDQDZ674lkmWUryRJJWs3UHmgwqEvdRgdzkSc3CekeXQzIHML5M5v
	 Pv/61L6NuRwHKdX5jUrDywJi+rt+Xm3TQAKrvDM/d9bOr8FIPbw79y6O3aUgvGudJcjFY
	 qoEHGbmjKHgP8afXjsywgd+77RFnlFO4U9E+Bpo08Q6KNhgPxvxWQhUHTOnV1s5MylA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DvvPScHw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02BE2606A325
	for <linux-trace-kernel@vger.kernel.org>; Tue, 10 Nov 2026 01:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DvvPScHw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C8B61F008A2;
	Tue, 10 Nov 2026 01:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794273070;
	bh=rfARRKJ2elGfshxD3wg6mA+RZ+/rVMBa8iNEe1Cr8iU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DvvPScHwTCE+CG59p1c9FmvjPygbV1BcKY6o0FUtlE9iE4/MkC6rdWE8FZsopFSBO
	 lOoqhDgyrx4cfdcvoI/6WDuOF4BqustXOVdWi3vH8aYpyskoFQPHmZWe7lJ509eNtE
	 jst1j9nrXuDOZDVSQ3tSEkA+TNxxMrQLe+odHYkxzWz9f4DJXZjwP152fdKitrkiLV
	 GFw0IOV6s1UbIRaB2rf9gRoOhZfBnQ+ikKsCTQytBXASGhAzvN6oO1GFaij1AFkbKp
	 iLSmQulsVKo9Lb4wWvirSYiovLXBXELolk8XnbRNOckQ77vuOJ6FRglFwIfROu6We2
	 3vPRg4gs85p8Q==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: sashiko-bot@kernel.org
Cc: linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 7/8] kprobes: Fix slot reclaim and sibling re-opt in optprobe state machine
Date: Tue, 10 Nov 2026 10:11:08 +0900
Message-ID: <undine-1794273068816464603-4d105c49559e2959@undined.local>
X-Mailer: UndineD 0.1
In-Reply-To: <sashiko-outbox-196313@kernel.org>
References: <179375029807.247640.13024754173032838618.stgit@devnote2> <179375036234.247640.2681461872008285645.stgit@devnote2> <sashiko-outbox-196313@kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

On Wed, 04 Nov 2026 00:30:42 +0000, sashiko-bot@kernel.org <sashiko-bot@kernel.org> wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> - [High] kprobes: slot leak and stale optinsn reuse via register_aggr_kprobe()

OK, this remains.

> - [High] kprobes: missing arch_disarm_kprobe() in unoptimize_kprobe() on force

This has been fixed by Mani's patch. [1]

> - [High] kprobes: premature unhash of rescued aggrprobe in add_new_kprobe()

This also fixed by Mani's patch [2]

[1] https://lore.kernel.org/all/20261105-kprobes-optprobe-state-v2-1-7a2f5290baa0@columbia.edu/
[2] https://lore.kernel.org/all/20261105-kprobes-optprobe-state-v2-3-7a2f5290baa0@columbia.edu/

[...]
> >  		}
> >  	}
> >  
> > @@ -1084,13 +1093,20 @@ static void kill_optimized_kprobe(struct kprobe *p)
> >  				list_del_init(&op->list);
> >  			}
> >  		} else {
> > -			list_del_init(&op->list);
> > +			if (optprobe_queued_unopt(op)) {
> > +				/* Move to cooling list so optinsn slot is cooled down */
> > +				list_move(&op->list,
> > +					  &optprobe_gens[optprobe_cur_gen].cooling_list);
> > +				kick_kprobe_optimizer();
> > +			} else if (!optprobe_queued_cooling(op) && !optprobe_queued_freeing(op)) {
> > +				list_del_init(&op->list);
> > +			}
> >  		}
> >  	}
> >  	op->kp.flags &= ~KPROBE_FLAG_OPTIMIZED;
> >  
> >  	/*
> > -	 * Don't remove the slot if it is queued for freeing or unoptimization;
> > +	 * Don't remove the slot if it is queued for freeing, unoptimization, or cooling;
> >  	 * the optimizer will reclaim it after the quiescence period.
> >  	 */
> >  	if (!optprobe_queued_freeing(op) && !optprobe_queued_unopt(op) &&
> 
> [Severity: High]
> Does deferring arch_remove_optimized_kprobe(op) here leak op->optinsn.insn or
> reuse a stale optinsn trampoline if a new kprobe is registered at the same
> virtual address before cooling completes?

Ah, yes, and we don't need to defer the killing gone kprobes because
that should not hit anymore. (which is in unloaded modules)
OK, let me drop deferring it.

Thanks!


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
