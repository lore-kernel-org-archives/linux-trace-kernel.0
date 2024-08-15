Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B1F17CA1D
	for <linux-trace-kernel@vger.kernel.org>; Thu, 15 Aug 2024 13:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723728306; cv=none; b=YXCvExraTVL7C4aexZpjMBLwQh5sfWju8y0rQ0OT6a6tk1rminZeqbRkpqJ2qMR+o6KAgY0rPNRgj5x2/hfIpXQHJ8xwpbjLemkwQErkbDyZZ2x9wjdSeVxhNzz8J18na9Tgki97C7AGCLl9wBy5toGVbiMzkQVMmKWw0DYYyTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723728306; c=relaxed/simple;
	bh=G5+XfiPM6LQ17WiipMjgZYP1kkhGBD84tmDH4lCo29w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ah4kb7GF1lTeneYo+1V0pPSjnsZdJ9u+dTBdCIapeFX2PVitwMLz4tEdYfLq7A8YkG0g5gC4yrp2laDPk2E8jls6SLhuryaIHcSmBoOIbKB9l5ZhcQTzqsT8rgs/OWCVSd+2No7GgIHxrm90HxLd9UMEI2mIbTkzncJ1C6C4oxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OpbBEo90; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OpbBEo90"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723728303;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=G5+XfiPM6LQ17WiipMjgZYP1kkhGBD84tmDH4lCo29w=;
	b=OpbBEo90Aq67tDaqYH+s0WikPyQBRd10tzJmTBEvzqP0cxG8H3svjULiOK7xEhR8lbKJrl
	kkpM9azGE2uwrixavk2AhwMjaQAp4C0LRtFc3YpFjAQOaXp4RfTuWIw5NUKumsaXkxfutY
	NDcFfBKWqveFOwIYJHfwDppGRbq+18I=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-6-AWDy-QXUPCaqAvQ73czgkQ-1; Thu,
 15 Aug 2024 09:24:59 -0400
X-MC-Unique: AWDy-QXUPCaqAvQ73czgkQ-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1AEE81955BF2;
	Thu, 15 Aug 2024 13:24:57 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.8])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 49ED23001FDD;
	Thu, 15 Aug 2024 13:24:51 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu, 15 Aug 2024 15:24:53 +0200 (CEST)
Date: Thu, 15 Aug 2024 15:24:47 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, peterz@infradead.org,
	rostedt@goodmis.org, mhiramat@kernel.org, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, jolsa@kernel.org, paulmck@kernel.org,
	willy@infradead.org, surenb@google.com, akpm@linux-foundation.org,
	linux-mm@kvack.org
Subject: Re: [PATCH v3 00/13] uprobes: RCU-protected hot path optimizations
Message-ID: <20240815132447.GA15970@redhat.com>
References: <20240813042917.506057-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240813042917.506057-1-andrii@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 08/12, Andrii Nakryiko wrote:
>
> ( In addition to previously posted first 8 patches, I'm sending 5 more as an
> RFC for people to get the general gist of where this work heading and what
> uprobe performance is now achievable. I think first 8 patches are ready to be
> applied and I'd appreciate early feedback on the remaining 5 ones.

I didn't read the "RFC" patches yet, will try to do on weekend.

As for 1-8, I failed to find any problem:
Reviewed-by: Oleg Nesterov <oleg@redhat.com>

