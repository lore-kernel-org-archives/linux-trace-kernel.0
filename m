Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 541306FCC
	for <linux-trace-kernel@vger.kernel.org>; Thu, 22 Feb 2024 05:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708578899; cv=none; b=B9RhuwnWKBfS/zvvIKIGMiuEk9/olWgqQWh0Wh3W2ITubjQxYROqpUFZ7qYG+LR8e+0ulULG+IcL3vaxArx627QA0TepJ06x/lwosBgshEzQcFjtkyDZ1xSdJcmqt7AD+E0El620h29q+4Q9iXSn66JXqO0On+daYOa0MorNSNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708578899; c=relaxed/simple;
	bh=3qny8yzuMmyJ1HQecd7Y6U83EBozIttdj4TJ16oo/RA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bf6daFW1UwmnGmljmzsGP+FgeIs5QI0D0MlWv91Los/QUPPCz8qDEh95ifB1LI5HryTQzTK82+qTSkR0fQ4LhY+eR2BgswNLW4WhzW2xkDYtkxMFtsbJ4yKQ5jEJVTQnFThQ7ASu/Kml1EE4aMjTBIFmYnHRyPtrrjef6YWhMdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nbQaCYzF; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nbQaCYzF"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-5d8b887bb0cso6085544a12.2
        for <linux-trace-kernel@vger.kernel.org>; Wed, 21 Feb 2024 21:14:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708578898; x=1709183698; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SjzQi95PdLFUOi++bhedl7ZKNdPeeAhvaDxnULICb2Q=;
        b=nbQaCYzFHkSsh5xuQmilSY8caKzng7EsQVlrt0dnXkF0ss7nOHTAG5hGAOAWJvWpoI
         NgKvwLyUV9VDTIz0RjIAdBrhQdxYX2DJo6jbri4kL8qc00JgB81yovWj8ZC0j14/2pNt
         C8SSQWpgYZPydqS8B8ptc9VpTJ4xPaQB6rx0EIyJD0f9m/eBS+kNliKShqaVi+OKzDOV
         fieXFpCRfs/VjpObzj2P5ZBlBhh2K4IcaLSnmsJdHJa81h61qAtkz2MMaPuNIvv/aJU5
         B1rqQ28lMF1De2os6/HLPzuZM5k4mx7DdYjgYxPPZkWARBJ/uAalDSNV4769+tIHyPRt
         r9/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708578898; x=1709183698;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SjzQi95PdLFUOi++bhedl7ZKNdPeeAhvaDxnULICb2Q=;
        b=Ltz5+rJNt04JatIPc5A/VmXqui8MulhIPx48XPP1dOR/SCUR3LEnUFIVcW7qzhSpq9
         HHshTiqlnknQjmSZR2iyBlLkGqqb0BXLteP1s0PtJnt+XBQ85Ey8+rRSAL1neETwNvYk
         u8HDEVu7bj1jkEk7vqW2FQFp2MhI3zgBEc4fvi08bTYDSeL9fnrGoaH66A4QszAbY4ag
         NTJWrXyh8XivtvT4OdSHAXQkXw+E3apcy0OOgCzVwhATOH4ztoy2yedo12vGMIzlRCrD
         mYiLtiy+eGEBDl0oOCbm7VIVbgxf3BQwz8uXHYvp2AJqzAz7dCbsi5OxFlfzOYNrY0S1
         lHKA==
X-Forwarded-Encrypted: i=1; AJvYcCV3xESOCw7m4OgNZxlWeM5Xe23v5klldTrbsDF/3cgi8jctk5A3GfJBMMhndXpLRn8r+aaRo1A1NjxqtawVUyJV4Z70gP/A7GQR/Hg4Vy0aSZSf
X-Gm-Message-State: AOJu0Ywoe1SIhDlwWv47H9zQj+mxDWfQKN8p0sRDHxm6LtGBluOggMOd
	VeNde5ea/BwMlAjn3+oq32/J2LG0S6lT4kZW38pr66KpYYJCn7Xh8JwjmDDjHw==
X-Google-Smtp-Source: AGHT+IGu63MPfTR0XWOYa6xte+sdI5ID4/pSdH0NA8SBF3CrpzvthDgTRKHWJ6IOCsRKwwxCAnXzlQ==
X-Received: by 2002:a05:6a20:d04c:b0:19e:9a59:20df with SMTP id hv12-20020a056a20d04c00b0019e9a5920dfmr26902478pzb.9.1708578897688;
        Wed, 21 Feb 2024 21:14:57 -0800 (PST)
Received: from thinkpad ([117.193.212.166])
        by smtp.gmail.com with ESMTPSA id li7-20020a170903294700b001db35d8ea6esm7109815plb.294.2024.02.21.21.14.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 21:14:57 -0800 (PST)
Date: Thu, 22 Feb 2024 10:44:50 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Krishna chaitanya chundru <quic_krichai@quicinc.com>,
	linux-kernel@vger.kernel.org, mhi@lists.linux.dev,
	linux-arm-msm@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	quic_vbadigan@quicinc.com, quic_ramkri@quicinc.com,
	quic_nitegupt@quicinc.com, quic_skananth@quicinc.com,
	quic_parass@quicinc.com
Subject: Re: [PATCH] bus: mhi: host: Change the trace string for the
 userspace tools mapping
Message-ID: <20240222051450.GC3374@thinkpad>
References: <20240218-ftrace_string-v1-1-27da85c1f844@quicinc.com>
 <20240221061146.GF11693@thinkpad>
 <20240221091103.37497ed0@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240221091103.37497ed0@gandalf.local.home>

On Wed, Feb 21, 2024 at 09:11:03AM -0500, Steven Rostedt wrote:
> On Wed, 21 Feb 2024 11:41:46 +0530
> Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org> wrote:
> 
> > On Sun, Feb 18, 2024 at 02:13:39PM +0530, Krishna chaitanya chundru wrote:
> > > User space tools can't map strings if we use directly, as the string
> > > address is internal to kernel.
> > > 
> > > So add trace point strings for the user space tools to map strings
> > > properly.
> > > 
> > > Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>  
> > 
> > Reported-by: Steven Rostedt <rostedt@goodmis.org>
> 
> Suggested-by: may be more accurate?
> 

Sure. Will change it while applying.

- Mani

> -- Steve
> 
> > Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> 

-- 
மணிவண்ணன் சதாசிவம்
