Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E7C248BDF
	for <linux-trace-kernel@vger.kernel.org>; Wed, 15 Jan 2025 11:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736939541; cv=none; b=L/ecbbQkTycoLmDDTcUe9J8A6mTfbevPFT1IdQCxy6DUDJf+1HftZ89zzUriMWlK4GDT6ofCKfNhNYmt4c2L1nIONHyEOzcc8bpdpXGZxPblZT+sHSzNGvMV/JAsnAALSWi5KSz1MIF8HpQ1vRK6+h3w7RqXgpHeUPtSwDxsiu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736939541; c=relaxed/simple;
	bh=ncN/6GUyiJWBB7eCcc51tg1zrUiwdh2XnxAt6ZN4BoM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hHCmqkEPVd26gW2t0toDIxpvlwjhngsOEaen0bUOzzUEJsJMu1Chu8AZ8pSLj8AJBLvq6VfI1zlfsbdDS+/FxYKct5Wxyxs+7zZy3uq72KODQAGBbXO4K1KpZXNtGG/CnwkrAaJV+7doKBuTjlW1SYa4zVSUHVK7CyK0K4nFa3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pr0dqjLH; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pr0dqjLH"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ab2c9b8aecaso908940966b.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 15 Jan 2025 03:12:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736939537; x=1737544337; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zgaAOweQb71OwFhtIsVZvOPhjn8Kd9vaQDqquf4yuhE=;
        b=pr0dqjLHHrOnVOr/6cV4n4509CnF4cCVUNh6CvC/sanxWWa3g9859/IdYYzWwaT5TP
         BGq5kaGQiFzghkUQHatNI3NZQ7Uyd23X7bbQXeaGxRvSJut8XSsAWan/kkMr3sUOdGnt
         Ljs3P9aPFfG+7Ba76+iVHmQZduorlS+EVl9+T75WtT9dF4wU84F/OvcK/RlmQILy1Gld
         zxzxgNfktawiPewy4QE7C54O7pyzfJJSOGjrhc6+0wXSW/PRJH5fSL6w3DOI8fZXgp3J
         T06Fw+7eV4ktRRLU/4qJnaCwrqPb/A+Lf6BK/It9pIgyZ9c3SshorrSHEZobTQ/D1ceI
         5reQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736939537; x=1737544337;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zgaAOweQb71OwFhtIsVZvOPhjn8Kd9vaQDqquf4yuhE=;
        b=djSWrx5anBYo670BIfcx2woqz7SPfQR6Ov00g+6cD74CgIjnlcwmamFUNvHU8/wVLn
         wvXZMnrviRCnZNZ84TFosX8tcCyjyUQJRVbCuw4/ESADtnuzZwpEJzgPJpJfugmI/HzR
         UfJ1LEbnYMcGwr7s1kx+5YB+ijm62QuH/eJfkNTJtYqz5xcxn2IJiQreBJZXUBTebgzq
         6pSH9m+MvCR3pcG64u2JrCueaK0rY5PSOCz44OKYHP57Wm6Te5+vlkKqoP35s9d5iHWI
         CbiOD2dWF1ANJBJ15RcNy8o5kTkw97bnixY3kDqYvdcGNaj5CNWsiYUoM8NWK+HW3PNN
         yyVA==
X-Forwarded-Encrypted: i=1; AJvYcCV3D2okaI4ce0kZEBwnlJypSWwV2evn8s/jQXjxiAmKslgdp/HVQ/UurqjvqiGVmWlLSUvnQdt8SeoMFoTu4KxwyeQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaN8VM495o/9RZUI2N3/yu9IECbXtLWpvB3FBVjUq9zFUOROC2
	3aHuUHRhm+02BMOS6RHXXemLrS4IlWZMI2rrSwCeI6H7c7O0wLgmQpLe7gboAe8=
X-Gm-Gg: ASbGncvANUcVxwCxLpZ6UvCU4G+cI5TQGpQvWeIEr5M+HUDG2cXrGl8aLH/zAZ5yHI7
	3MezP+PyZPk3w/c+klJ5Bfmc1Tcyet5DbSfZ0epeUp2x2se6piz+aFAv7XLJQaoNppaNE5KaGmg
	6MoVTFQYVmb2G+MVTQMUt+pTVVyfPS8Ja0wZOTeQ/cug6e+JO6n8KJjtqvCB2EURm2zulovqZ97
	85awdc7zT0/HD0B6CP4rXDtahPXo7jgkZb0D9VnTmYasQr+Bg0VqY63EDtcEQ==
X-Google-Smtp-Source: AGHT+IHJr6V+PPhdzpc+SbrFprkZ471QbDOH3WILGCE4sK4Gu0UuGCEFsPEB6d5nsHlakr+3W70JmA==
X-Received: by 2002:a17:906:7f84:b0:ab2:d96d:6364 with SMTP id a640c23a62f3a-ab2d96d888fmr1776570766b.18.1736939536889;
        Wed, 15 Jan 2025 03:12:16 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab2c90d7432sm738738966b.49.2025.01.15.03.12.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2025 03:12:16 -0800 (PST)
Date: Wed, 15 Jan 2025 14:12:13 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Costa Shulyupin <costa.shul@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Daniel Bristot de Oliveira <bristot@kernel.org>,
	John Kacur <jkacur@redhat.com>,
	"Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
	Eder Zulian <ezulian@redhat.com>, Tomas Glozar <tglozar@redhat.com>,
	Gabriele Monaco <gmonaco@redhat.com>,
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] Fix bug and add osnoise_trace_is_off()
Message-ID: <d4b0cf45-67ab-47ce-9acf-1dc934dcc50e@stanley.mountain>
References: <20250115081157.1274398-1-costa.shul@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250115081157.1274398-1-costa.shul@redhat.com>

On Wed, Jan 15, 2025 at 10:09:56AM +0200, Costa Shulyupin wrote:
> diff --git a/tools/tracing/rtla/src/osnoise.c b/tools/tracing/rtla/src/osnoise.c
> index 245e9344932bc..20275642a74cd 100644
> --- a/tools/tracing/rtla/src/osnoise.c
> +++ b/tools/tracing/rtla/src/osnoise.c
> @@ -1079,6 +1079,25 @@ struct osnoise_tool *osnoise_init_trace_tool(char *tracer)
>  	return NULL;
>  }
>  
> +int osnoise_trace_is_off(struct osnoise_tool *tool, struct osnoise_tool *record)
> +{
> +	/*
> +	 * The tool instance is always present, it is the one used to collect
> +	 * data.
> +	 */
> +	if (!tracefs_trace_is_on(tool->trace.inst))
> +		return 1;
> +
> +	/*
> +	 * The trace record instance is only enabled when -t is set. IOW, when the system
> +	 * is tracing.
> +	 */
> +	if (record && !tracefs_trace_is_on(record->trace.inst))
> +		return 1;
> +
> +	return 0;
> +}

Also this function should be declared as type bool and return true/false
instead of 1/0.

regards,
dan carpenter

