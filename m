Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 791A6218585
	for <linux-trace-kernel@vger.kernel.org>; Thu,  9 Jan 2025 14:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736432713; cv=none; b=MMMeWqBU1A45wjV9sxCg8GZJ6iZI8UnNAvlbYmBtOSJQk17f/+h+2uJB5UUpMg2wl7O2i96w8wpKlK0mVtOKZmdEEGzaT43XTtJgYctbjtLd8nEa2laUq4Dt3zeX85qoEJP6XRLoQLxFJ2iewJV01bGkrxEmci3WqanSO1UWoaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736432713; c=relaxed/simple;
	bh=toDOfdT/dLLxxneMaOhjxbgIjQyaRYqQq8Kg/40SKto=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Df1exo3+OyrTZrR+5a7Im9X7cdQ/nA9lSEzz6EP5a2eqxJhF+0oTn3m/8jdYat87Um/lyMJLYogdTPDauN0uEdRpw/GcHGlc4My6WldCnn4jvBdwrO/FjMs6flU2SaPPXfvqT1WA8XWTJbcfBtisMZj1+0Fq3C+4YthxpUIe51Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GA+HHG1e; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GA+HHG1e"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736432710;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6TQ+MRlGX4zoVa4E9hEX0jIlbvnXvUvfeYr2R+u5ruo=;
	b=GA+HHG1eF964nkbEmGTbYRgEZEAyIhmpGG6owl4SMzA5olHxLsas+Bp0q2txZP9FUrXPF8
	DqGTrX54mpWJJueRykFew/EBdYq0i0z+W4CDQQNGWPfremz8QQWvLDDrpAyS0dke3oD9JM
	OnYdIgCMy7a1D8+xQ8P1D9gE1BfmCDo=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-631-_xap2Xl0OAKARNgrQ8yOhg-1; Thu,
 09 Jan 2025 09:25:07 -0500
X-MC-Unique: _xap2Xl0OAKARNgrQ8yOhg-1
X-Mimecast-MFC-AGG-ID: _xap2Xl0OAKARNgrQ8yOhg
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 483C619560B8;
	Thu,  9 Jan 2025 14:25:05 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.245])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 44721195E3D9;
	Thu,  9 Jan 2025 14:25:00 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu,  9 Jan 2025 15:24:40 +0100 (CET)
Date: Thu, 9 Jan 2025 15:24:35 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Jiri Olsa <jolsa@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Max Makarov <maxpain@linux.com>, bpf@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] uprobes: Fix race in uprobe_free_utask
Message-ID: <20250109142434.GD26424@redhat.com>
References: <20250109141440.2692173-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250109141440.2692173-1-jolsa@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On 01/09, Jiri Olsa wrote:
>
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
> @@ -1915,6 +1915,7 @@ void uprobe_free_utask(struct task_struct *t)
>  	if (!utask)
>  		return;
>
> +	t->utask = NULL;
>  	WARN_ON_ONCE(utask->active_uprobe || utask->xol_vaddr);
>
>  	timer_delete_sync(&utask->ri_timer);
> @@ -1924,7 +1925,6 @@ void uprobe_free_utask(struct task_struct *t)
>  		ri = free_ret_instance(ri, true /* cleanup_hprobe */);
>
>  	kfree(utask);
> -	t->utask = NULL;

Acked-by: Oleg Nesterov <oleg@redhat.com>

