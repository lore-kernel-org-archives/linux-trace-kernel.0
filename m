Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 739FD3750D7
	for <linux-trace-kernel@vger.kernel.org>; Mon,  3 Aug 2026 10:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785753322; cv=none; b=u76zTJ9FlC6SfhlT8rAay76S6f6emSQDa/dkGs+W3+IY7w4eLI7t3QPaOo587DAY3ypxFE/htoFuWERShI1Ey6eAeleKMj8PRg70+VhQE75ZQ4kF4fHRz7zzt9hYTZoqppf9UErJdH2QOALDefL3xV6UnaWqs5DXij4N8CDbHTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785753322; c=relaxed/simple;
	bh=yeRlqgHQZa3hz5Qaq/3RS+NfWQ9WCl04KKECFw2GoZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HZvw8bljOQiXTY9OvKmyiQFu+39Lju2D9Re0+gaeXvM7azJ+eLQhG0n10cFcKC8aOTc50NWAJLPLTXc3K05uf9rHkoFXKKmHHETKyVYyE/WMCAGnlwFjIR0d6xGlDnU0ajAC0f4RyNTHd0NDypkwVEHo7wCkeV3b3ixrv0F5DDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aBmI952U; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aBmI952U"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-47f633e6058so3043693f8f.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 03 Aug 2026 03:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785753320; x=1786358120; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FRWZR/aXzNRtlaANjzO2S5r0yF9L37fVJhN+JbqqSaQ=;
        b=aBmI952UjFPeZ0ld+ZEccdKvuG1Sj8GNnJoztn8ZeRzD0Sc2bi6ciYfTsSY0Bqiz7p
         jtIN51TCOhQ1yKmeO2G2l/zNMy2NeATSO2mOodBroWKsoA2sTV5zt1HC2TH/u5n2QWmQ
         C2OTkYrc/jKVyfvbkkOt9jdIKow8DoXUoQUnHLp/jLxYJHrKxhyoNBVk+TXh20iU4aUA
         f4XYXqDJ2otfee5M+R+kZzb6HyBHMXemWusyTUCJd8lSsyAyb7E4zdbEyvvSOr840+F7
         rpoaGJotxIeinz9by3vYTkP6pRKWoYbdX4N9DKGQlRRpss9sB/09iqVgThdqM9K5uX47
         3IrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785753320; x=1786358120;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FRWZR/aXzNRtlaANjzO2S5r0yF9L37fVJhN+JbqqSaQ=;
        b=Wg5CYckHYchEw9c+uvuO+XovIhjbIBLGQCq1nF23O3s5FbmXKKZCNY/UoLnYo3rR94
         plqStNdOwwKXm84lb2UR6HJYhe7fYzT8DPyo9pNpbn2/oxKJ9dLnhdlfHKWoDDPkquel
         mYglh5Z4fWNcoc/guc0lRdDJ9e/WO54G7zrdxrjYN7fcS91Un1laQohqaRB63mjGQk/E
         CNtAVcO5pRA34pAQ08GzxCgBilwKheZ28kAKOtlZMkzCqwa8fJptCSzYzwv6WpD3Ovea
         ceEmsJeFNtFr6zT8XjLfRm7AO0SJLMSTrQ1mzb2HVo18iHvRAflZb918vbBVhC3QG3MV
         Fvxg==
X-Forwarded-Encrypted: i=1; AHgh+RqhX+7/9XtLq0p3TIv2uhbrLuG7UIX5+XDL+UC88gZXwzGPJVMKvFTuw/vi0VfjDPrEMbYEIQVgMYKX0Ne4PrqDOAs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWxEQMUJ7DbUm7AJy8rsNBgtdP53/O22NLqJlwVKKNKqKe+lK/
	7+RRKwU9SCxCZ+gb/gI2PnLya2zDSsut0jFJ9oS98KGk0SRDZFMngT9ZXmHq9b+exQ==
X-Gm-Gg: AR+sD11nZhZXPFBjg0MskXSEOoXWRnv22Pobl/viJgmyPw6w0JXUqt72EWUAIciLUPW
	8aprE6h32z7zBwuN8iTDcJD8xixpPIdzF/+gVBOg820L4vXiP7ETyyZvcyyYD91l7pVHU7pCFm4
	fq8y9vyqcRvJuUYva0YqxiKj8gb+CDQPCXIsySE0gCLBi/TfeAmTZl9PqJXf7XA2T/RW7Wz2TlE
	3yfJTbHVLt8w/8aWd6Doscnw0ei1tRcGAeE0SQfHN/W1GKid38cIjaTA6ede0+/3ZvuQa7PPtFK
	zEQnfTuYHoHNfqfybyil0z8OalGWgNZjhpDTa00V/a2B3mOlv4GbY3jaH1w/MJKC3t6dMADS3pR
	H8sbWPP9GOH3k7BvBVhLgDx7L3hp4x8pljb81ur9VOXi7/MDI/D/fuGdvSq6yUsbfMGPMYoR+c9
	Qlv8O4rR+DH1vNmKfdYTzR/hogHNxURtXZ5YSR44rsroCNc/9q4jLuY0xFGy+yZBtLhKsZJZVti
	zcgRkJIEk2lo72tOyYLVIvEXMbXbVC0
X-Received: by 2002:a05:6000:471a:b0:47f:ddc0:602a with SMTP id ffacd0b85a97d-47fddc06087mr15422708f8f.18.1785753299369;
        Mon, 03 Aug 2026 03:34:59 -0700 (PDT)
Received: from google.com (135.91.155.104.bc.googleusercontent.com. [104.155.91.135])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd41d1a58sm31650490f8f.7.2026.08.03.03.34.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 03:34:58 -0700 (PDT)
Date: Mon, 3 Aug 2026 11:34:55 +0100
From: Vincent Donnefort <vdonnefort@google.com>
To: Fuad Tabba <fuad.tabba@linux.dev>
Cc: maz@kernel.org, oupton@kernel.org, linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev, catalin.marinas@arm.com, will@kernel.org,
	rostedt@goodmis.org, mhiramat@kernel.org, alexandru.elisei@arm.com,
	joey.gouly@arm.com, seiden@linux.ibm.com, suzuki.poulose@arm.com,
	yuzenghui@huawei.com, qperret@google.com, ardb@kernel.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	tabba@google.com
Subject: Re: [PATCH v1 04/11] KVM: arm64: nVHE: Use NULL to reset the trace
 buffer backing pointer
Message-ID: <anBuzx3c2MJgLF8c@google.com>
References: <20260720161343.1367007-1-fuad.tabba@linux.dev>
 <20260720161343.1367007-5-fuad.tabba@linux.dev>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260720161343.1367007-5-fuad.tabba@linux.dev>

On Mon, Jul 20, 2026 at 05:13:36PM +0100, Fuad Tabba wrote:
> bpages_backing_start is a pointer; resetting it to plain 0 triggers a
> sparse warning.
> 
> No functional change intended.
> 
> Signed-off-by: Fuad Tabba <fuad.tabba@linux.dev>

Probably missed this when modifying the type for bpages_backing_start.

Reviewed-by: Vincent Donnefort <vdonnefort@google.com>

> ---
>  arch/arm64/kvm/hyp/nvhe/trace.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kvm/hyp/nvhe/trace.c b/arch/arm64/kvm/hyp/nvhe/trace.c
> index e7e150ab265ff..177fe3d8fbb13 100644
> --- a/arch/arm64/kvm/hyp/nvhe/trace.c
> +++ b/arch/arm64/kvm/hyp/nvhe/trace.c
> @@ -93,7 +93,7 @@ static void hyp_trace_buffer_unload_bpage_backing(struct hyp_trace_buffer *trace
>  
>  	__release_host_mem(start, size);
>  
> -	trace_buffer->bpages_backing_start = 0;
> +	trace_buffer->bpages_backing_start = NULL;
>  	trace_buffer->bpages_backing_size = 0;
>  }
>  
> -- 
> 2.39.5
> 

-- 
Vincent
