Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB5B318C31
	for <linux-trace-kernel@vger.kernel.org>; Sun,  7 Jul 2024 12:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720356634; cv=none; b=ry19Ld5xjvxOladZeebicyJArWfRImNSikqA771MV6ugcx0HcxfBmSYOX798whfFoTiQLdQ0nyiPd9BIUzFuFncuU/OXse2xHqGB1ddho3U6VOB+TNAZ+gTTwUaWfwXYWwO6eSIa/5f7jQv0vX9u7BBGGdb0nO7+0Gs6/qyw/fY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720356634; c=relaxed/simple;
	bh=taH0YtrxQyEc0YzAXWGoaJZyN70H1TeiAKd9O10n1rs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cb1qY2CSEUrPovDf+ZCVnesFOltrInrVGMvGRIPG7vq4STvPZiHcUcTvkj5m7NPJX9KmUIz28w2HV+XQFpzv6g4EONVX/KWhsWB3mnJO44Lb20WKkLDZUahmThtCMVYYGs14n6gPNJq/mLQDxuM4OjhXGdYAqFB5mVepENCSkBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PHlYaJCP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PHlYaJCP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720356631;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=D8olNbJRf/Z+tPofro/3YxVNnY4kbev5E8DXeMQ5ytA=;
	b=PHlYaJCPtqCKiqlfkRlg7uLEmx951rCyS1Msd5mdYMB01EFBC79BZv+B0fLm6GNt8mZJdt
	VUi3oprMd2Darw0tUAc7j4TZ1oc9b//v5Tl1j9rD9WGXX0RwRUO74bDKL/C/2frHgx1kMx
	pqQTRhTJnK2La2OJo7lzaWnry1jrvcg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-252-53zLvoATMBqFv583PKcHpw-1; Sun,
 07 Jul 2024 08:50:29 -0400
X-MC-Unique: 53zLvoATMBqFv583PKcHpw-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 04F21195609E;
	Sun,  7 Jul 2024 12:50:28 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.39])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id EA33C1955F3B;
	Sun,  7 Jul 2024 12:50:23 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sun,  7 Jul 2024 14:48:51 +0200 (CEST)
Date: Sun, 7 Jul 2024 14:48:46 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, rostedt@goodmis.org,
	mhiramat@kernel.org, peterz@infradead.org, mingo@redhat.com,
	bpf@vger.kernel.org, jolsa@kernel.org, paulmck@kernel.org,
	clm@meta.com
Subject: Re: [PATCH v2 05/12] uprobes: move offset and ref_ctr_offset into
 uprobe_consumer
Message-ID: <20240707124846.GA11914@redhat.com>
References: <20240701223935.3783951-1-andrii@kernel.org>
 <20240701223935.3783951-6-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240701223935.3783951-6-andrii@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On 07/01, Andrii Nakryiko wrote:
>
> --- a/include/linux/uprobes.h
> +++ b/include/linux/uprobes.h
> @@ -42,6 +42,11 @@ struct uprobe_consumer {
>  				enum uprobe_filter_ctx ctx,
>  				struct mm_struct *mm);
>  
> +	/* associated file offset of this probe */
> +	loff_t offset;
> +	/* associated refctr file offset of this probe, or zero */
> +	loff_t ref_ctr_offset;
> +	/* for internal uprobe infra use, consumers shouldn't touch fields below */
>  	struct uprobe_consumer *next;


Well, I don't really like this patch either...

If nothing else because all the consumers in uprobe->consumers list
must have the same offset/ref_ctr_offset.

--------------------------------------------------------------------------
But I agree, the ugly uprobe_register_refctr() must die, we need a single
function

	int uprobe_register(inode, offset, ref_ctr_offset, consumer);

This change is trivial.

--------------------------------------------------------------------------
And speaking of cleanups, I think another change makes sense:

	-	int uprobe_register(...);
	+	struct uprobe* uprobe_register(...);

so that uprobe_register() returns uprobe or ERR_PTR.

	-	void uprobe_unregister(inode, offset, consumer);
	+	void uprobe_unregister(uprobe, consumer);

this way unregister() doesn't need the extra find_uprobe() + put_uprobe().
The same for uprobe_apply().

The necessary changes in kernel/trace/trace_uprobe.c are trivial, we just
need to change struct trace_uprobe

	-	struct inode                    *inode;
	+	struct uprobe			*uprobe;

and fix the compilation errors.


As for kernel/trace/bpf_trace.c, I guess struct bpf_uprobe  needs the new
->uprobe member, we can't kill bpf_uprobe->offset because of
bpf_uprobe_multi_link_fill_link_info(), but I think this is not that bad.

What do you think?

Oleg.

