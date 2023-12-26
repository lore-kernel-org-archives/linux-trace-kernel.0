Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E284B12F
	for <linux-trace-kernel@vger.kernel.org>; Tue, 26 Dec 2023 05:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hOaTTgEY"
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-1f060e059a3so3507910fac.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 25 Dec 2023 21:32:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703568756; x=1704173556; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Z/yCtDNlZbkApsOPbotq0miDNKgFHHdTcJH5FR2SEXc=;
        b=hOaTTgEYTZFUhkKPe/tTr0A+O6ry+8aqpDGvL/7WcXFQ7tS3Ab0jCSQCYdb6eRKrK/
         4iRonRTjOkLVIo4YpNwMgoZudk/eFIjWkTR60TuExCXEML8k2skp5hbuvvdEm/qIhoI7
         p4GniBdX+jC/4rK1BpShCgq8CqrU9tXrI1isW+Zq0wht+vRb4EifiSzDg1ZB6hfuy1Fg
         ve7tA+DwFpYmUFkPXkEU/EJkxH0MSIMrK1Xvaxr1OkNOkL8QeZde4fglr0g7+o0MCjhv
         GxniQzdRK/cxrWKqbfZp12yMNrJh9iX8I0sfkOxF8RiQ9gBMtMOktU5pyOptq1NB14Mz
         Fi8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703568756; x=1704173556;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z/yCtDNlZbkApsOPbotq0miDNKgFHHdTcJH5FR2SEXc=;
        b=bvscP1/sE8CtDTYh2cuqYVnmJ+xrHSVCRcN6izYM0M7L275Ao9WFLzzDVBPb8dSwTm
         vGtT4N4N8n7sNPYQKM/xEEsxGnn56cH5X6zh+wTuUkBmgh+sQEHeeSZ5WmHgky/85oGW
         g3CVULJ6J0X1cGdQi/TcRT6iyg6IVSSr/lothmoxvqUNe6EXlNdO5goLLvf6/tb/7xWH
         Xgli3MgF+jhhRbg6RwsWa+OmvkHEn4FC0jbpR1aomuaNE53TrzdBKwv9b/lP4xhKNBB/
         LQEU41JsIdohzhJdRcnzY+2NuhQoQxMeTboIlTw6/EKIp+l/2yBoQBcJ9zda/qSir1t9
         nDyQ==
X-Gm-Message-State: AOJu0YwUGOEzlIw2nXlFL5yfBEyD9xhdiFQiUgAP3h9SYNsCSUu4WiNw
	ROpfmXebsK3lww1CsMWOdHKa2rHeyuEkvQ==
X-Google-Smtp-Source: AGHT+IHsV2cCLwDgQ+aRxdEBipW52bolZPopgXkwJdwS+zecDa1ZDPFsMRrh5GOgq3Hk9laWbArYnw==
X-Received: by 2002:a05:6870:858a:b0:1fb:31a0:619c with SMTP id f10-20020a056870858a00b001fb31a0619cmr8333158oal.47.1703568755795;
        Mon, 25 Dec 2023 21:32:35 -0800 (PST)
Received: from localhost ([122.172.86.168])
        by smtp.gmail.com with ESMTPSA id u18-20020a63f652000000b005cd821a01d4sm8703700pgj.28.2023.12.25.21.32.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Dec 2023 21:32:35 -0800 (PST)
Date: Tue, 26 Dec 2023 11:02:33 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: catalin.marinas@arm.com, will@kernel.org, sudeep.holla@arm.com,
	rafael@kernel.org, agross@kernel.org, andersson@kernel.org,
	konrad.dybcio@linaro.org, mingo@redhat.com, peterz@infradead.org,
	juri.lelli@redhat.com, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	bristot@redhat.com, vschneid@redhat.com, lukasz.luba@arm.com,
	rui.zhang@intel.com, mhiramat@kernel.org, daniel.lezcano@linaro.org,
	amit.kachhap@gmail.com, linux@armlinux.org.uk, corbet@lwn.net,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/5] thermal/cpufreq: Remove
 arch_update_thermal_pressure()
Message-ID: <20231226053233.gtvuflyonkcifa4x@vireshk-i7>
References: <20231221152407.436177-1-vincent.guittot@linaro.org>
 <20231221152407.436177-4-vincent.guittot@linaro.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231221152407.436177-4-vincent.guittot@linaro.org>

On 21-12-23, 16:24, Vincent Guittot wrote:
> arch_update_thermal_pressure() aims to update fast changing signal which
> should be averaged using PELT filtering before being provided to the
> scheduler which can't make smart use of fast changing signal.
> cpufreq now provides the maximum freq_qos pressure on the capacity to the
> scheduler, which includes cpufreq cooling device. Remove the call to
> arch_update_thermal_pressure() in cpufreq cooling device as this is
> handled by cpufreq_get_pressure().
> 
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
