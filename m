Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB8AB2E5B2A
	for <linux-trace-kernel@vger.kernel.org>; Fri, 17 Oct 2025 12:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760704511; cv=none; b=dGnQfolzyMHhtzC/kkng1wXm/UKYqfMO7io3xTdqz5ZSDWPYEMkkhgvBgAqfPC1KrOK+Qn5GbsOjJvBAI5YshOZqu8bQ7Wj8q3a5uaLDzGZAsW13nrmaZ5Jwam+Iqq8t91htMGwrogvATc6LWjs/Fdwye/AhKjwLaEJ9O3yXhic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760704511; c=relaxed/simple;
	bh=hooOmsIKnj5D8GAzQfDmrdxtW9sI7j7j97T+qU4bFO0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XVh0fkETAf4vjxQ2N2ya0VchtMbs7VBb0szrOxcG7WRrcTVat3s4ZPcz0DxqohUU8xHjnYn7QPg6J+QEcZEHRg8BtXlRuaAqy9TX/gtMLVrAn5xbBr2YP2duiUy6USYzlN1455n0j0JX5ffcHieMB6HsLIJU0WvX8P3Ss1uFzeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LPqaMkd8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LPqaMkd8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760704506;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3Xkl9mNK4xtIyBibAQFYw8DQjKmVQW6nrzyawypmZes=;
	b=LPqaMkd8hcQvU0k4ybL+YPmShyQA0XIcq0Nwwl360DPJC0JK0JqSdAMZV2Ruv6A4v4a46Y
	j8RJerOfL1rikBg7PBLcakqKaMQqw2pdWb6K7emdhWXVKZsQfOr+qfqT3E77uKJJetcSLr
	8/bDl1oCSFCQQKU8jx502ppG//ULiAc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-264-Q2xijE8oP6etRjV_EeZN9g-1; Fri,
 17 Oct 2025 08:35:01 -0400
X-MC-Unique: Q2xijE8oP6etRjV_EeZN9g-1
X-Mimecast-MFC-AGG-ID: Q2xijE8oP6etRjV_EeZN9g_1760704500
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5ED0519560AD;
	Fri, 17 Oct 2025 12:35:00 +0000 (UTC)
Received: from wcosta-thinkpadt14gen4.rmtbr.csb (unknown [10.22.64.136])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id C6ABA1800451;
	Fri, 17 Oct 2025 12:34:56 +0000 (UTC)
Date: Fri, 17 Oct 2025 09:34:55 -0300
From: Wander Lairson Costa <wander@redhat.com>
To: Tomas Glozar <tglozar@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, 
	LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>, 
	John Kacur <jkacur@redhat.com>, Luis Goncalves <lgoncalv@redhat.com>, 
	Costa Shulyupin <costa.shul@redhat.com>, Crystal Wood <crwood@redhat.com>
Subject: Re: [PATCH v2 2/3] rtla/tests: Extend action tests to 5s
Message-ID: <f2opu4ftzneryyownttyf7rnt5tkmhjlooxkjzqht3kh4u2rms@in33hwth6z5f>
References: <20251007095341.186923-1-tglozar@redhat.com>
 <20251007095341.186923-2-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251007095341.186923-2-tglozar@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Tue, Oct 07, 2025 at 11:53:40AM +0200, Tomas Glozar wrote:
> In non-BPF mode, it takes up to 1 second for RTLA to notice that tracing
> has been stopped. That means that action tests cannot have a 1 second
> duration, as the SIGALRM will be racing with the threshold overflow.
> 
> Previously, non-BPF mode actions were buggy and always executed
> the action, even when stopping on duration or SIGINT, preventing
> this issue from manifesting. Now that this has been fixed, the tests
> have become flaky, and this has to be adjusted.
> 
> Fixes: 4e26f84abfb ("rtla/tests: Add tests for actions")
> Fixes: 05b7e10687c ("tools/rtla: Add remaining support for osnoise actions")
> Signed-off-by: Tomas Glozar <tglozar@redhat.com>
> ---
>  tools/tracing/rtla/tests/osnoise.t  | 4 ++--
>  tools/tracing/rtla/tests/timerlat.t | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/tracing/rtla/tests/osnoise.t b/tools/tracing/rtla/tests/osnoise.t
> index e3c89d45a6bb..08196443fef1 100644
> --- a/tools/tracing/rtla/tests/osnoise.t
> +++ b/tools/tracing/rtla/tests/osnoise.t
> @@ -39,9 +39,9 @@ check "hist stop at failed action" \
>  check "top stop at failed action" \
>  	"timerlat top -T 2 --on-threshold shell,command='echo -n abc; false' --on-threshold shell,command='echo -n defgh'" 2 "^abc" "defgh"
>  check "hist with continue" \
> -	"osnoise hist -S 2 -d 1s --on-threshold shell,command='echo TestOutput' --on-threshold continue" 0 "^TestOutput$"
> +	"osnoise hist -S 2 -d 5s --on-threshold shell,command='echo TestOutput' --on-threshold continue" 0 "^TestOutput$"
>  check "top with continue" \
> -	"osnoise top -q -S 2 -d 1s --on-threshold shell,command='echo TestOutput' --on-threshold continue" 0 "^TestOutput$"
> +	"osnoise top -q -S 2 -d 5s --on-threshold shell,command='echo TestOutput' --on-threshold continue" 0 "^TestOutput$"
>  check "hist with trace output at end" \
>  	"osnoise hist -d 1s --on-end trace" 0 "^  Saving trace to osnoise_trace.txt$"
>  check "top with trace output at end" \
> diff --git a/tools/tracing/rtla/tests/timerlat.t b/tools/tracing/rtla/tests/timerlat.t
> index b5d1e7260a9b..b550a6ae2445 100644
> --- a/tools/tracing/rtla/tests/timerlat.t
> +++ b/tools/tracing/rtla/tests/timerlat.t
> @@ -60,9 +60,9 @@ check "hist stop at failed action" \
>  check "top stop at failed action" \
>  	"timerlat top -T 2 --on-threshold shell,command='echo -n 1; false' --on-threshold shell,command='echo -n 2'" 2 "^1ALL"
>  check "hist with continue" \
> -	"timerlat hist -T 2 -d 1s --on-threshold shell,command='echo TestOutput' --on-threshold continue" 0 "^TestOutput$"
> +	"timerlat hist -T 2 -d 5s --on-threshold shell,command='echo TestOutput' --on-threshold continue" 0 "^TestOutput$"
>  check "top with continue" \
> -	"timerlat top -q -T 2 -d 1s --on-threshold shell,command='echo TestOutput' --on-threshold continue" 0 "^TestOutput$"
> +	"timerlat top -q -T 2 -d 5s --on-threshold shell,command='echo TestOutput' --on-threshold continue" 0 "^TestOutput$"
>  check "hist with trace output at end" \
>  	"timerlat hist -d 1s --on-end trace" 0 "^  Saving trace to timerlat_trace.txt$"
>  check "top with trace output at end" \
> -- 
> 2.51.0
> 

In general, my pupils dilate when I see time based synchronization.
However, in this case, it seems harmless.

Reviewed-by: Wander Lairson Costa <wander@redhat.com>

