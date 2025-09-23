Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F1530DD00
	for <linux-trace-kernel@vger.kernel.org>; Tue, 23 Sep 2025 11:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758625839; cv=none; b=emusxiowEg0oEdqnA2tyc7rROqJuCxfR7Lcv3QUfeJjKlhotZ+N4J0qjviHeoCgc7M6SsLw1Byi98MKfGAId2Hrlr8XLy3Z0YCFVDaIxjdHfChp7XLMufTl9Hrme1eHLnbhEDGlTfRO0J2Z0147unr169rYRY1QGbNiShKUH3Uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758625839; c=relaxed/simple;
	bh=wGRrexcrJiOYxex9LPSrvm70Gi0w/jmnAo5XesaOW1M=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GDKihsOz5WkSYQFBdDFtM9fU736loMRzUcsBsGJyUb0a971sri37boG1qlnIzQd7xDQFCl2XEjoc7S5Mo1kLqVshsAlhMB7syqlPsA913vZPMTn+sNSHE1U5w2rw0YwXIO1VpvGUPPNiXnxU7QBKphHPvR2pMUpIVCmUzc9nQ3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ae9YOFtj; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ae9YOFtj"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3fc36b99e92so1371887f8f.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 23 Sep 2025 04:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758625836; x=1759230636; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tUjJweEPB4TqONfwC9fpDlwaU6QM2qlfDS5A23MkLtU=;
        b=Ae9YOFtjcOo9kCmzREoCWChl1wKvUdJjZlm+TsEylERaa1L4kkSYi+K4uNEbWmLv4K
         XxmlPS0SsGU8mT51meZiuelPgpFr9j5DTe0ZuYhITHLvQQdjOpapgHuFPEUJE5Cfb5Ab
         L32H9SewvMcaq18c7QfR5xDiFytSw5K8ZkY1sJewx77eVR9wLuxCSl9NLsJi1+zCT3X3
         3IhXYZ/3XrZxcLudVDpJcGEWvGoOe0N7J6BLDsznSh1EIWBNtd3W7ZlBd3sBdPLU3M9F
         DC7z4SPl1R2nk1S4iSqIfvNxFz+k2eb0mL4fqiI7ZDUwwYfzNSfr+/DOHpe7D74Mx4Bk
         qo7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758625836; x=1759230636;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tUjJweEPB4TqONfwC9fpDlwaU6QM2qlfDS5A23MkLtU=;
        b=wuF4rVj2PRB3To4ZtcsQ4cZjGGRlgztDfaGSYW1Db6RvuaHYzgVrd5nzN7mfyOHc2f
         VTH3azWMx2tjGhPQFfCf3Qzrt4ovjc4cdZzA1iyeM/qDNBIYk4Lsoc/czZRSSbp4Uazr
         S1PYksBCzNc8PZc+Lt0r03UAU4yQzociIGfUW3a70yIgrmY7f7vhF606Xo1/RQxGAOxc
         TKCnh0PGgFPivkW+9s4YtgPmw62ORUM2ao8pWz/oz20763wRVYfzEsMfqVg+wdgM0at9
         gXtvfSvl9mJ9H46kvpFd1/OTA9h+Iu7a4fLaKUzVFNU4c7rxv7gwUaIEkwFChuYBWC0I
         XyPQ==
X-Forwarded-Encrypted: i=1; AJvYcCUzh5T87L894tMaglpHcp/qDqZ2bMtM6pQD3RjjcfPsap/ZUcynMXu70EnbXqnWgwN9bTNG4LCRW9V1MSg7SPtAG0k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyptCc8WL6sk3m6CTV8IjiVnFmoWZ7heCT7cEtVWvyfIG47fU4+
	1hjJvJN+tAAjI0VoFPT9pzeiMNyBMIA4tL6j8utIfHO6sZ6owJZDQCXTHMeeDlPCxTI=
X-Gm-Gg: ASbGncuvsnWmwA29vk4PXRb0mb9TBa3UJxriL0Wfnis151tnsWRAbhc4vCMn2l2/Log
	cH5MNEg59Z3fV2fVMYCo9bbDb3KpvNBXilJflc8CpK9hajij3sg8R9BUWj3HQ1A6bMesmP5sT23
	yvY3JC3KgxqVUexi8kg2nYZKeSeAddMt/fidsdf1GEKq79kvW9zUlrOJnKehdGwqKtTVT6a8ym7
	NrExkbDFqJimhBbuQlcRINh0txs6RtXN/U7L1EU+Os45bxLNhN17+LoTcsdNe4TwkajOvFucydt
	b1e6az11p9R+uJI6XUU+CccF82DFzztpWQ9SevLAZld5W4gOm1lDcaDTPfChiN1soD0laylM
X-Google-Smtp-Source: AGHT+IHgMX3BiSNRvfrTGGdpNnaqqWvHnAmBH8PkRL8VnvuR0hyv/WFqY9PPvGGhOMcdRD/JvBVOdg==
X-Received: by 2002:a05:6000:186f:b0:3e7:428f:d33 with SMTP id ffacd0b85a97d-405d090c6d0mr2107024f8f.16.1758625836201;
        Tue, 23 Sep 2025 04:10:36 -0700 (PDT)
Received: from krava ([2a02:8308:a00c:e200::31e0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ee07407fa3sm23503973f8f.21.2025.09.23.04.10.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 04:10:31 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 23 Sep 2025 13:10:26 +0200
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: mhiramat@kernel.org, rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH 2/2] tracing: fprobe: optimization for entry only case
Message-ID: <aNKAIsHQZySyrV4o@krava>
References: <20250923092001.1087678-1-dongml2@chinatelecom.cn>
 <20250923092001.1087678-2-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250923092001.1087678-2-dongml2@chinatelecom.cn>

On Tue, Sep 23, 2025 at 05:20:01PM +0800, Menglong Dong wrote:
> For now, fgraph is used for the fprobe, even if we need trace the entry
> only. However, the performance of ftrace is better than fgraph, and we
> can use ftrace_ops for this case.
> 
> Then performance of kprobe-multi increases from 54M to 69M. Before this
> commit:
> 
>   $ ./benchs/run_bench_trigger.sh kprobe-multi
>   kprobe-multi   :   54.663 ± 0.493M/s
> 
> After this commit:
> 
>   $ ./benchs/run_bench_trigger.sh kprobe-multi
>   kprobe-multi   :   69.447 ± 0.143M/s
> 
> Mitigation is disable during the bench testing above.
> 
> Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> ---
>  kernel/trace/fprobe.c | 88 +++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 81 insertions(+), 7 deletions(-)
> 
> diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
> index 1785fba367c9..de4ae075548d 100644
> --- a/kernel/trace/fprobe.c
> +++ b/kernel/trace/fprobe.c
> @@ -292,7 +292,7 @@ static int fprobe_fgraph_entry(struct ftrace_graph_ent *trace, struct fgraph_ops
>  				if (node->addr != func)
>  					continue;
>  				fp = READ_ONCE(node->fp);
> -				if (fp && !fprobe_disabled(fp))
> +				if (fp && !fprobe_disabled(fp) && fp->exit_handler)
>  					fp->nmissed++;
>  			}
>  			return 0;
> @@ -312,11 +312,11 @@ static int fprobe_fgraph_entry(struct ftrace_graph_ent *trace, struct fgraph_ops
>  		if (node->addr != func)
>  			continue;
>  		fp = READ_ONCE(node->fp);
> -		if (!fp || fprobe_disabled(fp))
> +		if (unlikely(!fp || fprobe_disabled(fp) || !fp->exit_handler))
>  			continue;
>  
>  		data_size = fp->entry_data_size;
> -		if (data_size && fp->exit_handler)
> +		if (data_size)
>  			data = fgraph_data + used + FPROBE_HEADER_SIZE_IN_LONG;
>  		else
>  			data = NULL;
> @@ -327,7 +327,7 @@ static int fprobe_fgraph_entry(struct ftrace_graph_ent *trace, struct fgraph_ops
>  			ret = __fprobe_handler(func, ret_ip, fp, fregs, data);
>  
>  		/* If entry_handler returns !0, nmissed is not counted but skips exit_handler. */
> -		if (!ret && fp->exit_handler) {
> +		if (!ret) {
>  			int size_words = SIZE_IN_LONG(data_size);
>  
>  			if (write_fprobe_header(&fgraph_data[used], fp, size_words))
> @@ -384,6 +384,70 @@ static struct fgraph_ops fprobe_graph_ops = {
>  };
>  static int fprobe_graph_active;
>  
> +/* ftrace_ops backend (entry-only) */
> +static void fprobe_ftrace_entry(unsigned long ip, unsigned long parent_ip,
> +	struct ftrace_ops *ops, struct ftrace_regs *fregs)
> +{
> +	struct fprobe_hlist_node *node;
> +	struct rhlist_head *head, *pos;
> +	struct fprobe *fp;
> +
> +	guard(rcu)();
> +	head = rhltable_lookup(&fprobe_ip_table, &ip, fprobe_rht_params);

hi,
so this is based on yout previous patch, right?
  fprobe: use rhltable for fprobe_ip_table

would be better to mention that..  is there latest version of that somewhere?

thanks,
jirka
