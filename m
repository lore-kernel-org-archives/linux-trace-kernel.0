Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E717E6AC0
	for <linux-trace-kernel@vger.kernel.org>; Wed, 10 Jan 2024 06:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GkckBDl9"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6d9f94b9186so3236569b3a.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 09 Jan 2024 22:43:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704869007; x=1705473807; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ufriYbCxMamJExkyO+DSziDprmr/nvohHV8KvnEcisE=;
        b=GkckBDl9tyDeaKoq1OlLbr6jEBwdbjzMGB0I45CAU6xI+pgxYAVVcgVcq2AKQpBjM7
         3wnDntahFoAcep5K8VnjbMQzSJIofcavO4I7WeCodBVsVW8sbbAy3vuCAA23d10llbWQ
         O0Sa1BdzkP2xMT49yTz2ONeRQ0t3IdlTQum1qPOpfmaOziYsSz+6XZRSr9zXz8ZyI7IT
         OorO6nPNXk+DvFyUSi31O7tQPj6+WQAiDZdAp8KoiEEuE89AijmVyZCZabZe5dKcdwdV
         PbKiXXhbg5q2qGY1BdIQLX4bb8S1WkyNIE0CjOlaKMneYqwUl0Y8joqktrM0wx4EbVEw
         JFlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704869007; x=1705473807;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ufriYbCxMamJExkyO+DSziDprmr/nvohHV8KvnEcisE=;
        b=UsfvbDnaJ6s+v437Ij+Pcf6ohYKodaH1BCIa5b4RuQnPXAkemUmiv7urYk7oRFlIDR
         ZYJoykv/+jlK1d5j+hhhQUCPZB0NpmklyAeFxcipqjxZ9xpSx2cSXneHcx/BrF0erUWi
         fgNHtWTz/urkcJvEWeuJKSvmpYuXjjWNanwmqpuhqmqSMlbWlptif8ea4JfBIP0HVxrZ
         iAlfy6jIEgsXOuWbUckMQi7cf3jP2KlvP1EsYcxdd8CET4KZNlPRIVeKdAxTCPOcyjQc
         E41bCX9hrONRBPQYsF3PuBdwnNYJOBi0Kw34RbWNr3gWeXwga4GzoucFMbhMHFcPo0xt
         S9tA==
X-Gm-Message-State: AOJu0YzM4F5EEK7z5MNLWHEJBxM2pMpdorZyw9M8nSVaziXO33QUzQNM
	XTUosZTqiu3yvDBdtbgLoI8EoB1mmwbWHA==
X-Google-Smtp-Source: AGHT+IHVmZ9O2UiKApFYg6a+2bvUEeNRE+QH24QgnpIssMtERJd0DP+8Dglnh788IGmlXjBYlPjMPA==
X-Received: by 2002:a05:6a20:1682:b0:198:7feb:97ae with SMTP id q2-20020a056a20168200b001987feb97aemr365175pzc.123.1704869007250;
        Tue, 09 Jan 2024 22:43:27 -0800 (PST)
Received: from localhost ([122.172.81.83])
        by smtp.gmail.com with ESMTPSA id n5-20020a634005000000b005cd64ff9a42sm2618582pga.64.2024.01.09.22.43.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 22:43:26 -0800 (PST)
Date: Wed, 10 Jan 2024 12:13:24 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: linux@armlinux.org.uk, catalin.marinas@arm.com, will@kernel.org,
	sudeep.holla@arm.com, rafael@kernel.org, agross@kernel.org,
	andersson@kernel.org, konrad.dybcio@linaro.org, mingo@redhat.com,
	peterz@infradead.org, juri.lelli@redhat.com,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
	lukasz.luba@arm.com, rui.zhang@intel.com, mhiramat@kernel.org,
	daniel.lezcano@linaro.org, amit.kachhap@gmail.com, corbet@lwn.net,
	gregkh@linuxfoundation.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, qyousef@layalina.io
Subject: Re: [PATCH v4 1/5] cpufreq: Add a cpufreq pressure feedback for the
 scheduler
Message-ID: <20240110064324.bex3ssej5ghie6cu@vireshk-i7>
References: <20240109164655.626085-1-vincent.guittot@linaro.org>
 <20240109164655.626085-2-vincent.guittot@linaro.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240109164655.626085-2-vincent.guittot@linaro.org>

On 09-01-24, 17:46, Vincent Guittot wrote:
> Provide to the scheduler a feedback about the temporary max available
> capacity. Unlike arch_update_thermal_pressure, this doesn't need to be
> filtered as the pressure will happen for dozens ms or more.
> 
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
>  drivers/cpufreq/cpufreq.c | 36 ++++++++++++++++++++++++++++++++++++
>  include/linux/cpufreq.h   | 10 ++++++++++
>  2 files changed, 46 insertions(+)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
