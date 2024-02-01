Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C66465B680
	for <linux-trace-kernel@vger.kernel.org>; Thu,  1 Feb 2024 13:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706793631; cv=none; b=O7cUCePNm4gLqBhMCG2z2cS/BLDOiqVmbPh+aEtJbtcvVUylnkI8l9eyrA336jmFPMudwcMooIoPmcbn9aZxdcLixtoSYoFqZsL2uiue/V/kGugz+xk47sPYwVRN0lAK8RFPgo9f9tShm80/tuk/SEW2oROEEei0lE7pzOmkSdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706793631; c=relaxed/simple;
	bh=GcXd6zzIctDICMWvOQarMzR5bNNDBeDptM+4zbpLab4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B0nqe8Wog5LTOAlT2jC922/rQ4ZnMEoJTHx15j4oRpL01xn7Gfrxi5LEtCNRhe6pCouWYMqVkJjf1+K4w9fSdagZMZpPmCmeEVnr4NqDZdEFQ1Gsbpuu5ZIIcayoCXM+e0J0YKRkGSKgmC8bB4EotlwNeOLWb8Yw7LwHGFJnjYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=LMFvC17w; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="LMFvC17w"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-33b029a1c8aso1072846f8f.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 01 Feb 2024 05:20:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1706793628; x=1707398428; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ckd38E7X//CQPeoPjfsDgV9+RBwHO5Pr66/35DL0opM=;
        b=LMFvC17wnqUYX2+JAqN+qzBY6A7qv8ygkQnpoWYS7HZ/Z+ZS3Ip9jI04kbGz8hpsWo
         UEzLBtLY7drFbo8slH51dJRuUXZJa7uIPrB6sLA621Qo91YzM2/4ftcPMxO6QMuVbvF3
         aNiQMl3dzwkzR/YOd6j8dYrzIrzNABka/IcL1gbvGXlCzaGZfRQpX2ZbKjylnFWUviC6
         OiV8GyiPyw9uVRSEJyMA7OXYYuoUnmRafgV8L6WiGwyDFWwohxlSQcEZRcLTErXqXYP2
         yxT3vrB4MXniwJ8b2KMkjIffaSlRPbIO7A2S8+1eOaRkNWC2RwO83dJLqWfJa5VSD0pC
         WfBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706793628; x=1707398428;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ckd38E7X//CQPeoPjfsDgV9+RBwHO5Pr66/35DL0opM=;
        b=WvcdJsKgRjJ6L6KQgxKfbR4C0z3s/9vibjztbYp7ukaopgu6Wc4uHx6Dl+EHQpIZ/i
         a+WW8+zMEyvE0HiANwI/AyBMOk4D9mjRmomWXRbCxrEYuwU0q+MWc2rrvw/h8FRTPnq5
         BnJlETXa8LmUbw1Lh6Oytvll0zSqzQXZIipyPgxR4GrogGAATL35eZJoNkIYFNOd8z13
         cjto893XW/29OQdp1MYY1El1GRH1D12nwJbkreADIPU8sVngevAcTC9UYNpeRlvG9umW
         OS2aVo6nFg7aoUFS3//sBL/oT+Gq14R6UUfUKs4DcXU4vCDpBd06R1wCFYfs45RGg8D9
         ++Xw==
X-Gm-Message-State: AOJu0YxSB9TX00O8VDvoSW8Z7cyVe6EiY0daL46yn0RlGC4wQyeaTd7J
	3QaMjYIX/KmsY/f2s2Lk5tx5yDXP3AnImq1RxV5FjeaV88XixTAcQ63baoyrzkA=
X-Google-Smtp-Source: AGHT+IHk/wPWjk6/XkiNfSrZ3SmxvnCWMEsoyBPSbhsSgYxxmtwma3Xfp3CCmWFxVHfDz6gn6Ox21w==
X-Received: by 2002:adf:fc8b:0:b0:33a:ead3:6438 with SMTP id g11-20020adffc8b000000b0033aead36438mr7131258wrr.33.1706793627930;
        Thu, 01 Feb 2024 05:20:27 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWPqx+9MNhBCRHDXiJgYNXxir1yprGTfyboxwXaZZU+nhZm/YOBWCW/+a8V+GvwrGTg2DiHuwJY/ksYnmINi2Av9bdaqyWuZ+golhzH+fIHz64cUPStUIb7ppQgTnNyeDkqwRUe+uAf1A/v5jEHJY+pWMpol9caC8aNzxyxS86DqH1rsgiE7JyFDIBXECLB+GNQImXC1S3Rnc/DbI17dVGrYNi1XsaCHJcYOuNgAz3hi5gkIQotWr1ldgB/EHTQsjKnWFFnbofy7/Z0/gUzuaUlvjPpAcI/nT49+xTqniyCu9Q4ci4FvIzROk8uNjRLMePRCyly8mU7UTjtqMJzznb9zuFiw+res4AdWylJcOYqInJdv+Fkcqm7+RBM7eHMI+i71m0U5/XWFnSdaYV36oRF8CPq42nI4/UK4q2vdq1vhgKf9XWDbXQJufeB/A5u7BykDjs3ARKds9PBc6vzv2+aFBjDy+ciY6ySK55xgMad+xOygE4Dsfe0p9ipJp7TbIOFG5pcnnSoXqZtoTSHf6r1HqZVMawTvolegwwKys/ggdMGymqCVeb1TCBYnLo/4GTVmrSzH+BDvv1gD1lD+w0Cxe/AjjSMY3TbTyshJDQWsnf47Rxl3fc6UAsHtmFrezEuU9z4gPtucYPUyg==
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id a15-20020a056000100f00b0033aee3bfac5sm10318553wrx.16.2024.02.01.05.20.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 05:20:27 -0800 (PST)
Date: Thu, 1 Feb 2024 14:20:23 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: John Garry <john.g.garry@oracle.com>
Cc: Jakub Kicinski <kuba@kernel.org>, mcgrof@kernel.org,
	russ.weight@linux.dev, gregkh@linuxfoundation.org,
	rafael@kernel.org, rostedt@goodmis.org, mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com, davem@davemloft.net,
	edumazet@google.com, pabeni@redhat.com, keescook@chromium.org,
	masahiroy@kernel.org, nathan@kernel.org, nicolas@fjasle.eu,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	netdev@vger.kernel.org, linux-kbuild@vger.kernel.org
Subject: Re: [PATCH RFC 3/4] net: ethtool: Use uts_release
Message-ID: <Zbual3uIsjXENw0c@nanopsycho>
References: <20240131104851.2311358-1-john.g.garry@oracle.com>
 <20240131104851.2311358-4-john.g.garry@oracle.com>
 <20240131112432.5133bcaa@kernel.org>
 <fa2636b8-de7c-494a-bb9c-d1a8cc97f6c8@oracle.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fa2636b8-de7c-494a-bb9c-d1a8cc97f6c8@oracle.com>

Thu, Feb 01, 2024 at 01:57:16PM CET, john.g.garry@oracle.com wrote:
>On 31/01/2024 19:24, Jakub Kicinski wrote:
>> On Wed, 31 Jan 2024 10:48:50 +0000 John Garry wrote:
>> > Instead of using UTS_RELEASE, use uts_release, which means that we don't
>> > need to rebuild the code just for the git head commit changing.
>> > 
>> > Signed-off-by: John Garry<john.g.garry@oracle.com>
>> Yes, please!
>> 
>> Acked-by: Jakub Kicinski<kuba@kernel.org>
>
>Cheers
>
>BTW, I assume that changes like this are also ok:
>
>--------8<---------
>
>   net: team: Don't bother filling in ethtool driver version
>
>   The version is same as the default, as don't bother.
>
>   Signed-off-by: John Garry <john.g.garry@oracle.com>
>
>diff --git a/drivers/net/team/team.c b/drivers/net/team/team.c
>index f575f225d417..0a44bbdcfb7b 100644
>--- a/drivers/net/team/team.c
>+++ b/drivers/net/team/team.c
>@@ -25,7 +25,6 @@
>#include <net/genetlink.h>
>#include <net/netlink.h>
>#include <net/sch_generic.h>
>-#include <generated/utsrelease.h>
>#include <linux/if_team.h>
>
>#define DRV_NAME "team"
>@@ -2074,7 +2073,6 @@ static void team_ethtool_get_drvinfo(struct
>net_device *dev,
>                                    struct ethtool_drvinfo *drvinfo)
>{
>       strscpy(drvinfo->driver, DRV_NAME, sizeof(drvinfo->driver));
>-       strscpy(drvinfo->version, UTS_RELEASE, sizeof(drvinfo->version));

Yeah. I don't see why should anyone care about this "version"...
Let's remove it.

>}
>
>-------->8---------
>
>right?
>
>John
>
>
>
>
>
