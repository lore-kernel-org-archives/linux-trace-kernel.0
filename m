Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794409625;
	b=1gg3j/+tGdYQ0ugrWfKEUJS/4AuSJbGFZ4/9VlgQbfL1QxQgwLUbKP6/lU1HCxndB8fl
	 B04Z2yyorKTBz02AWNYwrWmLz8gX+stTKdkHZYYdDWbZhKdXqIamjPvVdoGSU2bfQ87ZZ
	 4NBVMymc6cmR8+IIXjbOLxH3F6Xu3/uAYQVWvcpcRgJDadCitfAjkVm1K3tGxWjM4kW7W
	 OQYoZE12kj/v0mHQE1ZxCjV8P/XqiHC0reZdAw2kTUb5n+A74ZrXfBJXi/ConEv5YHjbR
	 S5bcG4cOsVu66lDxB1l2mOggYVlpYEzoSAcB0dAGIGQ5/Vyrc0LIY5/xVQKmvg2hTgA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794409625;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:In-Reply-To:X-Scanned-By:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
	 Content-Disposition;
	bh=B4vmEo6JeWk7kI+Rbno6KTwqomkHC0TPZQ7Gp154qJo=;
	b=NKxKkZ8mY9hauQ5pazCD+qYVE2yOhvyWOLjDGTU7QR1jl/TP5rRtXhO64uklCCyNTYJ+
	 WARnTuR1WqVq4DHvh3045x4StIFcg9cRS4VTuknaEYxPzLD9WxLlDHTnbqo4QIS2Aixil
	 TNq55lcHcAZw2r0hQqTUvW9dPfhulszFiCQys54DgZoEFhiZ0SYPxAj3XPHcPRHc2GfVf
	 1rmwqrrUeS1YgteUx3jCrsmUhWAKUSwy+bzZAg6eqQaa6ZhXoK3lMdHlT0YLN8WpM5Zyp
	 QxKGCVDN6zVbO3iGwsQ2trvtb2TWp4lBbnRA0XNkh1170xU88JfcDHjEXuG3os9zLXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=PqzR6Uwe;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C02B9606A899
	for <linux-trace-kernel@vger.kernel.org>; Wed, 11 Nov 2026 15:07:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C02B9606A899
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=PqzR6Uwe
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794409624;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=B4vmEo6JeWk7kI+Rbno6KTwqomkHC0TPZQ7Gp154qJo=;
	b=PqzR6UweFSF/N9BPbRq6DAbgJSHCizeAf+L2XXcvhci53SVoybbGSh90p9IIuOWedC2ui5
	8IyTAlYTfaq4xK3BWAQPfBXdQ8ecgjbn07Z56Lz6xy26rTJFhtkS8WFkpZwKvsHjt+dGWZ
	9eJ7afBKmoK2K3jYSufYeLdxGdIqiTU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-370-AisQuOWnM4mok3IeGCsEUQ-1; Wed,
 11 Nov 2026 10:06:58 -0500
X-MC-Unique: AisQuOWnM4mok3IeGCsEUQ-1
X-Mimecast-MFC-AGG-ID: AisQuOWnM4mok3IeGCsEUQ_1794409616
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E603319540F2;
	Wed, 11 Nov 2026 15:06:55 +0000 (UTC)
Received: from onestero-thinkpadp1gen7.tpbc.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id CED3330000E8;
	Wed, 11 Nov 2026 15:06:51 +0000 (UTC)
Received: by onestero-thinkpadp1gen7.tpbc.csb (nbSMTP-1.00) for uid 13628
	oleg@redhat.com; Wed, 11 Nov 2026 16:06:55 +0100 (CET)
Date: Wed, 11 Nov 2026 16:06:50 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Rosen Penev <rosenp@gmail.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v2] uprobes: Use flexible array for xol_area bitmap
Message-ID: <avSEikCPEn_Q3KpI@redhat.com>
References: <20261111022605.66010-1-rosenp@gmail.com>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <20261111022605.66010-1-rosenp@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: XnUtwZg1EFl_VFvrlj_ta0z5OuYi5fg1a1IxYu4Z6Gw_1794409616
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On 11/10, Rosen Penev wrote:
>
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
> @@ -108,7 +108,6 @@ static LIST_HEAD(delayed_uprobe_list);
>   */
>  struct xol_area {
>  	wait_queue_head_t		wq;		/* if all slots are busy */
> -	unsigned long			*bitmap;	/* 0 = free slot */
>  
>  	struct page			*page;
>  	/*
> @@ -117,6 +116,7 @@ struct xol_area {
>  	 * the vma go away, and we must handle that reasonably gracefully.
>  	 */
>  	unsigned long			vaddr;		/* Page(s) of instruction slots */
> +	unsigned long			bitmap[];	/* 0 = free slot */

I agree with Peter, you can just use
	
	unsigned long			bitmap[BITS_TO_LONGS(UINSNS_PER_PAGE)];

Oleg.

