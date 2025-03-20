Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E03F72B9CD
	for <linux-trace-kernel@vger.kernel.org>; Thu, 20 Mar 2025 19:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742499671; cv=none; b=sbes3fJu1uazLTF/wXGQzEkY1vhzuiPzeMXgvHqHol09/72f0zDi8+FBrBDbjYIZ2sYADhUZm/c1ex4wqVp3RbIvlqjUOAwFWIoQ45Z3TW0xyp8qqRA1uVJLTTFzyjXK2J8Ueqqtw1qD5istUGbkU5iNe8/jJqUvEFNnuo4RKSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742499671; c=relaxed/simple;
	bh=wvQxy7EYplUISZ0w1bmP0u/Y9bJXMJJWRo6e/ddO4pc=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=PX+GTtDdyiyFq4fEYqcPi4Eu77XhBK+YEbrVG9GN2ccQlvqEPxgdYZkjHt6dlwLd1T0rt08QwoMX5xg/7caJ2IhEkdeD1EvPt6rvfaPSmrd6gpN8e4r9CbX1rFh3++BAkLxRC26Ar4vDvSGH0+8dLXBWabcu81HPpyibcMAg36Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LY/NhqKB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LY/NhqKB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742499668;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GuxXqw6GD7Luri3ii6782mBHPFKtCRI2jJ0fXlHMP6E=;
	b=LY/NhqKBCWHYP5M78tMjphQXh1HqMwPR/Bagv1HfItNmvvN+94nj4JRGuL21r9T02vkkJc
	w/6BQFRCLjPChRoRfNZEikkXavE9mFYNf4eOsztbVME9YctQ1lkWtOaUZqqt/jjB7FctLq
	lhZ5qWRu09ohO36F4/NTLgjqTBW7Nm8=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-674-lrs3L6PnMamRJhAv9ezoCw-1; Thu, 20 Mar 2025 15:41:07 -0400
X-MC-Unique: lrs3L6PnMamRJhAv9ezoCw-1
X-Mimecast-MFC-AGG-ID: lrs3L6PnMamRJhAv9ezoCw_1742499667
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6e8ec18a29aso12606166d6.2
        for <linux-trace-kernel@vger.kernel.org>; Thu, 20 Mar 2025 12:41:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742499667; x=1743104467;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GuxXqw6GD7Luri3ii6782mBHPFKtCRI2jJ0fXlHMP6E=;
        b=uhD+jmXIV8KLNM9CJTB4pmBmxPE5j4Fcj5aioc0ZbRKQDGUcP5/lwSdHcIvuK4PU7M
         JcK4uvHvnFEI+tETZuIqDUySQI5Qbh61QA6y61TzOdGcWUk57jz1YPXkTH4zUVyNYo4M
         nVsL73jbBxjnlBSQky2MZpWkVYV0VkT2io98AWcls7fH0Fmf19sA4GzWFxoLOfn5536d
         bH0NY368to/z6xMjZ+Y+92UGaP5i9ZF/z13EuWxGqqahZvmN3fr3EGFjN13Yc/HH+DjA
         T/AcbtfZsalvwYmuW3iGOwor47+T6zxXrqh37DhVvKkJpgEO/EXaAFpBjcZ1syKJFv0R
         hsJw==
X-Forwarded-Encrypted: i=1; AJvYcCUAVw9HC3cNojOibyP5XXaWy2+As6g3C8EkgZ1lI0deS9whdfl9odRwN8GnC2ntKCGsll6DR3Gd1rB+HEwqoG0xlEI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2xUmO4rFwwWPB2dI0Kn+SlvKcdFzLgMqsTsg1xxV2KRzcwT8V
	kOR2kLf816DD9CmgzzuTkwHJBKWmmVBqI6QhKKe9Y4dJYYHOQLG8SVn1089XVPa1y8YYxGAi43X
	g/y6PtOkAHSpiGG4rtndo3ph+8qjtLBknKgx4DjpPHZlnnfFoB7h+6l2/8i4sMmufAZXUQg==
X-Gm-Gg: ASbGncugLO48QT+w1BhpxNPOroIY5L8Ek9dvHdWGH5PBirS4IUYLti4tz6JW73fSsNf
	DAJNSkoYJ9POTsS1JONofYVXjKCrOXjfLele7xuNJ4b0Ofjbp3wDO4BdMrtt3M958rBcwJh8qKw
	QBjX6mxJRG+IitYYUSE6kP8RPn1xTvY6hQLXwl+jxAfviMglQmxc2GognxI8iCjxyeduXeimXwK
	r8oKjSne2RcdLVqVxP0BK9dnEl4+UzltaLKdgxoYfoQvBPxKXNJVyXFUUhXfQVVW5qo8JqhCoqe
X-Received: by 2002:ad4:5ded:0:b0:6e8:fcc6:35b6 with SMTP id 6a1803df08f44-6eb3f275e0amr8278126d6.2.1742499667148;
        Thu, 20 Mar 2025 12:41:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFxgR5kEC/tNHdZ06VV6oGL8c8ichrEbJIpBzq1A+tGZpLER6gVnAF2uploqeF0gS5LehZNxw==
X-Received: by 2002:ad4:5ded:0:b0:6e8:fcc6:35b6 with SMTP id 6a1803df08f44-6eb3f275e0amr8277746d6.2.1742499666574;
        Thu, 20 Mar 2025 12:41:06 -0700 (PDT)
Received: from fionn ([76.69.33.37])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6eb3ef0ecf9sm1976856d6.14.2025.03.20.12.41.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 12:41:06 -0700 (PDT)
Date: Thu, 20 Mar 2025 15:40:55 -0400 (EDT)
From: John Kacur <jkacur@redhat.com>
To: Tomas Glozar <tglozar@redhat.com>
cc: Steven Rostedt <rostedt@goodmis.org>, linux-trace-kernel@vger.kernel.org, 
    linux-kernel@vger.kernel.org, Luis Goncalves <lgoncalv@redhat.com>
Subject: Re: [PATCH 3/6] rtla/osnoise: Set OSNOISE_WORKLOAD to true
In-Reply-To: <20250320092500.101385-4-tglozar@redhat.com>
Message-ID: <d55ba3cd-2de5-7520-a0b2-e5bcb6bad235@redhat.com>
References: <20250320092500.101385-1-tglozar@redhat.com> <20250320092500.101385-4-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: dTH_m4tGDlE8euW_LKS1lKnGSNDNq0A0H_hg2aLyayA_1742499667
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII



On Thu, 20 Mar 2025, Tomas Glozar wrote:

> If running rtla osnoise with NO_OSNOISE_WORKLOAD, it reports no samples:
> 
> $ echo NO_OSNOISE_WORKLOAD > /sys/kernel/tracing/osnoise/options
> $ rtla osnoise hist -d 10s
> Index
> over: 0
> count: 0
> min: 0
> avg: 0
> max: 0
> 
> This situation can also happen when running rtla-osnoise after an
> improperly exited rtla-timerlat run.
> 
> Set OSNOISE_WORKLOAD in rtla-osnoise, too, similarly to what we
> already did for timerlat in commit 217f0b1e990e ("rtla/timerlat_top: Set
> OSNOISE_WORKLOAD for kernel threads") and commit d8d866171a41
> ("rtla/timerlat_hist: Set OSNOISE_WORKLOAD for kernel threads").
> 
> Note that there is no user workload mode for rtla-osnoise yet, so
> OSNOISE_WORKLOAD is always set to true.
> 
> Fixes: 1eceb2fc2ca5 ("rtla/osnoise: Add osnoise top mode")
> Fixes: 829a6c0b5698 ("rtla/osnoise: Add the hist mode")
> Signed-off-by: Tomas Glozar <tglozar@redhat.com>
> ---
>  tools/tracing/rtla/src/osnoise.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/tools/tracing/rtla/src/osnoise.c b/tools/tracing/rtla/src/osnoise.c
> index 1735a36466c4..a71618d876e9 100644
> --- a/tools/tracing/rtla/src/osnoise.c
> +++ b/tools/tracing/rtla/src/osnoise.c
> @@ -1187,6 +1187,12 @@ osnoise_apply_config(struct osnoise_tool *tool, struct osnoise_params *params)
>  		auto_house_keeping(&params->monitored_cpus);
>  	}
>  
> +	retval = osnoise_set_workload(tool->context, true);
> +	if (retval < -1) {
> +		err_msg("Failed to set OSNOISE_WORKLOAD option\n");
> +		goto out_err;
> +	}
> +
>  	return 0;
>  
>  out_err:
> -- 
> 2.48.1
> 
> 
> 
Reviewed-by: John Kacur <jkacur@redhat.com>

