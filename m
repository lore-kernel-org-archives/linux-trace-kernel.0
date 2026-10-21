Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792589090;
	b=jmCoskxAEAJBydDZKSS5cWRTcocliOzJk9LU3wfZgPETwJ8HP4uP4blpDFLx2nOm7TOt
	 wOFGeOqZL7HlpMUvYSKM/brzDPQyUo2AEqMhhHlY7tmXHzXl+NOCFBwLSb+bI1Biz9fBw
	 PajwIw63Cj51GOHD3oosyuq8Up5YRlehPXEvesLkry/WAk2IEWXV7P0XmAF/Ze6tE2WbC
	 LApthOs/sjDcAcEmofM4l7Q+mpvsYwZCCg9UQQWbrrzAkvcYe/yqK/DofqcVeWBA4fP9r
	 NRh2Pri7SrKMQwF7pawOt5w3mpAKY2x9jq3+e+HGevYXKMOapDzEqdfSyCiBE5aBDnA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792589090;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer;
	bh=gSlKv0ToGAeQ53lsfFOtI0+sE635JWib0pSuSvkBPtk=;
	b=l9xnKyGXvGh/TyoAuU2ff0lZpbSRAD2VEf4P/gOvAHOoXs3rkocQv9R2GfSUgwmNg1cb
	 urURpVMHKnu0kctB4oqsNqT6YnVCrf2cKx82cO0DUsF+GfbMS/5T2S2P6m+Vryb4kYMzq
	 2ygTnTT749it7gY3AzqDzO5WvuVhw9sGqXMMSjGgNdp5rxFR3W4Bqn3awfg4aHqiJZVtJ
	 +gQp1WwrM2AHAeiIvWpOkJzogGj116YhrnKFrdTPNwk90LmSrraxGTY/NVsRRNPkF5arR
	 Kz5lLhxZCapdy3e03sfTd0jFc29zMz+sAioXPXCYXs9/plFEPjzeq03wYR3ub7B4A9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=fP9QWsyg;
	arc=none smtp.remote-ip=209.85.222.171
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 200DF606A319
	for <linux-trace-kernel@vger.kernel.org>; Wed, 21 Oct 2026 13:24:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 200DF606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=fP9QWsyg
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-93e63ee7b4cso84633785a.2
        for <linux-trace-kernel@vger.kernel.org>; Wed, 21 Oct 2026 06:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1792589089; x=1793193889; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=gSlKv0ToGAeQ53lsfFOtI0+sE635JWib0pSuSvkBPtk=;
        b=fP9QWsygi5jE9vH80f+pFuefsreKP9vY3VKx3ybj4UodI383nCjmiCPGzle93AT/kg
         cSSqp0W3l9N+URsf0bNJu8U9FxgrYwOKjo2xUbUPfmkTXmuK4SUi5Nz2kdkdzadWkALf
         MaupmuT/v73XNXef8WoSyybKVXRC11TpUWuT3rJTqwW7rSbfjYvsCayflrfKRMrcjzQH
         Wx4Scn+PNBlC1/X5DvWxHzAd5MVStdp/7D0HCxpFxaFhtRz6vjB+9c9DuCCCtuDG8rLr
         XQbbixCZS5Cq/02baStbcWUzKKMf+VhW9pb70s8pZGlHqyIDBmvSC0rL6k0qVEv7rLgX
         sbig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792589089; x=1793193889;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gSlKv0ToGAeQ53lsfFOtI0+sE635JWib0pSuSvkBPtk=;
        b=tcTIAowyWiQByYS71RYRDrYWMi2t/RPp1J4fu9t3DaeRG1DW6oa2Mn56S9l0sEnq1L
         LkRRASM+jE45HZAI8hXjY8OaN4QO+I5DCi2QDa2/9qB+R8c7TMnDyYTelh4qI0XCLvXy
         Pmrh87bMImH74tPgRbc9UaJbb3znIsG3Eooged8B+RUy8uyGy9VADMv4dt7sOi4CGe/M
         KBvg8991iRKra7Vovl0cye75viEtJkByo8AnNR6hmv6tSdLNEaWZ8I/Imsx5I0y+QtrB
         gKqb5nvstr/hVJukoSlijsz2vOBP2h9ZNGxRtfkJmDKMl86C0B8xnr22gVXwLPvy36NY
         p0Jw==
X-Forwarded-Encrypted: i=1; AKwUvBzdkbKytc+L/8mTX9zzojpwFhuwkSj4w1jD+rf8a55FwNK5SbEx8dQa5xHN0lw+PUIxRy7qys//WbeZyvIA+MVQ2lc=@vger.kernel.org
X-Gm-Message-State: AFq9FYIvrhfGpRMYUQtPqbnIPDfbVwY3s9So14U2Pyk9j4s6iZWz+fF5
	G9yEzCNaalF/cStB6WzNckXjM7P94q73x6jlz9Ns0BIB9ZPnA25efGqDHYcBzxZSWfs=
X-Gm-Gg: AYBFou0weSwdbB0lHzC5YB46xs/3ELrsbhgwm3L/zi0OFD6y8Gtk4dhtbmBmX8wty6T
	hDZCbC0V+aT2JiAUov8xMSFYtlPLG8elqvCmKo4rNwk9jSgRcENHqcm71JQ3y3QWUZk0miE5UKG
	7BtcyXbOr9G8E4CG2TDDy9adCMwLfdLcEq3mH1EkUgrIHuWxjXH3lwwbNcljp1FsumPH/sgU15B
	GLVVUaz3csSN2pXWoTmprq8Gl6cKzcs3HKWeNxcRn+L+mzSdhrqq2R6B2umJFE9iWXyK5xliUOV
	a9XgBTe4B5ysyX8DsC+2L+Uqzw0AqPmRlJiZH7eKlnwDsIJMDjV9iDggTg6aE4mej8eMhGiaQTy
	cwVbHFKvkmjhDuK1weNVmkbwoi3Ks3bEOy9EAYceTuIvzHGfrWJpGax8DkjCjnk1T16wjK2mL9J
	F68E4KjKwIeH+PBnZQuQtR/YozX566r0sUzS/qW6TUoEwxqDCu8s+SvlWtkYp9Bmg2wpZ8ea0r9
	J4KdtsvSqK4LkJclmL30cPFeZenhqQvNsPucaNIJlT4rFPaezgPaZPUsVgunlH15hgDVktkODcS
	q4dx6Lb6JFhlS55lj9y3NDWWsetrz2IWXhuaugdT0mhtVayT
X-Received: by 2002:a05:620a:4496:b0:93e:5861:34df with SMTP id af79cd13be357-93f57feafa5mr395621285a.47.1792589088891;
        Wed, 21 Oct 2026 06:24:48 -0700 (PDT)
Received: from [192.168.86.58] (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93f56e221fcsm250054885a.40.2026.10.21.06.24.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 06:24:48 -0700 (PDT)
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3 0/8] mm: fix allocator races with memory hotplug
From: "Gregory Price (Meta)" <gourry@gourry.net>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: "Gregory Price (Meta)" <gourry@gourry.net>, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 linux-rt-devel@lists.linux.dev, kernel-team@meta.com, 
 akpm@linux-foundation.org, mhocko@suse.com, rientjes@google.com, 
 shakeel.butt@linux.dev, rostedt@goodmis.org, mhiramat@kernel.org, 
 mathieu.desnoyers@efficios.com, muchun.song@linux.dev, osalvador@suse.de, 
 ljs@kernel.org, liam@infradead.org, vbabka@kernel.org, rppt@kernel.org, 
 surenb@google.com, brendan.jackman@linux.dev, hannes@cmpxchg.org, 
 ziy@nvidia.com, bigeasy@linutronix.de, clrkwllms@kernel.org, 
 mgorman@techsingularity.net, anshuman.khandual@arm.com, 
 Bessel.Wang@huawei.com, jiang.liu@huawei.com
In-Reply-To: <63521469-3829-4895-a7d9-a0f7806c58a1@kernel.org>
References: <20261021023940.1940971-1-gourry@gourry.net>
 <63521469-3829-4895-a7d9-a0f7806c58a1@kernel.org>
Date: Wed, 21 Oct 2026 09:24:45 -0400
Message-Id: <179258908579.2324641.832287495252342628.b4-reply@b4>
X-Mailer: b4 0.17-dev

On 2026-10-21 10:24 +0200, David Hildenbrand (Arm) wrote:
> On 10/21/26 04:39, Gregory Price (Meta) wrote:
> 
> Usual reminder to slow down a bit :)
> 
> We have
> 
> 	Documentation/process/submitting-patches.rst
> 
> Saying
> 
> 	"Wait for a minimum of one week before resubmitting or pinging reviewers
> 	 - possibly longer during busy times like merge windows.
> 
> A lot of this here was broken forever, so there is no need to rush.
> 
> (thanks for the fixes ;) )
>

felt prudent to get the adjustment Vlastimil recommended out to avoid
time wasted on v1 since it was somewhat significant - but ack.

~_~ found a 9th instance of the same bug. Will send next week.

~Gregory

-- 
Gregory Price (Meta) <gourry@gourry.net>
