Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 638AD1D6DDF
	for <linux-trace-kernel@vger.kernel.org>; Fri, 13 Sep 2024 10:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726222098; cv=none; b=VrsWyz58xNHQIclocev8U0ONB+atnq2FUqy6RL7uXt0sk0mV0APwo43lxr1NP60saB+OnQ3OS4S061R/E6nFalAxQoi2lFcPxsTSG+jATkpDsZ5HPf7YpFknPKlMh1MHbyZiF7juXqrnN4WcgFs+RlfvzApJwnNnnYX+T8Y6jeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726222098; c=relaxed/simple;
	bh=NJ5vLMS3p7bc1+ugEtX1p5ebV1ErxgxGh0V/uCJ1X+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PNdnsPP1kvUbk98yWzaQV3lJ3SZ8f7suKqHfVVne+5lpOs3yiCG/ykt/rVmb6Vg4hMujIHM5iEUefbnUuqxxoBpaMxTK3P6HeTrI7Sn3DUgkbQHvk+/7I8aydnephWdxiu0ir+bDfMDITyvWWqq7jVR5Q/tq+JaycYnAbh3MhNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G/d4Wfa8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G/d4Wfa8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726222096;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hNIkurA652okgpZwfSLzJJZ0gdHyD3mAUwRUjJPJUt4=;
	b=G/d4Wfa8I6Kq8V/V9I3ZQnqPAKd7p7YynP1wTAmWYcUs9Svx86ew32KFF/N13nzHhL5wJS
	0q6QEGTOELwjIO8zXaF7vvbDC2EuQcSRLO5+QC+XBatAvapxoI0DP47jySFwm7LiKgV+Ig
	wOIuos53K+MtwfCCHJxIBfkb3DwXhH8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-695-jPnU5WGbOTyGqUvSuRaPwg-1; Fri,
 13 Sep 2024 06:08:11 -0400
X-MC-Unique: jPnU5WGbOTyGqUvSuRaPwg-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 09E061955EA8;
	Fri, 13 Sep 2024 10:08:09 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.25])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id A2E341956086;
	Fri, 13 Sep 2024 10:08:02 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri, 13 Sep 2024 12:07:57 +0200 (CEST)
Date: Fri, 13 Sep 2024 12:07:49 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCHv3 1/7] uprobe: Add support for session consumer
Message-ID: <20240913100749.GB19305@redhat.com>
References: <20240909074554.2339984-1-jolsa@kernel.org>
 <20240909074554.2339984-2-jolsa@kernel.org>
 <20240912162028.GD27648@redhat.com>
 <ZuP2YFruQDXTRi25@krava>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZuP2YFruQDXTRi25@krava>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On 09/13, Jiri Olsa wrote:
>
> On Thu, Sep 12, 2024 at 06:20:29PM +0200, Oleg Nesterov wrote:
> > > +
> > > +		if (rc == 0 && uc->ret_handler) {
> >
> > should we enter this block if uc->handler == NULL?
>
> yes, consumer can have just ret_handler defined

Sorry, I meant we do not need to push { cookie, id } into return_instance
if uc->handler == NULL.

And in fact I'd prefer (but won't insist) the new

	UPROBE_HANDLER_I_WANT_MY_COOKIE_PLEASE

return code to make this logic more explicit.

Oleg.

