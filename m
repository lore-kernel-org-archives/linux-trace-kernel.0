Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794496681;
	b=EMKjnR8WB3Q9cPhAkftwwKeBbDQtvRLCEYKq1+M9mO0LjgSscbmnXkjtDXgOV6DL87HJ
	 BvXCXi2zl31Gq+tSVeGTUXIozpAE57XPHImf6u7zjT7sNIA+9beH1t8q+L8qdH+hBnYso
	 1Mi2E9LHIZnV/C8wf8f6YSoG6zIv8iPw+x58rxvUNVJ1gfNSADnj3VoueSfVFsyxHiyaQ
	 VM7VARaTmr1tb1PPHY9LGYSensULJzIC6zpHjSCCDBrMkGu1U1ZtweZbfB6sh/kwht5mc
	 WwE/L4TPASNZMHSCdNgxyYaQRoNd5EBgQqBfV85KuMExcRyjnsNPTFtfjpnmAe4/6AA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794496681;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Rspamd-Server:X-Rspamd-Queue-Id:
	 X-Stat-Signature:X-Spam-Status:X-Session-Marker:X-Session-ID:
	 DKIM-Signature:X-HE-Tag:X-HE-Meta;
	bh=vVl3OPdDmEk/Lep1Edf7L5yNwWrGSP4vtoO7wQnTxWI=;
	b=Wd4nNco8jRF46o1iTrYCGYjknWCth73tkS4nm5ppbiPAEEAKSvbBNsi7fsZkw5rQwru1
	 uUfKe8ryOhYi8sVRW2vYQc6zkhffoALkRRPOL9Y4xYszpKpGvWxvYbq+s+pgRHPt4tENo
	 OYoX//b0zHzh1Azgi8FueMSY/KfC0G0PZGatBr9vb2KVZC4R1hRNzN1tYd5ySe46a2UJx
	 dhpbEfxfe37KEMeJIuoNtthrME+aXCuzmKrwU2Wq+BfeuwujffT8Ed7fJG5DFWtoUjTET
	 bCCuBPiJ82BtbeT/MdGepWNpMZLC9b/lYj7j6ySlJzlAmRl9BfU0k3l6jcevHsnclvg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goodmis.org;
	spf=pass smtp.mailfrom=goodmis.org;
	dkim=pass header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=sFlYyUwo;
	arc=none smtp.remote-ip=216.40.44.16
Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5192F60A260B
	for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Nov 2026 15:18:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5192F60A260B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=sFlYyUwo
Received: from omf11.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id E57D0C0600;
	Thu, 12 Nov 2026 15:17:58 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf11.hostedemail.com (Postfix) with ESMTPA id 582F12002A;
	Thu, 12 Nov 2026 15:17:57 +0000 (UTC)
Date: Thu, 12 Nov 2026 10:17:56 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: sashiko-bot@kernel.org
Cc: sashiko-reviews@lists.linux.dev, "Linux trace kernel"
 <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH] tracing/probes: Zero out faulted dereferenced fields
Message-ID: <20261112101756.0ff021f9@fedora>
In-Reply-To: <sashiko-outbox-208768@kernel.org>
References: <20261111050322.49bbebfa@fedora>
	<sashiko-outbox-208768@kernel.org>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
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
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: 582F12002A
X-Stat-Signature: 9sydmx1w5zf7zudct5ydxgij88mt4dzo
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18vXnAPWb5a2hgklm7GN+99fl/XGHkt3NY=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=vVl3OPdDmEk/Lep1Edf7L5yNwWrGSP4vtoO7wQnTxWI=; b=sFlYyUwoQcIgG0zva/Yx6C6WuCAxNLeCAEuz7RrRBjjQrTxx9NHb095SgjUun6/vddOXc+K2OR2lJEFgfXzFHyPyVxRW0ocgEPoM0zmtRYSXoScB9N5Oj5ZVEKclhFqNg6a92nBCExp+VjQ+M4T1xZdEbc5A7m/z2DElRmw9e5s=
X-HE-Tag: 1794496677-939391
X-HE-Meta: U2FsdGVkX1/xmpF1FOjryYnXTMrIkuEdg1fIvTDuqsCfY9AqlurdY2yElAPXa2XjdxFpDPL4/JBIHJ/SdF2hOCaRQzbzsBrjaPOeTYue1lkxQrVtVGxR7cJKuH621TPTt+BSDExK9QqUYre8DYpI0z0VPL0Lv8GFfG4oBsgjRSVG9byEN98H9tWqpcWWWauET47ILiCBrzKei3ULjnjbjCXTZuGwOW51bbZVxtIw/0AXPavmFF69/ZIEr4gj9AUgvgnXBUeDp5RVbcWPIQ5hB2WazaOIEfFK+dwhnvG9evf26Q5IpXONDHnYDzP3XC9wfAb9XbT46pFktLeLVMt0c9CAx9vdqo5O

On Wed, 11 Nov 2026 10:17:13 +0000
sashiko-bot@kernel.org wrote:

> 
> [Severity: Medium]
> Does this still leave the trace event field uninitialized in the ring
> buffer when an intermediate dereference faults in stage 2 of
> process_fetch_insn_bottom()?
> 
> In the commit message's "(task_struct)prev->mm->pgd" example, prev is
> valid and prev->mm is NULL, so stage 2 (FETCH_OP_DEREF) succeeds and loads
> val = 0, and the fault happens on the final dereference in stage 3
> (FETCH_OP_ST_MEM), where dest points to the ring buffer field.
> 
> However, if a chain has another dereference after the NULL pointer (such as
> "(task_struct)prev->mm->exe_file->f_inode" when prev->mm is NULL), the
> fault happens in stage 2:
> 
> kernel/trace/trace_probe_tmpl.h:process_fetch_insn_bottom() {
>     ...
> stage2:
> 	/* 2nd stage: dereference memory if needed */
> 	do {
> 		lval = val;
> 		switch (code->op) {
> 		case FETCH_OP_DEREF:
> 			ret = probe_mem_read(&val, (void *)val + code->offset,
> 					     sizeof(val));
> 			break;
> 		case FETCH_OP_UDEREF:
> 			ret = probe_mem_read_user(&val,
> 				 (void *)val + code->offset, sizeof(val));
> 			break;
>     ...
> 		}
> 		if (ret)
> 			return ret;
>     ...
> }
> 
> Here probe_mem_read() only zeroes the stack variable val, and
> process_fetch_insn_bottom() returns early before reaching stage 3.
> Because store_trace_args() ignores a negative return value from
> process_fetch_insn(), the destination field in the ring buffer is never
> written to and retains stale ring buffer data (or, for a dynamic string
> argument, keeps the pre-initialized *dl = make_data_loc(maxlen, ...)
> header without calling set_data_loc()).
> 

Right.

This is the same issue but in a separate spot. I think this fix should
be folded into this patch. That fix would actually be to ignore the
return value from probe_mem_read*(), as a fault would simply make val
zero, and if we are dereferencing it, we should allow it to continue
with a NULL pointer but detect that too.

-- Steve
