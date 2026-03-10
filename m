Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA3A134EEF9
	for <linux-trace-kernel@vger.kernel.org>; Tue, 10 Mar 2026 16:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773159877; cv=none; b=ZP+pYkm+dO5lkxTnb9adOXcNAulCTb7gKNf3DNKcaaepQgBZEEKdgBuV8rAjrjcfu7DBJFkmMIO9pnRL16sp1zA8MotXZBckcADdWZkghZaJqf+7IwD/I+XqplSOXrjeN403lmo5cn2UXWMk1WLDdUkA0WmerKy5g40KLWffyGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773159877; c=relaxed/simple;
	bh=e7TRnOtgCOkHw+bXVZQG4KYngKPErnXlRoLwTjzs/+8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=UxI3A2OK+FBU70lrq9dPtknIsFyaO4Be1INqxGJASQfY1aAQxpxFDA2dGfn5qTpMJQfs/jAN9w5cLo0lnodjJpym7buWJ48ZO2wRAp1j6MPJ+w+9rLIJAPsRQjK178iIHJqbNKMNBbVVP36XOD5KlRKEUk0bPtpZNx2Dw8hGmPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Mz2RIQum; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mz2RIQum"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773159874;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YxWAY1FZH4WXXKwBovAJr8yjxykMgu1y/Ao0+S6Xnac=;
	b=Mz2RIQumquPyrSduuIGYFPbYND+lHkmhKD7AFAW1D3wugBZhLkize6fW5mB+Kyzs3AmE4o
	hHGZd7CsQKFR/hUaqKltNwfqmc0vyGca1rNyGA/tjIKPx9FoUYZnYmetlayVa4rNSA0FBb
	DRN253gmHxVIGxwQjO/JyQzXSXRxYxE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-502-uCu7xRwKPkmyW-K735az8A-1; Tue,
 10 Mar 2026 12:24:33 -0400
X-MC-Unique: uCu7xRwKPkmyW-K735az8A-1
X-Mimecast-MFC-AGG-ID: uCu7xRwKPkmyW-K735az8A_1773159872
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 780AD18002DD;
	Tue, 10 Mar 2026 16:24:32 +0000 (UTC)
Received: from fedora (unknown [10.22.88.191])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 7B5421800759;
	Tue, 10 Mar 2026 16:24:28 +0000 (UTC)
Date: Tue, 10 Mar 2026 13:24:26 -0300
From: Wander Lairson Costa <wander@redhat.com>
To: Tomas Glozar <tglozar@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, John Kacur <jkacur@redhat.com>, 
	Luis Goncalves <lgoncalv@redhat.com>, Crystal Wood <crwood@redhat.com>, 
	Costa Shulyupin <costa.shul@redhat.com>, LKML <linux-kernel@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH] rtla: Fix segfault on multiple SIGINTs
Message-ID: <abBFn4252e8jKUPY@fedora>
References: <20260310160725.144443-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260310160725.144443-1-tglozar@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: cxtuOOEpmFS55W88RjsSRa_Wfo0qKTCGe7cVrfAD4jU_1773159872
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 10, 2026 at 05:07:25PM +0100, Tomas Glozar wrote:
> Detach stop_trace() from SIGINT/SIGALRM on tool clean-up to prevent it
> from crashing RTLA by accessing freed memory.
> 
> This prevents a crash when multiple SIGINTs are received.
> 
> Fixes: d6899e560366 ("rtla/timerlat_hist: Abort event processing on second signal")
> Fixes: 80967b354a76 ("rtla/timerlat_top: Abort event processing on second signal")
> Signed-off-by: Tomas Glozar <tglozar@redhat.com>
> ---

Reviewed-by: Wander Lairson Costa <wander@redhat.com>

[...]

