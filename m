Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F70138DC46
	for <linux-trace-kernel@vger.kernel.org>; Thu, 30 Jul 2026 17:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785432634; cv=none; b=qC7g4Ngnj9kw8/wgVAHtDe7YWvrQTBgpeA33waKKk04AGf8Qbx6VSXDSSWmXDgAN5W5Me86AAx3uJz/jMMZvK+WDBFb/3jRWJHL/6Ckp2Pvmr1cqbHGmcia2MJ1FS4h20bl/wNG9Cbb5OpKbYauV0PDv76M9KekYGDr8ow+zvEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785432634; c=relaxed/simple;
	bh=ZarrVrdKj2n3aaebkA5FovkqHBfFNmuG5d9kWTyUTbc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fgCkDe8vnkm3pw9IbEnch/BKYfh2XczLXweeCijJfgiqqlv3ucTaVuDaBxybZoaDq7VdI1KggMH+y8hFfiF9Nd3OXzw5id/v4GwuooQke8Yy9/vYJ6tDRa2Sn5rs3a6BhSwV+NTPMaARCHVarCz5aZAeBVp1tw8zHHp7XJT/8DM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=du4CQIwW; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="du4CQIwW"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-92e6391b114so7777885a.3
        for <linux-trace-kernel@vger.kernel.org>; Thu, 30 Jul 2026 10:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1785432632; x=1786037432; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=O1gNcDYuy2kFPtuMWDBBdwYzU3pwqwyp43h1K8eiHJI=;
        b=du4CQIwWEG7O6ckuHbU2xpM5rHc3KCc9Y6gGN06uDGZBul7DsSItwEtQUpmGwTL0uw
         MPdSC3xxvcne7biwuRXC6W0+0Q6dOL3s2t7LkHrTW2WqOcZp5zkxwZ4rKw0OjQ/P4lv8
         OiRNtl7pf/xdZvUUav5gmKC3O4Kfuy5FG7ce7DijnCp8/EY8VjnfaVmaMu1OfNctBAAr
         XWAdQTyQAgTcRPEWL0jBj/08dGNup1ctehZpCjS/655Po/ZtyZYM77TGBLAPJUL14pLB
         0d/6Ukpm1n8il1xPY3GJIkPZaTXYkNUkhIRM4pgsbu7e9Pq5Aq3VjsJCkkIXdh03UwMc
         lHaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785432632; x=1786037432;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=O1gNcDYuy2kFPtuMWDBBdwYzU3pwqwyp43h1K8eiHJI=;
        b=rq4Q3mHhSCtQUVayhKxQWZNJSc/SjuciULfvoof7Yqs3wdV2xaIs531chzLgGDwLf6
         Dh9xd0cBG5MNMev682g4oSMFCl2QwbQRydkGmKpXC/i9jnICgn/HJEqorlraH7tW6PRx
         E3vH5ArKTVMP9l5XagEpHe66CDpW/NLTmhaVqFTH4V/+EOtKxua9VK3WPgzaOEYF16eI
         4O0ZCGhA2ZRP6/GCpn4nXxnk7om3ArC9FwYQf6FnThIi/gRlbT/DS3XknWMlazYmu8wH
         1pP+HcLfYvIJ0BSHT1Dy4gBucismkKl6RshDW66EOW87eQnVh4ufsSRGjjTqrnOiDu+U
         1r0w==
X-Forwarded-Encrypted: i=1; AHgh+Rob9au9VLKVWfJL6KXvM8Zi90kBqzvZLamjq278J/OVF1t2INXux9dHZE0190uIzamSkH6frokQtUxosoRJuX4LJ+U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8f5491wfAYAtg87b4ENoqzXp5NHCjCPfON5mM9dsNGl5xyuWf
	JU8Bbl05IlNfnG7OfGU7TQMfEjBJhEFix4fEslRPrZEK8Ku/kznuneV9oPTgPGvaxrY=
X-Gm-Gg: AR+sD12uFzBdv2DhokyDfve+RyloQz+olMnOPrCtW8xYwlcTk6EZDSG8k+rl0/aM4TF
	k7j0/WVn8Cuxa1XKp419jcGOM7Q398pSHYI9uTE/p9EodFFRUQML9CSRtNXSC0FM3MFjSsrAnN0
	y8vJjQ34jFQaan0hEsB6Mk3CWlNswby+Mqh6MCdKF2CuFkKgqPsJSx+zRemMgnKQ7MO/yVwDbxh
	uZgqF2nOnKNAFNT9520WDURsHFxnlinsm2PtCbwSEtoMaIGyj+BBdvMK5eY+slUxa0cTnpKGsZA
	+YUWuswLGv2TVZ5yk+lUeFnzL87tAtLnfet4zIghDuVCVpgw3yKEb3OFDt8XdYYq3kXJTUGLWEl
	Dm9OfIa239KRD+yWoJa1Ogd5ZSzYpfx6AfJiMN6r3W6KuJhi0oLohptFtMKau7suGNPj8oNXiQM
	MUOKTrAXDzdcJzG2ocL38EilRi/6ysIwBGeMnxyd8MvJRw/+6cPcP54jCRRS33YsBAQHA/tSFKG
	uIKzHwrnOmxz+7X8HxAg43J1m4hVdGi85TPCwmg/Skt
X-Received: by 2002:a05:620a:27c5:b0:92e:56f7:c5fb with SMTP id af79cd13be357-93485f9c0a0mr372532985a.12.1785432632074;
        Thu, 30 Jul 2026 10:30:32 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-933d325a17fsm457745885a.13.2026.07.30.10.30.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 10:30:31 -0700 (PDT)
Date: Thu, 30 Jul 2026 13:30:29 -0400
From: Gregory Price <gourry@gourry.net>
To: Yiannis Nikolakopoulos <yiannis.nikolakop@gmail.com>
Cc: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Trond Myklebust <trondmy@kernel.org>, 
	Anna Schumaker <anna@kernel.org>, Zi Yan <ziy@nvidia.com>, Matthew Brost <matthew.brost@intel.com>, 
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>, Byungchul Park <byungchul@sk.com>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Alistair Popple <apopple@nvidia.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Brendan Jackman <jackmanb@google.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, David Rientjes <rientjes@google.com>, 
	Davidlohr Bueso <dave@stgolabs.net>, Fan Ni <nifan.cxl@gmail.com>, 
	Frank van der Linden <fvdl@google.com>, Jonathan Cameron <jic23@kernel.org>, 
	Raghavendra K T <rkodsara@amd.com>, "Rao, Bharata Bhasker" <bharata@amd.com>, 
	SeongJae Park <sj@kernel.org>, Wei Xu <weixugc@google.com>, 
	Xuezheng Chu <xuezhengchu@huawei.com>, Yiannis Nikolakopoulos <yiannis@zptcorp.com>, 
	dimitrios@palyvos.net, Ryan Roberts <ryan.roberts@arm.com>, 
	Huan Nguyen <nhuhuan@google.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-nfs@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Alirad Malek <alirad.malek@zptcorp.com>
Subject: Re: [PATCH RFC v2 0/3] Demote to lower tier using non-temporal stores
Message-ID: <amuJbBrTW9W6_sx8@gourry-fedora-PF4VCD3F>
References: <20260730-rfc-nt-demote-v2-0-452dbe3b5073@zptcorp.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260730-rfc-nt-demote-v2-0-452dbe3b5073@zptcorp.com>

On Thu, Jul 30, 2026 at 05:02:56PM +0200, Yiannis Nikolakopoulos wrote:
> In most memory tiering scenarios, the memory to be demoted is expected
> to be cold and most likely out of the node's last-level cache (as well
> as target pages in the target node). Using non-temporal stores instead
> of a standard memcpy path can reduce the cache pollution in the local
> node and the bandwidth overhead to the target node. Furthermore, for
> certain types of CXL devices that support in-line memory compression,
> the last-level cache eviction patterns can negatively affect the
> bandwidth of the device. Non-temporal stores can mitigate this.
> 
> This patch-set introduces a new migrate_mode flag for using non-temporal
> stores that is used only in the demotion path. Patch 1 adds some helpers in
> x86 and mm to bring non-temporal stores support to a respective folio_copy
> function. Patch 2 adds the new flag and necessary changes for compatibility
> with the existing behavior. Patch 3 uses the new flag for demotions.
> 
> Experimental data: in a CXL system with 1 memory expander, a microbenchmark
> that allocates N=64 GB memory in the local node and then triggers demotion
> using memory.reclaim, shows a practically complete elimination of read
> traffic on the device, i.e. write traffic is N GB with and without the
> patch, while read traffic drops from N to almost 0 with the patch.
> 
> Opens:
> 1. There is some "duplication" in the x86 tree and a bit in mm. Can we do
>    something better there? As it is now in copy_mc_to_kernel_nt we
> duplicate the machine check functionality, which if available will override
> the non-temporal. We were not sure how to prioritize these two and what's
> the best approach here. Can we completely skip the machine checked for this
> path? Huan Nguyen has some ideas here that we will align for the next
> version.
> 2. I am not sure how this should be structured so that it is easily
> adopted in other architecture trees (e.g. aarch64). We rely on
> memcpy_flushcache for x86_64 but this does not use non temporal stores
> in ARM. ARM support is currently out of our scope but any input is
> appreciated.
> 

I'm still a bit confused why using NT Stores needs to be an explicit
option - rather than the default behavior if NT Store is available.

Lets assume we did this for all ASYNC requests, is there a negative
effect? A positive effect? Why the new ASYNC type? Is there a
correctness issue?

~Gregory
