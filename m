Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84A793EBF2F
	for <linux-trace-kernel@vger.kernel.org>; Wed, 27 May 2026 09:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779875834; cv=none; b=AaqS2qe3W64tbUrc5wB65IKW7jsUCNy+FmmzuzF6hwmA8AmgWsEkXaxgWyqQzbJ5jHmyUl8ptNooSxQBj3vekhDiAI8N128CrpOg8tHalbFlIcnOXBJB4ucg36yYdTKzudfZOf+Y5dpAwi5jQH9eth/FylgrpFPSMFQhi/nwD8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779875834; c=relaxed/simple;
	bh=Tuai1Axfjkxum1GztuUcohIb7OIi67bbFU7uLGV2pY8=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jwWtFC//jos9lqHWzRuf/65oErfEoZgMdlgFyv5bzA9P4wfGR2QZ2i1T8UORWHCxAS9blIzAdUztt2aF9jA3l2hCvrjro6jsXfVoVRG+AtspyWk9UTSixdegr1xNTWLcryMbbg9p5ceixY8kycXaxNHSev6tQbmjVh5935bCLeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kTjMV1y1; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kTjMV1y1"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-49056b9f04aso51828905e9.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 27 May 2026 02:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779875831; x=1780480631; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XuaoXI5CN/vWA5ZvTeay7KhFRspk+qd3be2g4mt/zXc=;
        b=kTjMV1y1zqPnyl6QajXeHnlLCnLph+IccY66NKXzp9VWpwtkabUzQA5sbthZHTE/T4
         exsAxdpphFY1OOn7qaNH5tYADUKlYO7YkvMg2Pe6XyhuwCivGyv66QPcBR5mhXEvJjyD
         Snug2jFR6E/cCSPsKMiKQkAxIipfwVc40D1rUmHekng9kytALn+p+IZwv4LOboYKeH1Z
         xq4MB9x68YJe9RhqOsZsOSCnxrQeNdq9kSTUTmhHdfzULRlZmpS2sWm42XP5Z9xgXfNn
         nPmgUIZ2ua8rlf9lH6xHpUrlf2P/TdcdWVjdk6cQYk+jDg2ETwzDXOeFJZ4sSy1qLh/8
         rZ3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779875831; x=1780480631;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XuaoXI5CN/vWA5ZvTeay7KhFRspk+qd3be2g4mt/zXc=;
        b=VLpYbVKCtAQNETdbCMAxLEVDBmn0jyeWAii6HrFsnaN03a3bmKWBXnYX/kZiDNMCRy
         zLm05j8SW0iCzllKwoZxGsBPeNFuR4qoYT3jC6OHm6GgVEPpxMSAXa7RSjJytz0Z4wto
         Qp9/H+4HFUb9Hj0RqZizmJFlcNVlnPYOpOOZO3u3UsBIAvHV4w2geUQVVqvOQkHERA9m
         P0vNwLg+OoVVUOO6WcSG050O7eqWh/DLuY470U2c/3SOlvVZkUp+qJ+iCbIhSxIeUj1E
         GTTndwdWlS0sIJ5w4RfYMXLMpc/3ROvV80yqYP29tn7NFhdbG805sxCp7sDZp/MpsK4c
         MsLw==
X-Forwarded-Encrypted: i=1; AFNElJ97TqDZHUDE9WiZDWpM03oPpixjRPIWxUdLOz/wxxw1Gshs7hCZb+AB/k0eoUiGyIQ+cXigP3fk9KsznYK/DzqruhY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6uNLCTef3kikBo3fZ5tV3Qr/DRBkRjaj8/1N226CHAbO4MB9J
	5L8qMqB7y1FxpzsbNhQjm+Woc5hFolBsVpI++skSox9EprL5Gwr3FUth
X-Gm-Gg: Acq92OF+FfVAStP3ilHZmMzCKDVkgbmsh5tqU2Oq6Lh716eyoOjcJlIq0n3bXgmu7gN
	EDuNRzLqhWvhXHBifFEA94ZyKNWCUhs2gkG5jZ4GBDBRLQqLX+5atoYpGQbSwrEJbIvbUCzdg9z
	j5ui/9P6pCZWDl25J37/trK4tfO3luAEOa8xvbxPxC+94K/5+38bpFQF6bja2/wlQm6G93gqcA4
	BT3I9psRfu45cUoWFS9NGLnbiTz4/oF0ASqL4HoPRnosMN5ay8glHBk0ynK13zLIFWYyVxR/zdu
	1BzdBoissJcKPOWGi9swUt0DubqSBOib8ltlfJCEg3zL01mOHSEMocvbcz2BIqHuI1/aVoKvSZS
	tK48XNfHYVLA8laWovbzndwazvqcWu3IIXMfA3Ap4opb0EXWdigzoP4a9UyxjBpCJCGkavGBHW+
	s1jbGQ0cJExCYl73e3Q+Fcdr7IrQ==
X-Received: by 2002:a05:600c:4688:b0:490:4224:e0a2 with SMTP id 5b1f17b1804b1-49042ae265bmr385107545e9.33.1779875830564;
        Wed, 27 May 2026 02:57:10 -0700 (PDT)
Received: from krava ([2a02:8308:a00c:e200:b655:ff13:e355:16a3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45edb54a6cdsm4845867f8f.2.2026.05.27.02.57.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 02:57:10 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 27 May 2026 11:57:08 +0200
To: bot+bpf-ci@kernel.org
Cc: oleg@redhat.com, peterz@infradead.org, mingo@kernel.org,
	mhiramat@kernel.org, andrii@kernel.org, bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, ast@kernel.org,
	daniel@iogearbox.net, martin.lau@kernel.org, eddyz87@gmail.com,
	yonghong.song@linux.dev, clm@meta.com, ihor.solodrai@linux.dev
Subject: Re: [PATCHv4 04/13] uprobes/x86: Unmap trampoline vma object in case
 it's unused
Message-ID: <aha_9GF7AYzVRSsm@krava>
References: <20260526205840.173790-5-jolsa@kernel.org>
 <addf3472e04583c864492a9343420c1e0356b324b4a84a71145dd759d8ec367d@mail.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <addf3472e04583c864492a9343420c1e0356b324b4a84a71145dd759d8ec367d@mail.kernel.org>

On Tue, May 26, 2026 at 09:46:49PM +0000, bot+bpf-ci@kernel.org wrote:
> > commit 68883203f0583fb1a8d79536f5c8945542974abd
> > Author: Jiri Olsa <jolsa@kernel.org>
> > Date:   Tue May 26 22:58:31 2026 +0200
> >
> >     uprobes/x86: Unmap trampoline vma object in case it's unused
> >
> >     In case the optimization fails, we leak new-ly created trampoline
> >     vma mapping (in case we just created it), let's unmap it.
> >
> >     Fixes: ba2bfc97b462 ("uprobes/x86: Add support to optimize uprobes")
> >     Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> 
> Should this Fixes: tag point to a9fe6f54968c instead? The vma leak bug
> was actually introduced by commit a9fe6f54968c ("uprobes/x86: Remove
> struct uprobe_trampoline object"), not ba2bfc97b462. Commit a9fe6f54968c
> removed the destroy_uprobe_trampoline() cleanup call, and its commit
> message explicitly states: "The new vma leak is fixed in following
> change."

there's no a9fe6f54968c hash yet

> 
> Suggested: Fixes: a9fe6f54968c ("uprobes/x86: Remove struct
> uprobe_trampoline object")
> 
> > diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
> > index c8af41ed681a..af5af7d67999 100644
> > --- a/arch/x86/kernel/uprobes.c
> > +++ b/arch/x86/kernel/uprobes.c
> > @@ -677,11 +677,14 @@ static unsigned long find_nearest_trampoline(unsigned long vaddr)
> >  	return high_tramp;
> >  }
> >
> > -static struct vm_area_struct *get_uprobe_trampoline(struct mm_struct *mm, unsigned long vaddr)
> > +static struct vm_area_struct *get_uprobe_trampoline(struct mm_struct *mm, unsigned long vaddr,
> > +						    bool *new_mapping)
> >  {
> >  	VMA_ITERATOR(vmi, mm, 0);
> >  	struct vm_area_struct *vma;
> >
> > +	*new_mapping = false;
> > +
> >  	if (vaddr > TASK_SIZE || vaddr < PAGE_SIZE)
> >  		return ERR_PTR(-EINVAL);
> >
> 
> Does this fix address the VMA leak scenario across fork chains? In v2,
> sashiko-bot raised a concern about inherited-but-not-tracked VMAs:
> 
> https://lore.kernel.org/bpf/20260518114208.CE128C2BCF6@smtp.kernel.org/
> 
> When VM_DONTCOPY is removed, child processes inherit trampoline VMAs
> but their tracking list (mm->uprobes_state.head_tramps) is empty. When
> the child executes a uprobe, get_uprobe_trampoline() fails to find the
> inherited VMA and creates a duplicate trampoline.
> 
> Child fork:
>   dup_mmap()
>     copies trampoline VMA to child
>   mm_init_uprobes_state()
>     initializes head_tramps as empty (parent's state not copied)
> 
> Child executes uprobe:
>   arch_uprobe_optimize()
>     get_uprobe_trampoline()
>       head_tramps is empty, fails to find inherited VMA
>       create_uprobe_trampoline()
>         find_nearest_trampoline() finds new unmapped area
>         installs second duplicate trampoline VMA
> 
> In a deep fork chain, each generation inherits all previous VMAs, has an
> empty head_tramps list, and creates a new VMA. Can this cause linear
> accumulation of redundant VMAs, eventually exhausting vm.max_map_count?
> 
> While this patch addresses unmapping failed optimization attempts, it
> does not prevent the inherited-but-not-tracked VMA leak scenario in fork
> chains.

there's not head_tramps list anymore, was removed by earlier:
      uprobes/x86: Remove struct uprobe_trampoline object

jirka
