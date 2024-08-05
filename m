Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F0A313C3EE
	for <linux-trace-kernel@vger.kernel.org>; Mon,  5 Aug 2024 14:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722869531; cv=none; b=soLwTzQe+aLhNdTbFvE0RltKRSES9sIKYJLz+FNCoqg1Cu7qGdplV0LQMzxVhRmIVIiqJdtqzbhnd867tc9z+3DIjJWvRDirbKohndThX10IRQXEGukvURkMx3xx0gj0ZHrcfpT+V1IaI/UMr6HFNm/QcxamvwThMkRIFcND5Qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722869531; c=relaxed/simple;
	bh=4OYN+uwqmllS1ifCVYqfqrP0wsuDr0tVy3A/D+B1b7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bzgH5/kw2thuEVE9uiroX/NTKxsraWJjq6xjg25V4zjHRVvLPhOQgybpuMtRtlRTDMqN187m2yNAr7Y71EEm0/1xT+J1mGJCp6STcBfBx48M2RC+Ae+2ygsXQdIbd1hQx0wQXZvGSeVKGE93U/9jYJFlWeMNtsxymHNTtexnPS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DpaZorHH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DpaZorHH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722869529;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OHZfGYL5T6FMYKUtqsFLa7gkK/CdeKX+rspJ2D4JRhI=;
	b=DpaZorHH99CG4YX8tuW2ndK+ctx03hopRUiOTxf97hoMaHkwArPjCsdYKtru7Uk2pdEhk0
	gyG9eAlfVFwCA6Ys0ChDa2AhSk80aPwMJnolb3/IVVlsTfhKrR1cZf42F6x/cue3d93Qn1
	l5I/g8399jaN5X/mTDind5kQYpENXqI=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-177-2dl5GU_qO0elz3KG8l5Nsw-1; Mon,
 05 Aug 2024 10:52:04 -0400
X-MC-Unique: 2dl5GU_qO0elz3KG8l5Nsw-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A28211955D4A;
	Mon,  5 Aug 2024 14:52:02 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.34])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 1872D1955D42;
	Mon,  5 Aug 2024 14:51:58 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Mon,  5 Aug 2024 16:52:00 +0200 (CEST)
Date: Mon, 5 Aug 2024 16:51:56 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, peterz@infradead.org,
	rostedt@goodmis.org, mhiramat@kernel.org, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, jolsa@kernel.org, paulmck@kernel.org
Subject: Re: [PATCH 3/8] uprobes: protected uprobe lifetime with SRCU
Message-ID: <20240805145156.GB11049@redhat.com>
References: <20240731214256.3588718-1-andrii@kernel.org>
 <20240731214256.3588718-4-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240731214256.3588718-4-andrii@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

LGTM, just a few notes...

On 07/31, Andrii Nakryiko wrote:
>
> @@ -59,6 +61,7 @@ struct uprobe {
>  	struct list_head	pending_list;
>  	struct uprobe_consumer	*consumers;
>  	struct inode		*inode;		/* Also hold a ref to inode */
> +	struct rcu_head		rcu;

you can probably put the new member into the union with, say, rb_node.

> @@ -1945,9 +1950,14 @@ pre_ssout(struct uprobe *uprobe, struct pt_regs *regs, unsigned long bp_vaddr)
>  	if (!utask)
>  		return -ENOMEM;
>
> +	if (!try_get_uprobe(uprobe))
> +		return -EINVAL;
> +

a bit off-topic right now, but it seems that we can simply kill
utask->active_uprobe. We can turn into into "bool has_active_uprobe"
and copy uprobe->arch into uprobe_task. Lets discuss this later.

> @@ -2201,13 +2215,15 @@ static void handle_swbp(struct pt_regs *regs)
>  {
>  	struct uprobe *uprobe;
>  	unsigned long bp_vaddr;
> -	int is_swbp;
> +	int is_swbp, srcu_idx;
>
>  	bp_vaddr = uprobe_get_swbp_addr(regs);
>  	if (bp_vaddr == uprobe_get_trampoline_vaddr())
>  		return uprobe_handle_trampoline(regs);
>
> -	uprobe = find_active_uprobe(bp_vaddr, &is_swbp);
> +	srcu_idx = srcu_read_lock(&uprobes_srcu);
> +
> +	uprobe = find_active_uprobe_rcu(bp_vaddr, &is_swbp);
>  	if (!uprobe) {
>  		if (is_swbp > 0) {
>  			/* No matching uprobe; signal SIGTRAP. */
> @@ -2223,6 +2239,7 @@ static void handle_swbp(struct pt_regs *regs)
>  			 */
>  			instruction_pointer_set(regs, bp_vaddr);
>  		}
> +		srcu_read_unlock(&uprobes_srcu, srcu_idx);
>  		return;

Why not
		goto out;

?

Oleg.

