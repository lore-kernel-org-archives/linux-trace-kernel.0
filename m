Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E165190472;
	Wed, 10 Jul 2024 16:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720630141; cv=none; b=mltICGkk5r1MJJZLOxLkDJSCi/NZ2s/yxkLEoXJpcBdTGJULsDTgLiFcmhIEAPmEvhAdecBPR8NJqJro6lhcEMUsmqR86eUJtFqGuk/Jc9fcU057H6ogz9Np2eceazZk/CK3jq/EpbSiMuaHvejO2IUVUoo0bo4qedJg93CpMK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720630141; c=relaxed/simple;
	bh=+ngUvyNIMDI0dVPwuIaEz2ATgrqHeeU37EI9ohHmQOo=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=psxUaIL4CG0lveGI6UFYLDTkJ4duUGiB5D6FqI8HvRwRjcPUkenIFfS3A95f2PWmRik5/MLvaQNSlXe1PtdicBjxP+5AdC7nx6PttxfOyMf9zhGyc700BtCiE7qhCz+Qu5wAzYov7xe7YH32vRfxMZYMKo+Xxzw1E14vVNl17V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TfJ31m0X; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TfJ31m0X"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a797c62565aso105985066b.2;
        Wed, 10 Jul 2024 09:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720630134; x=1721234934; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mZ5Fgm9vLR52D4wwBlA+HMoDcnz5HQEVDNo626dqfWM=;
        b=TfJ31m0XDmyvoQLZLLjUUUzSsYGs4FMcgvuYBXVaSvQSusy3hKQ2y/Nl+hSTB0pBIt
         WCU9pbgqIArssBzouF2GF1/4DfffjgUnywoxFU8v/WVzhLuivbFmija6Q+5474wgH3II
         ExmN7r9LSyVNhGi0CpBliW+n7QkjDSkI4C4pD/PWYoIxs2PY8eyWV5pgDNKxAO2dXj9J
         jAJvTN0sP5exUkfdKsJRfKy8MFw/3yGYiU9u7vdO9Cua3OzpKEEiJNnmDlXikMuQLjWw
         M+5DUuG2Gys7vQrSLUaTo7/4j3f6kcnMATNY5vsDAiQMSWl/Tu+QvR+m2WSrXZSHcuvK
         PGRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720630134; x=1721234934;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mZ5Fgm9vLR52D4wwBlA+HMoDcnz5HQEVDNo626dqfWM=;
        b=mxS+SkSW9g86Xb+nWPP7gUt/+I8y6GjUHpfYjZPriPj5gDWMEaqJNF6ULJ4Wscafwp
         53Oeadmb2tYkkpc5Cbr0JLh0xCO5uKP6kvKd3yxHeA6ocAWWzH6FRR/reG0+fCGSjFrL
         sKGjeWDM2p38fMQO4l3O/nP17aoIeNF5ONQd/QqNPxc8GkTwgcbuq/dVAtA7cU+Ck5iV
         UjN7cea0D6sqWmTwSHl8meQoXFQh9tzdigj0hE6v0raIfTiw84NFnlSDZi7jEIMShzot
         mo447EzOVv5Jbc/U+Th/01qqUTU4pe2f40yaynF32L7vqyjahbxO3nTM0NCcp7HovvN3
         Mi8Q==
X-Forwarded-Encrypted: i=1; AJvYcCX5QUuRmG0wU3phiaKxcalvoUOYBM4GdS72KTGQaJmrpQKWGXpWMQxf2Wvf0/8M6HDCzwblNhnKJJl672+dXgjNLPkJkVyIyDnBKVlCmyFN024zC8oV0fJ+sb3HL2H17LVSrA2D5/ySBPsUiOhHHsEC
X-Gm-Message-State: AOJu0Yy0KA74KubqCLNi+/MC75mCDDny179gmVJvl5Du612mUXJtlg1d
	8UJezXiJRGf2qIGzbYQRjrpMzQwztf6HfXACiMymq3GVWq5019tK
X-Google-Smtp-Source: AGHT+IHV+UY1VaTqQ+sQFxAzBoDDUb3ky3ChoM8MgrJclXvNtmLns/7fHXDdMCQvcjIVqs2Rmt/ZFA==
X-Received: by 2002:a17:906:3590:b0:a77:c8f8:f9d0 with SMTP id a640c23a62f3a-a780b705305mr421737266b.44.1720630134261;
        Wed, 10 Jul 2024 09:48:54 -0700 (PDT)
Received: from krava (ip4-95-82-160-96.cust.nbox.cz. [95.82.160.96])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a780a8720f9sm174343166b.220.2024.07.10.09.48.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 09:48:54 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 10 Jul 2024 18:48:51 +0200
To: Oleg Nesterov <oleg@redhat.com>
Cc: andrii@kernel.org, mhiramat@kernel.org, peterz@infradead.org,
	clm@meta.com, mingo@kernel.org, paulmck@kernel.org,
	rostedt@goodmis.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] uprobes: make uprobe_register() return struct uprobe
 *
Message-ID: <Zo67c9nvbRD0h4-b@krava>
References: <20240710140017.GA1074@redhat.com>
 <20240710163022.GA13298@redhat.com>
 <20240710163133.GD13298@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240710163133.GD13298@redhat.com>

On Wed, Jul 10, 2024 at 06:31:33PM +0200, Oleg Nesterov wrote:

SNIP

> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 467f358c8ce7..7571811127a2 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -3157,6 +3157,7 @@ struct bpf_uprobe {
>  	loff_t offset;
>  	unsigned long ref_ctr_offset;
>  	u64 cookie;
> +	struct uprobe *uprobe;
>  	struct uprobe_consumer consumer;
>  };
>  
> @@ -3180,10 +3181,8 @@ static void bpf_uprobe_unregister(struct path *path, struct bpf_uprobe *uprobes,
>  {
>  	u32 i;
>  
> -	for (i = 0; i < cnt; i++) {
> -		uprobe_unregister(d_real_inode(path->dentry), uprobes[i].offset,
> -				  &uprobes[i].consumer);
> -	}

nice, we could also drop path argument now

jirka

> +	for (i = 0; i < cnt; i++)
> +		uprobe_unregister(uprobes[i].uprobe, &uprobes[i].consumer);
>  }
>  
>  static void bpf_uprobe_multi_link_release(struct bpf_link *link)
> @@ -3477,11 +3476,12 @@ int bpf_uprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
>  		      &bpf_uprobe_multi_link_lops, prog);
>  
>  	for (i = 0; i < cnt; i++) {
> -		err = uprobe_register(d_real_inode(link->path.dentry),
> +		uprobes[i].uprobe = uprobe_register(d_real_inode(link->path.dentry),
>  					     uprobes[i].offset,
>  					     uprobes[i].ref_ctr_offset,
>  					     &uprobes[i].consumer);
> -		if (err) {
> +		if (IS_ERR(uprobes[i].uprobe)) {
> +			err = PTR_ERR(uprobes[i].uprobe);
>  			bpf_uprobe_unregister(&path, uprobes, i);
>  			goto error_free;
>  		}
