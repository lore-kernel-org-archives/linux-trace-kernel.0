Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B3DE74BED
	for <linux-trace-kernel@vger.kernel.org>; Tue, 11 Mar 2025 13:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741698554; cv=none; b=AW0h9RkOSE5RKGG7sFGyudTBy+T0BPXyUB7IQNa/+3LbWcd2VLdnQhGXVZ7Gz44E82oBMhGi7qj6QaQw9G5uZTBNQzc7pIs81nZGttqpRyBtQdJs7iMWD85e9rEiu0Lq5WdNPHrCcMPM5yReywORzx04P3YVjvHSBsEHL1L5CZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741698554; c=relaxed/simple;
	bh=3oKxiRuwa/MVmwmoGHZ7LXpHpTMbcebcJS0NOhXOp2Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iS117/SZOTCcEH/p0A29Ns5DKJrA3FRRhbVcTkAcez0AanyrGJMyVJigogOF3hw+tXLaWi06btfyRpVeHUfffQhc7m+ctsSZ6It8vwQOrNa2H5LHu00cl/HWz4EJXqU6l5xtXiD9IFphgXdNV4HMO7/EhDYYj04M4oDOCg4op7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dDmaS2Sg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dDmaS2Sg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741698552;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2rp8S2qoYWcpM+y/XUGLKvTaosjAUEXQWiY3R6tC6Xk=;
	b=dDmaS2SgrQtQFjvYE+AoCGksImMW9FvHnRq7yFNcg1CC5wFVisKuHTBqnPEfbxJDL7CFUR
	nPq1RVy4MAo5EG7DMImFEqBTI78heZHliiKTUJ8usSur88P8Hss4FfND4SYcnfSyX06c4y
	/7OS0yxrLIC3lfDtUKKVZbCgHMZGxHU=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-605-aIEqmh42NYGkzXEx4iZ2FQ-1; Tue,
 11 Mar 2025 09:09:07 -0400
X-MC-Unique: aIEqmh42NYGkzXEx4iZ2FQ-1
X-Mimecast-MFC-AGG-ID: aIEqmh42NYGkzXEx4iZ2FQ_1741698546
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B9C3A1955D5D;
	Tue, 11 Mar 2025 13:09:05 +0000 (UTC)
Received: from localhost (unknown [10.22.81.23])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0C7901800268;
	Tue, 11 Mar 2025 13:09:04 +0000 (UTC)
Date: Tue, 11 Mar 2025 10:09:03 -0300
From: "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
To: Tomas Glozar <tglozar@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Jonathan Corbet <corbet@lwn.net>,
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH 0/4] Documentation/rtla: Cover BPF sample collection
Message-ID: <Z9A178_gk0LGynjd@uudg.org>
References: <20250311114936.148012-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250311114936.148012-1-tglozar@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Tue, Mar 11, 2025 at 12:49:32PM +0100, Tomas Glozar wrote:
> This is a follow-up to the BPF sample collection patchset [1],
> documenting both the feature's build requirements in the readme and
> the feature itself in the manpages.
> 
> A few fixes affecting the same manpages are also included in
> the patchset.
> 
> [1] https://lore.kernel.org/linux-trace-kernel/20250218145859.27762-1-tglozar@redhat.com/T/#u

LGTM.

Reviewed-by: Luis Claudio R. Goncalves <lgoncalv@redhat.com>

 
> Tomas Glozar (4):
>   Documentation/rtla: Fix duplicate text about timerlat tracer
>   Documentation/rtla: Fix typo in rtla-timerlat.rst
>   Documentation/rtla: Fix typo in common_timerlat_description.rst
>   Documentation/rtla: Include BPF sample collection
> 
>  .../tools/rtla/common_timerlat_description.rst         | 10 +++++++++-
>  Documentation/tools/rtla/rtla-timerlat.rst             |  9 +++------
>  tools/tracing/rtla/README.txt                          |  7 +++++++
>  3 files changed, 19 insertions(+), 7 deletions(-)
> 
> -- 
> 2.48.1
> 
---end quoted text---

