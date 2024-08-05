Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC9A15B13A
	for <linux-trace-kernel@vger.kernel.org>; Mon,  5 Aug 2024 15:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722873589; cv=none; b=TSy8DvvyxWSh22L5Tq4UlqHSx78r8mxrBY29vyT2Hy+M0mrcuI96Bgw9ZTD7tJjC+oE92p7c0//aGlMJTTqy+Aj2r283ZI9dVvJmLGYwSbkz8tb82tT5XHaZwIy/0dJYclpel9BjYVAVFjmkMOQrZmhLzbUW01MgW2117g1DdtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722873589; c=relaxed/simple;
	bh=q73GkdMAUsuhmAurIE+4Rh4oA3WCaPz5k88nx2PWlUQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Va3wagHS701w7JrzZXpLgPq3y2DhAHH55J433r3arVrQfFAYE3A6upF5F5KIiH/k7/PKKa6lfRBKSD/zFznVOVer0Gngw7ue0+Ac5Vq+Mgbm9no6bIoVOYG7bvaYV/rs4os3gpe8x5UJ30z2XcYrV83ETxphI3YRkYPH1Q/aQOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AOH3DJeT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AOH3DJeT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722873586;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=F5WoF7SpMgNw9Tt7F4AdxuqhGssiOGa0SxaZrKFwOpc=;
	b=AOH3DJeT//Li3jMDTPWCjoxYsqU3H9TBQl7Tmc+IaVQL7X4i4oZhO4MxEbT4Lk5FWqQwby
	uCuO+ZthIG0A4iBpsCaEIW/HJieSgl/6sAQCl9EIgKlA+5ST6uUTSF5m9gz+dxMYP7Ck3k
	K/zaLHTWv/SGaUQKH79SJJxQ18xiL5s=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-63-MA47QDb7PJSsHtxBMgmnig-1; Mon,
 05 Aug 2024 11:59:40 -0400
X-MC-Unique: MA47QDb7PJSsHtxBMgmnig-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8A1B11955D52;
	Mon,  5 Aug 2024 15:59:38 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.34])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 9BA311955D44;
	Mon,  5 Aug 2024 15:59:34 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Mon,  5 Aug 2024 17:59:36 +0200 (CEST)
Date: Mon, 5 Aug 2024 17:59:32 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, peterz@infradead.org,
	rostedt@goodmis.org, mhiramat@kernel.org, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, jolsa@kernel.org, paulmck@kernel.org
Subject: Re: [PATCH 5/8] uprobes: travers uprobe's consumer list locklessly
 under SRCU protection
Message-ID: <20240805155931.GC11049@redhat.com>
References: <20240731214256.3588718-1-andrii@kernel.org>
 <20240731214256.3588718-6-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240731214256.3588718-6-andrii@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On 07/31, Andrii Nakryiko wrote:
>
> @@ -1120,17 +1098,19 @@ void uprobe_unregister(struct uprobe *uprobe, struct uprobe_consumer *uc)
>  	int err;
>
>  	down_write(&uprobe->register_rwsem);
> -	if (WARN_ON(!consumer_del(uprobe, uc))) {
> -		err = -ENOENT;

OK, I agree, this should never happen.

But if you remove this check, then

>  int uprobe_apply(struct uprobe *uprobe, struct uprobe_consumer *uc, bool add)
>  {
>  	struct uprobe_consumer *con;
> -	int ret = -ENOENT;
> +	int ret = -ENOENT, srcu_idx;
>
>  	down_write(&uprobe->register_rwsem);
> -	for (con = uprobe->consumers; con && con != uc ; con = con->next)
> -		;
> -	if (con)
> -		ret = register_for_each_vma(uprobe, add ? uc : NULL);
> +
> +	srcu_idx = srcu_read_lock(&uprobes_srcu);
> +	list_for_each_entry_srcu(con, &uprobe->consumers, cons_node,
> +				 srcu_read_lock_held(&uprobes_srcu)) {
> +		if (con == uc) {
> +			ret = register_for_each_vma(uprobe, add ? uc : NULL);
> +			break;
> +		}
> +	}

we can probably remove the similar check above?

I mean, why do we need the list_for_each_entry_srcu() above? Is it possible
that uprobe_apply(uprobe, uc) is called when "uc" is not on the ->consumers
list?

At first glance I see no problems in this patch... but you know, my eyes are
already blurring, I'll continue tomorrow and read this patch again.

Oleg.

