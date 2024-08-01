Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13DD8208D1;
	Thu,  1 Aug 2024 12:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722514523; cv=none; b=gEuw67+9ZT7Vs82nraycgc6fkaXIZ0af8WfAnJFrJEu9WV0kPQIq5LS5N5GdJLSbZ9D0M9KGK/cJjL0puVoKv8srM7TiA96L73K39hWmhGoS0/aX2jVOK5n7D6lu1U+gXT3wC3Qn+vEtsALAy/fNBQs/llIOYJUFVJWApX8nxnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722514523; c=relaxed/simple;
	bh=ZhDXFoWGL7ldV6IXscVG+ltF8RcH1d1vHZjv0xlIMgE=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ft1N5GQc0iQ9c+QqRntO9R9Y5CmxpKNAzfOTmogA2Uddmc3BahdDPe4558hYNHu2SgH7WFBCavxWeCMUprV5Svl/+EvR9a69+SnruN7IOsmwgP4MQxOvwQDtL0XnWmDDA7W0AjlwYqx2+DMOkV7fhefV4BofS8xb3B3PJfa8iQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wewu8Jtk; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wewu8Jtk"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-368440b073bso1359297f8f.0;
        Thu, 01 Aug 2024 05:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722514520; x=1723119320; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=b0fgVgtgp3VowMbctHofO6wvaDHqLlJ1QMN9hMj2Y0g=;
        b=Wewu8Jtk6c2Y/JtKDI3iCxoC/1DiyZJP2WJoScVw/170abM/pSH4CZvJzhh9/99T8W
         2XT4c24qEq6jkqpAccQzM2wmvV9lOs1dx5WSF00xN+i3WwTfvkAT62gK2+R95m4ggPgw
         tP2aijFaos6E0B3XcxK0VFCfcfVtaRJO79bOvXCkxHxLG9zQTk9JLdOOqbMTj93/uU+v
         yjIEUZTHrB1WWyQbIuaIxlNnJmLctcszHZXmF6fr5vBLQKh1oHfIiUBOPxL594yFpTIy
         LlHcSGV1EDtOoFG5FDfJvXT94jXTH2eUJ7z2PZr74oo0lpX32aJoD5eEd8cq5038LT23
         L/4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722514520; x=1723119320;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b0fgVgtgp3VowMbctHofO6wvaDHqLlJ1QMN9hMj2Y0g=;
        b=RXXIbPjRtbpJpFmeLCVr0GIuVlTOznKQiMHvi4EUJzHJJxHGZ44C/Jpn4ysxUSCGoy
         94GnEphqFlxDIyUM5SGfN4JjsMH8Uof7cavb4eWmb4PH1GK33yhtOCY0N6av+vxo+Arc
         Mv0isNpEFqiZBTB5FwO04yYxrVrCBbH5D/mH6ss2V4lbykskV0Bwngaot3gNvceIvEc/
         AMgOwj/wS3U6LLSoBggHd3dpoEmokxzvcwAn50KWpcZe6oQZjrwC/KdQu8RbC8ptayfN
         A1CMSNC9I1ZbHcLX6GLC3xxBri9Oa4AvhIhDERcb+QpT18+Wd7dQ9aYxZrDAisoeKf7n
         fDAA==
X-Forwarded-Encrypted: i=1; AJvYcCVW8MpFd/Fc05kVHG9FEB0TRAkpQw3k2DY7yuJh0wPpUP1Zj4UvrjeAEQdBMjZMTfRuNZJk4rZfryeBS6i82V+2ZIDhgVx1Mm4xd/4e3G00X2DzYkaud8+yewhhSG/wa2GGVTMcslmhFBiaiadKF6aw
X-Gm-Message-State: AOJu0YyFU8falwvNrR5R6jGKDu7DjcBTxasnhgb/UTG/2dGb0mRqWsvn
	RiJX84zbuTtdxTZjrgui06L4JocQkRBEUQ+YvMMpPGC/945rVeLU
X-Google-Smtp-Source: AGHT+IGj9T8mNOenYa8uRUCT84vz4mhyC0en9nQRFJltfA5evn91A0hEm5jMhnF/XAszR2xuVY8Jxw==
X-Received: by 2002:adf:978f:0:b0:367:8fd9:db6b with SMTP id ffacd0b85a97d-36bb35a0ac8mr1242484f8f.9.1722514519984;
        Thu, 01 Aug 2024 05:15:19 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36b367d9859sm19234433f8f.28.2024.08.01.05.15.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 05:15:19 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 1 Aug 2024 14:15:12 +0200
To: Oleg Nesterov <oleg@redhat.com>
Cc: Jiri Olsa <olsajiri@gmail.com>,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>, andrii@kernel.org,
	mhiramat@kernel.org, peterz@infradead.org, rostedt@goodmis.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/5] uprobes: make uprobe_register() return struct
 uprobe *
Message-ID: <Zqt8UPBC7zAWDMHD@krava>
References: <20240729134444.GA12293@redhat.com>
 <20240729134535.GA12332@redhat.com>
 <CAEf4Bza1_njsVUad8so9EFxy8VmJsTfzaaAahBYFtOqdF1HAjA@mail.gmail.com>
 <ZqtyMTyu3uneHZDJ@krava>
 <20240801120018.GB4038@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240801120018.GB4038@redhat.com>

On Thu, Aug 01, 2024 at 02:00:18PM +0200, Oleg Nesterov wrote:
> On 08/01, Jiri Olsa wrote:
> >
> > > @@ -474,10 +477,10 @@ static void testmod_unregister_uprobe(void)
> > >  {
> > >         mutex_lock(&testmod_uprobe_mutex);
> > >
> > > -       if (uprobe.offset) {
> > > -               uprobe_unregister(d_real_inode(uprobe.path.dentry),
> > > -                                 uprobe.offset, &uprobe.consumer);
> > > +       if (uprobe.uprobe) {
> > > +               uprobe_unregister(uprobe.uprobe, &uprobe.consumer);
> > >                 uprobe.offset = 0;
> > > +               uprobe.uprobe = NULL;
> >
> > ugh, I think we leak &uprobe.path.. I can send follow up fix if needed
> 
> Yeah, with or without this change. And with this change we do not need uprobe.offset.
> 
> Please see the patch below, this is what I've added to 5/5.
> 
> Do you see any problems?

looks good, thanks!

> 
> Note the additional path_put() in testmod_unregister_uprobe(). Does it need
> a separate patch or can it come with 5/5 ?

I think it'd be better to have it separately, the test is already
released.. so people might want to backport just the fix

thanks,
jirka

> 
> Oleg.
> 
> --- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
> +++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
> @@ -432,7 +432,7 @@ uprobe_ret_handler(struct uprobe_consumer *self, unsigned long func,
>  
>  struct testmod_uprobe {
>  	struct path path;
> -	loff_t offset;
> +	struct uprobe *uprobe;
>  	struct uprobe_consumer consumer;
>  };
>  
> @@ -446,25 +446,25 @@ static int testmod_register_uprobe(loff_t offset)
>  {
>  	int err = -EBUSY;
>  
> -	if (uprobe.offset)
> +	if (uprobe.uprobe)
>  		return -EBUSY;
>  
>  	mutex_lock(&testmod_uprobe_mutex);
>  
> -	if (uprobe.offset)
> +	if (uprobe.uprobe)
>  		goto out;
>  
>  	err = kern_path("/proc/self/exe", LOOKUP_FOLLOW, &uprobe.path);
>  	if (err)
>  		goto out;
>  
> -	err = uprobe_register(d_real_inode(uprobe.path.dentry),
> -			      offset, 0, &uprobe.consumer);
> -	if (err)
> +	uprobe.uprobe = uprobe_register(d_real_inode(uprobe.path.dentry),
> +					offset, 0, &uprobe.consumer);
> +	if (IS_ERR(uprobe.uprobe)) {
> +		err = PTR_ERR(uprobe.uprobe);
>  		path_put(&uprobe.path);
> -	else
> -		uprobe.offset = offset;
> -
> +		uprobe.uprobe = NULL;
> +	}
>  out:
>  	mutex_unlock(&testmod_uprobe_mutex);
>  	return err;
> @@ -474,10 +474,10 @@ static void testmod_unregister_uprobe(void)
>  {
>  	mutex_lock(&testmod_uprobe_mutex);
>  
> -	if (uprobe.offset) {
> -		uprobe_unregister(d_real_inode(uprobe.path.dentry),
> -				  uprobe.offset, &uprobe.consumer);
> -		uprobe.offset = 0;
> +	if (uprobe.uprobe) {
> +		uprobe_unregister(uprobe.uprobe, &uprobe.consumer);
> +		path_put(&uprobe.path);
> +		uprobe.uprobe = NULL;
>  	}
>  
>  	mutex_unlock(&testmod_uprobe_mutex);
> 
