Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23AC1224F6
	for <linux-trace-kernel@vger.kernel.org>; Wed, 11 Sep 2024 09:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726048701; cv=none; b=bHRRZpJjRJY66RS7WtFqKCXuxy2qWRhM77aoGvpmJqaLQt4AL5aFj325j+JDtLoa7IOQUng2gVL5dwHKf3r/d3T+lMl9Mf0EKdTzSUPElafpXtlVhqVXFh24cRyzvdF33zGDL4Ybj0YLkxvU2uh+na6Tue5z3HE1h5oOWLQAdwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726048701; c=relaxed/simple;
	bh=hlOnZAwHEKTuQDJKg7tOOEVEaheKWwqvs4rBCT6SXgg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tgbSJn5/XLElr9hiRkoNLVIpPy1AbAC5QcuIRysHQ4MFEoXy5QaLQIRcFLxJUcb0XX3o3F15WgGYNUaCR/rM0RyLZQuUpdIk8Fqon/O0bm/cTRqlMsI50rkOz5X2LJDLcz7LY3PMc1Kdho2LcYNfLAnWTZ/M+koMmwjrFW2ohB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EVZz6ooH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EVZz6ooH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726048698;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=S8mw1EsAhYCXZxYuAgu+29kuStFev+Xk0N3JpjoTBR8=;
	b=EVZz6ooHrzTEwJKbuzVJDcdCCAeDAL5gzmgSmy/kad7WXWldvKIyIcCIKlPf6bTwsB2QFS
	RquPs4oecUgAnHMj+EddTHNV0h2v8sGQ2GGUm6KtRMEOzHRqX+2T3FbUHHzYrd06GmLhye
	SdUiYU0X4MLYHNv3+6HO9JdYz5+zRtk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-78-jWNaIMw3MwuwWyvCL30Ftw-1; Wed,
 11 Sep 2024 05:58:13 -0400
X-MC-Unique: jWNaIMw3MwuwWyvCL30Ftw-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B002E19560B2;
	Wed, 11 Sep 2024 09:58:10 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.229])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id AD7DC19560AD;
	Wed, 11 Sep 2024 09:58:03 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed, 11 Sep 2024 11:57:59 +0200 (CEST)
Date: Wed, 11 Sep 2024 11:57:51 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Sven Schnelle <svens@linux.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] uprobes: use vm_special_mapping close() functionality
Message-ID: <20240911095751.GA20308@redhat.com>
References: <CAHk-=wjD0XLhkzou89J-TK=L6B88pFoNYxN1uTWRQB3U5Czywg@mail.gmail.com>
 <20240903073629.2442754-1-svens@linux.ibm.com>
 <20240911094401.GA19080@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240911094401.GA19080@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

I guess VM_SEALED could help, but it depends on CONFIG_64BIT


On 09/11, Oleg Nesterov wrote:
>
> On 09/03, Sven Schnelle wrote:
> >
> > +static void uprobe_clear_state(const struct vm_special_mapping *sm, struct vm_area_struct *vma)
> > +{
> > +	struct xol_area *area = container_of(vma->vm_private_data, struct xol_area, xol_mapping);
> > +
> > +	mutex_lock(&delayed_uprobe_lock);
> > +	delayed_uprobe_remove(NULL, vma->vm_mm);
> > +	mutex_unlock(&delayed_uprobe_lock);
> > +
> > +	if (!area)
> > +		return;
> > +
> > +	put_page(area->pages[0]);
> > +	kfree(area->bitmap);
> > +	kfree(area);
> > +}
> > +
> >  static struct xol_area *__create_xol_area(unsigned long vaddr)
> >  {
> >  	struct mm_struct *mm = current->mm;
> > @@ -1481,6 +1500,7 @@ static struct xol_area *__create_xol_area(unsigned long vaddr)
> >
> >  	area->xol_mapping.name = "[uprobes]";
> >  	area->xol_mapping.fault = NULL;
> > +	area->xol_mapping.close = uprobe_clear_state;
> 
> Ah, no, we can't do this :/
> 
> A malicious application can munmap() its "[uprobes]" vma and free
> area/pages/bitmap. If this application hits the uprobe breakpoint after
> that it will use the freed memory.
> 
> And no, "mm->uprobes_state.xol_area = NULL" in uprobe_clear_state() won't
> help. Say, another thread can sleep on area.wq when munmap() is called.
> 
> Sorry, I should have realized that immediately, but I didn't :/
> 
> Andrew, this is uprobes-use-vm_special_mapping-close-functionality.patch
> in mm-stable
> 
> Oleg.

