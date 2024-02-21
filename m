Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B780339FE0
	for <linux-trace-kernel@vger.kernel.org>; Wed, 21 Feb 2024 06:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708495917; cv=none; b=o3JRflk1/WT3SrC02OC4gXoPsCGWNuihx6yBNUfPENNb7nEsO3MuDFHP7MZSOLaaJkC7qTNuN0UVJD4NBNgKyRdzHGrS+SViLYF4DZa2INz2m7Z2tL7Qn3w1vexCl5yhSLwVxhkB2bEMjqR1s0OqkLTpbYq3bM1nviLez1TlhFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708495917; c=relaxed/simple;
	bh=2TAQVV25B3Mep0g8bVd1ctba4+Nb47hssI9JMLGlWw8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jtKeaqe59k473RrBQ3HstlwHgvjwPSjYD/tPN4zW8dhETE2xYhGuF0IjoraU2PEC5kZ+vonunH7F6UOCJl4LColCjAUUlORoK2DcPqcbI0Knd4KEpkH/wbkR9w0vbPgJpMM67WMBWAgvJOmkuxTJXp8dsj1Ha6r296PFA+i1PgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yC9ZYg11; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yC9ZYg11"
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-21e7c3e3cf3so3677978fac.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 20 Feb 2024 22:11:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708495914; x=1709100714; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fL2zwEDwboBOluBoCe5ERhhpUpWk0xO78/TTkM69qsU=;
        b=yC9ZYg11G1iqQHNIfpM/Z7zOLx5oT9S+Vt63cIGDgkFUWBH0rWbVZqFqlJJisR1vIy
         gkmkhOdgs/WrmGZUk2R3zP4DV62bSRlFgYzaGAUcxjv1UZqrwQJ39RCbknPwcuF6G/Y1
         iTmttM/HCaV3kp05WoLhK5gPdwWs4mYS9g20hzxuL2LfkbcFrAdUkBJzLSj1Lt3ZICmS
         F7DBkJ1wBelM0AbK1chW9dmD5o7/UtLD4q6VxU8DYwMTeUvwSmsewzzMcynJxgVMfcGb
         ZWhpNzyVyI9z8T+vE1qopd2jmAqEB3JzP0h1jPlu+CE4vNDzx/cnscUVDf68h1SUyyWt
         gSBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708495914; x=1709100714;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fL2zwEDwboBOluBoCe5ERhhpUpWk0xO78/TTkM69qsU=;
        b=rhZRbnpsfe2+yr6vuQjv7QNohEoJ/k4ejKoM4fBy3RAzzlrRoXaZDwrYY2WsJWbMRI
         5dpU/Z7FtqM8vJeTKl9lloLKOJZhUftvnRCWNL9qNfmGrwymE653gYy7D2tYkPLcYy57
         YtEFZbsYilP3KnXFxHaxnSygmfIAuw7cpkxjCScYTWWvopF/oUV06ra9afw/XLP69MPO
         K1f7+eqy3zrhrSCgtIm5dcH1ZSe1M3z+6XGsRXCd2cXscgj1PYgcp/CycC6haVM0IqF1
         aeJbGhjl+LIzjD5AZI10NVdN5rV6VQQgShMpPwYf65tXAFrXxVFm8abr6irYLJRLExe/
         XSCg==
X-Forwarded-Encrypted: i=1; AJvYcCWnJvkH6oH6l3xUmqz4iSObVrGgHrIfzoqS4Hk5WgzSWoHcH2RJ/xT9yeVqElPKbKrxbCxDgTTbsmMP2gETMHidT3/XpuwRatKNUjhpB069IdCW
X-Gm-Message-State: AOJu0YxKCvTmXNTufFprL+wULAYjn5gYoMlxnkSJbdbIhg+5GgpJoRjH
	yfetFxIk088CTM7HRHqOvlvfqtVzAk9qqxaVnKu2xRqndYc2luWTrUcB2GVh2A==
X-Google-Smtp-Source: AGHT+IEXMreBXKcUfZWk6J8tb7zlxvS17xKsDFwi7Dxrk9YaZ/GcMzlIx9Pg4VQIy7bL/eGMHKNC3g==
X-Received: by 2002:a05:6870:ac1f:b0:21e:7ad8:dce8 with SMTP id kw31-20020a056870ac1f00b0021e7ad8dce8mr13146574oab.23.1708495913799;
        Tue, 20 Feb 2024 22:11:53 -0800 (PST)
Received: from thinkpad ([117.207.28.224])
        by smtp.gmail.com with ESMTPSA id g2-20020a636b02000000b005dc87f5dfcfsm7555975pgc.78.2024.02.20.22.11.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 22:11:53 -0800 (PST)
Date: Wed, 21 Feb 2024 11:41:46 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
	mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, quic_vbadigan@quicinc.com,
	quic_ramkri@quicinc.com, quic_nitegupt@quicinc.com,
	quic_skananth@quicinc.com, quic_parass@quicinc.com
Subject: Re: [PATCH] bus: mhi: host: Change the trace string for the
 userspace tools mapping
Message-ID: <20240221061146.GF11693@thinkpad>
References: <20240218-ftrace_string-v1-1-27da85c1f844@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240218-ftrace_string-v1-1-27da85c1f844@quicinc.com>

On Sun, Feb 18, 2024 at 02:13:39PM +0530, Krishna chaitanya chundru wrote:
> User space tools can't map strings if we use directly, as the string
> address is internal to kernel.
> 
> So add trace point strings for the user space tools to map strings
> properly.
> 
> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>

Reported-by: Steven Rostedt <rostedt@goodmis.org>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  drivers/bus/mhi/host/main.c  | 4 ++--
>  drivers/bus/mhi/host/trace.h | 2 ++
>  2 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/bus/mhi/host/main.c b/drivers/bus/mhi/host/main.c
> index 2d38f6005da6..15d657af9b5b 100644
> --- a/drivers/bus/mhi/host/main.c
> +++ b/drivers/bus/mhi/host/main.c
> @@ -1340,7 +1340,7 @@ static int mhi_update_channel_state(struct mhi_controller *mhi_cntrl,
>  	enum mhi_cmd_type cmd = MHI_CMD_NOP;
>  	int ret;
>  
> -	trace_mhi_channel_command_start(mhi_cntrl, mhi_chan, to_state, "Updating");
> +	trace_mhi_channel_command_start(mhi_cntrl, mhi_chan, to_state, TPS("Updating"));
>  	switch (to_state) {
>  	case MHI_CH_STATE_TYPE_RESET:
>  		write_lock_irq(&mhi_chan->lock);
> @@ -1407,7 +1407,7 @@ static int mhi_update_channel_state(struct mhi_controller *mhi_cntrl,
>  		write_unlock_irq(&mhi_chan->lock);
>  	}
>  
> -	trace_mhi_channel_command_end(mhi_cntrl, mhi_chan, to_state, "Updated");
> +	trace_mhi_channel_command_end(mhi_cntrl, mhi_chan, to_state, TPS("Updated"));
>  exit_channel_update:
>  	mhi_cntrl->runtime_put(mhi_cntrl);
>  	mhi_device_put(mhi_cntrl->mhi_dev);
> diff --git a/drivers/bus/mhi/host/trace.h b/drivers/bus/mhi/host/trace.h
> index d12a98d44272..368515dcb22d 100644
> --- a/drivers/bus/mhi/host/trace.h
> +++ b/drivers/bus/mhi/host/trace.h
> @@ -84,6 +84,8 @@ DEV_ST_TRANSITION_LIST
>  #define dev_st_trans(a, b)		{ DEV_ST_TRANSITION_##a, b },
>  #define dev_st_trans_end(a, b)		{ DEV_ST_TRANSITION_##a, b }
>  
> +#define TPS(x)	tracepoint_string(x)
> +
>  TRACE_EVENT(mhi_gen_tre,
>  
>  	TP_PROTO(struct mhi_controller *mhi_cntrl, struct mhi_chan *mhi_chan,
> 
> ---
> base-commit: ceeb64f41fe6a1eb9fc56d583983a81f8f3dd058
> change-id: 20240218-ftrace_string-7677762aa63c
> 
> Best regards,
> -- 
> Krishna chaitanya chundru <quic_krichai@quicinc.com>
> 

-- 
மணிவண்ணன் சதாசிவம்
