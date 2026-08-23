Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D0972FE056
	for <linux-trace-kernel@vger.kernel.org>; Sun, 23 Aug 2026 15:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787499503; cv=none; b=lFwIi3KNUqrsDquXCr8kZbbkp7Zgrff1gPu744e2JsWUrqR/16Z1jz7nwTSOFSMg30nx5Y/DTXafF9bbmAg4FR1Eyrx8Uk8bWFIsnCANVanQGzsU9bdLYPh4QygoIYAppJx3StgC0iRJxTAavleOzE4r/aO2dKL+f4HA1jEC0Nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787499503; c=relaxed/simple;
	bh=Tbar21ce9OTGcLBMIQzzGytM5xBdN3LvkCP6lfk5XOs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=nEBWzukouYSVtNgCgQJXbSNgfAeW06T0t/74I6xqh4mTO0yQe8lbZtaZFCCedV5ly9udfpB5gmKhaihOaQzb6fyVizt8KyyJj+AGWzmVd/3+rCGOSMIs5KiYtpub/ItTehvGLFAxJ4BW5gWZXtgXpCs2F/C05tgBtrrcckzVVOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KMFInANU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KMFInANU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787499501;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PAA53XOf3mrbjNpGupFk6+rMupZk8loQAb5QiUHye6o=;
	b=KMFInANUKvO/XED7qe7tVtx5mTHQSynNDemRNTB1J7DeHLgTnanVsk9rTAvMjWWoQJo7QK
	3Xz16RZW/j0oKI6eF34KZcN79rA++OfezwellvABkL3OS5quXMLY7OQ5NtuWiNCJSwRvw8
	eOlqKXbDZkZLfOI2NzY6LTf0loNVeA4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-312-MYOS7aidMuu3gqaPupF6sw-1; Sun,
 23 Aug 2026 11:38:16 -0400
X-MC-Unique: MYOS7aidMuu3gqaPupF6sw-1
X-Mimecast-MFC-AGG-ID: MYOS7aidMuu3gqaPupF6sw_1787499494
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EB9F2195398B;
	Sun, 23 Aug 2026 15:38:13 +0000 (UTC)
Received: from fedora (unknown [10.44.32.9])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id D290619560AB;
	Sun, 23 Aug 2026 15:38:09 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sun, 23 Aug 2026 17:38:13 +0200 (CEST)
Date: Sun, 23 Aug 2026 17:38:08 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Keke Ming <ming.jvle@gmail.com>, Andrii Nakryiko <andrii@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] uprobes: Free utask on dup_return_instance() failure
Message-ID: <aosT4H14zcowzU_7@redhat.com>
References: <20260822054620.452262-1-ming.jvle@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260822054620.452262-1-ming.jvle@gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-MFC-PROC-ID: Zk-vSm3ihtEE9d_dSnT9kunjz7haRs-QSimFHUIH15g_1787499494
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

(Add Andrii and Jiri)

On 08/22, Keke Ming wrote:
>
> dup_utask() installs the new uprobe_task in t->utask before copying
> return_instances. If dup_return_instance() fails, the partially copied
> utask is left attached to the child task.

Yes,

> Free the partially copied utask before returning -ENOMEM.

But why?

Note that uprobe_copy_process() warns but returns "void", too late
to abort copy_process().

Perhaps we should change uprobe_copy_process() to kill the new child
on failure, it will likely crash anyway.

But I don't think this patch can make the things any better.

Oleg.

> Signed-off-by: Keke Ming <ming.jvle@gmail.com>
> ---
>  kernel/events/uprobes.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> index b25531331902..0c8a664a0fe5 100644
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
> @@ -2140,8 +2140,10 @@ static int dup_utask(struct task_struct *t, struct uprobe_task *o_utask)
>  	p = &n_utask->return_instances;
>  	for (o = o_utask->return_instances; o; o = o->next) {
>  		n = dup_return_instance(o);
> -		if (!n)
> +		if (!n) {
> +			uprobe_free_utask(t);
>  			return -ENOMEM;
> +		}
>
>  		/* if uprobe is non-NULL, we'll have an extra refcount for uprobe */
>  		uprobe = hprobe_expire(&o->hprobe, true);
> --
> 2.43.0
>

