Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB165332EC5
	for <linux-trace-kernel@vger.kernel.org>; Fri, 17 Oct 2025 12:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760703720; cv=none; b=C10QgT+FgT7eLwJmwhiHBUJxV2QvrJyt3/4zOKt+gopOjeqR0kUFKuvluTTYIkHj2Dfi8WiddjDzukZCQ238c6lUrD80sdF1gY3sVqYCkcyEz0IxEyYbGJqDZeQAfcGBbRcBkth1hIhM71irFaMn7XxRsIdbUvM4NFho2+z9IVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760703720; c=relaxed/simple;
	bh=j8Q53LcqjX3K9rk1KcRLTnP/SfWrr9ihFvV63BUfTkU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jRSfb+6Das9Dqfkni/wYJDZVnZMbQcQMZE1vXPvXQZUKnYvfREqi43ki1XAbATob7M1KqqvWlW1rOoZNCdKWcMAT/J34y5gUn7UrG0smbZ3+P8Gi7oEejmXM1zhi9TXPbgDTopRbbKoLOo3wXFx6lRm5O7KxjZfsdGnt9BIgmHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fZj9Rii8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fZj9Rii8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760703717;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yNH8eNs471XcxnyIGOJ1GC1Y2iijHI3W5R1uBtM188U=;
	b=fZj9Rii8hOCxhQu96uvKPnXrfg7a86Xdr0cyDFPfyZGmkH3nn+FI6Bvr61EZVJgmXhWwEW
	I01svx3CV1n+977sgB3pIg9uzHoLiMVXIJ4Nbe9B1MaiEtir2Gv4OYgmJ/JOFPwsTs8JQZ
	5+eHjsZ5uBOvGE+zh5wmWmT6afJSbOk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-122-J5Adp1OPO_qZlQs7YsFtMA-1; Fri,
 17 Oct 2025 08:21:54 -0400
X-MC-Unique: J5Adp1OPO_qZlQs7YsFtMA-1
X-Mimecast-MFC-AGG-ID: J5Adp1OPO_qZlQs7YsFtMA_1760703713
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A84E51800673;
	Fri, 17 Oct 2025 12:21:53 +0000 (UTC)
Received: from wcosta-thinkpadt14gen4.rmtbr.csb (unknown [10.22.64.136])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id EFCCE19560AD;
	Fri, 17 Oct 2025 12:21:49 +0000 (UTC)
Date: Fri, 17 Oct 2025 09:21:48 -0300
From: Wander Lairson Costa <wander@redhat.com>
To: Tomas Glozar <tglozar@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, 
	LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>, 
	John Kacur <jkacur@redhat.com>, Luis Goncalves <lgoncalv@redhat.com>, 
	Costa Shulyupin <costa.shul@redhat.com>, Crystal Wood <crwood@redhat.com>
Subject: Re: [PATCH v2 3/3] rtla/tests: Fix osnoise test calling timerlat
Message-ID: <jvl55palxxkx7cf5l5faa5ufzzl6oyq37sxzy4xhm4hzoslprh@mvssmcs42dyv>
References: <20251007095341.186923-1-tglozar@redhat.com>
 <20251007095341.186923-3-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251007095341.186923-3-tglozar@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Tue, Oct 07, 2025 at 11:53:41AM +0200, Tomas Glozar wrote:
> osnoise test "top stop at failed action" is calling timerlat instead of
> osnoise by mistake.
> 
> Fix it so that it calls the correct RTLA subcommand.
> 
> Fixes: 05b7e10687c ("tools/rtla: Add remaining support for osnoise actions")
> Signed-off-by: Tomas Glozar <tglozar@redhat.com>
> ---
>  tools/tracing/rtla/tests/osnoise.t | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/tracing/rtla/tests/osnoise.t b/tools/tracing/rtla/tests/osnoise.t
> index 08196443fef1..396334608920 100644
> --- a/tools/tracing/rtla/tests/osnoise.t
> +++ b/tools/tracing/rtla/tests/osnoise.t
> @@ -37,7 +37,7 @@ check "multiple actions" \
>  check "hist stop at failed action" \
>  	"osnoise hist -S 2 --on-threshold shell,command='echo -n 1; false' --on-threshold shell,command='echo -n 2'" 2 "^1# RTLA osnoise histogram$"
>  check "top stop at failed action" \
> -	"timerlat top -T 2 --on-threshold shell,command='echo -n abc; false' --on-threshold shell,command='echo -n defgh'" 2 "^abc" "defgh"
> +	"osnoise top -S 2 --on-threshold shell,command='echo -n abc; false' --on-threshold shell,command='echo -n defgh'" 2 "^abc" "defgh"
>  check "hist with continue" \
>  	"osnoise hist -S 2 -d 5s --on-threshold shell,command='echo TestOutput' --on-threshold continue" 0 "^TestOutput$"
>  check "top with continue" \
> -- 
> 2.51.0
> 

Reviewed-by: Wander Lairson Costa <wander@redhat.com>

