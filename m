Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 468FC2609EE;
	Tue, 13 May 2025 13:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747144106; cv=none; b=gTnD1Xyk2MMzV+BYu6aNpbReA6UOwg2Xz63aLMJLiMugn2NywYOPs+1Q8bGiDe1nGJnsh9Pi3kR/Ikct4e9/gFvtheovQB0Kax/y/QBNPXc9UoKVFrKvZyzK0IizfMMk3bdMI9MHq/hE6xiEunHay7NdqnWzhN1aFbctOTFPhJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747144106; c=relaxed/simple;
	bh=kVifG9CfR4unLk5n/PTpvrsJpqog9P9M+eQR7NcAm78=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eyfBEQ5k6yY7mIHTqJTYqCIOu+7ddgkS9TQ6eG3cxiw5AwoO0iTq6RQUbiqBgJBxQ/0W6z88Q6ztkg/CUzRvf9WXhwDyXPeobfLFQ6llbLOyy9EoAgVndh1uD2tB+nNH2bRrH2baceq1dSMBC9iRSrzavQ8GCkxRPnAx9Xio9ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hKqWZhT9; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hKqWZhT9"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3a0bdcd7357so3916628f8f.1;
        Tue, 13 May 2025 06:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747144102; x=1747748902; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Q5dBi2Ve1Ok5KJwca299O8xdGqWqPW+y1Ffqh5dB8LA=;
        b=hKqWZhT90OlKDHH4YwdKsvRgvi4wgmVC0mtTN8Q2W/ZMnBUleH/CNn54kINFc042GG
         M6w9CHfM36yuVomE/yZkJzuKv/WJqAgoAjrxLPuy3maNAoMgoMhhknwaEc6+WgQd5w1Y
         Zbzec8xEKqdYD7QNUh66kYVeftYxZyyks9K0GA9ZZdyYI4WlfkZo6OvzrubfHSbHtVJu
         3m38hmezvOuP/RKMNFxK8h0p2oPTDYhm8vQfk4eoh7KQABLPoXldC28j/fdavYbI5gio
         0W2EWf3XYYIcYhIPmVrpd7KjVbQgY81iQRKUcWwcmWzQk1D4vXwx5PuIw5pptcnkpktd
         aSyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747144102; x=1747748902;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q5dBi2Ve1Ok5KJwca299O8xdGqWqPW+y1Ffqh5dB8LA=;
        b=TrmfVIFgd9uF8zGeHd16FSPjhyVJhaK2LULbKmrlep6MpZreDlsD8cpM/pXVzOMAJl
         xgxbf8tv0ytP7TkLwGzEVJiDefc2qEGSfRlv5Yt6gCfTnRoxJ0/Ct6mpH0tjFhEdLN2m
         4ZnJjkG5iU0yWB4hkzLfxTwBN4eMmHec0rd2M2nyolKHQq+zUDTZ5gVZxBDv1TbP7vra
         SIqL4DUyowz1dm+CFy0tkloxdcHn7pQ3n0WT2ccSdTT3EGeKRRErowutIZOgDCU/9YKd
         U0ITT08Dt2wKPUzDS1xiYexsGbiQZa+KaJL1wWoOKrcW4GW8Fniy6KVAxffOaXNot+SF
         qlqA==
X-Forwarded-Encrypted: i=1; AJvYcCU38096jRIrhuiwZ4GUawjbhXmyQFyTK/Yq+5vFr67rlTBVnBBQtZ/UsKRwAsirVDAquHNvkZdxdXO22lEpV0clv7b8@vger.kernel.org, AJvYcCXjs5APtKVkWrsKkJiNbqZlePvpAOWAd51TZnXF0WXSfbAFfA1lmTL/h5goAvbsb/wgIE7cVaoSCsJ5pYs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoggQ3PuR4QaHNqJkwljcYOCAZkIoqkSvHZLuXdf8V7tjZsyiH
	zeA9mKs6B70hmYh1lwOEjzszGbkOlC5O51BE9TqT4uLLyA+z/gHu/47s2bZD
X-Gm-Gg: ASbGnct2WfAOfC4UoH4tckurg+1RA3ocrIDkEdakBZpUWqAKI0f/5jn4uY/OE6hkvNn
	m8E+XqEPUzBn7lUqItBQ12OWdjmYBH/2fb3Je0YedVAvxt4ZsWE0fCisK2lNrdBdGFMv255DAIP
	ElI/b7R9heUG3yAcYnHAig6Te3j3TNNTMKHGstRmV/B11eiv91kI6gIKxXIURf0KKkF0AO4LPRm
	NPetNNogdsuuhUQlxioGU16trp6UAV0+mj4bw5avNcYzn8U04pBsLE2nCMaOUmRv1FHPNM2uWxc
	OvKcC4Fhc6ZAVJpJOE5OS5epbbzGN0lwJdAMENmH+qjT6H5t
X-Google-Smtp-Source: AGHT+IG9V/H2mjJswbNcu51neQX4F6PUBudpT7t07ajZdhxaRyL2Q31ILjRFOWqDRUMJ6acYQT5KGg==
X-Received: by 2002:a05:6000:1845:b0:3a0:b84d:805c with SMTP id ffacd0b85a97d-3a1f64c0b60mr14250338f8f.49.1747144102258;
        Tue, 13 May 2025 06:48:22 -0700 (PDT)
Received: from krava ([83.148.32.128])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f58ec8f1sm16059285f8f.26.2025.05.13.06.48.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 May 2025 06:48:21 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 13 May 2025 15:48:20 +0200
To: David Hildenbrand <david@redhat.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH mm-stable] uprobes: Revert ref_ctr_offset in
 uprobe_unregister error path
Message-ID: <aCNNpJaTGmchbS1s@krava>
References: <20250513122125.1617722-1-jolsa@kernel.org>
 <60b3386e-dbb1-4fe9-bc38-d62eba4d9c50@redhat.com>
 <8323f942-52e1-44b4-b599-e275f1c66ede@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8323f942-52e1-44b4-b599-e275f1c66ede@redhat.com>

On Tue, May 13, 2025 at 03:17:46PM +0200, David Hildenbrand wrote:
> On 13.05.25 15:16, David Hildenbrand wrote:
> > On 13.05.25 14:21, Jiri Olsa wrote:
> > > From: Jiri Olsa <olsajiri@gmail.com>
> > > 
> > 
> > Thanks for debugging.
> > 
> > > There's error path that could lead to inactive uprobe:
> > > 
> > >     1) uprobe_register succeeds - updates instruction to int3 and
> > >        changes ref_ctr from 0 to 1
> > >     2) uprobe_unregister fails  - int3 stays in place, but ref_ctr
> > >        is changed to 0 (it's not restored to 1 in the fail path)
> > >        uprobe is leaked
> > >     3) another uprobe_register comes and re-uses the leaked uprobe
> > >        and succeds - but int3 is already in place, so ref_ctr update
> > >        is skipped and it stays 0 - uprobe CAN NOT be triggered now
> > >     4) uprobe_unregister fails because ref_ctr value is unexpected
> > > 
> > > Fixing this by reverting the updated ref_ctr value back to 1 in step 2),
> > > which is the case when uprobe_unregister fails (int3 stays in place),
> > > but we have already updated refctr.
> > > 
> > > The new scenario will go as follows:
> > > 
> > >     1) uprobe_register succeeds - updates instruction to int3 and
> > >        changes ref_ctr from 0 to 1
> > >     2) uprobe_unregister fails  - int3 stays in place and ref_ctr
> > >        is reverted to 1..  uprobe is leaked
> > >     3) another uprobe_register comes and re-uses the leaked uprobe
> > >        and succeds - but int3 is already in place, so ref_ctr update
> > >        is skipped and it stays 1 - uprobe CAN be triggered now
> > >     4) uprobe_unregister succeeds
> > > 
> > > Suggested-by: Oleg Nesterov <oleg@redhat.com>
> > 
> > If it's in mm-stable, we should have
> > 
> > Fixes: ...

ok

> > 
> > here
> > 
> > > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > > ---
> > > Please note it's based on mm-stable branch, because it has the
> > > latest uprobe_write_opcode rewrite changes.
> > > 
> > >    kernel/events/uprobes.c | 4 ++--
> > >    1 file changed, 2 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> > > index 4c965ba77f9f..84ee7b590861 100644
> > > --- a/kernel/events/uprobes.c
> > > +++ b/kernel/events/uprobes.c
> > > @@ -581,8 +581,8 @@ int uprobe_write_opcode(struct arch_uprobe *auprobe, struct vm_area_struct *vma,
> > >    out:
> > >    	/* Revert back reference counter if instruction update failed. */
> > > -	if (ret < 0 && is_register && ref_ctr_updated)
> > > -		update_ref_ctr(uprobe, mm, -1);
> > > +	if (ret < 0 && ref_ctr_updated)
> > > +		update_ref_ctr(uprobe, mm, is_register ? -1 : 1);
> > 
> > 
> > Hm, but my patch essentially did here
> > 
> >           /* Revert back reference counter if instruction update failed. */
> > -       if (ret && is_register && ref_ctr_updated)
> > +       if (ret < 0 && is_register && ref_ctr_updated)
> >                   update_ref_ctr(uprobe, mm, -1);
> > 
> > So how come this wasn't a problem before?
> 
> Oh, or was this a problem before? Then we should find the corresponding
> commit that needs fixing.

yes, I think it was a problem before, introduced early on by:
  1cc33161a83d uprobes: Support SDT markers having reference count (semaphore)

it seems the scenario described in changelog will hit the same issue even
without your patch, I'll re-run the test to be sure

thanks,
jirka
