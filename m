Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4662417A2F2
	for <linux-trace-kernel@vger.kernel.org>; Sun, 27 Apr 2025 14:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745763905; cv=none; b=TEdBxP87HlTc573ulEvBGbDQi5iT/UqoHViehyhwyumg1mlLrM97OZlrkRfPmEK7FUUqThcZY2Q1E6v5MKVsv+VNifsQgYva8O90o1PvuUN48uLL5RxTUSHzn2RgO1Mu7myHD2QeJhYPU1S2amKT+wasHml2yTD2/FV92pflqAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745763905; c=relaxed/simple;
	bh=Ps7sTe8S6LYJCX4j2bIheJAnRl1QnQmJk/rY3rgwsbc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tvlnIjFAt+Ban1ZRPb+kBrCPARoEd/iaOK8G48zm+5tyzlOcfQyvSSL6S68KTiqb7zYhMhXj2WPkvowowQ1bPaHnSOlPyvJ1otZbHeIu6VtrV+OjOercw5SkleNJ/mAfAWgNU7glPLDSsr0SxYYKDQ7GmhiSckaF1bXe/i3OyCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hi4LAePA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hi4LAePA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745763900;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tmwk3zN05evJEspzQM+NK/fIVHBMNvMlBhD9GL7xf0s=;
	b=hi4LAePA/n7foTwEmVCtkCdW2HDWMQhS0xQ4h11cAyg+vLbkbPNoiBRMXQMcp2vK5Sa8gR
	ylKqVpC47jHeVliiuNWAFKxcebhLADOKJYKPY8WbWA+egSQGWAnfr5NkvPKPIr6v+S3rH4
	DK5nABCf02ZLwJaRIXNdu/Nb6SwyvFE=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-167-b92HLJ8VP0-OFpGc71vt3A-1; Sun,
 27 Apr 2025 10:24:53 -0400
X-MC-Unique: b92HLJ8VP0-OFpGc71vt3A-1
X-Mimecast-MFC-AGG-ID: b92HLJ8VP0-OFpGc71vt3A_1745763888
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9EF7F195608C;
	Sun, 27 Apr 2025 14:24:47 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.18])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id EEC51195608D;
	Sun, 27 Apr 2025 14:24:40 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sun, 27 Apr 2025 16:24:09 +0200 (CEST)
Date: Sun, 27 Apr 2025 16:24:01 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Jiri Olsa <jolsa@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	x86@kernel.org, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Hao Luo <haoluo@google.com>, Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Alan Maguire <alan.maguire@oracle.com>,
	David Laight <David.Laight@ACULAB.COM>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas@t-8ch.de>,
	Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH perf/core 07/22] uprobes: Remove breakpoint in
 unapply_uprobe under mmap_write_lock
Message-ID: <20250427142400.GB9350@redhat.com>
References: <20250421214423.393661-1-jolsa@kernel.org>
 <20250421214423.393661-8-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250421214423.393661-8-jolsa@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 04/21, Jiri Olsa wrote:
>
> @@ -1483,7 +1483,7 @@ static int unapply_uprobe(struct uprobe *uprobe, struct mm_struct *mm)
>  	struct vm_area_struct *vma;
>  	int err = 0;
>
> -	mmap_read_lock(mm);
> +	mmap_write_lock(mm);

So uprobe_write_opcode() is always called under down_write(), right?
Then this

	* Called with mm->mmap_lock held for read or write.

comment should be probably updated.

And perhaps the comment above mmap_write_lock() in register_for_each_vma()
should be updated too... or even removed.

Oleg.

