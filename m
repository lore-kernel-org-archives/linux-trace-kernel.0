Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF2141F37A1
	for <linux-trace-kernel@vger.kernel.org>; Tue, 17 Jun 2025 03:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750131000; cv=none; b=NxY9Xwd2TqtuFbNGrzRwIuMrSxPZZhq5m7lbatVXebY9CMEP26iOkaQ37PGsSVV3A3rEeZ/CncLRGE8KHOKAlLXS7NR3VIXz3zEN0wkSlZeYI0v+zJLjfEXqT5Plh9w9xTRNZP1JY2snGA7og4tTsgOPLTviKvr5KWvS+61k8cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750131000; c=relaxed/simple;
	bh=yUjLj5dHFAp5s2XajRxukKnvBAY8lCZU277Bt4Hn2B8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pTXAdtudNwN/Ota9YAX/oqXzefpyAqEp6UFy7844Id5se1BMgdi967h2tSXnPtRVyXc4oRXBrR6/iOeEkPoOjZ9uXVpSp3CEi3uDSQ6BX6ZDDOosDKC6nfeZEI01nrbES6m4dRj2m1reYoSsTuNHJUFQg63QBn0CseZM8tEjNFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ci8kuokl; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ci8kuokl"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2348ac8e0b4so68075ad.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 16 Jun 2025 20:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750130998; x=1750735798; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CUqINV3rw8vfD2veAggpTZ6kVQqewNkg6mMiquBfyXs=;
        b=ci8kuoklzcVwQ2utLbPg8S9e5aVuLfX/HqVa3YhrTppp5HHi2ZWF3MF4KbEP8CJTAh
         xMwp8I9l8YmrCs2dUDdAU5K7J2Dq1mlykQZyeJdiSn5bVkxI2415o40b//bqprgph4IQ
         ZXpF4JKExwfuiv+rk4docBecS33/KRG4WpXa4ji396tuuJy6iL4O7N+L1gipnfiscmha
         IOXW38lqxuG3YBEd+oAkt0SULBeaoLPlDTph0xpmDZO6+9eEtkUSofaNL1O3caqCj5rn
         g8PcxcZMUtY3OrTZdADv6rej8n3oFUEMMB4QW4cheyvv8BifhT8f4pkcZ6rRYcGmqrPm
         NAjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750130998; x=1750735798;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CUqINV3rw8vfD2veAggpTZ6kVQqewNkg6mMiquBfyXs=;
        b=K3Ixv8ib5t6b5Ou9jb8vHF4VlwGSxMKpZDAG+yhIxhUzxv/+s0AAXVm3fS4Ov5GfvK
         OfbcEfnhVQfECkaq3oBv4+gIX8Qz1ccHkrC2L5DMmrpzIQKNg8pAlnooqCqiB2Woknld
         Pt25QLdkChGU1BgDqyNuYKjMvmKYCNE1yn8puTfnXDcfbz5kg8ODWWF5s03zZ+hLXv3d
         6TjxcLatjJi40S3Nea2SS/j10VujjtgJb7gYcwX8FJqFx8XMn8locd+8PHpGbQ1t11on
         kAORbpfA1K4DjkQwUWRBUGo4bEBgz7CgwwF9Xq6tFYeZYVzlFy4rqcCj5EvLcNTf2Btm
         1aNw==
X-Forwarded-Encrypted: i=1; AJvYcCXthhoACKr8m5pDRv8CM/HvBXRP/FwUywGWEwM21D0Rhpp2bfk1NlLZuGnbPj/M/RfmAffWf5ietyKe6rKBC56VVp4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWVJ08k0Hs5wS2+IYVT/fB5hlnd/p7LL7apB6BXYie23sTnSbP
	G5aHTmaJ3U6Add4AQabkR1/q18MBYioXp0YOt/HpAwFdKR1JzoismEPiRo82pvhUyQ==
X-Gm-Gg: ASbGncsZUoRgsgM4K4EJLrdvg5u2z2Ozd0+rnP1RcZklaZAcGyPCSzMMvVQwjsoWzjD
	GemZLSzYhFCU2fgB0aZELV6jzc/KWkM9NwexJC6sxuJf1ronQDWrlhry0HNuItNEmLrxZjI6SNF
	hsd7imvzTBw+MY81qoV9/p56y5RAN/NoTjHNzVF0hc0mgN2nkZvETaq3wcEDBHNokV+Vi4sRS0N
	2e2JSxWzikZnnf4doE5C5vChKLU+mrpvTfNJOMyopVo+y8wyzMM/UONCrSEHgCB0NaJh8OcAvlL
	EnpLI4dCROeMz+iUSaQTsBkicFZ2T0bVfffEVfDtSAszW2EdH2X6ANDjTk+qNlW1PrivPdRjNhY
	/+fpQzUX3p7KW/dZRAmnJs3XA/D1SiRbItSMmmg==
X-Google-Smtp-Source: AGHT+IHiDCwavgLhAVfK+Sm64NCnqWHuip3kUbYnXShrwNbzo/IsVxNbWKDXEl3n55X7VrEHzCOV/A==
X-Received: by 2002:a17:902:cacc:b0:236:9402:a610 with SMTP id d9443c01a7336-2369402aadfmr323735ad.22.1750130997870;
        Mon, 16 Jun 2025 20:29:57 -0700 (PDT)
Received: from google.com (137.184.125.34.bc.googleusercontent.com. [34.125.184.137])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-313c1b2b545sm9464790a91.0.2025.06.16.20.29.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 20:29:57 -0700 (PDT)
Date: Tue, 17 Jun 2025 03:29:52 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Linux trace kernel <linux-trace-kernel@vger.kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Christian Brauner <brauner@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH] binder: Remove unused binder lock events
Message-ID: <aFDhMCoPsf7O1oHc@google.com>
References: <20250612093408.3b7320fa@batman.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250612093408.3b7320fa@batman.local.home>

On Thu, Jun 12, 2025 at 09:34:08AM -0400, Steven Rostedt wrote:
> From: Steven Rostedt <rostedt@goodmis.org>
> 
> Trace events can take up to 5K each when they are defined, regardless if
> they are used or not. The binder lock events: binder_lock, binder_locked
> and binder_unlock are no longer used.
> 
> Remove them.
> 
> Fixes: a60b890f607d ("binder: remove global binder lock")
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---

Thanks Steven!

Acked-by: Carlos Llamas <cmllamas@google.com>
