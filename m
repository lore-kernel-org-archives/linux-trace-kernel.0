Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F2F3597F
	for <linux-trace-kernel@vger.kernel.org>; Tue, 11 Mar 2025 13:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741698475; cv=none; b=AQeiUAygmIBI9jF39mYTwi8KcqfL3eliZV3bQ8aIns3ouhlh+3zVcg1Qy3CDkuUE1etVL8VhapscfNdqQmGIbNNwOLD0Hc4ew0nMGrS5qNsvjtedDqiazBs5KUZPEIKwKJIr2Uaf/liNVJPG6Y9/m72NMogbfTWxHbmpgt2B4Ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741698475; c=relaxed/simple;
	bh=Y5DI7+SRpVq21SnJ5XCa+73thQkmx5Q3vChAwkd+ejw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U45S3texRFzbIfuBr7VfZNm2kP3toFHZcB6s1kee742KkEtU1QioT2DF8LOpdLEeQVsRN1LzvoEhPswUrAqfqKqsHxYWkcLsXZwDRM9KtLo7IjasCeF2USHQQVvXXLr8A286ou0jPPzTkOK8+abuHmP7ap23s9w323ZCre/4dYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iN8Kxykf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iN8Kxykf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741698471;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GdzATd1PXx/GmdafuFTK4X7kP47DhqkVfSwlwyUvZU8=;
	b=iN8Kxykf66i9L95salTdElOIcG+quBjea5MH2YQNbIZ02IZnDAqgHsmfkPfMeHu74IykH7
	qKtYCqlxRdVeltI1G3CwrO1c5d2dEaHVDZuZLfUQN8LwFbKIJIBLvn3k4VU8bptUxpRh8u
	xb7vslmBQ8qlpFhfIP6jCfY/Fgz2YF0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-650-Dq2imMx-O7qH0IQZFDw64A-1; Tue,
 11 Mar 2025 09:07:48 -0400
X-MC-Unique: Dq2imMx-O7qH0IQZFDw64A-1
X-Mimecast-MFC-AGG-ID: Dq2imMx-O7qH0IQZFDw64A_1741698467
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F19E0180025B;
	Tue, 11 Mar 2025 13:07:46 +0000 (UTC)
Received: from localhost (unknown [10.22.81.23])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2CD7919560AB;
	Tue, 11 Mar 2025 13:07:45 +0000 (UTC)
Date: Tue, 11 Mar 2025 10:07:44 -0300
From: "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
To: Tomas Glozar <tglozar@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Jonathan Corbet <corbet@lwn.net>,
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH 4/4] Documentation/rtla: Include BPF sample collection
Message-ID: <Z9A1oN_XdMguNgHy@uudg.org>
References: <20250311114936.148012-1-tglozar@redhat.com>
 <20250311114936.148012-5-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250311114936.148012-5-tglozar@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On Tue, Mar 11, 2025 at 12:49:36PM +0100, Tomas Glozar wrote:
> Add dependencies needed to build rtla with BPF sample collection support
> to README, and document both ways of sample collection in the manpages.
> 
> Signed-off-by: Tomas Glozar <tglozar@redhat.com>
> ---
>  Documentation/tools/rtla/common_timerlat_description.rst | 8 ++++++++
>  tools/tracing/rtla/README.txt                            | 7 +++++++
>  2 files changed, 15 insertions(+)
> 
> diff --git a/Documentation/tools/rtla/common_timerlat_description.rst b/Documentation/tools/rtla/common_timerlat_description.rst
> index 8cd3e717baa8..49fcae3ffdec 100644
> --- a/Documentation/tools/rtla/common_timerlat_description.rst
> +++ b/Documentation/tools/rtla/common_timerlat_description.rst
> @@ -8,3 +8,11 @@ The *timerlat* tracer outputs information in two ways. It periodically
>  prints the timer latency at the timer *IRQ* handler and the *Thread*
>  handler. It also enables the trace of the most relevant information via
>  **osnoise:** tracepoints.
> +
> +The **rtla timerlat** tool sets the options of the *timerlat* tracer
> +and collects and displays a summary of the results. By default,
> +the collection is done synchronously in kernel space using a dedicated
> +BPF program attached to the *timerlat* tracer. If either BPF or
> +the **osnoise:timerlat_sample** tracepoint it attaches to is

In the last phrase, s/is/are/. So that "If either... or... are unavailable".

Luis

> +unavailable, the **rtla timerlat** tool falls back to using tracefs to
> +process the data asynchronously in user space.
> diff --git a/tools/tracing/rtla/README.txt b/tools/tracing/rtla/README.txt
> index dd5621038c55..43e98311d10f 100644
> --- a/tools/tracing/rtla/README.txt
> +++ b/tools/tracing/rtla/README.txt
> @@ -13,6 +13,13 @@ RTLA depends on the following libraries and tools:
>   - libtraceevent
>   - libcpupower (optional, for --deepest-idle-state)
>  
> +For BPF sample collection support, the following extra dependencies are
> +required:
> +
> + - libbpf 1.0.0 or later
> + - bpftool with skeleton support
> + - clang with BPF CO-RE support
> +
>  It also depends on python3-docutils to compile man pages.
>  
>  For development, we suggest the following steps for compiling rtla:
> -- 
> 2.48.1
> 
---end quoted text---

