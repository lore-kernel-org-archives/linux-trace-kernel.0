Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 718ED42E8DD
	for <linux-trace-kernel@vger.kernel.org>; Tue,  7 Jul 2026 14:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783435435; cv=pass; b=pD8w5YLLpdFBbKlXEDFhF8EG16CaQCy1RbvH8GcDsWPB/m65VwXoq/7h4tAMs7IujJjxdbVNYPzKCgNE/x6icm9rR8SWyjniRS7P0ZtAaFo5GD87/xv+1OLFaFt3aZM02HZ9CmJAo3H98oIFdYRi+pAvrlsquCLt/bdg+q3P+hc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783435435; c=relaxed/simple;
	bh=6AYnViclv/2FGBWVdRm67Oo2J+NOKAfqV8ACaSZP77M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P3XZzU6c7yBvFD8URj7mbKGD69mNwlPoJfXhqmZJlbozbCgoPN/jqXsAdshRSbvc5gcz5elg15B5kGYjCe/QRw11sL4eTdgF1NF9fR6NNG5jZS038I05efbPDzxnLHgE1XtPvxskEsIwTjjNVNYf5N8ER8ICPO73kFcXUMHfuHI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qU9J0C9q; arc=pass smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qU9J0C9q"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-847a69ba83dso3425716b3a.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 07 Jul 2026 07:43:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783435434; cv=none;
        d=google.com; s=arc-20260327;
        b=DhKxN4KcWe7uZ6QKxKFn6+DCiys3jcw87Wq6qY+wVKu+rjKTe7CJJUKLP2/5KnyeDr
         qXBLdCF5h5KcN24J+h1hOlv6GHafd3CmFCTow+VDV7RDkrN9Xg1AW4fGK7R8h/LEBxNq
         YopKFbprNHWjHPEIKwqVyo7shMwnpx/8tgfVvnM+PQn0NJDrKwuyIll/osXr4r5DSd7T
         +/kP46XzNw1aDIzDjMotJvNpBxnkHaMlx81nyEndUBZDINqnZa2apJFusPb0Ac8rRbhu
         3tXA5jhHJ/qscxY13wGzWHTLKvxuUXOi7OuIDVMG5gOou9jSUX/UlruUxoCkMDD1e4sk
         tLpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Tv8u/TrF2GWrJ2FphGLExw/G5HOJtgvR9AbpDmjQITo=;
        fh=90d01Nem2dPEgckmXZwObyXzLhhdxu3d44A/errmJIE=;
        b=bwV6+eMFNk3itbrjViziYrC1KzaxW1VWD2WUDBGDJhTTLIhQyLDRJkKE5AcTa3LyTr
         gL3sGav0vGeimaNvoQiq62nXNLZnDa3neOx8GB9nGTUVA6vb4PUtnFuq6hD26+BVQEcn
         zvSf3gKoqKpJLTBTj0ZlLnOzKXL9llSr1IuODM1aPbopsulimQ0EEWJ78CVFlxTb5cPc
         EvsOXBVAwd9ghKNVoWGKkb6+Ewx+DEfxASzGAxRHLoVo+7wAgYmukVp/TJi5f2G+WmPU
         2fmeslMnxFAY3z/frK6H4xLmZmwsx9E7Vp/0psCsMWzyhSSsu4Gv922iIiyolelUAwIB
         A7mw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783435434; x=1784040234; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Tv8u/TrF2GWrJ2FphGLExw/G5HOJtgvR9AbpDmjQITo=;
        b=qU9J0C9qrQlwRwAPeCF+ZsMVTwcDw5zzq56FUAyp8rqEKPJwCOSJ5eS3wnRNRf9TEG
         y3nRYNGvm5IId+kfyaYxJ1642jGHblNNq3UwPF/U4KBOn0WplPF08HspzBelMxV4aayl
         2/utzH7YGrNP0B6adWpW8JNu47Iz9fn6i3Tp0bz+m0jj2QyS6zlZRUualc1DHU4y5/vn
         cjvo3aTYM9ZmlPPnGVZ+7i26lcvmD6uisDnvxldpQfbYRTWptyuG6S9JeLosAeDgEZhe
         nHJWn3VdOvXEuL8JIs2OaacCwiCHZ+rxDsirPEJDPpp0K8dXcqd4MF7Pwxk6nH2T+74r
         FDaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783435434; x=1784040234;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tv8u/TrF2GWrJ2FphGLExw/G5HOJtgvR9AbpDmjQITo=;
        b=KoUF+AWWMe3K++haMpcVSEQCqNIVh+Y9wfmWix8sdaVSqgvUQU9K8k9gNno+Dc7Alz
         +3G5Eq6XFjVXrk91XqT6Ya7i3butTSGDsAHdhVF8blgp3rdiKqH6CaS3QZyhqZa/jYkN
         E6HlaQYndXFP6IMMJbyMMthPw7bBb0J4wI/JOp1IEV1qAcfJA7evURpZY9EdnNfmncYY
         QfHdhA8/LXgmwhDQ4BdIIDZqTgMwalyQsWTpR3bpIsjwJkCCLWHTiBMxtTPSSbrzu5HD
         yTqXTRxTgClX7HfDOLXnxB1uE2KpqvmiXcNejOm9rE/cxveHFhjW0gERfF3jOAy526c/
         Z0/g==
X-Forwarded-Encrypted: i=1; AHgh+RoAxVNqwbStMFKCaYXjm0WT/na9njmqQg4BCDTuPN/auN/1sfsf0Zqk/oV9+lqnLbB8XSOnVqGy1dyJ2XYwNBZNALI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxl5vRHzn4D0m1Jz6JkRflZn2qecnnsKzYZ5zep+H4OHAJ1ghUI
	8GM4JQigg1wcXGwR8wOwZPFpav6XoRmy7l+9tRwqKzs6Hz89/174bCV14/+Xd4iZCfXYDoNb4wC
	cNyWOACNVn+QKg+qNa92LgpLCklLNmkU=
X-Gm-Gg: AfdE7clQE9VUQbpE+SYBpAm20O0Fh3p8D7g32OPQe9pAEZqNA5hjpITrrAClsE87MDi
	SwcbftaZFRIfXQiy3CqUyPk2S+1kIOKhaOeRrdayU2LcC0acifAKs8Alk0mbC2TJUN38cTGNnWL
	OMOmv91vOLGgOVxuXJMBxX+tc5ktKpfqmJ12QjqakZJxfFn3H8IfCekxWBSo4Xt3HwPkGdRB8Fz
	9pC/Q+rKm9if683MOE18tmOZQo5jyMy5er8p9LMwApv9Bx5xl8QlHa/6hZ4EzR7l+ZIs5uVG7qZ
	e5UDTsYgr/361CQzhFFM6BXhOw==
X-Received: by 2002:a05:6a00:1bc7:b0:847:980b:f299 with SMTP id
 d2e1a72fcca58-84826bb460bmr5447444b3a.4.1783435433732; Tue, 07 Jul 2026
 07:43:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260618222743.538915-1-michael.bommarito@gmail.com>
 <tencent_89647CE40DC452B891C65C94D1B271DE8E07@qq.com> <20260624200535.GA132-beaub@linux.microsoft.com>
 <20260706160650.2791767d@gandalf.local.home> <CAJJ9bXzJpYRE-NjOjiArpuJWGnFXr+jq7ukbEEdEhK9YPCbYrQ@mail.gmail.com>
 <20260707104205.582db193@gandalf.local.home>
In-Reply-To: <20260707104205.582db193@gandalf.local.home>
From: Michael Bommarito <michael.bommarito@gmail.com>
Date: Tue, 7 Jul 2026 10:43:40 -0400
X-Gm-Features: AVVi8CfpxD2hcyjt1UC6coacnc6d5fETrGBxov8Mb-FitbiVxyPDp9IVFaTxCOk
Message-ID: <CAJJ9bXy78yKmOb+x-THk4EwJxY=0si04YAMtmOu-SzarVJwRBQ@mail.gmail.com>
Subject: Re: [PATCH] tracing/user_events: fix use-after-free of enabler in user_event_mm_dup()
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Beau Belgrave <beaub@linux.microsoft.com>, XIAO WU <xiaowu.417@qq.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> Ah, you're going to send a new version. I'll drop the one I pulled then.

Saw your pull for-linus and I was just about to send a separate patch
set for the second UAF with a ktest (as 2/2).  I can do either way,
just let me know which is easier
