Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 939D03AEF2A
	for <linux-trace-kernel@vger.kernel.org>; Thu,  8 Oct 2026 03:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791431552; cv=none; b=SDpqsSmmUHsOfU8zlvM2pVJog7vkHfg9ZwVBUX3HxLWpnANhmLJ8JQ0SeJTrjkCuUIny7wzwwUoE6U8FN9M0IQMlC7Er7UE9F0YRTqTwhZQa6gsBSWkr5rNSBKYtFGP0FsxrP1iaT7GmEkAhkGKbO3ajJ5hQYrN3BO8gDqKA9dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791431552; c=relaxed/simple;
	bh=+S7+6b0tE0OmnLFC+QstPEqY3o50EFg74OIiryzh5ws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cb8IFaMFp6ZdQ12qtT3Wm7GLpBQ0S5VvWmu3qmYqsNqycfRQdj49M1QQITDuBAdYEEoPECcgOL35NbdWYEubbIr9aKBg5oEHB7oyQt0gByZpaPkBE/wQZ8jGMdujWqgSeV/vSCAACK7IWCdwOYzfqIBTR0WTHgp9mrKOEwqLls0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=c+JIULFa; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="c+JIULFa"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-881269371acso106832b3a.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 07 Oct 2026 20:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1791431550; x=1792036350; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Vy0poknliGswHcpdQnidx1yFhBPlUDC+lTCKJfWkmRg=;
        b=c+JIULFawh9O9VQ87fwLeM+LvkiSl70/x6DXs5EcnJs4AIMY1GEWJp8ObgBPZGJB4x
         Mv05UncODjqv2XyRjoBKQVbMrhjwEpgHXgw9TY63vhs/aUwuE3SSQTJZSrZUcCc/8UiJ
         ddvf+4LXB6MROmkpIb8AqBcLQdRz76QjzjoX0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791431550; x=1792036350;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Vy0poknliGswHcpdQnidx1yFhBPlUDC+lTCKJfWkmRg=;
        b=EE87rFT1kMkAp7+VsH5QFdKqjQ071nDSCnNgA0+aNG/dN160kjVtL6I8S0CDmejFxT
         qgigiDmntIgx4D3dWhUWejmJX+ItJVbf0M+NWaYecP3Nb+WUReUCGNYFrAx3Zm+uUg4z
         QH87HICw+X7lV6hlxcIoYixG0Od/Ts+esneYjgaZd6VjUF+GJGV4Oalbh4vBeCCvMV1C
         OvH8ONN+EiDRdPrO1on+6q9qaenG10UclbznNmD3L3QTOm2ARdFeP0ZdmSaJH3kTpOoI
         DUGw3Q/ZmwZDaK5LziK4Jyx0HAlGHhHw7lAVP6mhdWxcve/ElcmiReTA+ywDp2M5vYQw
         F33w==
X-Forwarded-Encrypted: i=1; AKwUvBw+jwr0QahHfEdTQxLq7c4VChMZmjO/jxwbhfwPSDtjtmG//wn/Lk0+Xwo+11Ho3lISYF5Zzt37iNX1xJSP2M3rCKQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYKPrHaUdnZgFiWxw1NSKHtsneqORNkx420VjdA60CGDPW6fZfwh
	k8nOmlP2dDV8bFL48wcfhcT1pm6Q9D+nM2hrPbrVWgNCaze0KVFeLsaM1NWf7MQ5UQ==
X-Gm-Gg: AYBFou3X8Db4zQYxSD4wfoH+DPfxfqkHFZ/OwJxf/5Kdh1kYdlPS+CsXmEeL11Ifra+
	oQwg49TKTVXf74dC2LEUFDIc0LmQ39MS+0GMhKvDCORc0HGNTxoCNF+OrEjAlRK9gqhaoscluPg
	7gC1hXzbUZvYhxBPD3QtQLjmOVkOpYtyxBIoZBxg3/m2q0wWTvor4INT2fZ0Se7LBQz42YSn+3h
	fMA8CZTx1B7Hn5zCfi/eNIr4nG0nwF8/tUpdHIhS50sRrT79bjfyoUaOWt1u10phoJLoMNBiSfp
	lk3fCXkU3QIKtLgGeloIBEhKiVDDiX2BQfjBH6rhNh6p9a9wtX/eBYgojhg6j4RhOfNcBbdvuay
	6cC00rxfcVC8LgbvP//V6uo++T6oeHkwSyksVuQNtTLCPN/NfAYgNWzsW/3lvU9MA7FHykerv9c
	vE+qEIY+2oOuXtyRXzImcEC6fyzzt6DcOlRyc36JLKZ+/CGs2XvJ8jesGEGQzwPy3cEr/RRwrm/
	4iJE++m9kJ42L1yHKrC+kTaI3tQH6ZadA9HGQ==
X-Received: by 2002:a05:6a00:4b4f:b0:880:f22a:b123 with SMTP id d2e1a72fcca58-8930d0045e0mr655238b3a.36.1791431549972;
        Wed, 07 Oct 2026 20:52:29 -0700 (PDT)
Received: from google.com ([2a00:79e0:2031:6:97d3:292:91b3:138d])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-892bb49a188sm977281b3a.33.2026.10.07.20.52.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 20:52:29 -0700 (PDT)
Date: Thu, 8 Oct 2026 12:52:23 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Oreoluwa Babatunde <oreoluwa.babatunde@oss.qualcomm.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Georgi Djakov <georgi.djakov@oss.qualcomm.com>, andersson@kernel.org, konradybcio@kernel.org, 
	abelvesa@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	minchan@kernel.org, axboe@kernel.dk, rostedt@goodmis.org, mhiramat@kernel.org, 
	mathieu.desnoyers@efficios.com, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	djakov@kernel.org
Subject: Re: [PATCH 4/6] zram: Add QPaCE zcomp backend
Message-ID: <ascS2nPCSQJxOGDS@google.com>
References: <20260930145215.3380977-1-georgi.djakov@oss.qualcomm.com>
 <20260930145215.3380977-5-georgi.djakov@oss.qualcomm.com>
 <ar3yt8Kl3WUV93lP@google.com>
 <4ed3f09f-74fc-4f07-8897-5c773fbde0b2@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ed3f09f-74fc-4f07-8897-5c773fbde0b2@oss.qualcomm.com>

On (26/10/06 16:53), Oreoluwa Babatunde wrote:
> On 9/30/2026 10:43 PM, Sergey Senozhatsky wrote:
> > On (26/09/30 07:52), Georgi Djakov wrote:
> > [..]
> > > @@ -80,10 +87,10 @@ static const struct zcomp_ops *lookup_backend_ops(const char *comp)
> > >   	while (backends[i]) {
> > >   		if (sysfs_streq(comp, backends[i]->name))
> > > -			break;
> > > +			return backends[i];
> > >   		i++;
> > >   	}
> > > -	return backends[i];
> > > +	return NULL;
> > >   }
> > 
> > This hunk looks unrelated to the patch in question.
> ACK. Will remove this.

Thanks, if you are going to add qpace zcomp backend, please note
that zcomp API is undergoing some architectural changes [1] (shouldn't
be too much extra work to adapt.)

[1] https://lore.kernel.org/linux-kernel/20261005122036.718976-1-senozhatsky@chromium.org
