Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B707C3EEAE1
	for <linux-trace-kernel@vger.kernel.org>; Thu,  3 Sep 2026 09:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788428157; cv=none; b=rUOoDusMgcyknzjBrwYw1AyCk4R//aL0A23yhmb8UWqCsIz71F8qzQGaNccrVdDUE0VzONYF9IW2T3o2jeDJdwASSVms4CzbTSg5Hx2++6jOXI3RZrrgUtdUFrAbzlaAQdM8QoPTCDT0gFfrSXYK8MqW2yMs2verVuF7bDLlP5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788428157; c=relaxed/simple;
	bh=6dxSwnVMhBQ6QrxcI00aXBMeMsbJMY0TD4I+y+LKu/c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gk+f5/S+YUMYiH3JpB3iDc8P6Suzw65t8KvP1SkWVD4Pm4sjyhgKvMufznIe6TiJ1ICbNEynzirHQiNoBR5LpCGYJxxdYRvmhT+ECcEC/8uGaoFPGi6qGImT09WRheE2Z+VNDkcrF+sqgprBLDrhKRu1Z2bpHfTNwMcWAFq+FsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=exUGNFig; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="exUGNFig"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-49954b88fffso16464595e9.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 03 Sep 2026 02:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788428154; x=1789032954; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SA0YMkKZrk5pHRtNM6ynurrEGkiVyx5dwe1u190lCDo=;
        b=exUGNFigLqG7qUWyYpfXvNYjTx/7yDbbBtTm/KWAsQhVB4CYbGOUHDf8wYBy6sCAhw
         1FsCyDToJJWi/T0jsZNlAx3vvXNG7Umlr7QMUFHTTI3mOo8KAeea+M6yYNAM6351/4zc
         aqC0Qfekez5FKPZGgqI15mgdQuvmbNhWV3abWKd2ZaJTjJbU/+aoUq9BRIP77f9llJA3
         luOztfFpL9WqdtmXjpeJdq/oUTTTMYS3iZMXq1YK0RjtJO+IwREWyyWNTat31yeU2+mw
         e5pYvFaMROzMXnmWB7CYfHoKJ9+GwdyjNB2t1tLB1Q/1KXNjvOTRtx85yPKJcUSLKF3w
         HdLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788428154; x=1789032954;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SA0YMkKZrk5pHRtNM6ynurrEGkiVyx5dwe1u190lCDo=;
        b=sLU0GrT9Gl547uBXU0Niol1PFkXLJJNx8dop6akzGDyxF5VKp2TW1HLwP4WBzF9wfr
         oqhWtqa8ag6qrJQ80z5RTTT9QPwl6mc801ZBeYlQH3aIAtunSff2TKrfXGmCsiRqriqX
         BATWVxmiOg5b/gU37Ti/Erq9wA8YgY4RAdHzC7JJ47j5L2oUJOmpKzEzC5RJDyb8YYbv
         YKqv+E7H1pW5hS1Ymx8Y7RDYYoYED0j1jJSqN+za/OOcFNzD9GNkNRz3+WdESPdvo2Na
         iBhc1HG5NdC+dAUb8GCMsZTQ2K3zTlVyxLpIo0iMgjpzA327MYluN88MNlMffZJmhaGH
         TrEA==
X-Forwarded-Encrypted: i=1; AKwUvBzf6WQcdwYvdL/3riClR2tsRdl/hs0gG0lUHLndHIea4ntk2DkfWh8NBdb8a8tw8gJ4Dyzs2E7G8VacN3LZGebNQ1Q=@vger.kernel.org
X-Gm-Message-State: AFuF++kTPQvwfcaTikM5VMy8ovQrK7QbjTuZ4EoYzzfQbJ5DZEAgBK71
	8wvnr8bzHA0TkQIZSqxVVOy99kcllbEiusZqR1Yp5fwjahepYENk6hvlwbQE1J/F8OP5KNBUCW2
	9MaMB1Q==
X-Gm-Gg: AYBFou1UX9sdG0ggFzI9nvvBBPnaVpTvVMNj8/ruS67CaCz+R/dgh/7TqZsNhAfdUdM
	tvCVIUwN5m3n8DJu8/ImUB112aU6F8w1syE7pg5X+HE+qOIUyG+t4/Hgzy+EISIfXRygDhKG3AQ
	ESojBy4/HoDmOuv4qMwl8hYO0emz3qvc06O6mVHCsDbJZSbCapIk5g1Zpv3j7bBOzz5XdM8umlb
	p/Z79O/AKgU3tULz2fyH9hCvm57FpNFbVMNrvQJWtTQUrwIQIpD05Y2rrkZUKkp68jcww5dubTJ
	UXV5lFg2kUG+NHOiwDn3FkVXtAIPQhfibwaWylY15Ar5VPLiSOz/WwZkqF6d5+y7y43zpdeVZ6a
	icp0i6Nv8juXHJObevgpR/Sa7uqt9GiHkJOpZ6e+qcvq40j3JsTE37bZ0NBMhmeMeAxiPNMg4cs
	i7JjInoWcULrtfcsepFhQFVogPwP/57JmMImcZ5Ndo9Z26Om9CXK/AY6Tq3uJulGid5IZ5fd4p8
	6XToj4+bIZSe97ca2k5ZzADmuL5d4iL
X-Received: by 2002:a05:600c:4ed0:b0:499:726a:a017 with SMTP id 5b1f17b1804b1-49ce57ec163mr200889865e9.1.1788428153444;
        Thu, 03 Sep 2026 02:35:53 -0700 (PDT)
Received: from google.com (135.91.155.104.bc.googleusercontent.com. [104.155.91.135])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cee80eda4sm55247145e9.15.2026.09.03.02.35.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 02:35:52 -0700 (PDT)
Date: Thu, 3 Sep 2026 10:35:49 +0100
From: Vincent Donnefort <vdonnefort@google.com>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, rostedt@goodmis.org, mhiramat@kernel.org,
	linux-trace-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com,
	kernel-team@android.com, linux-kernel@vger.kernel.org,
	Lee Jones <lee@kernel.org>
Subject: Re: STABLE REQ: [PATCH v5 06/10] tracing: Fix subbuf resize races
 with trace_pipe_raw readers
Message-ID: <apk_dQ4Q6msdw_Ub@google.com>
References: <20260901123444.GA1350131@google.com>
 <20260902-daily-reply-0006-tracing-subbuf-resize-7-2@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260902-daily-reply-0006-tracing-subbuf-resize-7-2@kernel.org>

On Wed, Sep 02, 2026 at 06:14:05PM -0400, Sasha Levin wrote:
> > Concurrent subbuffer resizes may crash trace_pipe_raw readers or leak
> > uninitialized memory to userspace due to stale size values.
> >
> > Fixes: bce761d75745 ("ring-buffer: Read and write to ring buffers with custom sub buffer size")
> > Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
> >
> > Not sure if this is the latest version or not?
> >
> > I see review comments, but no v6.  Anyway, no matter, it'll do.
> 
> Queued for 7.2, thanks.
> 
> -- 
> Thanks,
> Sasha

This isn't the last version of this patch, I have just posted a v9 [1] and
Steven hasn't reviewed it yet.

[1] https://lore.kernel.org/all/20260901155445.1475405-3-vdonnefort@google.com/

-- 
Vincent
