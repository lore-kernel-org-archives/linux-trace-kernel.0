Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A6F12A1B8
	for <linux-trace-kernel@vger.kernel.org>; Sun,  1 Sep 2024 23:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725233237; cv=none; b=tJr/x51WYIJr+zgOxtEQf42FDVX6CbVe1n3MnVdQ32IFgaHbxUpwMxnM7Msm2sBe2d+n+5HfKtRszxr4clxQTHCxkfg9Biw1HdFM89S7U0oqcuRiiNswQjQ+IhsSVXVFGQR+nte682egA6dmWAsqRU1I+YOAi8MqOl9nKrZWytw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725233237; c=relaxed/simple;
	bh=UHO7qZg3vgGuY6p2K02J+y9Yh7BXj5vPsRbVackxNHA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZbIUUNi9wyLAPSJzFKuWIXOH7SRUwwRvFas9RTFEFEumDLpKdcPwZ9Lx568VC7N90jmAH/KllwWNbYeg/HOEh9du8YIAJ4WRxyRJx8gFXvVEs42lCISnLF7sK+v+ylR18yymGpvpDRi0/XADoznjKjIwVLT/92QWGPnjToI2IUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bUq0oxJT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bUq0oxJT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725233234;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yPAaiWWm2xRTp2nibl8MXxRQuZzIA88EjdR0rbeKAOA=;
	b=bUq0oxJTbI4duurAlaQ4nG2gzB6XJ9uAPzlcZ109syKrfanBzhBiP0MEnXE6EsNNuSLnTy
	YI3BTC/KYraHS0/lmq5dYoZ+RqJc8BB0YJtfpKdklDJnk2GThvs8rhLt0i9QmJRRv5wGmy
	8KNnjvh6DJAYCa+CiTckxB/v23h8Tto=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-618-o4vfVhcWPSyiCBd-CehN6g-1; Sun,
 01 Sep 2024 19:27:11 -0400
X-MC-Unique: o4vfVhcWPSyiCBd-CehN6g-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8F1AE1955D48;
	Sun,  1 Sep 2024 23:27:08 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.35])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id A79DC300019A;
	Sun,  1 Sep 2024 23:27:03 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Mon,  2 Sep 2024 01:26:58 +0200 (CEST)
Date: Mon, 2 Sep 2024 01:26:53 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Tianyi Liu <i.pear@outlook.com>
Cc: ajor@meta.com, albancrequy@linux.microsoft.com,
	andrii.nakryiko@gmail.com, bpf@vger.kernel.org,
	flaniel@linux.microsoft.com, jolsa@kernel.org,
	linux-trace-kernel@vger.kernel.org, linux@jordanrome.com,
	mathieu.desnoyers@efficios.com, mhiramat@kernel.org,
	rostedt@goodmis.org
Subject: Re: [PATCH v2] tracing/uprobe: Add missing PID filter for uretprobe
Message-ID: <20240901232652.GA12854@redhat.com>
References: <20240830101209.GA24733@redhat.com>
 <ME0P300MB0416522C59231B4127E23C6F9D912@ME0P300MB0416.AUSP300.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ME0P300MB0416522C59231B4127E23C6F9D912@ME0P300MB0416.AUSP300.PROD.OUTLOOK.COM>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 09/02, Tianyi Liu wrote:
>
> On Fri, Aug 30, 2024 at 18:12:41PM +0800, Oleg Nesterov wrote:
> >
> > 	- So I still think that the "right" fix should change the
> > 	  bpf_prog_run_array_uprobe() paths somehow, but I know nothing
> > 	  about bpf.
>
> I agree that this patch does not address the issue correctly.
> The PID filter should be implemented within bpf_prog_run_array_uprobe,

OK,

> or alternatively, bpf_prog_run_array_uprobe should be called after
> perf_tp_event_match to reuse the filtering mechanism provided by perf.

No, no, perf_tp_event_match() has nothing to do with pid/mm filtering in
this case, afaics.

See https://lore.kernel.org/all/20240829152032.GA23996@redhat.com/
and perf_trace_add() which adds the event to this_cpu_ptr(call->perf_events),
see also the hlist_empty(head) check in __uprobe_perf_func().

Again, again, I can be easily wrong, I forgot everything I knew (not too much)
about perf, but at least in the case above perf_tp_event_match() is not even
called.

> Also, uretprobe may need UPROBE_HANDLER_REMOVE, similar to uprobe.

May be... Not sure. But why do you think we want it?


And... I think that BPF has even more problems with filtering. Not sure,
I'll try to write another test-case tomorrow.

Oleg.

