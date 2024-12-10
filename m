Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B6102343A6
	for <linux-trace-kernel@vger.kernel.org>; Tue, 10 Dec 2024 16:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733849656; cv=none; b=L4rmc62nPCZkNOm/xuki1Osvfe/LkqoKXx1C9+AXDu/88zHrenygaDSIrMAYhkwQ7eMw2N/ptOqtiGoyAj9bEaIA96bdSej0UnCOum1cccGBJd/F9BxV7aaOIP7A5QPS4OX5NsalCsrPuh9PRriDc/XFOmG6WAfLrL15UfluQbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733849656; c=relaxed/simple;
	bh=3sn7QlcYPVrIalne+GpOHpJwfF0reHhkLV2yJqlqG7s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GN6PzlSLQPbZgI+AMimL8CMF3xv039nheF1LIEa1Oy5JTcpyFKreYvWhx9KDwx0aUcHAgiwuTyRiKmHMdcR9Ukhd3XX4qP1jsLbCYYKP5d5DEWhVIKXvo7/mLQOcjbtdE7no1w6KspW3wUkw3kksOVsE2kSx/3m1ddBhoa/WxCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F4fDl9bZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F4fDl9bZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733849654;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uYgy4fScGjSMekKKz7zapMxNc5WYY7jYizVCi92CPVg=;
	b=F4fDl9bZ9GGvdvZgE8GwrWTX+zpkAEnYI58qZfnM9lpN/E2j8vwzID8XFTS67mQe3uMgXw
	zpl9uR/nqnQTHEp4oFgun+K+NqdqxIFThJcqF5s1ReJTJYzq2B0TK6K3QIKpWaQWD8Ypb+
	USgE5bApLAaohNVhfA5OqYIRERc17ag=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-5-Pcjwg3CCMr-5zOAySgSt3g-1; Tue,
 10 Dec 2024 11:54:10 -0500
X-MC-Unique: Pcjwg3CCMr-5zOAySgSt3g-1
X-Mimecast-MFC-AGG-ID: Pcjwg3CCMr-5zOAySgSt3g
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A3AE11955BF9;
	Tue, 10 Dec 2024 16:54:06 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.4])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id F15341956089;
	Tue, 10 Dec 2024 16:53:58 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue, 10 Dec 2024 17:53:43 +0100 (CET)
Date: Tue, 10 Dec 2024 17:53:34 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
	linux-mm@kvack.org, Peng Zhang <zhangpeng.00@bytedance.com>
Subject: Re: [PATCH] fork: avoid inappropriate uprobe access to invalid mm
Message-ID: <20241210165334.GB31266@redhat.com>
References: <20241210163104.55181-1-lorenzo.stoakes@oracle.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241210163104.55181-1-lorenzo.stoakes@oracle.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

I must have missed something, but...

On 12/10, Lorenzo Stoakes wrote:
>
> @@ -1746,9 +1741,11 @@ static struct mm_struct *dup_mm(struct task_struct *tsk,
>  	if (!mm_init(mm, tsk, mm->user_ns))
>  		goto fail_nomem;
> 
> +	uprobe_start_dup_mmap();
>  	err = dup_mmap(mm, oldmm);
>  	if (err)
> -		goto free_pt;
> +		goto free_pt_end_uprobe;
> +	uprobe_end_dup_mmap();
> 
>  	mm->hiwater_rss = get_mm_rss(mm);
>  	mm->hiwater_vm = mm->total_vm;
> @@ -1758,6 +1755,8 @@ static struct mm_struct *dup_mm(struct task_struct *tsk,
> 
>  	return mm;
> 
> +free_pt_end_uprobe:
> +	uprobe_end_dup_mmap();

if dup_mmap() fails and "mm" is incomplete, then with this version dup_mmap_sem
is dropped before __mmput/exit_mmap/etc. How can this help?

Oleg.

