Received: from mta0.migadu.com (out-101.mta0.migadu.com [91.218.175.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00DBE2F12AB
	for <linux-trace-kernel@vger.kernel.org>; Thu, 17 Sep 2026 01:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789608230; cv=none; b=mtJpeWP7hyG69QOsnjM8sLCX4k27DtL3B9+vPHxGmF3MJMiL9Y7qweN8a7OxEs3sxsSxI1yUjV6LmB5enTrmVgQ3+naZwUgbk7Vf7f0e2NKI2f+YRCuOWmUX1kffDzw3fZWETLqgHMuZzSLl50ebnmmxhnt8M3XIe9wvZikSktA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789608230; c=relaxed/simple;
	bh=wDg1fKXgo2gnh1KZoLEb6HenGD7qVnWNZCNvYn7EiGM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UjDl8q63Nps1yb3BxrpuGeQlm3HBIbcPsjUmqdT6oUiaegZKV63GD/xiKCKO2QVxlwdHSmuvbauNv+qk42Q5pdflLoFzODLByWF4PQeSHk0GL23pGGVWcP86f+4lFF1FtRojZZj5n3GLkfSg1SEu/ky2bocqi+svp9A1705MBBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NSXjE+eQ; arc=none smtp.client-ip=91.218.175.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NSXjE+eQ"
X-Envelope-To: linux-trace-kernel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=wDg1fKXgo2gnh1KZoLEb6HenGD7qVnWNZCNvYn7EiGM=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789608226; v=1; x=1790213026;
 b=NSXjE+eQjTHs61mS8ahOdvlpL97CYi3Oil7vbxswIjGlHKEgS5xxU62Mx1lYLoYG0Bfa1DrG
 zOKJP4j8FYwIPImThj88zDmnj7iuq7IKZi1chAB9Lsl/+cfQZh8ej3sNWqww9qhZaAeDv+Dh3Y7
 2SAgwrYf/1MAFCRZ6hyVz3cE=
X-Envelope-To: linux-trace-kernel@vger.kernel.org
Received: by mta10.migadu.com with ESMTPS id 19db6483ce23b745;
	Thu, 17 Sep 2026 01:23:46 +0000
X-Mizu-Trace-ID: 19db6483ce23b745
X-Migadu-Flow: FLOW_OUT
Date: Thu, 17 Sep 2026 09:23:39 +0800
From: Baoquan He <baoquan.he@linux.dev>
To: Steven Rostedt <rostedt@goodmis.org>,
	Ridong Chen <ridong.chen@linux.dev>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Kairui Song <kasong@tencent.com>, Qi Zheng <qi.zheng@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Barry Song <baohua@kernel.org>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	David Hildenbrand <david@kernel.org>,
	Michal Hocko <mhocko@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	"open list:MEMORY MANAGEMENT - MGLRU (MULTI-GEN LRU)" <linux-mm@kvack.org>,
	Ridong Chen <chenridong@xiaomi.com>
Subject: Re: [PATCH v2 2/3] mm/mglru: add tracepoint for scan_folios()
Message-ID: <aqtBG9Oyu-RVI7jv@fedora>
References: <20260911102939.2485750-1-ridong.chen@linux.dev>
 <20260911102939.2485750-3-ridong.chen@linux.dev>
 <aqkoeJvFzqpoGeaP@fedora>
 <e38f2b80-20f2-4787-9e07-fb601552f550@linux.dev>
 <aqn7h3BVCCRFI2TI@fedora>
 <20260916095122.50cbb620@robin>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260916095122.50cbb620@robin>

On 09/16/26 at 09:51am, Steven Rostedt wrote:
> On Wed, 16 Sep 2026 10:14:31 +0800
> Baoquan He <baoquan.he@linux.dev> wrote:
> 
> > > However, 'sc' is an internal structure, so sc->order cannot be accessed in
> > > TP_fast_assign(), and I don't think it is worth making scan_control an
> > > external structure just for this.  
> > 
> > Agree.
> 
> Or what you can do is to move include/trace/events/vmscan.h to
> mm/trace_mm.h (or whatever you want to call it) and struct scan_control
> into "vmscan.h" and then you can use internal structures within the
> trace event.

Sounds very reasonable, thanks for the valuable input.

> 
> Up to you, but this is what other subsystems have done.

Yeah, leave this to Ridong to decide.

