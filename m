Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4833B16C857
	for <linux-trace-kernel@vger.kernel.org>; Thu, 11 Jul 2024 16:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720714125; cv=none; b=WbiZcoAgvicangtPX6Fd239vIcEgvQrHFW3llFnUvNPSk/NARdkp3fpj1LzqBoUCNGnSRZapnQvA2RP9hq5r7E/DGWNvigTa4cvncGu8oTGNtozeZb+BkhVT6Pru4gZG0X+SxoVQt1Y3rPJ5KcBTsSZ6CZmOAx/XASoTw0do+k4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720714125; c=relaxed/simple;
	bh=qN0wmCW/k1iCpLejR5R5JII4+LFenpvZ9gTPOETVeuY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zj5bDaE6Wmh3hHkgu+AkWkQCjCG7H60mUxUAnt0wMonNmVxc0URpU3kP8/ycSZK1Y3RgnxquSAGrVLKwgBF52rZHGNJU5uAwtlybznOW3P4lP0G1+hMSOUP/waV6efgOH1aO83Pm8EN0fubUdON1qNRPQMIZjSSXGayC0g9GGcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=am57vXcj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="am57vXcj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720714123;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hgGl9mF1/pdLfefEWwcTT04X38sx/DljoB18U/mp7y8=;
	b=am57vXcjtcexc3lBqJbF+pS8HgdBI7dER4P4o8ydrzrmHEhZaHKvamhf4YNetH2ba5GmVX
	uQY8+5PCf4H0QXH7CHynNKcIUqSbYdZUd+QOxhXaPqKlIGkr//ekIvbct72eOp73B81oSU
	DcnmlYBlT4bQ9orshWaHM8AAncquRIA=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-519-0LOXUkM0MVa3lAmAuDnXCg-1; Thu,
 11 Jul 2024 12:08:36 -0400
X-MC-Unique: 0LOXUkM0MVa3lAmAuDnXCg-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D0C291955F3E;
	Thu, 11 Jul 2024 16:08:34 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.32])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 27A9519560AE;
	Thu, 11 Jul 2024 16:08:30 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu, 11 Jul 2024 18:06:57 +0200 (CEST)
Date: Thu, 11 Jul 2024 18:06:53 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@kernel.org, andrii@kernel.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, rostedt@goodmis.org,
	mhiramat@kernel.org, jolsa@kernel.org, clm@meta.com,
	paulmck@kernel.org
Subject: Re: [PATCH v2 10/11] perf/uprobe: Convert single-step and uretprobe
 to SRCU
Message-ID: <20240711160652.GE16902@redhat.com>
References: <20240711110235.098009979@infradead.org>
 <20240711110401.311168524@infradead.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240711110401.311168524@infradead.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

I'll try to actually apply the whole series and read the code tomorrow.
Right now I can't understand this change... Just one question for now.

On 07/11, Peter Zijlstra wrote:
>
> @@ -1956,11 +1960,13 @@ static void prepare_uretprobe(struct upr
>  			 * attack from user-space.
>  			 */
>  			uprobe_warn(current, "handle tail call");
> -			goto err_uprobe;
> +			goto err_mem;
>  		}
>  		orig_ret_vaddr = utask->return_instances->orig_ret_vaddr;
>  	}
>
> +	ri->srcu_idx = __srcu_read_lock(&uretprobes_srcu);
> +	ri->uprobe = uprobe;

It seems that, if we race with _unregister, this __srcu_read_lock()
can happen after call_srcu(uprobes_srcu, uprobe, uprobe_free_stage1)
was already called...

In this case read_lock "has no effect" in that uprobe_free_stage1()
can run before free_ret_instance() does srcu_read_unlock(ri->srcu_idx).

Perhaps it is fine, uprobe_free_stage1() does another call_srcu(),
but somehow I got lost.

Could you re-check this logic? Most probably I missed something, but still...

Oleg.

