Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E0B219E7E2
	for <linux-trace-kernel@vger.kernel.org>; Thu, 19 Sep 2024 14:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726755531; cv=none; b=KH7YXQQiYLFXlXgYiu3JKXwv6lc4pDoVVId2rbIfXiK7c/7qo4W6vJafhpjCg93PFHgbIHNQwepnBOmIpZbAe/+rtsJ3/HUks2owAZkpGSwdtsueu30K9RfHYX46uHGadTNHi8nJhhXexiAU5HKmbKiIhkpqLLMNMVby/voY95c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726755531; c=relaxed/simple;
	bh=gc4T4yfrpxqIxAFlg534waohYyFHbILhZjyNuL99wmc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lEorVU34UYd45+3H7j4HBQRsLpUrYauk6i/t5X4zUmI+7XCMWtBzbss02uFcfVeeoDWX9lYMpPK4rklmO/73otnnxvUxJf0V4hFNcIgkuoNPWs5zbkJNcwPWR9K29Gn7Bp+9kbdegC1iFA3TbEsquc2ri1BuSiy/l1cHqXhlZk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YabXtPt3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YabXtPt3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726755528;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HcxPWGn3Cql3pXPARI9tj+GnG7kgTzBF8K1LuScbaqY=;
	b=YabXtPt3LfWhG5rnzzMIKOhTYtAimLWXAx//jDbdodFhOTUAveCcQWMPggCDVhEd/J5kPt
	ajoklmfOhPLnvZSOy38iI7hYDsKL7mMY3EeOyjAbwleMG46xJwl4yEuT0ovH47Li07H8QW
	sgkG3zmcO0UAsca+o6m/qvJesYA0jJI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-463-YqlIB93CNJ-juoFLmIsd5g-1; Thu,
 19 Sep 2024 10:18:44 -0400
X-MC-Unique: YqlIB93CNJ-juoFLmIsd5g-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (unknown [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D10241944D3F;
	Thu, 19 Sep 2024 14:18:42 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.110])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 28D321956086;
	Thu, 19 Sep 2024 14:18:38 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu, 19 Sep 2024 16:18:30 +0200 (CEST)
Date: Thu, 19 Sep 2024 16:18:25 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Liao Chang <liaochang1@huawei.com>
Cc: mhiramat@kernel.org, peterz@infradead.org, catalin.marinas@arm.com,
	will@kernel.org, mark.rutland@arm.com, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] arm64: uprobes: Optimize cache flushes for xol slot
Message-ID: <20240919141824.GB12149@redhat.com>
References: <20240919121719.2148361-1-liaochang1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240919121719.2148361-1-liaochang1@huawei.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On 09/19, Liao Chang wrote:
>
> --- a/arch/arm64/kernel/probes/uprobes.c
> +++ b/arch/arm64/kernel/probes/uprobes.c
> @@ -17,12 +17,16 @@ void arch_uprobe_copy_ixol(struct page *page, unsigned long vaddr,
>  	void *xol_page_kaddr = kmap_atomic(page);
>  	void *dst = xol_page_kaddr + (vaddr & ~PAGE_MASK);
>
> +	if (!memcmp(dst, src, len))
> +		goto done;

can't really comment, I know nothing about arm64...

but don't we need to change __create_xol_area()

	-	area->page = alloc_page(GFP_HIGHUSER);
	+	area->page = alloc_page(GFP_HIGHUSER | __GFP_ZERO);

to avoid the false positives?

Oleg.

