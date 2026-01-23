Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 836012E5B09
	for <linux-trace-kernel@vger.kernel.org>; Fri, 23 Jan 2026 13:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769173404; cv=none; b=f6cXdb0+qnNOsv1pt3GKGNQ32X7RXIPtpGPHyaWIxluQQSyd4tgkshSbn5lZUgKC4XHtexD7IW4xhqgiPK9OB3JH6HYkk1q8QwAYCPh+Rk2shrX8kYP9RpOKHbRfMptIBQGTza+kXH8N3IuW+fdGgbY1lJmEaZG3EriPjYmoyHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769173404; c=relaxed/simple;
	bh=hGG8q2LDtTMO7x/GKprkkhTP5qjLaky2UXr+3Q6SRls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=ZT2TKPxPbX+z7wSMtUS5IbSe/ugbJEkfvO6vBdIkw8ORKAHZLfKJNEa0/NDv3WcOp2tJLIkxRzckhXTL/UsIcuHyFQGl69la4/5XUhrUwDi+3GPn9HWfEptAWfVyBihmM/tYCjQ+aYFET0RLDMlNnC5VL073tzaQlbhaozfAQr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W7FBwg/3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W7FBwg/3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769173402;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=f1OPSHMWxka9EbcgB8qFbDMq6x4990pyxNKpMSpRDU0=;
	b=W7FBwg/3vheJDKSis3e/XkZZ5fkd8S5y1PsKOoDw3/WrYsg8yL3gKwlGS8nAXJYyPGtJok
	xTd0LO8tuRmUXmdbsI2GZn7ecU08TbAGISfGjRY5XV6WoXz5ZvjPqKstNOa1dicvFU9Bmm
	dpoi+0i5yPAHXJ8x7Tc9JQvwVhctgYE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-203-bi3EA3-OMK6X9QbzRbpUUg-1; Fri, 23 Jan 2026 08:03:21 -0500
X-MC-Unique: bi3EA3-OMK6X9QbzRbpUUg-1
X-Mimecast-MFC-AGG-ID: bi3EA3-OMK6X9QbzRbpUUg_1769173399
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-4358f1c082eso2130529f8f.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 23 Jan 2026 05:03:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769173399; x=1769778199;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f1OPSHMWxka9EbcgB8qFbDMq6x4990pyxNKpMSpRDU0=;
        b=R7Nk7lI0WCrIgquafc5AxECQzQ+z0TJ8sC9XkRv7YIBUJNINNqa9rp8/qQOQ6z5kiO
         FbHjZyqu0c5zT9nzVd+9xdDkUeTRjMdpZL83lntZu6WHPhFGW1TNW1r3BtDiEaarKUK0
         QjDmCvETMSwKvqaW0q1GkJcQi/NGJyOtcd4oHoSeIgDew3ymIdkIJ/DNwOOZN90JUqIq
         ZqWTFIBjH93HaEYDsJzLsnRVbMr+akFkWcB7KYhE2xQnKmQkZT3ZrkkQRH4y8K+lcmRI
         K8w9cHLJDfEfhTJH/qhMW3zR9E31rwpwF+ikJlm1UntSgYCslQiKCZ+rCGeggzkNvzYo
         JYkw==
X-Forwarded-Encrypted: i=1; AJvYcCXqt3C/bST3CK4FaUw/P6DMUg2Ypwicj5ZpvXj1WkDZ2L2je7/+GJoTqW6hTRsmZvQearHzn5QICETdJurYZmLEPds=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGl8DxVbc7sNrqKyYmYR5acZSQTP2pjNq+NP71fOJ7/qRG4eHV
	RNVRC0y6nAQlN9Kxqf8ZFr2Pm7kD/Q/RUIPcG7vW6hVfD3G1WxyyDa32y30tXVVgwPqbpVzrFWG
	gvvUGI+XwSAI3SKksUmDWmFjw9+jA6QcsIdjA0aeH/TGxQzGlBogKA2k8R/pshloYIlO6Re61Jw
	==
X-Gm-Gg: AZuq6aL57vOeasvStfB0qZ/HQAzITH/VmqKV1wBE1x+s8qcD7jOBEQpufJLRdRCVFzw
	2nwPfwIt0h5OQ208cGr4nGfxNjLycjrf+OF+kJG0/H2ed+LZ0Es0lJutcZts7z6Aqi0alFg2VFX
	bvnKPrOG387RE7BqxldjuExO+lxkM3EmwPkEDQr4NLk8mFq17Gf8kVQYuJIEqDlwYKFLV8Spkk6
	kjv5t+qgEBHTnG7y18xK4oLZgZnK12VbYt871ABg+lbvKbI6oDCjdL1hrAnXrgqBGIO9/NlZRvF
	6RrUjOySqGWmTCwR2xDL1QbBo5wb2lh+o5iX+tx/tStIuzWNg/2uvCmaRsdwbAW8lPPRyit6Vf6
	3dnmBQe+1BkhOnUIUMkY9OM+teq/LSH71gEnKh0E6
X-Received: by 2002:a05:600c:1f90:b0:47d:6c36:a125 with SMTP id 5b1f17b1804b1-4804d309167mr49515025e9.17.1769173399236;
        Fri, 23 Jan 2026 05:03:19 -0800 (PST)
X-Received: by 2002:a05:600c:1f90:b0:47d:6c36:a125 with SMTP id 5b1f17b1804b1-4804d309167mr49514505e9.17.1769173398802;
        Fri, 23 Jan 2026 05:03:18 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.129.40])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435b1e71503sm7361058f8f.25.2026.01.23.05.03.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 05:03:18 -0800 (PST)
Date: Fri, 23 Jan 2026 14:03:16 +0100
From: Juri Lelli <juri.lelli@redhat.com>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
	Nam Cao <namcao@linutronix.de>, Juri Lelli <jlelli@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Tomas Glozar <tglozar@redhat.com>,
	Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH v5 14/15] rv: Add deadline monitors
Message-ID: <aXNxlHEimMLg6fU_@jlelli-thinkpadt14gen4.remote.csb>
References: <20260122155500.362683-1-gmonaco@redhat.com>
 <20260122155500.362683-15-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260122155500.362683-15-gmonaco@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 157IpnPUquR4On3uKBtqikQF9EwJAfE1ETIyF-K8cwA_1769173399
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

On 22/01/26 16:54, Gabriele Monaco wrote:
> Add the deadline monitors collection to validate the deadline scheduler,
> both for deadline tasks and servers.
> 
> The currently implemented monitors are:
> * throttle:
>     validate dl entities are throttled when they use up their runtime
> * nomiss:
>     validate dl entities run to completion before their deadiline
> 
> Cc: Peter Zijlstra <peterz@infradead.org>
> Reviewed-by: Nam Cao <namcao@linutronix.de>
> Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
> ---

Looks good to me!

Reviewed-by: Juri Lelli <juri.lelli@redhat.com>

Thanks,
Juri

