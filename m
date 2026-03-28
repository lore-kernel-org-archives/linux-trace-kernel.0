Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4444D306D2A
	for <linux-trace-kernel@vger.kernel.org>; Sat, 28 Mar 2026 04:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774673829; cv=pass; b=DhpQSqd7SIeGbnPBYv9BAkaH5jSJjl/JfpB//pYI8Ooa/GXnQ7ZOQo7eD4c1PgqHW8gZnM/KEULF759bmboHlsrv4qRPq91ipZy6EvpH7jSO6r8ZzW/d9a+U9lDsL47tne897Qy3HgfljS1m/NB888y4X1d7/lJDN5mjoVo0350=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774673829; c=relaxed/simple;
	bh=+4R39jBltVGzbIw18Ru3BAk5E+bTIc59uxduvZAZ+7A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MO03ZakOqdASrgA71rf3nDEVp8XWq2Y6C5zDVBAwldOTR4YRYyE1V7ZGU+cQjRFg/oJGjeJIlaqFh7iWFPECoYOflfpbI+tX845lBREs8VFmLqNQR/BbGro8zlJQxqeWqfzt0gIc0nQSZ0S8x8IbHKNxLwpOxuf1e5D9uYmD8ng=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Av+QlXVA; arc=pass smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Av+QlXVA"
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-12a693cdf29so3164061c88.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 27 Mar 2026 21:57:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774673827; cv=none;
        d=google.com; s=arc-20240605;
        b=YtYyKy+lDjE8wjOMzPP+PYnmmSvbF122ga3QmOEta5o9H6CXtIG+5cYFtYD3QTepxj
         tnQn5+1cVIXCo1Tr6P1lS725q14ViuvcHjZ3Xj25sCNxHv5mShS3THntoG7jVcW/+wwR
         GFlpFOg6DtbA1cb6ec6x43+ekVP9VBY6QIeA5TA+Ru6tY3VejM0qg6DGF/lw4qsReCiY
         mLMIJs/cBvnayzbPD87dh5efan0mH00nW2AT4TC2xVbRt3WRpXLZ2+1mDOBrtpW3Ouhn
         asBFa2515WeDLcPu+vyIZ+md1enHNzlN7f1DfQ37BRxJF+Kz0HPAzx8YG4VEMNZ6YwTL
         J2oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=+4R39jBltVGzbIw18Ru3BAk5E+bTIc59uxduvZAZ+7A=;
        fh=KRvFATtG+lCnpsVjkBcaLMcwFEaA6SiRSqICTDnUGtY=;
        b=jIY11giG/JPpGFcU/OhHaUvx4JpUf+oLNLvxilebwEohQoV4/AfIk4ZWjq3LF2ByFs
         nFsXSFR7+kcEJl1qJZYgiKspLqrKXrrW7DEx7a/ESJErkKLBlWlTP6F0sfvI51gR2m+1
         yn5t5Xat0hDexsZw2yWohW7Jd2MTzQzGdG7Jvj5bkXMFkTqRT1TRf5VV4H9jD2iv0nOl
         mo++TdnWclwolrZXG8UZ9q0ZO8Pt2CGgj+ufwg+IKUcHSmx+cbya8/B++vygTUu42YpR
         tGusFpVz6g9FfzTzP6IVipS+91q/3eFBlx7JqVqoLACvgu8LOIUtSJ2h9hn7gbPHNs2t
         2TaQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774673827; x=1775278627; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+4R39jBltVGzbIw18Ru3BAk5E+bTIc59uxduvZAZ+7A=;
        b=Av+QlXVAV3vx17yrKsD9dIKMtZI29xz+yw8Js8yB6x3xepP0CeJKS9jpFVmmYTjsmp
         OXwV5nZCYnu+cejaswTCIx0DIZ+82K2qktSVEqYyd6E4nmOj+/xCBxiitdkcpshW6eG1
         5w3QM4KWphEPt0+MtmvokZQ4RFnvWDwYTFJ3a5E1xv+bLMyUIRZ2LvbtmUEVr7yLgRD0
         zzprfxEu4W/yCMLU8T78T5cRPgF5JuHJm3CXEpln71Li0n4VlkCLXi5UeErw6B/lUSUO
         dbXW/efh9U197MFXnGqLIhmtU7tS2H9z9+MXd+ZlZfZQnXJFVtKldHzCITAfCSMcZqIY
         k3DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774673827; x=1775278627;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+4R39jBltVGzbIw18Ru3BAk5E+bTIc59uxduvZAZ+7A=;
        b=eA9j52XG7kwaJHFld+3cKbuYbDqyV1Dc5qDZ0OQlu3okP14pBeC1IAr04vLJcTbguT
         qG9KABPMOCoAH4m6vMFJXW4/WSmH4+CBqM392JtrD5j8S8EvEb7OB2a/UMp12wHZ1dLp
         1nO2tLvAPwZzhkVLVCi8mpFbJFJbsLYpYh5UN5CkUv8ZpB+B7I+yXIy+27WEhdLdv37b
         59Yi3bVrfbK4HEvuFSL8MRLNfeIEJLaZkv4fashbP0FdqPCWxjop338KEihNggfhAGdo
         DZIGOpqSt4trV3r2vvoXRAS+l2ppX1WxjqhFIeQU7YJorQ7/rT3UFPlluDkwVWaVFL1L
         vtKw==
X-Gm-Message-State: AOJu0YwhHet8BH5MUFPhMaHPk4s3RlcbP1kimMjGE3D/3dh2YiQph3Dw
	pbObAODuHdck+9ERyakgHDCSH1ga3aX589Mynwl2KVN0bHe5G9fyXiYNsSPGqD7Tnmir9KwDi0T
	RGvHxDlmy6E1hp/MPWl8d093XnidF5Qc=
X-Gm-Gg: ATEYQzyZAjGNdBVTxiSLtseZOh5o3kJZ05plfGeI94uRvKXKmEvIxM+fbK6AUwVzirl
	IqdMU5f0R5EGw4i3UZd0zD5t09Kt0F4UFmkoY3Rh44FbsUf4ZzPaS3o3vO1YDONmYEVh4HUohs2
	8DW+/CRERIuHD5d3GNd48qYR/5VAm3miVtnwE4gHy0BevJ0BmbAaEXT0pOFI16NR0MRMQqlrKEW
	fqsG+JFxxbwQAsJElfLyGuXmY1Q9ECNlYLVhGj0m3j6dxBs7sLA1tsCEXeJvm2EHS0/LGWjefJR
	7qhi2C+jh3vPZjfxGcthI9aLLkAG2nWbWAGkjvybzt/UOCpIXhQ=
X-Received: by 2002:a05:7022:239d:b0:11d:fbf1:1e27 with SMTP id
 a92af1059eb24-12ab305432cmr1987679c88.19.1774673827286; Fri, 27 Mar 2026
 21:57:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260324221326.1395799-1-atwellwea@gmail.com> <20260324221326.1395799-3-atwellwea@gmail.com>
 <20260327150634.5df3cf4f@gandalf.local.home> <CAN=sVvzFMC1m2aGT23aRpPpoddBVP59mQBmEsQyEPKBYm3J_Vw@mail.gmail.com>
 <20260327223022.167defcc@robin>
In-Reply-To: <20260327223022.167defcc@robin>
From: Wesley Atwell <atwellwea@gmail.com>
Date: Fri, 27 Mar 2026 22:56:55 -0600
X-Gm-Features: AQROBzBXixs_1bHGezATrCDRV4JQ9282_1E3qbUU5kp8ynig-T_EsPTGmaYGpYc
Message-ID: <CAN=sVvy3ghzJtXjT+V4uhF1153xtHW7wBkS=kHgW2=KYS719cQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] tracing: Drain deferred trigger frees if kthread
 creation fails
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	mhiramat@kernel.org, mark.rutland@arm.com, mathieu.desnoyers@efficios.com, 
	tom.zanussi@linux.intel.com
Content-Type: text/plain; charset="UTF-8"

Hi Steve,

I'm glad the test case was helpful. I'll include similar testing
details in future commit messages and avoid grouping unrelated
patches.

Thanks,
Wesley Atwell
