Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D95369D40
	for <linux-trace-kernel@vger.kernel.org>; Fri, 25 Sep 2026 02:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790303496; cv=none; b=VGUhqeWFuqj0/loGYLGPXVIhLGOYZr84KN049ByoaK8WkiuN+snLGn7bZzxYBr/2fwsFUNHssBeY3x4SvnA06oNvKPTzgCBRPNtaqUfhJkof1CXaAsb5PusNx2Tn5iWlB40Sxocn2uk2xaaQ/y2v29alyhBRbUxsUKeh7aMYRBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790303496; c=relaxed/simple;
	bh=jS2W/bUER37p+AiiJp9pAGcS9BY4dqAFA39GLs13Xyc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CQopS5myct6/VnCNkeqRd2rskSxUyimBZl4kn08hFuMC7siqqr97kxFHUU6yYipeWXKTBCXYG8Ym0gQhhn+kszdERuYkoEAyUc8PbEotzL5NB6zQQ/ZXB1QTGAwsimnEUwjIVbd/Xuub5lYwsjwOWBHQGvBkl8fyPFlPGYrwa84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c5Gw5YeB; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c5Gw5YeB"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-396ccd5cf02so267176a91.3
        for <linux-trace-kernel@vger.kernel.org>; Thu, 24 Sep 2026 19:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790303493; x=1790908293; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=aKFA6xm6L+MWelDqLaCtGsiYbykSMXyQpjjhRA+8aLg=;
        b=c5Gw5YeBhKeBSWglXqGAbnAECTapva1KY5zZrqJ++EyFtJ3dtZ04UfBj9oN6zckrP9
         J2BHm+azYTgZhMA6Mb1hXU8v79vYtFUZkt0KXtun2jDzry5dfy8axshRYlMVbqeFsXbr
         IyiXdWqm38RH/yZYqNxElKabyXvb/H+B4bmbdeRiHQqsyOV+72lskUsKHFWQkbKrh+8F
         0f+ljPVR8vEoU6+zBSRqkuw+0eEQ7uMQnTFz0nqjTbwSk8s+JI53ATRMrQl3XZpq9WA5
         yQPmpTbLuwLWi/ZPXvHrCpGLwLZ7NvrrxDhSypwMtVDrohzWr2iOWfia0GOpe8stVjtV
         YNDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790303493; x=1790908293;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aKFA6xm6L+MWelDqLaCtGsiYbykSMXyQpjjhRA+8aLg=;
        b=fAcQRyXY+kXfJkbvO+ECxPKnBPnluOVY3l1RGfR5OX0ofyopX/Auf+RekYt8uZqbve
         DKBztGZXj4uV/W6Y7dF3RsNIb2ElHVJ/LWeCNi24jIOpccQZhZSOV2ob4Pu7hMtgn4m1
         SFrL2k2aVGHE9BCTUrzv8MOAv8o9H63ENPD+2CJSKLWNywWblaIpWr6pk56UyRMDrhRP
         QeKzgt+rXW7kuDtIKjy25LjOyMuP5PT9WgvbMxR+4QWhEeiiewSDZjSXGZNSzUNHIj17
         xtoown7fQ/nSsDVNqf/zy/PTpgEro6toG5RDynvSxcT/uxbWFT5RhY/ha51qyDaEp2Xz
         caAQ==
X-Forwarded-Encrypted: i=1; AKwUvByjBYyZs/4Y9OMv5DBt5sET21iG9ufzqmpVeVlQNUrbpPOjY34ZFl95RMxHTQt44OcZpJYZujdwP0uE2I3RcDaXdqA=@vger.kernel.org
X-Gm-Message-State: AFuF++maVrW/uJnyR7hWtHdDnPzbwzr1LdwfJs3RezHlxAhu04AEbxYx
	TIhHm625AEH6xhs+e5tS/SeWZwGtCTWKa/KfVTTL2EEt/WNnuZHoWd41
X-Gm-Gg: AYBFou0U3kKJyKRNln/r43x5eIpJRepxYPDy/SrVPrt9pWwfjhU08/6jKdB12Q2WKfx
	4boDTZtwZ7cBRhr5FsjDhtjpeydZ8fg83ihgibKzeJ0TbEmwfefnunBhxgsrNHK5RyDFE/qECNg
	GEdJDqKt2tdH281UCpvpDWTIY1N4zordXAkX1538t8nR6hPGFDXXgpbTbXxJbg0NzNnpelFNzzB
	G5Rt8gZ/PP0hG/tSPtiZ4gJO4+nFWKCPQJVX+GBIMIaDK2VZ6bx92Vm08bpbD6zWyG84/AAoVYf
	Yj8ZYYVOFwlnuD4QZDSkfoZfiqkH++h2oMK+eutmbQedvnt+enMbSAOCStwt6ifLmdDkj+DanfP
	XNlfTtn9l1uHUybwTXH9dj0JAZQYwlSpmVhVSfmHC8HgxP6rWBcQu9C4kLtrm242X11YLqznH3v
	cpKmJQtH0s7jMXJ3JKCAajnx5s0pPI1WuYgcfsavvXQFWFHUwuUxbvlQ4KmkJg7wcC8ZSuxUugf
	vcZuJ+d0Li1
X-Received: by 2002:a17:90b:3985:b0:39e:6c69:f482 with SMTP id 98e67ed59e1d1-3a098d5e61fmr3841860a91.65.1790303492904;
        Thu, 24 Sep 2026 19:31:32 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc7879030dasm486783a12.7.2026.09.24.19.31.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 19:31:32 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 24 Sep 2026 19:31:31 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Vincent Donnefort <vdonnefort@google.com>
Cc: rostedt@goodmis.org, mhiramat@kernel.org,
	linux-trace-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com,
	kernel-team@android.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] tracing: Fix simple_ring_buffer undef check on parisc
Message-ID: <ef7578ff-8416-495a-aa2c-035ecd956362@roeck-us.net>
References: <20260923074213.3077182-1-vdonnefort@google.com>
 <20260923074213.3077182-3-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260923074213.3077182-3-vdonnefort@google.com>

On Wed, Sep 23, 2026 at 08:42:12AM +0100, Vincent Donnefort wrote:
> simple_ring_buffer uses local_set() and cmpxchg() on unsigned long. Add
> them to undefsyms_base.c to extend the allowlist for the parisc
> architecture.
> 
> Fixes: 1211907ac0b5 ("tracing: Generate undef symbols allowlist for simple_ring_buffer")
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Closes: https://lore.kernel.org/all/5574c9e6-9ed2-4ee6-a2b2-fb6ee81e83a1@roeck-us.net/
> Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

Tested-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  kernel/trace/undefsyms_base.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/undefsyms_base.c b/kernel/trace/undefsyms_base.c
> index e65baf58e6ff..37310baf706b 100644
> --- a/kernel/trace/undefsyms_base.c
> +++ b/kernel/trace/undefsyms_base.c
> @@ -9,6 +9,7 @@
>  
>  #include <linux/atomic.h>
>  #include <linux/string.h>
> +#include <asm/local.h>
>  #include <asm/page.h>
>  
>  void undefsyms_base(void *p, int n);
> @@ -18,11 +19,13 @@ static char page[PAGE_SIZE] __aligned(PAGE_SIZE);
>  void undefsyms_base(void *p, int n)
>  {
>  	char buffer[256] = { 0 };
> -
>  	u32 u = 0;
> +
>  	memset((char * volatile)page, 8, PAGE_SIZE);
>  	memset((char * volatile)buffer, 8, sizeof(buffer));
>  	memcpy((void * volatile)p, buffer, sizeof(buffer));
>  	cmpxchg((u32 * volatile)&u, 0, 8);
> +	cmpxchg((unsigned long *)p, 0, 8);
> +	local_set((local_t *)p, 8);
>  	WARN_ON(n == 0xdeadbeef);
>  }
> -- 
> 2.55.0.1082.g2b9226bbc0-goog
> 
