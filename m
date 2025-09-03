Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 506842FF17D
	for <linux-trace-kernel@vger.kernel.org>; Wed,  3 Sep 2025 13:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756905848; cv=none; b=UG3p20ERPYwqvwJVrwjTAcUfEVN/SFSlTcruFohh2sVZlGpErr5AVYi5neicWxj88r0lPiaQQ3OgrNc/wUFNMbfyv5AOsw8udDBueXHQGZIjv10KNrjhbrsTJbIEXrK7GxlhF0KDbHt7G3IJj9EaKHshdg4kNF3mKeCHNMahTtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756905848; c=relaxed/simple;
	bh=jzIteg6avMtpEuBBHIFZYlXNRMKt8IW7AEhql563AnA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WMDUgUH9KgEw7OPSljXWEqnOCX7hfkwc0oW6dJnDm9nrJMzDqeIBVAC/Gl2HnvfhRxTlkW7s/l7+Ilkv4IHPEI037Ehc2DL6gIldklzMxCCtTh01L4yMLQWZe9BraRSw9hwEtZ274nctEKwJ2+ulrI+tLNfJ0iWmSSeAuWwTH3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O0BrmUPp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O0BrmUPp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756905846;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jzIteg6avMtpEuBBHIFZYlXNRMKt8IW7AEhql563AnA=;
	b=O0BrmUPp0cCx0RLsvqrMRUATepZcv1zyuvJ1QmcddOfp3deTAu0xZxdjJidwgRO6lgeaIp
	RMdTs9ZGnRlJB5L/y7wfr1tZDWU/opIDtsugQp4jpzfo5AJLsd7JUrq7ndTWejGPrcV0jO
	9AdxSv8pC9IafiK5Xe4NVmfE0vlaxz4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-353-rYNH-XEqPi2Wy7BrFLnPAA-1; Wed,
 03 Sep 2025 09:24:01 -0400
X-MC-Unique: rYNH-XEqPi2Wy7BrFLnPAA-1
X-Mimecast-MFC-AGG-ID: rYNH-XEqPi2Wy7BrFLnPAA_1756905835
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8DC6C180035C;
	Wed,  3 Sep 2025 13:23:55 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.52])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id B313E1955F19;
	Wed,  3 Sep 2025 13:23:50 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed,  3 Sep 2025 15:22:33 +0200 (CEST)
Date: Wed, 3 Sep 2025 15:22:27 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Jiri Olsa <olsajiri@gmail.com>
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
Message-ID: <20250903132226.GE18799@redhat.com>
References: <20250902143504.1224726-1-jolsa@kernel.org>
 <20250902143504.1224726-4-jolsa@kernel.org>
 <20250903115912.GD18799@redhat.com>
 <aLg8lLgHdBhNeaOf@krava>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aLg8lLgHdBhNeaOf@krava>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 09/03, Jiri Olsa wrote:
>
> On Wed, Sep 03, 2025 at 01:59:13PM +0200, Oleg Nesterov wrote:
> >
> > I am wondering why (with or without this change) perf_uprobe_init() needs
> > the additional arguments besides "event". It can look at event->attr.config
> > itself?
> >
> > Same for perf_kprobe_init()...
>
> I think that's because we define enum perf_probe_config together
> with PMU_FORMAT_ATTRs and code for attr->config parsing, which
> makes sense to me

Ah, and "enum perf_probe_config" is not exported...

Thanks, please forget then.

Oleg.

