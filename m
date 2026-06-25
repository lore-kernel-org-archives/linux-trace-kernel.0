Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 120CE3328FC
	for <linux-trace-kernel@vger.kernel.org>; Thu, 25 Jun 2026 13:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782394752; cv=none; b=lZqC96OJRBd78Z/VPv3zvSijpS5k3O9i0pl59ExH656bW3/auAtYDzWmzROCBGzk3a5Zrqu4Oq/2R+hVRbfGoe2gx6hA2Re5UKLNCsCZuCLrBGKo9q47k/8nTJnHXx59hBT9VNqVn3KjSQJoYy0vfnpbniD5UohLal/KFku8RPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782394752; c=relaxed/simple;
	bh=fysN+GwPFKdZUBFXeRcuQzcnn6PJj6IHgd/eZHDDDuE=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E/cdhufsKilSryuwP8p1zjXukDJj3zg9BRyLqRxSTv2l9ZbtiffAlwF2hTt+dCSg717eamEYqOjIVgLZjDjpMyvwU3dD8BzYasoRlgivSwVietFDtAq4Jo7eSkFTVdoQx4WA4e28gH41GFE1dajfwxB4SMpWC6Q7e1OxPtyqORQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DC8o0uV+; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DC8o0uV+"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-490b211ee6aso14557525e9.3
        for <linux-trace-kernel@vger.kernel.org>; Thu, 25 Jun 2026 06:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782394749; x=1782999549; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qQEwvq/5iOL5LCOfs7e9AqD+RJGtM5zn47GPJywSjW0=;
        b=DC8o0uV+6lVxnjVNRsdUnh3fwMKEe6EJEyLVzGVk0CrAC2xdJLqf82134fuUKQW3rB
         /AwjPj7Q8qITQntZbPbmLZNXVA/KD394cB9DBsxy/Q1gD94FnK10thnsVFYbHEUBus/t
         KTHrT1KhRgfmQ+W5MutSqHjSsuHMH4YUqKs6cl6FjES+xhtsqv1z5774/Low2nxGMffT
         fyCc49jC1HmGR/rIA9uE5j8oeWNw+p2gSCIwgq3q2/oRyj/wxc5nf/pvrihA82YBAXEe
         x8uWN68h3XoucJCc+YXsBKWa7C4gDRwn8rOQ1ryQnApdcu+ha9SCFR7ngB5jcU5ODgLY
         iKyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782394749; x=1782999549;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qQEwvq/5iOL5LCOfs7e9AqD+RJGtM5zn47GPJywSjW0=;
        b=QQbgLgNMclNThaLYKU5w5sO8vNDJPbRk9IGfYDCIp3t07/Op111t+/6r6pTRTd7oGj
         EJmDeY6S2Yk/DdtThnVw5mTGHNfD6wNEcrXVQMDhlXikqgdUyN3GyRZW8yGR4YS0brDy
         1BuG7VKtjO9YEn1TCuXYi9TbToH5Zwhh6uhr5dntL/zJ5AruP7vj+Cxt2F6ZfAviAUo0
         LoY8bfFMdJXQqhsAadKPgSweRK8m4IX9UOizxYnshZb4XqZ76jlwA0xV0g0Y43ZvWCq+
         FPrdCmVVc++z1GI+FbOVQkw0EixIHvA0mbqfSA8pUZzN6+ENeZiMbFMqFNR4a+Vz1tWe
         /3Kg==
X-Forwarded-Encrypted: i=1; AFNElJ9BC3H+jH9WBOKncVBq8i+OrmQ2iAJFMnAzaJADMBiDZZc9RN12XDwEh0qBeFWzphjzXFyXve9aSx7o+ZTAwLBOBXI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCR3IbSw0GMIn/6vSOVjI6ax2K3Zw6XcL78+ZzrhIgxdYpnRbM
	EzMimUsgtSqDiu705CnEyzR5gfjdpPHneCeM+KeYo0/PH54ykfnpeevT
X-Gm-Gg: AfdE7cnFr5vjC7PJ8vd24LDlyqDnWq/sO82YZ6Ej5WIoAiRFKT42TVU526ihVtS3Kp5
	oG6fnTck9DslMTsmz/mcJ1VhUAiwBHD25ZYRUSxHSMbIDOU2RSje87bUNraZTUlzzQNlIiHV+3r
	melWtQXmKuansFgY7gZd8yuu3OtS18kTGpLvrendhDixF8V/G6DM2apmECYJCDHl5L97Pmyonbv
	cP7LtB97uNepYq0zTWnyabRxot2wUTJg0ZWnmfQKNqMbCd2THoBx1xziDPxItgZphLxqZEg5iPQ
	nImwsdI89yc9eFwhMktazmuuXeRfvhkC5/vo3PSGtk4wz16mOruoPVDYbPPMQoRBA9ngfZQazlK
	T3yPzigNocEIRxxIdir00k3wf7aZUKLufOvN6sMvYB9t5XKgxfWBVYeCUu2cYIVwaSMM/rK+omC
	bitFIw
X-Received: by 2002:a05:600c:848d:b0:492:5145:f054 with SMTP id 5b1f17b1804b1-49266893222mr34056195e9.26.1782394749135;
        Thu, 25 Jun 2026 06:39:09 -0700 (PDT)
Received: from krava ([2a02:8308:a00c:e200:b655:ff13:e355:16a3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46d3b59cef1sm9011861f8f.26.2026.06.25.06.39.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 06:39:08 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 25 Jun 2026 15:39:06 +0200
To: Oleg Nesterov <oleg@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCHv4 02/13] uprobes/x86: Remove struct uprobe_trampoline
 object
Message-ID: <aj0veiIdtp3YcKyK@krava>
References: <20260526205840.173790-1-jolsa@kernel.org>
 <20260526205840.173790-3-jolsa@kernel.org>
 <ajvrZ_mMXnKrWf7h@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ajvrZ_mMXnKrWf7h@redhat.com>

On Wed, Jun 24, 2026 at 04:36:23PM +0200, Oleg Nesterov wrote:
> On 05/26, Jiri Olsa wrote:
> >
> > Removing struct uprobe_trampoline object and it's tracking code,
> > because it's not needed. We can do same thing directly on top of
> > struct vm_area_struct objects.
> >
> > This makes the code simpler and allows easy propagation of the
> > trampoline vma object into child process in following change.
> >
> > Note the original code called destroy_uprobe_trampoline if the
> > optimiation failed, but it only freed the struct uprobe_trampoline
> > object, not the vma. The new vma leak is fixed in following change.
> >
> > Acked-by: Andrii Nakryiko <andrii@kernel.org>
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> 
> Reviewed-by: Oleg Nesterov <oleg@redhat.com>
> 
> ---------------------------------------------------------------------
> Although I can't convince myself I fully understand this code with or
> without this patch ;)
> 
> A couple of questions below...
> 
> > -static struct uprobe_trampoline *create_uprobe_trampoline(unsigned long vaddr)
> > +static struct vm_area_struct *get_uprobe_trampoline(struct mm_struct *mm, unsigned long vaddr)
> >  {
> > -	struct pt_regs *regs = task_pt_regs(current);
> > -	struct mm_struct *mm = current->mm;
> > -	struct uprobe_trampoline *tramp;
> > +	VMA_ITERATOR(vmi, mm, 0);
> >  	struct vm_area_struct *vma;
> >
> > -	if (!user_64bit_mode(regs))
> > -		return NULL;
> > +	if (vaddr > TASK_SIZE || vaddr < PAGE_SIZE)
> > +		return ERR_PTR(-EINVAL);
> 
> Do we really need this check? It looks a bit confusing to me...
> vaddr is bp_vaddr from handle_swbp(), it should be valid?

true, will remove

> 
> > +
> > +	for_each_vma(vmi, vma) {
> > +		if (!vma_is_special_mapping(vma, &tramp_mapping))
> > +			continue;
> > +		if (is_reachable_by_call(vma->vm_start, vaddr))
> > +			return vma;
> > +	}
> 
> Perhaps we can later optimize this code a bit? I mean something like
> 
> 	start_reachable = ...;
> 	end_reachable = ...;
> 
> 	VMA_ITERATOR(vmi, mm, start_reachable);
> 
> 	for_each_vma(vmi, vma) {
> 		if (!vma_is_special_mapping(...))
> 			continue;
> 		if (vma->vm_start > end_reachable)
> 			break;
> 		return vma;
> 	}

looks good, will try to use that

> 
> >  static int __arch_uprobe_optimize(struct arch_uprobe *auprobe, struct mm_struct *mm,
> >  				  unsigned long vaddr)
> >  {
> > -	struct uprobe_trampoline *tramp;
> > -	struct vm_area_struct *vma;
> > -	bool new = false;
> > -	int err = 0;
> > +	struct pt_regs *regs = task_pt_regs(current);
> > +	struct vm_area_struct *vma, *tramp;
> >
> > +	if (!user_64bit_mode(regs))
> > +		return -EINVAL;
> >  	vma = find_vma(mm, vaddr);
> >  	if (!vma)
> >  		return -EINVAL;
> 
> I guess find_vma() can't fail, the caller arch_uprobe_optimize() has called
> copy_from_vaddr() under mmap_write_lock()... Nevermind.

hum, how's that.. I'll check, but where's the magic? :)

thanks,
jirka
