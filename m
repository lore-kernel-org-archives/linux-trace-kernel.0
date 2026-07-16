Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DEE830D3F6
	for <linux-trace-kernel@vger.kernel.org>; Thu, 16 Jul 2026 14:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784210894; cv=none; b=URIZLczhcQCeAGrK9x2ggYpcWgzgU+bdN+XPTg72kFoG1ImxXEJZTvLgwAiG1LR2fFl8CVGxzQj4YcIjheR6/iiuGdMjqOmge+Bbd2iYJOgqHFiVFkvIvWUYfKaTGS6T87nmek+AL58XT7bSv9qZRljaTX9Dg2oHNQjXO4jnZuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784210894; c=relaxed/simple;
	bh=ejMlw6WKT8jyVCCw3AsrvbeaZg52FRJYn9GWiq45kx4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=iUo1mam9Rn51nTiaZZy9Zqre+bmyi4FPaZTa4C2BdI3RkdXm1Z1xHZgn60PW+l9s8YDdKexAhAIZDOqOGBnpMJ3FrX2Dr39Too4bBisQSXwY2WRbf+wPL6+V8VFBs0tEb78Z351EMK1tXS19PN9cs9ZmGra2xRB5AH/zG4vbFVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EzsSmttG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EzsSmttG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784210890;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IBOHAh0+nB5PGISeg9vLXFVhKkGyP214uzg8iWo+FVk=;
	b=EzsSmttGdEY73wSVBJNaMDP+Rhqfdvwo6EE1TMC/ej+2jKmcXaPY4RYvkrjp6sdh9ZaHHS
	MiJOIUQMmlYC0UsXFGKQgC70RHwQ5Rm8eC4lCSdfDzhegfVyUhvQmHpsrH1ww7RzyTc3xE
	7zaWVrzLGYRgEDmovKWuZHq8Fo1wCuQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-302-6YkY1gA5NhiHNZceu2TvyQ-1; Thu,
 16 Jul 2026 10:08:07 -0400
X-MC-Unique: 6YkY1gA5NhiHNZceu2TvyQ-1
X-Mimecast-MFC-AGG-ID: 6YkY1gA5NhiHNZceu2TvyQ_1784210886
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8B6BC1955F27;
	Thu, 16 Jul 2026 14:08:06 +0000 (UTC)
Received: from wcosta-thinkpadt14gen4.rmtbr.csb (unknown [10.22.64.82])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id EA4AC3003EFC;
	Thu, 16 Jul 2026 14:08:02 +0000 (UTC)
Date: Thu, 16 Jul 2026 11:08:01 -0300
From: Wander Lairson Costa <wander@redhat.com>
To: Tomas Glozar <tglozar@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, John Kacur <jkacur@redhat.com>, 
	Luis Goncalves <lgoncalv@redhat.com>, Crystal Wood <crwood@redhat.com>, 
	Costa Shulyupin <costa.shul@redhat.com>, LKML <linux-kernel@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/4] Documentation/rtla: Document unsetting options
Message-ID: <aljlrfp7iEziuo4B@wcosta-thinkpadt14gen4.rmtbr.csb>
References: <20260629083654.1548925-1-tglozar@redhat.com>
 <20260629083654.1548925-4-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260629083654.1548925-4-tglozar@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: TyoCOULQgX59RhwZ-aI78h9HDn43LJjLQD6QAFXr3aQ_1784210886
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 29, 2026 at 10:36:54AM +0200, Tomas Glozar wrote:
> Add an appendix documenting how to unset options in RTLA. For options
> where unsetting is currently not supported, add a note into the
> respective section.
> 
> An additional note is added for --on-threshold trace. As it is
> considered distinct from --trace, it is not reverted by --no-trace.
> 

Reviewed-by: Wander Lairson Costa <wander@redhat.com>

