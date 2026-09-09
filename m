Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 989EF3B52FF
	for <linux-trace-kernel@vger.kernel.org>; Wed,  9 Sep 2026 06:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788937014; cv=none; b=WrAzR3O/Cpi6AVepsOGj603mPecOW4n5N6hHCMR1fPX/kjcSr+q6UanQbrAYvhSrhRBqMv9ZV9oyrsH7idVkL0jE8UvCEbgSsU0ReSzdAHd2NiOYIbY7pAQMotU/VL4UWgyxrdyG9YFd6Eo4s2mt799C3nALuF3JHyi9LbaSLwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788937014; c=relaxed/simple;
	bh=HPNLMBO9N4prqf/mQOgRlKyxaKwXtI72+5mxXq1aDyE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dXD/AC3Jk94sx7viz+6KnhTR0RDrW2ygA2XoXzjozzLmGDYvxQNbwBXJOVeFnqJQiQ0A1OHbAh2Uo0gor0OBRgbyJ8lOC4W08u1gJ3SVQq1UC0VzMgP48ZYv7o/376zkcAmnGPGAyBgkpt7jzIjcVpxZacAlCJ4ckNMg1a5sOgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=F82511EJ; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F82511EJ"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-49557167508so64449545e9.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 08 Sep 2026 23:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788937005; x=1789541805; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7VMyo+jbi8Y24lYE0+2xSfhRa8JaTYv/5jSwKEcVL+I=;
        b=F82511EJwoG7tMy1NBoAeSRgiSnVn6sQwU1gdln+/+HDzycMG1Vx6BEMOp4ozNTgeq
         ZhpGHC4qql/hGNxeMmFSm+K8UmmjpSpbrma8hUtERQlv0AqmcRwySucGTpA1b1bCloIG
         JH3u3m7UMSm2ufLCqtbXMpyQtLeV374eWsMFcaS4pnVErf3+2nHjgynSXU2eLnpDtsBV
         Pvh3ry8QwwUyQ+3pe72KE3rcaEVsvrgs2k42aSYl1uFjZsdQNJu3LqsQx6tIlnsG7tdR
         Uegp/0A+3S7L13tX5fxvyyzimJA5pdbrhYLpuS4vRtg5WcOSNTCkNVE8NgNX+86AQrdr
         HjpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788937005; x=1789541805;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7VMyo+jbi8Y24lYE0+2xSfhRa8JaTYv/5jSwKEcVL+I=;
        b=XWjD6XNooaxww/7G4wzBUQys5bzR343pY55Ybik7dmWKr5lFL1Yq+y/Bh/cRSAQctv
         oY6y4apwnQGUA93dermoR5j9Mmap5em0ZoRIuPcHRPeCtI3uAf+UoOWrQcuKkp1QWxHB
         BJ75zNfMjguXRKOHDxIbgHmQFlHkdfW0r80WBa9JeR2aZDGXpJ8D0mU8VDQWbHAD+ntR
         u9lLb/KvPdX3pTb40/ImoMDsN35VHF6vD84VusjF7WbeDO6gMQhKh8Zs7Z9kRidPRSuG
         6YZNqLEGWbOUAsHwdfyqB4SqzjnL453TLDm14+BcPZi+HW3G0OeCPGCLgnr2kCTWY7K+
         uaQA==
X-Forwarded-Encrypted: i=1; AKwUvByOc8f+gmcGmo9BoYSG36ye70MF/3D4jOMH6r/pA4zqc9mERQJG26/RRHwuffoTMrrWrA8AtzjSGie8mDcV1yfNhZQ=@vger.kernel.org
X-Gm-Message-State: AFuF++lQnkmGadQ5Y0X8jkFCSZZVs0vxReNnMhQgzKniOjJbBbqGGg+6
	ASSLj7wb2NfDL9GG5ykMWjQ5hIvihPBCsBVQCwexOGyisV/QlThSX/ytAMlLoYCEXw==
X-Gm-Gg: AYBFou0jvKZ75GbA2INW9SusdqUM4IhQou53IMaNC/a2GQYx51ctYP2ntRf1UA8DB2p
	VaP9No3yrh1FyX4tq2aT0UPOUvPiC2Vpk1Yzuw3pRazMlI1ta6g/KM8fIiOM+Oduio6vCHbVGTk
	Mc7OiJui1zbm3QGVKLi5m1XmM3vPuSMMaew0uo8lsJhWeB37mW7xpHpYNH4Ddc76GuxGywJvTt9
	QDt6hlrWzh4u2P+sKD7zBtVFfMrNUsqJxo8ApRvBT62XxQWKlBc5qpe1dKz0bhfk7HsPN9bVmwp
	03qDudftgoRs6QVhrhC742FlLCFv8AZN9fNoMAXsZohlNCtTA4GSXuoduT1IECIZs0j/ws5upAS
	V1U4LCFu2cmDy1stj1K6r9zuCBao09eiEn470tpyTjbOeLiwmfITrPrc10ztjiODzlJEV8sc3Xr
	EAW+NRxX5jrhWA4i1bAi1iVml3t0GSrjWnPywbh1uGhcl6b3yjPBgiRELvbSSkCDovzMVzDgWv3
	XxbI5dedBWrPBkbL9TyQ4q/nTocBLOzdkdP9HxlwF0=
X-Received: by 2002:a05:600c:8715:b0:49d:17d4:aff2 with SMTP id 5b1f17b1804b1-49d17d4b01dmr220148115e9.1.1788937005074;
        Tue, 08 Sep 2026 23:56:45 -0700 (PDT)
Received: from google.com (135.91.155.104.bc.googleusercontent.com. [104.155.91.135])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49d04fe7f9dsm350601935e9.0.2026.09.08.23.56.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 23:56:44 -0700 (PDT)
Date: Wed, 9 Sep 2026 07:56:40 +0100
From: Vincent Donnefort <vdonnefort@google.com>
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: Fix ring_buffer_read_page_size() kernel-doc
Message-ID: <aqEDKFX7X3Gjv2oq@google.com>
References: <20260909062917.89482-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260909062917.89482-1-kmehltretter@gmail.com>

On Wed, Sep 09, 2026 at 08:29:17AM +0200, Karl Mehltretter wrote:
> ring_buffer_read_page_size() takes a parameter named rpage, but its
> kernel-doc describes page. As a result, kernel-doc reports rpage as
> undescribed and page as an excess parameter description.
> 
> Rename the documentation entry to match the function.
> 
> Fixes: dae8dda341d2 ("tracing: Fix subbuf resize races with trace_pipe_raw readers")
> Assisted-by: LLM
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
> ---
>  kernel/trace/ring_buffer.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> index 9c03a555a6ba..0e30c7bd6045 100644
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c
> @@ -7384,7 +7384,7 @@ EXPORT_SYMBOL_GPL(ring_buffer_read_page_data);
>  
>  /**
>   * ring_buffer_read_page_size - get size of the read page.
> - * @page:  the page to get the size from
> + * @rpage:  the page to get the size from
>   *
>   * Returns size of the page in bytes.
>   */
> 
> base-commit: 893e11787f78e43b534e252249ac3fff4d1333f8
> -- 
> 2.53.0

Reviewed-by: Vincent Donnefort <vdonnefort@google.com>

-- 
Vincent
