Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D9C850AC2D
	for <linux-trace-kernel@vger.kernel.org>; Mon,  7 Sep 2026 15:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788795812; cv=none; b=KbFUpOKp/dIdbixjVzGynWpaGOgxVhvGhbYjGy6bXwb3HkbiyG0KZxiBWzrj0uddOYB5S0hRhXHuQEd3b2qgBgMAkUJ/MgsjvyG9DBq8RtHUJcVvdO/z+RBD8A9Mm0k714Zl+zdbjPwExhxALx2+XFnaMnw9AQ0w/mA332+ZUv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788795812; c=relaxed/simple;
	bh=MICC69rDhpY77nwXlWteXYHHthmexIfa62lpP2Cj7Co=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iKxuzkjEDj1XjZLb+X98ftGnAkBBfvXGNXJxM9q2DaVRTeeVxC6/w+Od7AfUJ1eh+J+l6BVXAgk/GjTUujz/eORjKtHis+ASbCjlroerDLRrwFultYqR/FYMHlOLTUWk3pfaBLNie2tb0QJ0gSgIeK2YnfLRePs7pYo+IDoK1iA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=Wxwdz4as; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="Wxwdz4as"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-9399997417aso156700385a.2
        for <linux-trace-kernel@vger.kernel.org>; Mon, 07 Sep 2026 08:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1788795807; x=1789400607; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9N6f/b+RDjU+5LdwC1W3FgNOtZzFd5njRslDhw37g/s=;
        b=Wxwdz4asm/wUkAUNPcS7PK3TKmk03THM0ngCJKv2mGm8eYY0UNUxnic/ApLQ0dSzrd
         bkHz+ZvTFiWmDGZt/+bG/l3m41ZVbFPlSp0fw7bMxMEK/P6/KSpK621zmAwxmMxZVO8Q
         1Kycppc0Kxxv5t5cmDqbAeiJ++wELgckZPjdrbkkyHC1oys5mE4JKSOHKeLYbgqkLi9y
         fpGgYnxKwzc32YOlgsHBFkT6LOEA+hFpKyBeDUzT//Jexpfi83xzaE7ASctcmG81qsoN
         v2ZsrvyH9BXle7aWkjm6sdoPFmkvg44QbgfJbfr/6D4jf18am1wEmmvFBYiFMTVDpqYq
         VTeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788795807; x=1789400607;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9N6f/b+RDjU+5LdwC1W3FgNOtZzFd5njRslDhw37g/s=;
        b=j7yj3rPCEiwJxInsX8/YN3lv9TkZr09uq5z1NmKfZrIYifWM/2bRovSEYzZ2QGLs3k
         +BLlvOZf1cCd2BvOTuixx1XZaq+abphzh8cewoncj6gwCYvIkYumrLU+4LeBld3nPykb
         hWcREamZFcglIJTtJL8MI7bkCClTkxIWXm7lgBxbO8ViPGiAoQvYOBmQX3K+orYxg96U
         Hg2TdQexUk0nT74tIdYJ1XjQ5UOgqFLLdPBdkjltktDqIoP9qmIQfIeLi+KcNl8cVWSD
         o7Z4vxNmD8pO8vpe5qxKT0Jo61cVd7HbZXI+OrTKAHdVu+P7MJOZZ8gaTz0TF9XWZ4of
         BRKw==
X-Forwarded-Encrypted: i=1; AKwUvByD9NRmp1YgO35At2OQa8+osiuIkkb211pC8lUAC5u9BiNdvHNj3Il+mu+SY8JGJWvlUvpfPbD2iytcvGx+8OnVzIQ=@vger.kernel.org
X-Gm-Message-State: AFuF++lyfQ/2p2a+vcaJOetY0KZvTcqNBQQJc55cfd7z93ZyVMKxlyc1
	AXsRbQzF5w4OTcTfdWOCTpRVCtg/kaW9AdnJ6FzUO8WELBHHRM/dlGmrKLWS5OBu60s=
X-Gm-Gg: AYBFou0urMr/cJvKc7MHniJ2OJrecZuBzrYnwqZd9i83thwx8727W5o113WqT68W2Dt
	gg87sZPy1NDQWs4DVj94mIqWm8oq0Nc4rVV75QQvm6rHBVczY9V4GRRg5cmGk0MMAf2XdW2i6qY
	P+BGpPDUQFwm50FCn87x2Um1ecfQXA15FUfzLNfzPIGut8qZS10ZszxvUhE5pxzijxJmt2KTWrb
	lpmJBNA0yb1AYl9qzQkpj1QgciLXrCDQVRI3AerYqS6Tzlot9Db8SriV9+KGp89kuftb3LKvcoP
	m3fK1T2o6HK2rvt3EqNjgmC9R2t0u5sUAXdzsw4vrzpCo+by6YPSJX4HLKWHLNNg7gOt/smjd9D
	XjyvMXf73ZxTi/y8JSVfIsHelWO7qmVTNfObfL6wDWbkLVhCZEvE9ZMqkjvA79OaNUW1Sr3RLp8
	/YA/h3biTVvxQZEZl/MXwz+xCoQGx2w4qrs8UVr5JKWwalPtDE+6GVdnmnrhj+zcLBVvXcnMdl6
	3qalvsDpVgaJN+1N8Tv+513ZuRiT4tGSswtfg7BNliq
X-Received: by 2002:a05:620a:1a10:b0:939:93f:3b41 with SMTP id af79cd13be357-93980341197mr2411106785a.16.1788795802336;
        Mon, 07 Sep 2026 08:43:22 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-910406bf8c3sm94620766d6.48.2026.09.07.08.43.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 08:43:21 -0700 (PDT)
Date: Mon, 7 Sep 2026 11:43:19 -0400
From: Gregory Price <gourry@gourry.net>
To: Ye Liu <ye.liu@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, Ye Liu <liuye@kylinos.cn>, Michal Hocko <mhocko@suse.com>, 
	SJ Park <sj@kernel.org>, peterz@infradead.org, paulmck@kernel.org, mingo@redhat.com, 
	rostedt@goodmis.org, jpoimboe@kernel.org, mic@digikod.net, oleg@redhat.com, 
	tglx@kernel.org, linmiaohe@huawei.com, nao.horiguchi@gmail.com, rafael@kernel.org, 
	gnoack3000@gmail.com, ljs@kernel.org, rientjes@google.com, shakeel.butt@linux.dev, 
	xu.xin16@zte.com.cn, chengming.zhou@linux.dev, will@kernel.org, boqun@kernel.org, 
	frederic@kernel.org, neeraj.upadhyay@kernel.org, joelagnelf@nvidia.com, 
	josh@joshtriplett.org, urezki@gmail.com, juri.lelli@redhat.com, 
	vincent.guittot@linaro.org, tony.luck@intel.com, reinette.chatre@intel.com, x86@kernel.org, 
	paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com, pavel@kernel.org, 
	lance.yang@linux.dev, mhiramat@kernel.org, pmladek@suse.com, longman@redhat.com, 
	mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com, qiang.zhang@linux.dev, 
	dietmar.eggemann@arm.com, bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, 
	kprateek.nayak@amd.com, mark.rutland@arm.com, Dave.Martin@arm.com, james.morse@arm.com, 
	babu.moger@amd.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, rcu@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH v2 3/8] mm/ksm: convert process iterator to
 for_each_process_rculock
Message-ID: <ap7biSs63MDeB34i@gourry-fedora-PF4VCD3F>
References: <20260907081334.1152889-1-ye.liu@linux.dev>
 <20260907081334.1152889-4-ye.liu@linux.dev>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260907081334.1152889-4-ye.liu@linux.dev>

On Mon, Sep 07, 2026 at 04:13:29PM +0800, Ye Liu wrote:
> From: Ye Liu <liuye@kylinos.cn>
> 
> Replace the manual rcu_read_lock()/rcu_read_unlock() pair combined
> with for_each_process() loop in mm/ksm.c with for_each_process_rculock(),
> which scopes the RCU read lock to the loop body via scoped_guard(rcu).
> 
> No functional change.
> 
> Signed-off-by: Ye Liu <liuye@kylinos.cn>
> Acked-by: Michal Hocko <mhocko@suse.com>
> Reviewed-by: SJ Park <sj@kernel.org>

Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>

