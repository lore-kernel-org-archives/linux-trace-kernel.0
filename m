Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B7531AA3C3;
	Tue, 30 Jul 2024 20:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722372934; cv=none; b=qqdlTQ71JNpKbpaYGiM0k/9VkM3d+yLUXC57ZnFM+hqv8qMOIS/NhUPUh+STi1GVJ5sC0+jEHzINEbeuCXIpM9yEYyp7awpCKfpEc7oazr0Z9/2jcJUQio8x65P0+6Gr8E506hb0m88pzancEQGWzUj8VKWpJtq+I5JKiDm8INI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722372934; c=relaxed/simple;
	bh=lqH9udwRALDLey0Fzi+k3lV4SUo27h4wrcUGKMlKx74=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sBkginGI8jdh5jbMLtn0g3jf3vGz3vRHaM6sLfcUfnZNWJlxlGICVEp4pYbSl+J5D0rV8+/I0kYAOW7F0K+NvkQDryXfqM9HL8aDkBcmDsG8uTMuNyTiXORWTu33MTy1kvm71lJYxXF8bBVrhoyEGcHLUMnRtP/4w2HczKrcnX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=mC9ot78K; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mC9ot78K"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=lqH9udwRALDLey0Fzi+k3lV4SUo27h4wrcUGKMlKx74=; b=mC9ot78K21YygygUFFYJT1CQxJ
	PCD61AcE6u8u6NYhLv//OWum8AFIyVe7qi9IvZ6C537fodFVak56FFQb9QCaWO3rfc9CujkRP7wKM
	14bULTT7VROtrLNVq62mNHpmNZTmEjBJiYTxX96FQcz1+3MHuh7rpSpKeXgmHvSYcH9DtSZMWrfN/
	BDz9H34qXQevTW/a9+8GnoA3PBTfnYur/hlhroXLVlF7CdFnWyk/6jQENAVKARdZPbvHSzWRermBi
	rSTV6EcBnZ7hr0Fp3RAt6oL5959OUeGq0NTwEtIlsp+zfQnmcwc14vu95IFSlIuOs70acMS8xbfbu
	0wuw5TOA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sYtsV-000000055A2-14bE;
	Tue, 30 Jul 2024 20:55:27 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id DCDCC3003EA; Tue, 30 Jul 2024 22:55:26 +0200 (CEST)
Date: Tue, 30 Jul 2024 22:55:26 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Oleg Nesterov <oleg@redhat.com>, andrii@kernel.org, mhiramat@kernel.org,
	jolsa@kernel.org, rostedt@goodmis.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] uprobes: shift put_uprobe() from delete_uprobe() to
 uprobe_unregister()
Message-ID: <20240730205526.GV33588@noisy.programming.kicks-ass.net>
References: <20240730123421.GA9085@redhat.com>
 <20240730123457.GA9108@redhat.com>
 <CAEf4BzZ=vMh9=t3iH+pqwTDaYGfXvuF-0BqaLsOgAx2qV7Vqzw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzZ=vMh9=t3iH+pqwTDaYGfXvuF-0BqaLsOgAx2qV7Vqzw@mail.gmail.com>

On Tue, Jul 30, 2024 at 08:08:49AM -0700, Andrii Nakryiko wrote:
> Also, can you please push this and your previous patch set into some
> branch somewhere I can pull from, preferably based on the latest
> linux-trace's probes/for-next? Thanks!

I can stick then in tip/perf/core if you want.
