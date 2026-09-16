Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED036501F5E;
	Wed, 16 Sep 2026 13:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789566711; cv=none; b=Hm8rPpjyNTHLJf7V9M4el9SROCkWvY6r2+AOvL2FSXKBGuhyjymjhqbxaOcYhGVR0Y8fy7qgCrNhTqErsibsee9kR+s4os96xGjTz0AVIypqyM832CupydZ6ZjkQK1y+JGBz+xnV/Qw4PQYDJ2/OPVQLsZ8XfZnVNtxu0f2ljus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789566711; c=relaxed/simple;
	bh=CYCUaFKF30v608ok/oaJzEtMb0FXgUyqdiKoxQwP1Mg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LZ+51DeBLImjhIrnU2sFbiyqI+S4VNHIFaYqada6Gx+I9XaSCmY+Du/JO/+o9EnpQvjmVv19ow07sNPCUzjRNooHp6+ojhN+xqYQwhx6d6PUUarKOh3TEb0RoA1nzoVHOkKmq9bibfkV5anl7SzMv69HidalXe/dMhojhY2io7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=l1CY+DOM; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="l1CY+DOM"
Received: from omf04.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id F3BB780665;
	Wed, 16 Sep 2026 13:51:30 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf04.hostedemail.com (Postfix) with ESMTPA id F091320030;
	Wed, 16 Sep 2026 13:51:24 +0000 (UTC)
Date: Wed, 16 Sep 2026 09:51:22 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Baoquan He <baoquan.he@linux.dev>
Cc: Ridong Chen <ridong.chen@linux.dev>, Masami Hiramatsu
 <mhiramat@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Johannes
 Weiner <hannes@cmpxchg.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Kairui Song <kasong@tencent.com>, Qi
 Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, Barry
 Song <baohua@kernel.org>, Axel Rasmussen <axelrasmussen@google.com>,
 Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, Baolin Wang
 <baolin.wang@linux.alibaba.com>, David Hildenbrand <david@kernel.org>,
 Michal Hocko <mhocko@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, "open
 list:MEMORY MANAGEMENT - MGLRU (MULTI-GEN LRU)" <linux-mm@kvack.org>,
 Ridong Chen <chenridong@xiaomi.com>
Subject: Re: [PATCH v2 2/3] mm/mglru: add tracepoint for scan_folios()
Message-ID: <20260916095122.50cbb620@robin>
In-Reply-To: <aqn7h3BVCCRFI2TI@fedora>
References: <20260911102939.2485750-1-ridong.chen@linux.dev>
	<20260911102939.2485750-3-ridong.chen@linux.dev>
	<aqkoeJvFzqpoGeaP@fedora>
	<e38f2b80-20f2-4787-9e07-fb601552f550@linux.dev>
	<aqn7h3BVCCRFI2TI@fedora>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: irjbtkznaum8zrwiwcezfwryhub1158r
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: F091320030
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18SJirAJj0hlDFf3ly3wdOJRosyZeYeUmk=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=oeM1slf5/TlEIZ+/3YKGqvcyO+zDrbVBSRK8hiBB5ps=; b=l1CY+DOMbpJKcpjlzAM2diNrXL7nPJVM2lngLvaKciPGh0uXXpSo40knlfQCPckEtCEolPOGvHeP5c95/CMRQsiC46J0m3lV5/Htpsp3/1pRh2IbalqgqXpdXUYRPkkieTHv4N1wIfRnlJlXDCT5by5Yq/R2grAHT1Tu+uJsCgA=
X-HE-Tag: 1789566684-7934
X-HE-Meta: U2FsdGVkX19UJ8lW1xmB0R2mxjz89QBslEjhduHRiY4qlRY5yOWoeny9H58NMlqDwXlP3THcOruj6daUuuul4JVZpmpvlj7i1/ijpeYw2JzEPJJ6ajaF5NxTU1dBURGCnpoeeK//ECSEYTXBLRIu8L9ys9kJvdkaqqLOL8HszlCpbZV1xNu/QranXaw+sY24EEkgWw8svkcU2JbsoDoJ99xGu2T18mLIgRAtscOoamchnegPWe7H8yx4XnV83zhHlqsYu1lIoXYPPYZJJeDpqC7KUy8J/UsvlbLmbdvSQARgBjrtPhQhXPyBQMXtZoT9

On Wed, 16 Sep 2026 10:14:31 +0800
Baoquan He <baoquan.he@linux.dev> wrote:

> > However, 'sc' is an internal structure, so sc->order cannot be accessed in
> > TP_fast_assign(), and I don't think it is worth making scan_control an
> > external structure just for this.  
> 
> Agree.

Or what you can do is to move include/trace/events/vmscan.h to
mm/trace_mm.h (or whatever you want to call it) and struct scan_control
into "vmscan.h" and then you can use internal structures within the
trace event.

Up to you, but this is what other subsystems have done.

-- Steve
