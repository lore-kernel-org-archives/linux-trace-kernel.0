Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3831219067C
	for <linux-trace-kernel@vger.kernel.org>; Wed,  1 Jul 2026 09:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782898131; cv=none; b=aI/07d8jiib/nEjbf9yTzPr4MtPXmQn4MYFxBjkL8VK8N8LscDu+mUMhk/jDSew0Fid/y8lvEZV+geRXpI7yX+YfBmHPOC31PMS6BLB70ukTtKlLZz6AQtFjSgp1x5paInWyOr5LRVh4/HE3baf2SgrUOOUOS7DW7vmnmc8ZJJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782898131; c=relaxed/simple;
	bh=sr0k1d1NhOQsip+Xzw0s2NcwtVXRJi62aNuS+q9S+Lo=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lcZmwdYi+kOunRN7aeSfRdlnNTCN68xvDlrDpaHJIAYDc/t7rbq9vVghrdVNSm/MDP68HzgQB/x//Hj8uCNy3u0uu4Nm2x+o5OINghG6WVEdQrE1B5x1ne/9ekN3VX4DHjqUbBsj944wjZrQE7E3IpAdxwkhXmOBlRHwL3abwF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CZ7r5S5U; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CZ7r5S5U"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-493b7612475so3178505e9.3
        for <linux-trace-kernel@vger.kernel.org>; Wed, 01 Jul 2026 02:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782898129; x=1783502929; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WRbki0GQJaNcrLB+xSEtBVJukwNO7EFac3s8dHYCr9w=;
        b=CZ7r5S5UNRmpk5PlKtQBEKFvqhqdkp8khWB8PafjLFtsozmXve0SVY+rMB16/w31sy
         0nXYbMEE+oX7dpjce5d31oIEX+wX46u33UYjsbWJoPpMoIYMq+VJ5RotQd38zYQSqkzs
         R+aLMS0TYMFiyZZb9eNg3rVbJ6vECJ9QDDeXqF5G9pBbyu78fJ2d7Lv30FKapZPaIU9k
         nWV0ngsXCOieVZFi37+HzOY12yfqJimsrM7mBsa/TGW1pYUWkjf3SIb8IoO8QOe/S0Pj
         tNWd/o9UaTfTr81aXUsE+HwpRczSCeHN5A19TfqJFQPOu4ssiATUOpl9C+wZH7Yf0/iR
         H+1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782898129; x=1783502929;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WRbki0GQJaNcrLB+xSEtBVJukwNO7EFac3s8dHYCr9w=;
        b=J60dWcLYYyEL4ahpKPnfNyYZplOnvW7YQ3v1SgJYPlnPN/5daOhXVrESF1ivKTvlMd
         4x/npaZBWb8mzA0qnNjbow9F9X0A5FP835hrxms5PdWsQ3zvkV6CeY9s24kND4Jo7owq
         QFULsVQOn2PKyuzJ/RaOzW8Jr99M+RB424QnWLPFudW5zOb9pZmlk2rQ4rnMyPopuFOH
         JyZ6DQJibrjHHk8VvpLzkATpS+B/sADKN8Su6iQgOQOb9c3kb21JfHZDvV95ks/H1J/i
         wqcRyXbJpdkEkW7c+EPDFAEFBQqJgPPaXQRy1JvNnTos+CFrC8qwpHwCJ6OcFuAJiY22
         s6YQ==
X-Forwarded-Encrypted: i=1; AFNElJ9ahz5kWqkAxYtVqSLqLKAs6r/BwvYStROwte41lTBm+w9eAomQGImp77TKQpllXAqqwIKU6dOsC/EWSquN3hDO77U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1e/4kjv8AWNhqXaUGcdaWtFea57R2Xr5u99KqHg2XksiEYIvS
	GtUonlOtilYIRzWGar47S25I77wuMKm9V8w1FgPPwZFKE6T7bhNWNoua
X-Gm-Gg: AfdE7ckyXVWrczOompGqoCushExLNzNzT/xIw7G1cIIw6+aRHrTTs87MUV4DarXufqo
	uouRrxdSVe1/eo6jIwlp2KsN2ZrOEFf4Tt/fw+RYxZQnMC4a9AwcFFQOBVZmj1E/YcCMYREFN1S
	D6sncrZradhQq8565Vd3QopnTWo0zEYnLXeaK0XGKkYr36J5LOhrbLAGelErt3ZqZ150Sqdwpnd
	p+QbdzdYvCOCrM6X/0LdG9HWN4pqxz/L9KtardNBihRPAsmOvf9kaN+4DkbWMRDvNaUw6r9FtbB
	WS1WvZS+A5kug6WnFssYql/I12USJI0LsURq9Nti4PBnT910znA5rZrAqWn5LQ78nO+67/e0Uo1
	hxBPkQGMRSO8tSEvAEpEuszBpr/RsvejUnv8gyOpKZwiO7ySPr80hgYGkob7B1quB24bd9Q1tN5
	ZB4gNdAn6aHfwQpQQcc3+rEC3u
X-Received: by 2002:a05:600c:8117:b0:490:688b:f9f8 with SMTP id 5b1f17b1804b1-493c2b99aafmr11244445e9.27.1782898128375;
        Wed, 01 Jul 2026 02:28:48 -0700 (PDT)
Received: from krava (37-188-177-177.red.o2.cz. [37.188.177.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493be810be8sm58292775e9.9.2026.07.01.02.28.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 02:28:47 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 1 Jul 2026 11:28:43 +0200
To: Oleg Nesterov <oleg@redhat.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCHv4 02/13] uprobes/x86: Remove struct uprobe_trampoline
 object
Message-ID: <akTdy5EX9f5D2Tql@krava>
References: <20260526205840.173790-1-jolsa@kernel.org>
 <20260526205840.173790-3-jolsa@kernel.org>
 <ajvrZ_mMXnKrWf7h@redhat.com>
 <aj0veiIdtp3YcKyK@krava>
 <aj0xonQHcEQgIi77@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aj0xonQHcEQgIi77@redhat.com>

On Thu, Jun 25, 2026 at 03:48:18PM +0200, Oleg Nesterov wrote:
> On 06/25, Jiri Olsa wrote:
> >
> > On Wed, Jun 24, 2026 at 04:36:23PM +0200, Oleg Nesterov wrote:
> > >
> > > Perhaps we can later optimize this code a bit? I mean something like
> > >
> > > 	start_reachable = ...;
> > > 	end_reachable = ...;
> > >
> > > 	VMA_ITERATOR(vmi, mm, start_reachable);
> > >
> > > 	for_each_vma(vmi, vma) {
> > > 		if (!vma_is_special_mapping(...))
> > > 			continue;
> > > 		if (vma->vm_start > end_reachable)
> > > 			break;
> > > 		return vma;
> > > 	}
> >
> > looks good, will try to use that
> 
> See my next email, we can use for_each_vma_range().
> 
> But let me repeat, we can add this mimor optimization later, I don't want
> to delay this series.
> 
> > > >  static int __arch_uprobe_optimize(struct arch_uprobe *auprobe, struct mm_struct *mm,
> > > >  				  unsigned long vaddr)
> > > >  {
> > > > -	struct uprobe_trampoline *tramp;
> > > > -	struct vm_area_struct *vma;
> > > > -	bool new = false;
> > > > -	int err = 0;
> > > > +	struct pt_regs *regs = task_pt_regs(current);
> > > > +	struct vm_area_struct *vma, *tramp;
> > > >
> > > > +	if (!user_64bit_mode(regs))
> > > > +		return -EINVAL;
> > > >  	vma = find_vma(mm, vaddr);
> > > >  	if (!vma)
> > > >  		return -EINVAL;
> > >
> > > I guess find_vma() can't fail, the caller arch_uprobe_optimize() has called
> > > copy_from_vaddr() under mmap_write_lock()... Nevermind.
> >
> > hum, how's that.. I'll check, but where's the magic? :)
> 
> arch_uprobe_optimize() -> copy_from_vaddr() reads this mm at the same vaddr,
> this means that vma at this vaddr must exist. Unless I am totally confused ;)
> But even if I am right please ignore. I just tried to understand if find_vma()
> can fail or not here.

ok, will leave these 2 changes for later

jirka
