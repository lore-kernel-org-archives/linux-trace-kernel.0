Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928B07262D
	for <linux-trace-kernel@vger.kernel.org>; Thu, 13 Nov 2025 12:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763037876; cv=none; b=scCezH+S8VSRnJGfeXFhiZUFdZ1S+AG64MlrU2WDdrf1Ge8TYtK3a2/EH/wsgZntV3iZo3iPfJZhIEW/0nEXXCK3Qw3nZHra7rlXNNVfB9atswo1RcAQ6kr5sdnBno25+mHFZxMN4ykpUxm3Hqj0s9NloFOhwpiQRkU4wfajP5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763037876; c=relaxed/simple;
	bh=dnhYb190v8aOLjAoddug3EWP0Pv7uFkraOgvgLYO0yM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=us5YlHNVOH+uk93lnfhX1iNS6t92H86A/C2i9oNuXzNXIq3kBsljx8VIn08zbRRGbQNAqtl21HJaNsChYbSWm/Tih9EyKqgYQ7NSjv1Ma1PnSCyRUOvPZrn0iL0wODvVFgLdAvSqyhmid08GN6zUDd9STE0qwOlFEcJm2svdGJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JnV4Onfi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JnV4Onfi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763037873;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kS5Nm7H1pNOZzdn0uGUVqC+gzBZ9oH1EpURjYTJP/4s=;
	b=JnV4Onfi8hCpdf0rdZhvM38bOpCFlPDkT+Gmr9OrqxTR3atUhITzG8XAWZTGUMqNs8A51P
	BPv9QmYWKojt4bhVGzCUQg9SpGzVtnVIMrorc254qpxI+BsdSSt8uWpdtS7/y3KcnXqVxD
	p9z75relWsKSAmVLjBHR9esvXzGbYCo=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-237-SUS8M_ILNlO4h0a9VFBNng-1; Thu,
 13 Nov 2025 07:44:32 -0500
X-MC-Unique: SUS8M_ILNlO4h0a9VFBNng-1
X-Mimecast-MFC-AGG-ID: SUS8M_ILNlO4h0a9VFBNng_1763037871
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6161A18002C2;
	Thu, 13 Nov 2025 12:44:31 +0000 (UTC)
Received: from wcosta-thinkpadt14gen4.rmtbr.csb (unknown [10.22.80.152])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 41C50300018D;
	Thu, 13 Nov 2025 12:44:27 +0000 (UTC)
Date: Thu, 13 Nov 2025 09:44:26 -0300
From: Wander Lairson Costa <wander@redhat.com>
To: Crystal Wood <crwood@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, 
	linux-trace-kernel@vger.kernel.org, John Kacur <jkacur@redhat.com>, 
	Tomas Glozar <tglozar@redhat.com>, Costa Shulyupin <costa.shul@redhat.com>
Subject: Re: [PATCH 0/5] rtla, osnoise: Fixes to address intermittent test
 issues
Message-ID: <huyshuvt7ztuvmjwgetxah6agfasrneqjrtusy4r4lsrpjhe6d@2y45svtyifvn>
References: <20251112152529.956778-1-crwood@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20251112152529.956778-1-crwood@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Wevk4WOuaBdFoEbvMqKmj7nQg4KbnRL6iVLiB5qW1D4_1763037871
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 12, 2025 at 09:25:24AM -0600, Crystal Wood wrote:
> With these fixes, I'm able to run the tests in a loop overnight with no
> failures.
> 
> Crystal Wood (5):
>   rtla/tests: Don't rely on matching ^1ALL
>   tracing/osnoise: Dump stack on timerlat uret threshold event
>   tracing/osnoise: Array printk init and cleanup
>   rtla/timerlat: Exit top main loop on any non-zero wait_retval
>   rtla: Set stop threshold after all instances are enabled
> 
>  kernel/trace/trace_osnoise.c          | 46 +++++++++++++++++----------
>  tools/tracing/rtla/src/common.c       | 20 ++++++++++++
>  tools/tracing/rtla/src/common.h       |  4 +++
>  tools/tracing/rtla/src/osnoise.c      | 17 +++-------
>  tools/tracing/rtla/src/osnoise.h      |  5 ---
>  tools/tracing/rtla/src/timerlat.c     | 29 ++++++-----------
>  tools/tracing/rtla/src/timerlat_top.c |  2 +-
>  tools/tracing/rtla/tests/timerlat.t   |  2 +-
>  8 files changed, 69 insertions(+), 56 deletions(-)
> 
> -- 
> 2.48.1
> 

On patch 3 the commit message says that osnoise_print() is implemented
as a macro, but it is actually implemented as a function. But that isn't
a blocker.

Reviewed-by: Wander Lairson Costa <wander@redhat.com>

