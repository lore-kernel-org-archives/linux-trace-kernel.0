Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795684635;
	b=szsx6r+oBFok/N4HKfDEQ2dUFOW2Q2w8EcTJo/OzwTWGby0nbqzgePtcLYpFkhuc7mMl
	 pHTJFi3hFiwT3tO7k11tUu//roDvj5HzQSnfmunttNmfR4QwyKHjWQYB0fo1eYJkdRAE0
	 El7nT8xUkDWsTgeXJwcsAaYnr9670O5yUSV8DlvX8sVXytpH/3ti8hWj/j4ucJeeB+9Ss
	 7DL2/n5AE/iPpcjq2VuhrREpHE4B5RRzBmKXDD1Nb7pR5+gQZRgkeExmtBQWuwQHcIdvN
	 iogwh4D9dodAzPWzhOkCm+oKn+RfJ2TtefemWeawg8LzE/qpmaVZek6ji8JKS3Qk44A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795684635;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=C/z0kFZffqp1LFtR2rltFphJVQEqkB2za+Qwi9gT7eY=;
	b=oYelOwKgS/omOZnJBZZm3hihEItuwnPPcSeXxL9JwLHCXcxVtzuY9Jrhm7JKbeJQGR9e
	 F/Geg1qVa9nbbwxzUoz9o0w9ghSyK++cc0y8+Ugaw3GM8wrq0yV8ls0FEBuGlccTVBmWh
	 x+jNtj+hhtdCcWM2ALWA/sZHD1LEE9WRPC5be4ughMp6V2zwNiywMz3IZWtgcUfyenxwO
	 qaADvGPpw0fHsB76+EGRJB351MCfaTO+dBkPhg0XVZjryCTgsGbp7qEdtttXpVX8M1LDC
	 RXlGejHuHYKpBMZWAO3zWvx+xiCxOFxjkM4Xa/SdUMtTtXRncjzOq/+9ZbhilIo/mwA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=r6p70MTL;
	arc=none smtp.remote-ip=209.85.216.44
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE1B606A33B
	for <linux-trace-kernel@vger.kernel.org>; Thu, 26 Nov 2026 09:17:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0CE1B606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=r6p70MTL
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3b413f6dda6so852052a91.2
        for <linux-trace-kernel@vger.kernel.org>; Thu, 26 Nov 2026 01:17:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795684634; x=1796289434; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=C/z0kFZffqp1LFtR2rltFphJVQEqkB2za+Qwi9gT7eY=;
        b=r6p70MTL3/Xp7tYLBv0xUqK504I7RvC/GMoANlXUQwqgpJFW0Q4Y2tC2alhflbNCcq
         /A8OA8nFLlUaOsHPDDxNBtdwCZPltr1p2LvUwRUQhOyArmF/IR3WwgGe5dXg6IfHlKNS
         +CdwQ4IQmsDjXCIdGvgan72z07pP11kM/KVZ7xqRc2CWoZryv8mmX51MM67mmPj4Vmd8
         AxWq64uSSQvpvxxiJteq0d46UF1dtU+vczWaEJGHBm41Bpnx1gBebTGekyVP+MR/n0dn
         7+pRd2c9o37KOdlt2eNX23MFQlOe1WECONDYqFpdILvnKHPceVidEXjVbPBliyfgliAY
         EYdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795684634; x=1796289434;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=C/z0kFZffqp1LFtR2rltFphJVQEqkB2za+Qwi9gT7eY=;
        b=hlO9RHvGo9Xeb73MqPDmCi/171geS5A+Jrx/E7v43bXQYcGUHTSPFfpJZbUqVD5Zsb
         0FR11dpQWzrMV1T3Av9dON9te9U0gioxnyjJ7sxeH8FuaZXLpaXSjoQEdLihLsH0TEi5
         eqAnwq6oAnMKddGxDJ1mubGvnsWY/GEv5rMbgCwDPjiiLreL7m/kkx/bhhx337yCtwTr
         gq7SDsg8zltQQngB+DYV74KD84Z2uaHotrTLPlGkGyaG84PC+lOxejbuV8eRbe/Sb85F
         +vaw6T+zOsNyBpZB4fOP9L+s7E74hnKKLRHHTZfrIZMlPb3ySWwJAyRftlDVTbU1L8P3
         6ocA==
X-Forwarded-Encrypted: i=1; AL+hErEclCS5fAqqw23Fpef/5TTOVhvXdy+SlJVUKMjdim3l8P2NKM8eCZh6mpf4dRmQRmDQRQ1DmhIwNalG3sjmX2LXErI=@vger.kernel.org
X-Gm-Message-State: APuU4Z9vH0Dw6Y9wL6y96xFPoXcrAtt6W6eycAMTwfGDbJBkfOPhsQyK
	9hurGdPN+in41AU9Uij4xM8Re8YZoFRHm7N4Qd6N5rbjS3H3wbFfSEbY
X-Gm-Gg: AZFdTZfz6Fa9ejXs7kcFedIDI40TLCYF4xbKa2KcAqcMzA1+BHfa0eEYQ5cw8FhlWWR
	Lt/NiW45CzgBVpgHDu1z/l4g3m7OEqe8iRhKOtUtK8K59oYfvxQ2d2HOarnzVCaKBpV6FwDEpWF
	SnsIToMf9hTSjfJo6ty+IASQCWgMulNqQT8v6/vQ97XbB8nghLO6sPHYCM+vNLAISvORU7FyNVV
	D6jus2RfcL+KPgTGw4axr/Un2CAFbi06GZYnUYC3tnx0uPEuYVkv2WnLCYMJPVk+PV6JIfZBb0n
	xawTEnKU7LEfRWD/YeU/Ns/Jh5rVvEPFZUMrsEcDIvrCXSk/7EuV4z0nO0GVEmHAKu5rqa/kYm8
	O8thje7Uq6OSSW+n7U5lYCj29Cpl/MelMLKHtVOXY4XNOKT1gVFFnY+0rSV/WcR0j62WuFhWhTi
	MpH5iZXAESHjvjvB4VfxAA6g/hS+siZElx/y9uSGH5EspEoD01taU1zGNjbxDbj9EGpQnp14OWv
	L30uVbK6GMqXWEUSHuJqx1vKD/mKObToSSgYN1dfMk4Omw9iByCrn8WGd//fXsx0C5jrehKPqRo
	7m4oYVS4ZdXF+UiCi/ieKebPv5OJc+qlFrwvglZxIzHmDw==
X-Received: by 2002:a17:90b:498c:b0:3ac:73c7:9c07 with SMTP id 98e67ed59e1d1-3b41c55b914mr29233956a91.0.1795684634345;
        Thu, 26 Nov 2026 01:17:14 -0800 (PST)
Received: from gmail.com ([43.224.245.234])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b4dfbe54a2sm11023723a91.17.2026.11.26.01.17.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 01:17:13 -0800 (PST)
Date: Thu, 26 Nov 2026 17:16:42 +0800
From: Wenwu Hou <hwenwur@gmail.com>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com, linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] tracing/hwlat: Bind the sampler kthread instead of
 setting its affinity
Message-ID: <awf4-hjPFkBxPUev@gmail.com>
References: <20261125084600.2306377-1-hwenwur@gmail.com>
 <awbklFE66PIMKFop@localhost.localdomain>
 <20261125103822.2129a7ec@gandalf.local.home>
 <awcLwio_qyE3d1bL@localhost.localdomain>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <awcLwio_qyE3d1bL@localhost.localdomain>

On Wed, Nov 25, 2026 at 05:24:34PM +0100, Frederic Weisbecker wrote:
> Le Wed, Nov 25, 2026 at 10:38:22AM -0500, Steven Rostedt a écrit :
> > On Wed, 25 Nov 2026 14:37:24 +0100
> > Frederic Weisbecker <frederic@kernel.org> wrote:
> > 
> > > >  static int kthread_fn(void *data)
> > > >  {
> > > > +	unsigned long flags;
> > > >  	u64 interval;
> > > >  
> > > > +	/*
> > > > +	 * kthread_bind_mask() sets PF_NO_SETAFFINITY to keep the initial
> > > > +	 * affinity from being overridden by kthread_affine_node(). Clear it
> > > > +	 * now to allow userspace affinity changes and cgroup migration, but
> > > > +	 * keep per-CPU threads bound to their CPUs.
> > > > +	 */
> > > > +	if (hwlat_data.thread_mode != MODE_PER_CPU) {
> > > > +		raw_spin_lock_irqsave(&current->pi_lock, flags);
> > > > +		current->flags &= ~PF_NO_SETAFFINITY;
> > > > +		raw_spin_unlock_irqrestore(&current->pi_lock, flags);  
> > > 
> > > This is not pretty but moreover, is it a good idea to let the user override
> > > that affinity?
> > 
> > No, but we used to. Perhaps we should make that not possible instead? :-/
> 
> Right, the affinity should only be changed by the kernel if tracing_cpumask is
> written. Otherwise it doesn't seem to make sense to let the user play with the
> affinity.

I agree. Perhaps v1 is better.

> -- 
> Frederic Weisbecker
> SUSE Labs
