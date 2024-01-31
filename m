Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D957D281
	for <linux-trace-kernel@vger.kernel.org>; Wed, 31 Jan 2024 02:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706668690; cv=none; b=aqb27aHp44nE2cuTSVDSOiNItto/F8wuEpgXPcQCrtmAqKrgyFBYrvhmfSrudUWjxZ+2Q4Ny5F60NYYnLuu555ZritbJVdt1pqUicZvjnijeQFmiKJATYcTlM2jUBNTeA8Q5drvMfgtrAhCc3dHktY+uqYb97ECcnjiGl7XPChU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706668690; c=relaxed/simple;
	bh=LGO4BdOvNZmc1lXwuOScKvZxhDaPx77tpjeDFBkTccE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JXPjPk6cuYWE8h7v9/zpcMAjKsAfRlicXwQLS6AJ/F4Vvlthha75PCftx+rVEk8teyVeZ5dsvXN2YRmsJP4tBy//zfGXb+asWFjQw9+PfkXGkmU9ge5sPQVsOLInbVs3vOVDxuxqzLKGnp0pC1NFW/pshN03tFuh8EaLxhjd11I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Yzg4GlwO; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Yzg4GlwO"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-50eabbc3dccso5847705e87.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 30 Jan 2024 18:38:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1706668687; x=1707273487; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=19aDwrdmn+mJoidoEhiPwZ55uaYowtebYP59bRAkETQ=;
        b=Yzg4GlwOoMM4n+vHoEGBxFzylZoVRgG01TGpQUShGA9DOW9WS4iUyDquoJ2qAGz4ul
         FxAOvyl/DG5nPoxarEWLKsUTRKhPSBdVXwlDVc8b0TP0Z5Zs87SguJ2kk49kNpoRIoRu
         E9MGGP8BoOnCdmDOIUNjP1FggdrpWSaQPuAaA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706668687; x=1707273487;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=19aDwrdmn+mJoidoEhiPwZ55uaYowtebYP59bRAkETQ=;
        b=PL/eSoUQohphbuyaQTyty0n4XRfecd40r66C1KULh84KgigRXY+Y16MUkJnK1VZ6R8
         0TaaijtPxU9VQ7vqM5yBn+cDcXw+5XMNVTMEtaHYBcS0QEG7cKfZg+36KfWXdiHkJnxk
         NA5Pw/qO5WKm9Z/ZWpfncz++QzChZHtxuBbqJRE6ZLPPGAe3i41rO3jHtsjqf37WB23I
         rU2dwnOXw4feywVhUkGssVtDLwNfd9hZFQfiI1ZlmsHubHKRw7ETBFoSryrMSThX05da
         fy3lNhaVXCHTQuMgOJcwxDida78bBStFngQWQptamoXWUTnyma6Eo0g89eIsMEx2Cb7W
         E2zA==
X-Gm-Message-State: AOJu0YzL9yXxmLLD3KX0V4kcitDa30OG3oJ7DHouuNzEotNxRonYCUjm
	/WXQmQ3DOa2U77Wdf2m6+CQR5H+nee1/weIFDuIl8qacAdeomJokXb9UtOJVMXalZVZqVmbnpd0
	doj78uw==
X-Google-Smtp-Source: AGHT+IFMyA9InAMlHiSLWyAdyVhxRlUvz/Nu1LLSPvBRaSBYa4xvteJ7SLRgIGrjoXZx0j9xX69Dzg==
X-Received: by 2002:a19:6757:0:b0:50e:ca86:658a with SMTP id e23-20020a196757000000b0050eca86658amr317370lfj.45.1706668686903;
        Tue, 30 Jan 2024 18:38:06 -0800 (PST)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id c23-20020ac244b7000000b0051121bedf76sm179495lfm.34.2024.01.30.18.38.05
        for <linux-trace-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jan 2024 18:38:06 -0800 (PST)
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2cf4a22e10dso54983121fa.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 30 Jan 2024 18:38:05 -0800 (PST)
X-Received: by 2002:a2e:9c17:0:b0:2cf:2ba3:e3d7 with SMTP id
 s23-20020a2e9c17000000b002cf2ba3e3d7mr195592lji.8.1706668685355; Tue, 30 Jan
 2024 18:38:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240130190355.11486-1-torvalds@linux-foundation.org>
 <20240130190355.11486-6-torvalds@linux-foundation.org> <20240131011246.GP2087318@ZenIV>
In-Reply-To: <20240131011246.GP2087318@ZenIV>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 30 Jan 2024 18:37:49 -0800
X-Gmail-Original-Message-ID: <CAHk-=wie3VgLatmR4J_VpnyJR-qKppz=gnDfxEa9Gyy-7cH7HQ@mail.gmail.com>
Message-ID: <CAHk-=wie3VgLatmR4J_VpnyJR-qKppz=gnDfxEa9Gyy-7cH7HQ@mail.gmail.com>
Subject: Re: [PATCH 6/6] eventfs: clean up dentry ops and add revalidate function
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 30 Jan 2024 at 17:12, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> > + *
> > + * Note that d_revalidate is called potentially under RCU,
> > + * so it can't take the eventfs mutex etc. It's fine - if
> > + * we open a file just as it's marked dead, things will
> > + * still work just fine, and just see the old stale case.
>
> Looks like use after free, unless freeing ei is RCU-delayed...

We hold the ref to the ei in the very dentry that is doing d_revalidate().

So it should be fine. The race is with eventfs marking the ei
'is_freed' (under the mutex that we don't hold here), but when that
happens and we end up still using the dentry, the ei is still there,
all the operations are just going to fail.

             Linus
