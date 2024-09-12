Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3215C1C232D
	for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Sep 2024 21:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726175694; cv=none; b=derIduBeMB7X+7wjgIeyQYdXyJ5tYyxDuXAEYxnmdGrypyWiq5Vth1dnTx5Iy89kS1AvbrdBBB86jHVktmpbcHCZ0AeRWyTLJYohOlQpehpc7d3GUYYld/OdgtfF/H1bNC/YBuM+48tZY8oSDHvB1ZHrCP1+LcMTUuMOXE+ucEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726175694; c=relaxed/simple;
	bh=peVnoRwbqecr/0PJF00iv4hFysL5tmps7T44YTBQn1E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PtqzAuccnf4PpX+yot2F/DwUyS0/C6lVbj0xlL58OjCfeZwSs17l/IBCpuOVDodgmhpfe8Wo7fUVmGksyBhuxMOLPNrZmZ14prY3gdLMLJVUrpVNLIAqJtqGrycT21wyb/ta77coMl3xC1j7bUFeTrowp+P8Ffg3ikvGF9EMOeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TgrAtnXr; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TgrAtnXr"
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3e0402a98caso669060b6e.3
        for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Sep 2024 14:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726175691; x=1726780491; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2EO0qmaSPp73jvXnTs7TJzCKL8q51LBbEbQNyisfg4c=;
        b=TgrAtnXr/7OJjvCVwZLNYSuwZYI+CkWtp53jxLr5DY6OZMrP9OBl6+HAyQk39Vmnoh
         qqFlvNt44CLztfbZrj0FuRCR2iGPcc5KwKMipprl2samIjPIUTwaC70Mb9o7pSqUALGS
         Y1XgtxzCoN2PV7HZ0F2hE5CbBIAFQWCEhapMSPTvKUjbbG/dkBUb37F4sJm/Y1dxF/Fr
         W6/AXeohOW30JF1yMFMif9gq8qYKoFtgGFkSwa9AId0I5wgxwi5PemXv+4fDECM9suBZ
         3A3nv5hCG0cMhnOLAQ3WtQ+XBjSLOF1Q0kJvhR5D+s+tgs3yeGY0AdbQe17Y81c19wFz
         +PjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726175691; x=1726780491;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2EO0qmaSPp73jvXnTs7TJzCKL8q51LBbEbQNyisfg4c=;
        b=ZuyihaTMx8azwZEby+RR7w5aC+mrf6uAJegXPsAeDQ4IbPemgF0LP3PtbkGspqMd3F
         56t7eikSOyRDYQhKNakS5CG9IQQWjYbBLzqeMtco52qQjCG50lGHPGrosLwV2hStmzwX
         RMLW17uhQCjBN6HwJee5ZF6Tl7QRzddK7tM6eCfQSGuOMHeLo6Rlr8x/p9F9bG1QveQN
         wjqrhlJtSlBeVsbzdJpYYDIZq7zWfYMkYeyZP1al051vSxoc9v2997ZB1wMmmgz2HNxV
         Y7Ff9CNgfJuTSEKDrUKMlX4ESNS1FXwT8+/I41pGMraXReSsOxaTJcvr3ebBtkc8URFO
         kBeQ==
X-Forwarded-Encrypted: i=1; AJvYcCXqvS2v+PsYXzc4QMTzdudV+yDM42NdFq41U6G7hJ4tqhz4TGu7+OnYciGa3cVlB80tqs/vmLwK87yasCmx2qc/W1w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTWsD2/moCIQBtPGjnwyNEMDy34fWPp5Kj5JeIUzmLh4zXKLI0
	CTzYgNFKIjRk+s2K9AWTq91HL1sUhY69KdpxH5hO+6cp2i1PSaOQHAkfIA06uA==
X-Google-Smtp-Source: AGHT+IEXhrO73skogk/s/nT+zYKnKQ0Yub0DnxaAiKfl03Q20IYpu3fPe1nRti4noHn1qI7LW/QNUg==
X-Received: by 2002:a05:6808:399b:b0:3d9:3a2f:959e with SMTP id 5614622812f47-3e0719ee561mr3950771b6e.0.1726175691128;
        Thu, 12 Sep 2024 14:14:51 -0700 (PDT)
Received: from google.com (30.64.135.34.bc.googleusercontent.com. [34.135.64.30])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5e1cab53594sm2250200eaf.43.2024.09.12.14.14.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 14:14:50 -0700 (PDT)
Date: Thu, 12 Sep 2024 14:14:47 -0700
From: Justin Stitt <justinstitt@google.com>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: akpm@linux-foundation.org, torvalds@linux-foundation.org, 
	alx@kernel.org, ebiederm@xmission.com, alexei.starovoitov@gmail.com, 
	rostedt@goodmis.org, catalin.marinas@arm.com, penguin-kernel@i-love.sakura.ne.jp, 
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, audit@vger.kernel.org, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, Quentin Monnet <qmo@kernel.org>
Subject: Re: [PATCH v8 4/8] bpftool: Ensure task comm is always NUL-terminated
Message-ID: <ozoyqz5a7zssggowambojv4x6fbhdl6iqjopgnycca223jm6sz@pdzdmshhdgwn>
References: <20240828030321.20688-1-laoar.shao@gmail.com>
 <20240828030321.20688-5-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240828030321.20688-5-laoar.shao@gmail.com>

Hi,

On Wed, Aug 28, 2024 at 11:03:17AM GMT, Yafang Shao wrote:
> Let's explicitly ensure the destination string is NUL-terminated. This way,
> it won't be affected by changes to the source string.
> 
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> Reviewed-by: Quentin Monnet <qmo@kernel.org>
> ---
>  tools/bpf/bpftool/pids.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/tools/bpf/bpftool/pids.c b/tools/bpf/bpftool/pids.c
> index 9b898571b49e..23f488cf1740 100644
> --- a/tools/bpf/bpftool/pids.c
> +++ b/tools/bpf/bpftool/pids.c
> @@ -54,6 +54,7 @@ static void add_ref(struct hashmap *map, struct pid_iter_entry *e)
>  		ref = &refs->refs[refs->ref_cnt];
>  		ref->pid = e->pid;
>  		memcpy(ref->comm, e->comm, sizeof(ref->comm));
> +		ref->comm[sizeof(ref->comm) - 1] = '\0';

...

>  		refs->ref_cnt++;
>  
>  		return;
> @@ -77,6 +78,7 @@ static void add_ref(struct hashmap *map, struct pid_iter_entry *e)
>  	ref = &refs->refs[0];
>  	ref->pid = e->pid;
>  	memcpy(ref->comm, e->comm, sizeof(ref->comm));
> +	ref->comm[sizeof(ref->comm) - 1] = '\0';

Excuse my ignorance, do we not have a strscpy() equivalent usable in bpf
code?

>  	refs->ref_cnt = 1;
>  	refs->has_bpf_cookie = e->has_bpf_cookie;
>  	refs->bpf_cookie = e->bpf_cookie;
> -- 
> 2.43.5
> 

Thanks
Justin
