Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793239111;
	b=eDUILcNvYHm5RPk+0aCjsoWTwZG8uiVBluPmQrs/8FE7dkWxKX22YzXSTqD1JI/AaUxv
	 +SmHvACf8B7c1EGqqQfhf4b2Me/ol56LEoElLPyaUMdOOuo0s+3JavqJB6/LJLL1ByzGy
	 Hc4kJ0g297r06xSTHfUWpnzWooD60o0po5pRvD9y5x7JOhHDLp0+S+vHeOcv8ri9eCz7r
	 RpqruKlRXb9kX+gC/gh8IJhgEUIWSAq9qxSw9wwOgz58Uv0NPb+CkfTgOqGODwKEWaKJ7
	 rvB3aQA8zSqd1s9WXVVwUgYFERxkyPmitkTGrU/4ylqCFKOcHWdjwadkCZ5g3nLDBDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793239111;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=dDDmBiZ6LBL5o6on1kZE5w5gRBPR0BWLVFqunJKKsIQ=;
	b=0GfSpyJwcAXuo+7TgHMYqr4N5QKnSwzd1lu7pIxzfpd/uwJjf3e7PopfuzYV684l3ZtR
	 q2oYISEK+MDWQywizTEUs1qJ2OOkIwx0IJ50Y79KoUX/CpdBOq1BKN0G+VP93/Nt9xfEQ
	 q/O4V/nsYsRe7IDw7TuE4DJyJ3569jzpfUa/U+gscH4xHVssog0BDatHCdmmnT3265Ptf
	 /fjGGvUgjm5Ocbv4u+pa33gwEVAjJ5ZrJXmCO/CkQOS5XmD2pqS55K7T8rOEmdaq1Z+7E
	 FdhA/tQvCEQU+s9jDhQvwauZ/a9dYNKAlPUduT4uwAEJiiOXIiU56kZSIKS+KdTBhaw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ub8gTPqk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8B27606A31A
	for <linux-trace-kernel@vger.kernel.org>; Thu, 29 Oct 2026 01:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ub8gTPqk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D266B1F01825;
	Thu, 29 Oct 2026 01:58:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793239110;
	bh=dDDmBiZ6LBL5o6on1kZE5w5gRBPR0BWLVFqunJKKsIQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ub8gTPqkt8pyspVhoSyHC1VlJDozmnIAzZ8il2b2MBw84eq5aHQ/6Gl4W2KsopAbn
	 c3TfcaFu2Rdzn3IWfxFlw9IOIwXGQAiuSOrDAUz0Z4mcmSOB2Ipvvz/3nZBaIpXpeI
	 IHz0vSZRV513HK5aGgrA7zmesq0q0TJi5OZzpShKbXCCm5eiT2/x0pKpZaJ10tvEXM
	 uYHJjY9X41GmMNjhQVO2GO9Gd5jqgKanot0ZHQBVMGfS/zp7CR6qUrt379sLquSrwV
	 8iBxA1Qr9zA6jKLgyeCCdUygMujK1ixeQybgzkFLAlEDJF7xs3r8z2Vplp/ZSrgsXz
	 tPUcOFLHTbcRg==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: sashiko-bot@kernel.org
Cc: linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v4 02/15] tracing/filters: Fix false success return in process_system_preds()
Date: Thu, 29 Oct 2026 10:58:28 +0900
Message-ID: <undine-1793239108399290229-f99952b4203598ed@undined.local>
X-Mailer: UndineD 0.1
In-Reply-To: <sashiko-outbox-188613@kernel.org>
References: <179323784538.740114.15323117974242744566.stgit@devnote2> <179323786427.740114.10413984130946236850.stgit@devnote2> <sashiko-outbox-188613@kernel.org>
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

On Thu, 29 Oct 2026 01:45:53 +0000, sashiko-bot@kernel.org <sashiko-bot@kernel.org> wrote:
> [Severity: Medium]
> Can process_system_preds() return 0 instead of -ENOMEM when an allocation
> fails after at least one event matches the filter?
> 
> In kernel/trace/trace_events_filter.c:process_system_preds(), ret is
> initialized to -ENOMEM and cleared to 0 as soon as process_preds() succeeds
> for an event:
> 
> 	err = process_preds(file->event_call, filter_string, filter, pe);
> 	if (err) {
> 		...
> 	} else {
> 		event_set_filtered_flag(file);
> 		ret = 0;
> 	}
> 
> 	filter_item = kzalloc_obj(*filter_item);
> 	if (!filter_item)
> 		goto fail_mem;
> 
> If kzalloc_obj(*filter_item) fails on that same iteration, or if
> kzalloc_obj(*filter), kstrdup(), or kzalloc_obj(*filter_item) fails on a
> subsequent event in the loop, jumping to fail_mem returns ret (which is now
> 0) instead of -ENOMEM.
> 
> That causes create_system_filter() and apply_subsystem_event_filter() to
> treat the aborted update as a success, leaving the remaining events in the
> subsystem without the new filter applied. Also, if kzalloc_obj(*filter_item)
> fails right after event_set_filtered_flag(file) runs, EVENT_FILE_FL_FILTERED
> is set and trace_buffered_event_enable() is called, while fail_mem frees the
> new filter without installing it via event_set_filter(file, filter).

Oops, right. Hmm, it is better to set ENOMEM for each goto fail_mem...

Thanks,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
