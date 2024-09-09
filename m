Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC79188CC3
	for <linux-trace-kernel@vger.kernel.org>; Mon,  9 Sep 2024 18:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725906904; cv=none; b=JB5a8dqeuW2Z2qpeqPq/758lYFp7IHebdW8MFDIESRbST25KyVLunx5TDbc1N647tNLVU2iIFFX8YFBBvWAY2HmKcVRw2bfk8RMQ76qw/Xwmx6VIHwlF01Kt/b/ifX90dxAIL8cosEXmmpwv9ds7XyfsyGnWuR5kqNrs2KwbddU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725906904; c=relaxed/simple;
	bh=Gj4bfxjnChu7LPauy6tK52dNHXNEhiNDpxXWpDU9OYQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JFqYBE4Rkh2oj6+ewVawnjPGRCVlyruaryXDiKxcCqpoTcRJpV+02fVSmuH3ke9x4o4MZ9KNerBdjg4gGDEXxSuIfPlFJp8SYkQZDp9R62qt0NxUPvBqpmu+DFWtu4AmedzrAOJw15HMWEICHdvgZ3cpNVVoerkuNz9EiU8Vk0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FiC+jpRp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FiC+jpRp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725906901;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=u67DfEbyCrF6Qitp5l77mbP+q6a/yy862y2hfMz2Mjc=;
	b=FiC+jpRpdG/6511g4RZhynGCfnej5vx/QJST6ojpNB4Lg7uyejV0pgU3MxeMaZeDSGt8mr
	6Tu17RHIhc2iTtCba22wSR7UQtReEdiChROKWH0/ly0gT5uAfjK3ah+pX3CriuDxM3WWh5
	besHnaiSgm9huWWtLyKq641RvPufyaw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-561-beRijX9gM8mWd09wNxvYzA-1; Mon,
 09 Sep 2024 14:34:56 -0400
X-MC-Unique: beRijX9gM8mWd09wNxvYzA-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0F6571955EB5;
	Mon,  9 Sep 2024 18:34:54 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.74])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 1136E1956048;
	Mon,  9 Sep 2024 18:34:48 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Mon,  9 Sep 2024 20:34:42 +0200 (CEST)
Date: Mon, 9 Sep 2024 20:34:36 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Tianyi Liu <i.pear@outlook.com>, ajor@meta.com,
	albancrequy@linux.microsoft.com, andrii.nakryiko@gmail.com,
	bpf@vger.kernel.org, flaniel@linux.microsoft.com,
	linux-trace-kernel@vger.kernel.org, linux@jordanrome.com,
	mathieu.desnoyers@efficios.com, mhiramat@kernel.org,
	rostedt@goodmis.org, Viktor Malik <vmalik@redhat.com>
Subject: Re: [PATCH v2] tracing/uprobe: Add missing PID filter for uretprobe
Message-ID: <20240909183436.GC14058@redhat.com>
References: <20240830101209.GA24733@redhat.com>
 <ME0P300MB0416522C59231B4127E23C6F9D912@ME0P300MB0416.AUSP300.PROD.OUTLOOK.COM>
 <Ztrc6eJ14M26xmvr@krava>
 <20240906191814.GB17874@redhat.com>
 <Zt7Q6GVKtGTIdO1g@krava>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zt7Q6GVKtGTIdO1g@krava>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 09/09, Jiri Olsa wrote:
>
> On Fri, Sep 06, 2024 at 09:18:15PM +0200, Oleg Nesterov wrote:
> >
> > And btw... Can bpftrace attach to the uprobe tp?
> >
> > 	# perf probe -x ./test -a func
> > 	Added new event:
> > 	  probe_test:func      (on func in /root/TTT/test)
> >
> > 	You can now use it in all perf tools, such as:
> >
> > 		perf record -e probe_test:func -aR sleep 1
> >
> > 	# bpftrace -e 'tracepoint:probe_test:func { printf("%d\n", pid); }'
> > 	Attaching 1 probe...
> > 	ioctl(PERF_EVENT_IOC_SET_BPF): Invalid argument
> > 	ERROR: Error attaching probe: tracepoint:probe_test:func
>
> the problem here is that bpftrace assumes BPF_PROG_TYPE_TRACEPOINT type
> for bpf program, but that will fail in perf_event_set_bpf_prog where
> perf event will be identified as uprobe and demands bpf program type
> to be BPF_PROG_TYPE_KPROBE

Yes, thanks, I know,

> I don't think
> there's a way to find out the tracepoint subtype (kprobe/uprobe) from
> the tracefs record

Hmm, indeed. it seems that it is not possible to derive tp_event->flags
from tracefs...

Perhaps bpftrace could look for probe_test:func in [uk]probe_events?
Or simply retry ioctl(PERF_EVENT_IOC_SET_BPF) with BPF_PROG_TYPE_KPROBE
if BPF_PROG_TYPE_TRACEPOINT returns EINVAL? Ugly, yes.

Oleg.

