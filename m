Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C1E198E80
	for <linux-trace-kernel@vger.kernel.org>; Wed, 10 Jul 2024 16:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720629130; cv=none; b=T/+P1XLtAgEFPByGatK/jaDa86auDyU1JOsGgTSoPn0l/dfkmCoGSdwDiCQ2Rft/Qhl97W2WXu0t/+RAlYiRsWcwjHWUcppdc54FTM9HBojas4eAxhVAP8R2s/A6drXunePlYrPKzOwWMntPdhUXSy1QzVIv1em7/85FAp9ifzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720629130; c=relaxed/simple;
	bh=fYMc6KLTY6LKXBmxGdlexV5LNTc9Pq7aLfamCDMNYqg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iib2HPt+ZDfVo3FVleGos+vlVLF1OJbzbo1UTgYDku0I7Hb+yB67AZNuhgBHspZ0UV8llosdO4T9Cq+BEEJbRh9+K9Xc2sY6cE6t9dPHwy/Z1MX3zuN23sAxYDh7LaWaVW+FnlKY9n5Mwy5ornz5yu/McNq1J/a5D+xbtpHZbMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Kd/P3K32; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kd/P3K32"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720629127;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fYMc6KLTY6LKXBmxGdlexV5LNTc9Pq7aLfamCDMNYqg=;
	b=Kd/P3K32cYsDm5qa9J2Xg5JLVxzx8LT9PXlGmxb6deZZP8jQoEllv/nTQnl5ccksJEseiV
	q2V4Bm6+PImXMUbnxA/Ne0gcdsK+YGbUI2ENZ88oEfPTr6EcFR9ZOkrxnm9v7qEuHaDgK1
	qXQYCERxExCT/JcUifHNBkUxD329msM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-595-NNjsDcgkP_65D1O_JDi5QQ-1; Wed,
 10 Jul 2024 12:32:05 -0400
X-MC-Unique: NNjsDcgkP_65D1O_JDi5QQ-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 15C1D19560B1;
	Wed, 10 Jul 2024 16:32:04 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.169])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 4A7C33000184;
	Wed, 10 Jul 2024 16:32:00 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed, 10 Jul 2024 18:30:27 +0200 (CEST)
Date: Wed, 10 Jul 2024 18:30:22 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: andrii@kernel.org, mhiramat@kernel.org, peterz@infradead.org
Cc: clm@meta.com, jolsa@kernel.org, mingo@kernel.org, paulmck@kernel.org,
	rostedt@goodmis.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH 0/3] uprobes: future cleanups for review
Message-ID: <20240710163022.GA13298@redhat.com>
References: <20240710140017.GA1074@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240710140017.GA1074@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 07/10, Oleg Nesterov wrote:
>
> Peter, these simple cleanups should not conflict with your changes,
> but I can resend them later if it causes any inconvenience.

In fact I would like to push 2 more cleanups before the more significant
changes, but they certainly conflict with your ongoing work, albeit only
textually.

Let me send the patches for review anyway, perhaps you can take at least
the 1st one.

3/3 is only compile tested so far. Andrii, can you take a look?

Oleg.

