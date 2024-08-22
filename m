Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E9281C93AC
	for <linux-trace-kernel@vger.kernel.org>; Thu, 22 Aug 2024 11:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724325662; cv=none; b=m7KrqKxAXH9C5J+7Vvkp1lRKmemViOdKvvdchFuP5FxuQ1DDT49blx3VXm4CW8Ro5WqqCi5Hj/2Iax1Oot7HpEA6UL6apwOy7HAkV/nRRWkWJPbGwH6wuPv4oHpwDec0DhX2OA7rLp+bDLDKRdVXsUdomiHVe7bdeQ4tvzawkhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724325662; c=relaxed/simple;
	bh=A5P24p2SL0yOnJjyVxIhUhB7QdMcqUPOS6cz8vm8YhE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NesahsYIIcoGFoDIRwTs2dqkxZNxNWWVnQdQI91WUsfGKBBk5ytRVIMn1x/xz62MgUOJRfEm+TLevOxYIcCRRcYt4fWIpwmxa9YBee8aQtblGBZJZ7hpL7A513EYxtMLK4X159cvPwILR5wZC4iRimDICRgF+fecTlNylqVurws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TXEiC8BC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TXEiC8BC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724325659;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bpCy6dO0uqqF5xDxQyyJx28AB3JYQF66yHgVSJxJxvM=;
	b=TXEiC8BCrO9g3nhmuJLe5I1TdBQXuyFuOa9h3SbI89Za2Ria/hF0MKE1ANsM2MUERAwjGY
	EVgdYIUcVqMJAhuPfP37g4400R6PY//yt6Zvm7N7qwMf/wp2kQaX8XP9xChney+3dkeX4d
	Dnu9jvpHgUeXCj3upXMdkmiT2snUEnY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-187-aJBKaDvTMCmqgZqPHvDigA-1; Thu,
 22 Aug 2024 07:20:55 -0400
X-MC-Unique: aJBKaDvTMCmqgZqPHvDigA-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A45BC1979062;
	Thu, 22 Aug 2024 11:20:54 +0000 (UTC)
Received: from localhost (unknown [10.22.32.39])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id EECED19560AD;
	Thu, 22 Aug 2024 11:20:53 +0000 (UTC)
Date: Thu, 22 Aug 2024 08:20:52 -0300
From: "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: tglozar@redhat.com, linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org, jkacur@redhat.com
Subject: Re: [PATCH] tracing/timerlat: Check tlat_var for NULL in
 timerlat_fd_release
Message-ID: <ZscfFFUM6pBuwpGZ@uudg.org>
References: <20240820130001.124768-1-tglozar@redhat.com>
 <20240821160316.02c03c44@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240821160316.02c03c44@gandalf.local.home>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On Wed, Aug 21, 2024 at 04:03:16PM -0400, Steven Rostedt wrote:
> On Tue, 20 Aug 2024 15:00:01 +0200
> tglozar@redhat.com wrote:
> 
> > From: Tomas Glozar <tglozar@redhat.com>
> > 
> > When running timerlat with a userspace workload (NO_OSNOISE_WORKLOAD),
> > NULL pointer dereference can be triggered by sending consequent SIGINT
> > and SIGTERM signals to the workload process. That then causes
> > timerlat_fd_release to be called twice in a row, and the second time,
> > hrtimer_cancel is called on a zeroed hrtimer struct, causing the NULL
> > dereference.
> > 
> > This can be reproduced using rtla:
> > ```
> > $ while true; do rtla timerlat top -u -q & PID=$!; sleep 5; \
> >  kill -INT $PID; sleep 0.001; kill -TERM $PID; wait $PID; done
> > [1] 1675
> > [1]+  Aborted (SIGTERM)      rtla timerlat top -u -q
> > [1] 1688
> > client_loop: send disconnect: Broken pipe
> > ```
> > triggering the bug:
> 
> I'm able to reproduce this with the above. Unfortunately, I can still
> reproduce it after applying this patch :-(

We were able to mitigate the problem (triggered by that command line) simply
by handling SIGTERM in the userspace tool the same way it handles SIGINT. That
was one of the factors that helped the "closing the file descriptor twice"
theory.

Would you mind sharing the backtrace you got? That would also help us
investigating.

> Looking at the code, the logic for handling the kthread seems off. I'll
> spend a little time to see if I can figure it out.

You mean the 

+	if (!tlat_var->kthread) {
+		/* the fd has been closed already */

bit or the kthread handling in rtla itself?

As Tomas already said, thank you for testing and reviewing the suggested fix!

Luis

