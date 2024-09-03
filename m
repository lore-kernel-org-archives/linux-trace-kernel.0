Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BEEA1917DA
	for <linux-trace-kernel@vger.kernel.org>; Tue,  3 Sep 2024 18:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725388071; cv=none; b=YT1bE93xDdyiXafFpdzgfeL27KucRTmARTjRoYwWNugyktAG2uYAFWkEcZe3l1bWEWRnP0/cdQ3tbrI9W0nafj0ZkKN+nbqEM5w7KNPAO9HY3DG2hEDGu+AC8Mc1z/AAfSVmVvaeIop772jFeE4g+H3FnanmWV28O6pyTk8YSfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725388071; c=relaxed/simple;
	bh=bYoFUSBYagYM9vX6vLnvOKFtHmjQk8YSVP8bS/GZm3E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NM38OnPiaSXUBoSog6918eG8lL5aPjRZxEqly3fvPG63hOi5Et7fDx7fVPJNuNpt0FsMh/VrjHjipK9VczZfgXIDsnLis0d3G7rwkWdbkxmRo+xR0BHtvfSGfrP8q6qeEVSlPRLSwVAO8q2fvWxLhjjkqQZ0ZGhncje7GC9CpB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FqZ+Joom; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FqZ+Joom"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725388069;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d24OUKgm5JQW5fQKGEQedXZHagzGyggF2Py5ZgqPqAo=;
	b=FqZ+JoomETfhkUEQUUcoX/QuGz7QZvVVaPScQQV3yC2BtgQItTdXVIcWUvm96LBK/Ih3id
	Zz6p5yacXaiVHiIKZ6bD0Gqa7p7teL834x5aG8y4Z0G0v4IarbTTfxtlEUeYB8WTt2TOdt
	bHG/UpkcA5PVQiTzTlribaiIrvPvBTE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-581-LGAj98RNPu67JNz6csa9dA-1; Tue,
 03 Sep 2024 14:27:43 -0400
X-MC-Unique: LGAj98RNPu67JNz6csa9dA-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 017141955BEF;
	Tue,  3 Sep 2024 18:27:41 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.38])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id BB47C30001A4;
	Tue,  3 Sep 2024 18:27:35 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue,  3 Sep 2024 20:27:31 +0200 (CEST)
Date: Tue, 3 Sep 2024 20:27:24 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, Andrii Nakryiko <andrii@kernel.org>,
	linux-trace-kernel@vger.kernel.org, peterz@infradead.org,
	rostedt@goodmis.org, mhiramat@kernel.org, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, paulmck@kernel.org,
	willy@infradead.org, surenb@google.com, akpm@linux-foundation.org,
	linux-mm@kvack.org
Subject: Re: [PATCH v4 4/8] uprobes: travers uprobe's consumer list
 locklessly under SRCU protection
Message-ID: <20240903182724.GI17936@redhat.com>
References: <ZtD_x9zxLjyhS37Z@krava>
 <CAEf4Bzb3mCWK5St51bRDnQ1b-aTj=2w6bi6MkZydW48s=R+CCA@mail.gmail.com>
 <ZtHM_C1NmDSKL0pi@krava>
 <20240830143151.GC20163@redhat.com>
 <CAEf4BzbOjB9Str9-ea6pa46sRDdHJF5mb0rj1dyJquvBT-9vnw@mail.gmail.com>
 <20240830202050.GA7440@redhat.com>
 <CAEf4BzZCrchQCOPv9ToUy8coS4q6LjoLUB_c6E6cvPPquR035Q@mail.gmail.com>
 <20240831161914.GA9683@redhat.com>
 <CAEf4BzYE7+YgM7HMb-JceoC33f=irjHkj=5x46WaXdCcgTk4xg@mail.gmail.com>
 <CAEf4Bza6SRP0ZTuOa=W8W3uM86DJKkGoTQ9itHxcdGWt1Su=-Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4Bza6SRP0ZTuOa=W8W3uM86DJKkGoTQ9itHxcdGWt1Su=-Q@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 09/03, Andrii Nakryiko wrote:
>
> On Tue, Sep 3, 2024 at 10:27 AM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Sat, Aug 31, 2024 at 9:19 AM Oleg Nesterov <oleg@redhat.com> wrote:
> > >
> > > But. Since you are going to send another version, may I ask you to add a
> > > note into the changelog to explain that this patch assumes (and enforces)
> > > the rule about handler/filter consistency?
> >
> > Yep, will do. I will also leave a comment next to the filter callback
> > definition in uprobe_consumer about this.
> >
>
> Ok, I'm adding this:
>
> diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
> index 29c935b0d504..33236d689d60 100644
> --- a/include/linux/uprobes.h
> +++ b/include/linux/uprobes.h
> @@ -29,6 +29,14 @@ struct page;
>  #define MAX_URETPROBE_DEPTH            64
> 
>  struct uprobe_consumer {
> +       /*
> +        * handler() can return UPROBE_HANDLER_REMOVE to signal the need to
> +        * unregister uprobe for current process. If UPROBE_HANDLER_REMOVE is
> +        * returned, filter() callback has to be implemented as well and it
> +        * should return false to "confirm" the decision to uninstall uprobe
> +        * for the current process. If filter() is omitted or returns true,
> +        * UPROBE_HANDLER_REMOVE is effectively ignored.
> +        */

Thanks, LGTM.

Oleg.

