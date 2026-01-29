Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E276D3590DF
	for <linux-trace-kernel@vger.kernel.org>; Thu, 29 Jan 2026 21:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769722493; cv=none; b=C+QR39o1VCmVWq4mlSFeh4lBnW+Zq88OZofSwIchbKSDgNHNn9wGGENHvD72GKOFRjkXpYMUmk1u3I6ZSQ4XMztiNPs7M/NQrWnCrDat+mS2elVjsNB8Qg9qYkrQirqihvYpNfhTRx83vh5rgsZ9D3GMqbNG7pe/ysrcw6C5xoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769722493; c=relaxed/simple;
	bh=gNib5OzDxnus3NMxZ0EBqOkqUXY/IHxRC7kvLGUhqaA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CT6KBAIYRWKtQLdRJGHpX0hu3pECN5lwCzVevWS4V/zOzQCM0exgNU6QQEB0L4iLvWdebX89vTF9rOSN4h6GZlWvMwRvgLzuCbFHxi0Gmg534nukueww+K9l8P+l9wg0XtQjxu3Wj8+CYh1XRT+vWztIk73oUjKlbQ6K64qYV6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qALQxNT2; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qALQxNT2"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-47ee0291921so13135685e9.3
        for <linux-trace-kernel@vger.kernel.org>; Thu, 29 Jan 2026 13:34:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769722490; x=1770327290; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fuuFLD2E0Oz9BYdeyyjQ2aqYMkX3G7CJ//5VT0Rpgo4=;
        b=qALQxNT2/THQzZiHWguoVSYD4a6pmW3ZgGf17dbtk9rb8Ifxzy9rsN/9Q0nlDXCN7j
         OAfw6EPd+xwHq315z8aB/8kHmOG6yBND8U3cPxVayRPVqMaXOWXtGskg8v1DyC4+FZlk
         56rz0/zqJswFJqsjXM+/dP/3CTOYVJEnZYxnZJlcZkTALGeV3M0r+oxAoSKI32JDdrRU
         vsdIFA3WIEwd/lKGI3/6wX4pjNd4iElkgKOqqR9S3d99b+gM57hntbDsuhrvzxgcei/C
         f3ah8VZYXnKPNr/PKyr9Y+Ls+jRI078OcV1TIvVPs5rTffInYU2HvoU4rGlciVnWdTRe
         pj3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769722490; x=1770327290;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fuuFLD2E0Oz9BYdeyyjQ2aqYMkX3G7CJ//5VT0Rpgo4=;
        b=qZ7qyTnoW3w8SZuM8/CNgpHaQJktFp6o3M94WIlnm+MHSjAVu8fGKiRpKsaA26UIKp
         Iw+U93wKOQ2hO1kUh6Ped6pB+cJ0yc6+8HJ72AsdZTAm+w0o3qPzmoKJYVSLQu3moz4B
         scJ6gWtPWyjnRitabUMvo/dLYPVm4Eb1ZOhZZg4WjdHTk1ignkGpXSZ8QytrhHB+dkVx
         OjgvHef0aJQ8TSMxngAyY7xXUMknVSXy5rekBDP+0mnEhetY4fjlDLnpQkUEEaPg/o5+
         LpPUxdiX6mOndDlKthaRlip/5rEIjXkyOTOMqVbezlwE8ysXPk+22dZjabz+IjCtXZS7
         n/mw==
X-Forwarded-Encrypted: i=1; AJvYcCX/idC+ErfFjX73NGawEpjiuu+4r4drlehQq6MRLtf/9c+VemM4ZGT6w5TtqcuVeyN9Q/KeBGU7L5d5ed8QSp2roIo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZmlZghk0MBWRFzS/PFZiSVE9vCMt40+x/8unOsShTf/OhCEdC
	Teew0IVDn9gEZFsaWrG9Xk7QA4b7wPgvt8GctaRCCPE6b9GvDUHUQ+eLM2sL67XMwQ==
X-Gm-Gg: AZuq6aK7ih1MirV5ujz8enNHBgLcY5ErX2M1ck2h6X4i48EqFrrQjGJrtpItQf3TrGM
	mK4FlU9Bx4LcIXjCQE7Y+NPnh2CXoQlKkP42IW+XgHBbZVAzR4NH2Z4j20NTZLJDhP8BNfUzVKV
	IfBgOvLrNFv945I32n2WacyyCNTWlNEjHkzrT3wqz7NpJU5TsrUTUpCvfNQ+Sdhr2+jvCheH+Gr
	yZjQRv7Sx4mzYPJ6+Pago9cs0b1daVla8DbaNoUGhixvM9x9lOSZD5i3lPtkd/3098u7xWS+j6P
	8IKuBoneoBZvlEYdZipeudsBQqVnK1jCpWwW//H4IH8XjnWKyqmquamqiQ7nDdjiCSUm6/JJrxh
	AdWA9+xREgFq1r6oIgXx6v5bXlYGkrZEtvUbhph6CQcPjOzQ0YlbXjhSr6/RkEQSdTphb4Ngw7F
	AP03txcDLiHz1ZOV/onoZZrxlFiYGZEJlplpHPJ3SVGfJeSu/x/A==
X-Received: by 2002:a05:600c:310f:b0:477:7ae0:cd6e with SMTP id 5b1f17b1804b1-482db493e6bmr6275085e9.5.1769722490186;
        Thu, 29 Jan 2026 13:34:50 -0800 (PST)
Received: from google.com (44.145.34.34.bc.googleusercontent.com. [34.34.145.44])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4806cdd78d3sm156950105e9.1.2026.01.29.13.34.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jan 2026 13:34:49 -0800 (PST)
Date: Thu, 29 Jan 2026 21:34:46 +0000
From: Vincent Donnefort <vdonnefort@google.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
	linux-trace-kernel@vger.kernel.org, maz@kernel.org,
	oliver.upton@linux.dev, joey.gouly@arm.com, suzuki.poulose@arm.com,
	yuzenghui@huawei.com, kvmarm@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, jstultz@google.com,
	qperret@google.com, will@kernel.org, aneesh.kumar@kernel.org,
	kernel-team@android.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 00/30] Tracefs support for pKVM
Message-ID: <aXvSdljSYlartF1S@google.com>
References: <20260126104419.1649811-1-vdonnefort@google.com>
 <20260129123739.3c00155b@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260129123739.3c00155b@gandalf.local.home>

On Thu, Jan 29, 2026 at 12:37:39PM -0500, Steven Rostedt wrote:
> Hi Vincent,
> 
> I finished my review. I replied to every patch (before the KVM ones) and
> either made comments or added a Reviewed-by tag.

Thanks a lot! I will try to send an update tomorrow.

> 
> When you send the next version, if you don't modify one of the patches I
> replied with a RB tag, add the tag to the patch and it will let me know I
> don't need to look at it again.
> 
> You can use b4 or download the series from here[1] and it will automatically
> add the tags for you. Just create a new branch and apply the download via
> git am and work from there.
> 
> Thanks,
> 
> -- Steve
> 
> [1] https://patchwork.kernel.org/series/1047043/mbox/
