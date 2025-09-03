Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 277B02749C6
	for <linux-trace-kernel@vger.kernel.org>; Wed,  3 Sep 2025 12:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756900854; cv=none; b=f+jiqJTwGV26OQ1s/zgO8lG4nF/FAwsKOVLx+rSuLwaxv2e69oanIlXtRfYXfniEabruO0PULWiY11OoajNNoGMM4mU/Jz7HGR/uteX7oOZoEEbC1TsWuh7sCjjHEXHqlyQ5Ddy1n1Jqd6p2jiz2ws7Du5baedYvXh4D07TNjr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756900854; c=relaxed/simple;
	bh=+grVyZxAWtKNFWpbultXM2V6yd2mmR2F3jJF5AT5BFY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T+VCGH9RBCk5oOQnxRuLYqSUzx7l3A4VEEJMXvcNgpUgnuoDLsZauHD48Yr6hWlkdEh9hqbanT7EzkKLfzI62eziN2OunvmUZew6l5CmxBAbXzUPnQvdX6cPXVi0129Li/yyb40n1Bo9Ig7uOmZyYzWJsvk2c0RTmwlLkvc/hbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Md1PbUhK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Md1PbUhK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756900852;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1nw6naDuPKKSADEwjZLNE9uKM8R6m9CFTff86lS75ms=;
	b=Md1PbUhKggE3Ro1rzklLofbAGUlhL2aXnVZlppR4C/6a0HQWa6vJZ3AIDJZjtrZl47pDJN
	0PQYmbQvRrzSHhkl6q6LcVpKm/PDgOinBT/zF1CobH7F4lq0KBa7U20KE8xyeyO/KVMzCT
	Tigl9Nzk/cPl3GiOheMOERwO0OVSMSs=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-5--AUOuqbjOgiGyYcAnxfZKQ-1; Wed,
 03 Sep 2025 08:00:48 -0400
X-MC-Unique: -AUOuqbjOgiGyYcAnxfZKQ-1
X-Mimecast-MFC-AGG-ID: -AUOuqbjOgiGyYcAnxfZKQ_1756900842
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9B7461800291;
	Wed,  3 Sep 2025 12:00:41 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.52])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 446F31800446;
	Wed,  3 Sep 2025 12:00:35 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed,  3 Sep 2025 13:59:19 +0200 (CEST)
Date: Wed, 3 Sep 2025 13:59:13 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Jiri Olsa <jolsa@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	x86@kernel.org, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Hao Luo <haoluo@google.com>, Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH perf/core 03/11] perf: Add support to attach standard
 unique uprobe
Message-ID: <20250903115912.GD18799@redhat.com>
References: <20250902143504.1224726-1-jolsa@kernel.org>
 <20250902143504.1224726-4-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250902143504.1224726-4-jolsa@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Slightly off-topic, but

On 09/02, Jiri Olsa wrote:
>
> @@ -11144,7 +11147,7 @@ static int perf_uprobe_event_init(struct perf_event *event)
>  {
>  	int err;
>  	unsigned long ref_ctr_offset;
> -	bool is_retprobe;
> +	bool is_retprobe, is_unique;
>  
>  	if (event->attr.type != perf_uprobe.type)
>  		return -ENOENT;
> @@ -11159,8 +11162,9 @@ static int perf_uprobe_event_init(struct perf_event *event)
>  		return -EOPNOTSUPP;
>  
>  	is_retprobe = event->attr.config & PERF_PROBE_CONFIG_IS_RETPROBE;
> +	is_unique = event->attr.config & PERF_PROBE_CONFIG_IS_UNIQUE;
>  	ref_ctr_offset = event->attr.config >> PERF_UPROBE_REF_CTR_OFFSET_SHIFT;
> -	err = perf_uprobe_init(event, ref_ctr_offset, is_retprobe);
> +	err = perf_uprobe_init(event, ref_ctr_offset, is_retprobe, is_unique);

I am wondering why (with or without this change) perf_uprobe_init() needs
the additional arguments besides "event". It can look at event->attr.config
itself?

Same for perf_kprobe_init()...

Oleg.

