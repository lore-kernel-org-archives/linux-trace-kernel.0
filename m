Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793773559;
	b=ZJtmtSLF5QwerSdW2OpafFuFaj5Yc0PcW1lZ4Ud9P7Kg61nemvSr49SushZxrtLcDlo2
	 XLp+XjRTgoYIwv2kUbuw3DK16KUBV3qrsdj4D4wmqtOzZ2LEpOazDp3jRSrNJfmjEfxDK
	 ovCiN5WvAzfiic4F4Snh7gFCpYIw8svxw3Bv6VKilSGMrOL2d9XlaPAomkzw3fsAHWbGw
	 L0KnMG1kLLlDOuu0hZrITozV+wYqtOFHmRqdknhvbXIW6lLGBcmmb9TxhGePBUa9WruCV
	 g8yQyqD8SMQ+OxIbyMrcr4sRLaDMhhahOH8rOhg6OmX7CkmbBKRpmx7jP2383viWMAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793773559;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=Eed9z5suww4/zRV4jVvjzbO04jNWYIPB5y+W3yGdy9E=;
	b=0j7uqEbTZ9Gf6npp6LILiAW0jgOh9XBt4OK4HfmgXg8YceNck6n5yS8sZw3YouO/zkVO
	 Cdah+9ATOEf+4zVDVv7rqxnd7kHCmIopJc4ZH2KHqd3u8xDKRiCcXKxufc6Ylb4sN2+r1
	 YdglLYm3m0gXDpDLWq1NXhsjWNs2QlY8A5dwfZdpxdPpnnQC2reYoAP3Ul0LDJfMHolZh
	 JxKog/+r7Hal2KqHZGpPizOxVTQ7MqoH1F3BwCSnToXdAOPUPCCrpob1XBqdkwBTAFeEz
	 tMzdHjVYoKlyl1mRR05m4bRE7BjB5fGiJJ64wd4M1jElbDc57VN//PldIp7SsFW2aGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=UM4QTsp+;
	arc=none smtp.remote-ip=209.85.216.48
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9686606A328
	for <linux-trace-kernel@vger.kernel.org>; Wed,  4 Nov 2026 06:25:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C9686606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=UM4QTsp+
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3ae1da332bcso223892a91.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 03 Nov 2026 22:25:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1793773558; x=1794378358; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Eed9z5suww4/zRV4jVvjzbO04jNWYIPB5y+W3yGdy9E=;
        b=UM4QTsp+PqpxBSBnGqCzNhSX3eLBiKNzmrQYPknx4q2n0jGhih7gClXbRIzKaj1Tyl
         b2Druavk7Sm7f9O5NktMHL0U7eOtBcRv2rkls8rBpmfL55JVLpT4sEgGw5GDMTRcMNVE
         dzX8ZP57XnfnaPvxoh6ZPTZxMoClmZSaGi5i+ANPUmFLTgNkVDXcJ1tsaoFYESnIpTn1
         Zf/1DUI22oiGY5T5c3Ks6BgVnnWSJ2L3SHgF/PRxOLZDOP6M8KX6ynX4tKw/CBrTU98l
         yiw9ILmlTGooTjid//JulEprh/ZCbowjDfZWhNPwzgK0SCAMA4FpgZ0WhalKRDPENsjt
         hnqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793773558; x=1794378358;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Eed9z5suww4/zRV4jVvjzbO04jNWYIPB5y+W3yGdy9E=;
        b=RyZPdjKxU1ntwIHgOIcExAmuQo2WBHPqnUn9wGoRd7JX6gG7b1LI+uGwW9QXgeYtOW
         MlRkPS4USQy0tpkPE26YAX0O6qs0OttLhvWh1UoxMTuDGg0MocGRDHY3o+PcA4+rYz+/
         crD6jlLAzx/N/YyIZpWRP3y5F4NZxd4/hmJ8jsB+a/wfb8qjWkjlRSV4lmnRQefh/ghJ
         sRqa4+WUk0BPLajRZ4rjMCl2EwaDWpg9bOgVPuFTdO5Y1kKmxvzK12y3whDqhMhMHObw
         92wf3zL+Llk16kjvw/Coa7P4yXnPwZVufeE5jGQxUFkmipIpXuHGLPcl6+GEmGjj89en
         SsLQ==
X-Forwarded-Encrypted: i=1; AKwUvBxftuXDh4Wa7buaT/l2xQ5xYWBnFjWQlsb1kNtKaFD0HwQTxlI7GZcJOaMe1TJC21Ru7ECBhlTHfQyHfWS+JALtZlo=@vger.kernel.org
X-Gm-Message-State: APuU4Z/TfLF9QpUiI618jXlhVKyaSzPiAtmFkG46grnGGojKurCjZgw9
	zV6M1rSnU/2Vc6/g6fV+ZUrsbTm2uhNbXM1aZmkjME3AxO+dt8QjH5dFTp32i+nDESA=
X-Gm-Gg: AYBFou2BT+m9iVZrIkiVN/ZIymyucp9D8XYsl0eHM9qARmC+D/DT9YkoirDovTCIQOA
	PiLOGjHlamylBajEZC9vgL4l9OywV7tcmFp+0AhQIOWwphsL7QVlmy56BwLEtlrGf+3PXMdkc4s
	nfKaTtN/zwWo71uraM9wMaRhiR8zz7hIJKMEMN5ZR74H+zy4OXykjsZgs/jWQJEoot4MJ+hWL6T
	WU7HwC7CUZU3WQ85Lzv2+hBASHdER3ts0zex9IE8Asmcof9CCY0eSnPKJZU7afZkQc1EMGdsz7w
	A4cSsRaak1iSTilZeUP1QBhGa/nGnJ9+S4WdxMC+wsqWC/R3jdjoCi/GQ4R5cn2ved2f/+beXxO
	pr1Gm5mQYgHPDvfQ2QqYloUOAa5ZR4gBSQ/sKm/LjOf9RH6Ubr/yNbiC0nx9hgJMq12wNTHOESd
	YnucQSPHUJwVqoTm8/JSAqir2Q6hHm7CfecYEJeuwSmEyuVaW5SgsFrzmqL0NoY9DedkJtc0qPn
	80wLMC7Wpi3KnrRYA0fjdpgtmizCnz1ZElgEW7PoQg4U3mW4MQvAQl51sC6h5rbwCWxqX/a8pr6
	XS+FfG+B7PjHi3ihGDVnLwY3T1PbtNDKTVkD9w==
X-Received: by 2002:a17:90a:c886:b0:3ac:80dc:f407 with SMTP id 98e67ed59e1d1-3ae89865dcfmr11962403a91.60.1793773558155;
        Tue, 03 Nov 2026 22:25:58 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F ([61.251.99.240])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b093c499a5sm2672357a91.2.2026.11.03.22.25.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 22:25:57 -0800 (PST)
Date: Wed, 4 Nov 2026 01:25:24 -0500
From: Gregory Price <gourry@gourry.net>
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Cc: Zi Yan <ziy@nvidia.com>, linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com, akpm@linux-foundation.org, david@kernel.org,
	ljs@kernel.org, liam@infradead.org, rppt@kernel.org,
	surenb@google.com, mhocko@suse.com, kasong@tencent.com,
	qi.zheng@linux.dev, shakeel.butt@linux.dev, baohua@kernel.org,
	axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com,
	baoquan.he@linux.dev, baolin.wang@linux.alibaba.com,
	rientjes@google.com, rostedt@goodmis.org, mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com, muchun.song@linux.dev,
	osalvador@suse.de, joshua.hahnjy@gmail.com, rakie.kim@sk.com,
	ying.huang@linux.alibaba.com, brendan.jackman@linux.dev,
	hannes@cmpxchg.org, bigeasy@linutronix.de, clrkwllms@kernel.org,
	nathan@kernel.org, ndesaulniers@google.com, morbo@google.com,
	justinstitt@google.com, Bessel.Wang@huawei.com,
	jiang.liu@huawei.com, mgorman@techsingularity.net,
	anshuman.khandual@arm.com, stable@vger.kernel.org
Subject: Re: [PATCH v5 07/12] mm/mmzone: read each zoneref slot once when
 filtering by nodemask
Message-ID: <aurP1MUp8HhhjV75@gourry-fedora-PF4VCD3F>
References: <20261101021340.2251928-1-gourry@gourry.net>
 <20261101021340.2251928-8-gourry@gourry.net>
 <DML8OO28WT5O.3U6NG100XWKZP@nvidia.com>
 <a5270059-e5a7-4c8a-9f04-96135f79ea72@kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a5270059-e5a7-4c8a-9f04-96135f79ea72@kernel.org>

On Tue, Nov 03, 2026 at 04:00:45PM +0100, Vlastimil Babka (SUSE) wrote:
> > 
> > It is better to spell out the rename from zref_in_nodemask() to
> > zone_in_nodemask().
> 
> Added:
> 
> To achieve that, rename zref_in_nodemask() to zone_in_nodemask() and
> pass a zone instead of zoneref pointer.
>

ack.  Assuming you don't need me to respin just for that.

~Gregory
