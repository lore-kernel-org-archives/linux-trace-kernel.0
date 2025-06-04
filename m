Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7EAE1EFFB4;
	Wed,  4 Jun 2025 20:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749068928; cv=none; b=VZsu3ws0Rd9wHPtfsTNQuUGbcIN94iKe2RJiailKf+rUxyhhu/oTTb2F8wpgzQMTx6SxjXcMTh++zzBV7c0cc6AMEenZt6A1jHtY5dueLRYOVwaH1BF24MRfy3jjmc6c/epeXU85enpNRRs9L8/csruDJ9Z05IQRRQCoXK18keg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749068928; c=relaxed/simple;
	bh=noyam5GWaPL2awf00IN/m5bJjrgDJ9mecS+8d1HpfEU=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mFHMivXKMQKrJfHRTR13L9E8+rBDKT83R/1mptCbFNEsR4PVJg/OQRSlB+/WK5BqHx7V88Qo2bPXCuDxyPH6KLQzNmKxKnU70Mip8ceVu2/4GoCKE3Dk95myqXbi7fNpDmB+pItSYwkAURU9p/ob1bjosIZzmgIqhwMF2Wdwl6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=crxGOUIv; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="crxGOUIv"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-442eb5d143eso2050655e9.0;
        Wed, 04 Jun 2025 13:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749068923; x=1749673723; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QW72yX/segTSFEPF3mC1QtZj7iNoXgPG94wFfxNFQLE=;
        b=crxGOUIvUxBkfjE7xCpO1rA0ahqfa+eyUBYpZkzMGkH2o0XpCn7+xE3SzY/PlkV0IJ
         3b5eTCuBC8koxkFimJmK3BohKENWlOVqsYj5coKUcVPNlurbYaI8LFB19K9PmZxC9Utj
         cOKCtYVLq1q4knkHij/AXOQPor/r+Wh8HDV81/XX67hB66bT/yUss4WSOEgHUVS9ZkX4
         RmuaTI1YgIxElKtCwpRYZ9A/76Y7Z1KlyC33bOiMpheU6pwboQ8doDkTr/vd/48hAfzL
         RZsG2q2nkvVOL8a0e2Oif2Bxfb5dn0atb2fl4chK1ILUOT9y2v7DDMRovjg489/w9xob
         bfGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749068923; x=1749673723;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QW72yX/segTSFEPF3mC1QtZj7iNoXgPG94wFfxNFQLE=;
        b=IJKe00I9hV6cOF48HTuFb2F/a0MyDZCyVTjCLAaSQbNR8XSI6SyTM4x6Nkq7/9A38u
         LNVI5FCR/Ohj+5k9x/eb/grdUmT1SwlAmgFRfGN0PsHLMzIuq4IQU9LstdRsY04pJ7nw
         J2V0rJ3Uu/UFTPaGQ51hKSyrTwapvUaRSPpi4Z2rh+ycqZpZzPDHPpsYiEL1whMSXVGc
         KLfS7guAMABlgX6HpJT2D7XmlumgHMOkOG5gy5MNHAxe0AuB2L5vnAHWlGWWK8nQUN1m
         WNlS32ufMMBZEACKG6pie6bFN73cNVQGIktMV77m5khXi56z8oFymdkMpsjQiJ1z5sQl
         0y4w==
X-Forwarded-Encrypted: i=1; AJvYcCU/kuJBgfKe2HarO91ygqdsoaZrzcwySkQdrmifgR+pbNNMIBFlkAgqDGda2En7xKEJW4FnJqDp8j8RiNrLtVHXlHZR@vger.kernel.org, AJvYcCV/Y8BAoHUpImFNNkVoK8tqZeC0UJZ7JL1uIONPj7Ryndk5XyHrWl9JlVev6gA67qUrHwX7nNYI8s7+LiM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDb8cay/uUUazY/i0a21smZMPh9mnXfvOV3+I4tIFv+D1Xd1D/
	xAJS22PHsZ54yvJWAnqk21XreB4uvg5e9TusS4GvapdofeH06y2ARd4i
X-Gm-Gg: ASbGnctINnpQj3EKiWNNh9/OdDmhmUmXJ4oXdpHElWmk941PYXhA1uuTQo1YoeMHi5U
	UKX6HgWPKdgmSV/VZlV+zBvdvnZGxRfDxzMUT5W0O/25WCE8RCnfHPFSGVsZJ8E7/FsvhXbCDXG
	Rah9bADewCgD65dp4bJVAIP3y1fm7hGoZHJArE3UVtEqnpY5s2QeDZD/XfXGGaOf7pyN3F4SKMR
	IUq5M825GFbKmnAjq94SceJfFpU9a11MeWCUPc5VHTiXMp9xhIc4FeqI2V3qfyeM9AzRjvLLYIx
	dwImHajX7r1hSa5B37NXaHa3FsUGk5Dfmbcc/kg=
X-Google-Smtp-Source: AGHT+IEElTJGssICYj7R0432JA0UzKCUEw6TsKcBq2S54rvmxU0XesAbC/jm6oKubwGU5uu6u33pIg==
X-Received: by 2002:a05:600c:3b2a:b0:450:cf00:20f5 with SMTP id 5b1f17b1804b1-451f0a73c20mr41659365e9.9.1749068922631;
        Wed, 04 Jun 2025 13:28:42 -0700 (PDT)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-451f999a3c1sm1629065e9.6.2025.06.04.13.28.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jun 2025 13:28:42 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 4 Jun 2025 22:28:40 +0200
To: Masami Hiramatsu <mhiramat@kernel.org>, Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>, g@krava
Cc: David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCHv2 mm-stable] uprobes: Revert ref_ctr_offset in
 uprobe_unregister error path
Message-ID: <aECseBOkQynCpnfK@krava>
References: <20250514101809.2010193-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250514101809.2010193-1-jolsa@kernel.org>

On Wed, May 14, 2025 at 12:18:09PM +0200, Jiri Olsa wrote:
> From: Jiri Olsa <olsajiri@gmail.com>
> 
> There's error path that could lead to inactive uprobe:
> 
>   1) uprobe_register succeeds - updates instruction to int3 and
>      changes ref_ctr from 0 to 1
>   2) uprobe_unregister fails  - int3 stays in place, but ref_ctr
>      is changed to 0 (it's not restored to 1 in the fail path)
>      uprobe is leaked
>   3) another uprobe_register comes and re-uses the leaked uprobe
>      and succeds - but int3 is already in place, so ref_ctr update
>      is skipped and it stays 0 - uprobe CAN NOT be triggered now
>   4) uprobe_unregister fails because ref_ctr value is unexpected
> 
> Fixing this by reverting the updated ref_ctr value back to 1 in step 2),
> which is the case when uprobe_unregister fails (int3 stays in place),
> but we have already updated refctr.
> 
> The new scenario will go as follows:
> 
>   1) uprobe_register succeeds - updates instruction to int3 and
>      changes ref_ctr from 0 to 1
>   2) uprobe_unregister fails  - int3 stays in place and ref_ctr
>      is reverted to 1..  uprobe is leaked
>   3) another uprobe_register comes and re-uses the leaked uprobe
>      and succeds - but int3 is already in place, so ref_ctr update
>      is skipped and it stays 1 - uprobe CAN be triggered now
>   4) uprobe_unregister succeeds
> 
> Fixes: 1cc33161a83d ("uprobes: Support SDT markers having reference count (semaphore)")
> Acked-by: David Hildenbrand <david@redhat.com>
> Acked-by: Oleg Nesterov <oleg@redhat.com>
> Suggested-by: Oleg Nesterov <oleg@redhat.com>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

hi,
I can't find this in any related tree, was this pulled in?

thanks,
jirka


> ---
> v2 changes:
> - adding proper Fixes tag and acks
> 
>  kernel/events/uprobes.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> index 4c965ba77f9f..84ee7b590861 100644
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
> @@ -581,8 +581,8 @@ int uprobe_write_opcode(struct arch_uprobe *auprobe, struct vm_area_struct *vma,
>  
>  out:
>  	/* Revert back reference counter if instruction update failed. */
> -	if (ret < 0 && is_register && ref_ctr_updated)
> -		update_ref_ctr(uprobe, mm, -1);
> +	if (ret < 0 && ref_ctr_updated)
> +		update_ref_ctr(uprobe, mm, is_register ? -1 : 1);
>  
>  	/* try collapse pmd for compound page */
>  	if (ret > 0)
> -- 
> 2.49.0
> 
