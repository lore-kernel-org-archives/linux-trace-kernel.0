Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D3B146A72
	for <linux-trace-kernel@vger.kernel.org>; Sun,  7 Sep 2025 19:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757274713; cv=none; b=XE0b8nnCnh+DcewpMQxF1ZHsXeNMebzzdUKUyjYw1cDs6Tc54vrIEeBTeygHV8UvNq0x4qObwgAVsDWM/NgE4+O9Y6XdUeivWxaPwRznzhgDVAiOCu2cdrU0IPr1Gzznuc1iIHlUx3grcYaaqTzaI7+VkoGfoL9PjrcH6U3j0N8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757274713; c=relaxed/simple;
	bh=QfBisxMHgO7r/vlhbwhxhBMG2Cxv6MLUCkeyY5mG5Uw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Sr96kf4ELrkV75xD3uKz+1gEAxCKS7y52WHcc9hRHs5l4wX/aTBKA0+mpkr7KXvXWQXAlzeFwja4aInlY2aEml3Jmk/EioxDCPpACJw2KHIRa+HzDc8iu8Ei9TzmIvhiU6c81gt8IC/khRpIa3ULSTAzKBhEmTFf+KtFuXCqyvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KdpSGo9r; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KdpSGo9r"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757274710;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=j2VD2GYTX6Z0Jbedw0fadmaMIRvEnBVSxYP1uTl7p6o=;
	b=KdpSGo9r+zRVOXTvRueXughizDucfb5LBnjzLh5yJVniqZTQ/Mm1nShJFDr+efQy4LvENS
	4lMeH1hfvEG3iQgHspjdPvECDNgoSxyk/hvNRpahtmis6vVX0UT1Wuz3ETIwob90fb1cnp
	/G7kdNU/kSZ+ScIN63jutMWRJdTRO0c=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-139-Pi46ocYPPk6yVFV8l_xQ5w-1; Sun, 07 Sep 2025 15:51:48 -0400
X-MC-Unique: Pi46ocYPPk6yVFV8l_xQ5w-1
X-Mimecast-MFC-AGG-ID: Pi46ocYPPk6yVFV8l_xQ5w_1757274707
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-61cb4b06b86so148823a12.1
        for <linux-trace-kernel@vger.kernel.org>; Sun, 07 Sep 2025 12:51:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757274707; x=1757879507;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j2VD2GYTX6Z0Jbedw0fadmaMIRvEnBVSxYP1uTl7p6o=;
        b=UJtepayb+nWCA2Ej6dEMf9wlq2wx9jh+xjtInC1difU9a0ODhjMQEeMn+HWX0d1gya
         stNMH7PyOb47DO0PzrLklj9uzaMkrJ6SFesL8t6zwYNHXhDUWJuZg7ETX8itS4U3l8aG
         2+CZEcc8P0gQy26PjB/EM7h22/OJ4trF8Td3w1iednU8mH1kuC5sJqLpc75wIPewkAOF
         YRC3cV5D6iYOcYsXu2nT6A9KeuiavX287H2831ikTajEHibzP+pfrn1ygYn130XmFgAA
         XajQ1KCC5TGcsUryHRPN7dHoVkOqaAR0P0b3JHzFttulw/gP/tIWO/JKCKZhv+vZn6RI
         pRww==
X-Forwarded-Encrypted: i=1; AJvYcCUKOGg4Hf9Wzo354WferHigMThC+9Ty2LcAgpGZk8NRLO3Vlfpow/b6vWj/WZ3HAB0COQSzg/dDmCLRCSa/5EyXmTo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7rDXJPqTenXbzAbhj7YWbyh+59ZA/I2OaUO6tLvSaw32w/b8L
	yylUad0avkh2pDCNEpuiGxUEca0ZAMU2xAQSkng6OYnE8UKa317QyTH8ZMQJ33jBR/n1q3v3YB6
	lGB9FyEs0pBOADrUozenfFdHn3nSo5bZSQ1RBq2vYczb5Sl8JfPQ5vyEv31I2fbgNXZdFb1PfqP
	xWX0MeCVhSGPjz5hEtL8IG15eFLLr8F9ba0xq827Jhqcf3mIvI2Z8sz9T/6/o=
X-Gm-Gg: ASbGnctgk1Rl+Z02Le1aAbTm84XhjuYJNkDDvhMBOzK9LFy6le/8VBTe6yuS7eBksHC
	KlO0Iy92dQT5zQAI3hkDWQJtzP7C6jPaL26JqAyRfNcFLZuTfazJW0MQPmz+ziKd0s3/JZxy7Qs
	kCa0k8wZlMO+4atF/eenVrpwEG/bMwF1LQOgWs0ZWo34GRvcySoeJYS6w=
X-Received: by 2002:a05:6402:2786:b0:61e:acff:8e20 with SMTP id 4fb4d7f45d1cf-623729d4c1dmr6030237a12.6.1757274707161;
        Sun, 07 Sep 2025 12:51:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG1bitlxsEv3H/4ejZJafX6+B9eK6xVatdvvcUW2W95IkNsxQzm1WuCE1A3nBaGL+WMtCMdx7TzXgQmFJfFReM=
X-Received: by 2002:a05:6402:2786:b0:61e:acff:8e20 with SMTP id
 4fb4d7f45d1cf-623729d4c1dmr6030226a12.6.1757274706786; Sun, 07 Sep 2025
 12:51:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250907022325.243930-1-crwood@redhat.com> <20250907022325.243930-5-crwood@redhat.com>
In-Reply-To: <20250907022325.243930-5-crwood@redhat.com>
From: Costa Shulyupin <costa.shul@redhat.com>
Date: Sun, 7 Sep 2025 22:51:10 +0300
X-Gm-Features: AS18NWCAtyrklxKexGH77p5EBVj_EhgNIJ_5b0GMW3ORrXMLT1HQND6Am-LZnXs
Message-ID: <CADDUTFwg7aLjrcaXnkGb85ZnqtXvnyMV50+SBDfZO98sNQ7yrg@mail.gmail.com>
Subject: Re: [PATCH v2 4/7] tools/rtla: Consolidate code between
 osnoise/timerlat and hist/top
To: Crystal Wood <crwood@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-trace-kernel@vger.kernel.org, 
	John Kacur <jkacur@redhat.com>, Tomas Glozar <tglozar@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: TXAmHWVWpc3jf1qIQui_U9c9xDIaYSsd2la4dX1f5Ek_1757274707
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"

On Sun, 7 Sept 2025 at 05:23, Crystal Wood <crwood@redhat.com> wrote:
> -static struct osnoise_params
> +static struct common_params
>  *osnoise_hist_parse_args(int argc, char *argv[])

> -static struct timerlat_params
> +static struct common_params
>  *timerlat_hist_parse_args(int argc, char *argv[])

> -static struct timerlat_params
> +static struct common_params
>  *timerlat_top_parse_args(int argc, char **argv)
>  {

Why do you replace specific params with common params, breaking the hierarchy?
common_params is meant to remain at the lower level - tool-agnostic
and reusable across tools.

Costa

