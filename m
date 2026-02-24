Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DBA23A962B
	for <linux-trace-kernel@vger.kernel.org>; Tue, 24 Feb 2026 16:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771952098; cv=none; b=FwU/DBnaucKZUad+HlK5zsrEev6Ce8ruR3JFB0vz2cVgHuVKivP7/KRpwURG6fTAqvmfFDFCI5WNBJ269/yx4bObchZ+0EqACZIIyBnpiI77f2lpg+L/pV2XD5QqNjM8F94ATXGOnR1/Frfs6fb1gPDof938VCbWzg05zeW6QoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771952098; c=relaxed/simple;
	bh=jdCxOTtyEPr/iR2B4h4Aq7P1P0AhdAHaD1MtdqqOD6s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dI6b0sEKqegYcRfHmpItLe0h5P95tXFzJMwoNBkyyat2IUV2k69/QBp0WEzAhqvg0zUXSyTElALLDn/uGFfiNsJ3EZpxebk+VYETfA0ew53tQvQ+w13QBvQyIIs1SC6cP6L3SKtFPQrtOBNlm/xOWmet8/rd5SbjJlS6c88n26s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=Z2zmejZV; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="Z2zmejZV"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-8954a050c19so72295976d6.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 24 Feb 2026 08:54:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1771952096; x=1772556896; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/u4GoWFznFuQrqLlGOUj7jRuDM2CBLv4iVo/JzLKZig=;
        b=Z2zmejZVquI1y0nNwLqNgdh++8hSr+zpDa2yV7e0wOzQgDnLWmrhwFjX3Nz0nCaNJr
         8eBG5VQI7nts0IIFMCVb/AGg7lhckLxHal2BBu41sPjWLsUn9PQo2mHQluPTkW87sgOA
         NAkghOy7LRthIUbPKhMKbI+0rttrlsTGnTevisRUYEmI+E7Ue+pcyw1U8RnvQF+f1eQa
         5GgaXeUYhX25bEpZxL3JYLOmmIvDbHNr0v+qNJuZqXKevCPK1LFvWAihoPf68qZfXDxN
         js+YwTbh/Jir44XqV7VH2Ue8EGBN8Gqx3O/80yRMxO9BZNvkIrS2XbY6gMdDe+Kus5t3
         d8ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771952096; x=1772556896;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/u4GoWFznFuQrqLlGOUj7jRuDM2CBLv4iVo/JzLKZig=;
        b=Jtj/CbUpndALCKH6IqksfxCVh0b3QZndlZUqvhx6QTUI7z+yP6Us0hMwvDneg8an61
         CtKA+htViPbin6ORuFjrjPyDyBnhDTplufw3JuhuSptRIXBKoTpY3zS83RVAM1F3C8CA
         P55EhIFQC36urIwa+7jnoV07V7ShDdAOMkEyfpqcr2dkCdRkOilc2C29Gf6ms/DUuE0X
         EhBGyejut9vIM/jmpQ7Ctisb5Cvr/ZxR7fqXglkanP29ZMg6q8H2JA8aYGhDfPX2swcb
         7g0zM22xjtao4d+th+PXrLA7NsGmI8/0MDuVvaavxO6+7Kk6j+dWMViCRGeTwTdu4YSF
         uITg==
X-Forwarded-Encrypted: i=1; AJvYcCWAOT9EPpxXzXIC1pSR5SDEx3MhfwON3krS+l67HmTGFys4npESCWzUG+NM/zh7tHmxQdmo5oZGytoyCIZDrxXJbbY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBEQROdx9o4Ef2WFVJG81kta8RtuVJzOEv6oGGaC1fGZX028Wr
	fAfi3954L1Pmhtl7gK8rUUDq7C9hWuP8l7fX1sZh0GJMZBABue+6gbh7IHu1J1yJ5u4=
X-Gm-Gg: ATEYQzylw+Ynpn8bzCqGcVSJqyfUz+4buH9cwCnaDUMgCrKV1+i/YjDV/m8PWqq2Fij
	3TYAprFQl2rPIDNcccsY9ysqgKOPb00QykeB/2a707jkg4mjf+1gr0PDpR8qx2BQMOJRTwYh536
	VtRGkevDZn7SrQdSNavBJ6Ncd9GTAHRxHvInIvu74byYNTGEqIDxGkcxD1WRaPjh2aELNWC8bjW
	fz9BaEmoztfknDUH1eix7Ajh0HL1WDtccYqgCDjhinXSsRnw5f4lIXKh6VVl30sI2NzvSl04IDm
	blgC7gqeQvwbsyZ4F6tqzHz5i1xpGPtQfC+myB+Sy5qqu+erwYlxgjNEp52to93QEVYSVnXV4nH
	aG7dHxNcCI1vuNrNKZLWZlN5Tr7vZ4F/WvLd4uY3odojfpfFE4zFRKSLv1pzcUmmo0Ha3nkfgfa
	fHi1HcwwPE6nGP34UbsVd0P0rnhE3/4G+S64jWMnhVXDY0MV9v0OeJSfp5MqeKHhZDooc+cVb3x
	xUlGEbz6w==
X-Received: by 2002:a05:6214:1bcc:b0:893:4efa:e8aa with SMTP id 6a1803df08f44-89979e317cbmr188639836d6.9.1771952096264;
        Tue, 24 Feb 2026 08:54:56 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cb8d0ec694sm1029766685a.29.2026.02.24.08.54.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 08:54:55 -0800 (PST)
Date: Tue, 24 Feb 2026 11:54:52 -0500
From: Gregory Price <gourry@gourry.net>
To: Alistair Popple <apopple@nvidia.com>
Cc: lsf-pc@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org, cgroups@vger.kernel.org,
	linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org,
	damon@lists.linux.dev, kernel-team@meta.com,
	gregkh@linuxfoundation.org, rafael@kernel.org, dakr@kernel.org,
	dave@stgolabs.net, jonathan.cameron@huawei.com,
	dave.jiang@intel.com, alison.schofield@intel.com,
	vishal.l.verma@intel.com, ira.weiny@intel.com,
	dan.j.williams@intel.com, longman@redhat.com,
	akpm@linux-foundation.org, david@kernel.org,
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
	rppt@kernel.org, surenb@google.com, mhocko@suse.com,
	osalvador@suse.de, ziy@nvidia.com, matthew.brost@intel.com,
	joshua.hahnjy@gmail.com, rakie.kim@sk.com, byungchul@sk.com,
	ying.huang@linux.alibaba.com, axelrasmussen@google.com,
	yuanchu@google.com, weixugc@google.com, yury.norov@gmail.com,
	linux@rasmusvillemoes.dk, mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com, tj@kernel.org, hannes@cmpxchg.org,
	mkoutny@suse.com, jackmanb@google.com, sj@kernel.org,
	baolin.wang@linux.alibaba.com, npache@redhat.com,
	ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org,
	lance.yang@linux.dev, muchun.song@linux.dev, xu.xin16@zte.com.cn,
	chengming.zhou@linux.dev, jannh@google.com, linmiaohe@huawei.com,
	nao.horiguchi@gmail.com, pfalcato@suse.de, rientjes@google.com,
	shakeel.butt@linux.dev, riel@surriel.com, harry.yoo@oracle.com,
	cl@gentwo.org, roman.gushchin@linux.dev, chrisl@kernel.org,
	kasong@tencent.com, shikemeng@huaweicloud.com, nphamcs@gmail.com,
	bhe@redhat.com, zhengqi.arch@bytedance.com, terry.bowman@amd.com
Subject: Re: [LSF/MM/BPF TOPIC][RFC PATCH v4 00/27] Private Memory Nodes (w/
 Compressed RAM)
Message-ID: <aZ3X3Jni0HZXZMVl@gourry-fedora-PF4VCD3F>
References: <20260222084842.1824063-1-gourry@gourry.net>
 <fzy6f6dpv3oq3ksr2mkst7pz3daeb3buhuvdvcw4633pcl7h6u@mxjgiwpg5acv>
 <aZ3BEn_73Rk8Fn7L@gourry-fedora-PF4VCD3F>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aZ3BEn_73Rk8Fn7L@gourry-fedora-PF4VCD3F>

On Tue, Feb 24, 2026 at 10:17:38AM -0500, Gregory Price wrote:
>    - Changing validations on node states
>      - mempolicy checks N_MEMORY membership, so you have to hack
>        N_MEMORY onto ZONE_DEVICE
>        (or teach it about a new node state... N_MEMORY_PRIVATE)
> 

This gave me something to chew on

I think this can be done without introducing N_MEMORY_PRIVATE and just
checking:   NODE_DATA(target_nid)->private

meaning these nodes can just be N_MEMORY with the same isolations.

I'll look at this a bit more.

~Gregory
