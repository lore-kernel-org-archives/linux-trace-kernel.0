Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E676B16CD1D
	for <linux-trace-kernel@vger.kernel.org>; Fri, 30 Aug 2024 10:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725013464; cv=none; b=CNAOdyVmKpM6hENaaynoSF7n3VnBW2AAxGi6lfNeBcIYWk0zYUI0f62W3gaqcKDCLIUZuEifTMoqj9MOlGn3AJjXEfPL2pOdKf8vVzK8JT1SGtOIf1FPtYE4/N2dRG+SNXu3yOHvbQRbolbZvp4zgwsdQsTQ4L/1Bax7J6sigMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725013464; c=relaxed/simple;
	bh=RQsHHI7kpVwOdK1joEOHTJ/7pkW/4sUkVR399XuvvWw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HZhd/JmigjuzGrXNidx4KtQ+gxhZ1m09yESE4WlTGusFGPODRUsBimvfWTBQSJex5esXelDVjP24S5Lfd+QzDT+FdtHMn5GOFg/niIRCjnwZQk5YTSzX6TNtDlX558703FG6synvieP2XLM9svGQRCu4rtwXA47KpgAhFVG3J38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FAGptrby; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FAGptrby"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725013461;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XYesMj5ueiMNqutffq7npoYQS7CjMMgXBJZZO+/Hjyo=;
	b=FAGptrbynQMs5LmkuuNdcgUPcJLcdMzjOISeTMEHibwSY2D6O+JLOe0nhtlNRMkfKKOA5O
	lMt3ON82rGvSMvT57D+nLOuwAcQnLMorfH3ci54iRP5LPOJHO49KRD9D2NeI0rZoJQYOz+
	Xxp3iSpochM309uRoaQX2tk7Tl4iNts=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-292-nL0bmLKMNpqdezNL84YlXg-1; Fri,
 30 Aug 2024 06:24:18 -0400
X-MC-Unique: nL0bmLKMNpqdezNL84YlXg-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 967581955D48;
	Fri, 30 Aug 2024 10:24:15 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.148])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 8F0F61955F45;
	Fri, 30 Aug 2024 10:24:10 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri, 30 Aug 2024 12:24:07 +0200 (CEST)
Date: Fri, 30 Aug 2024 12:24:01 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, peterz@infradead.org,
	rostedt@goodmis.org, mhiramat@kernel.org, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, jolsa@kernel.org, paulmck@kernel.org,
	willy@infradead.org, surenb@google.com, akpm@linux-foundation.org,
	linux-mm@kvack.org
Subject: Re: [PATCH v4 0/8] uprobes: RCU-protected hot path optimizations
Message-ID: <20240830102400.GA20163@redhat.com>
References: <20240829183741.3331213-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240829183741.3331213-1-andrii@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 08/29, Andrii Nakryiko wrote:
>
> v3->v4:
>   - added back consumer_rwsem into consumer_del(), which was accidentally
>     omitted earlier (Jiri);

still,

Reviewed-by: Oleg Nesterov <oleg@redhat.com>

